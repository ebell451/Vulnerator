﻿using log4net;
using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text.RegularExpressions;
using System.Xml;
using Vulnerator.Helper;
using Vulnerator.Model.DataAccess;
using Vulnerator.Model.Object;

namespace Vulnerator.Model.BusinessLogic
{
    public class RawStigReader
    {
        DatabaseInterface databaseInterface = new DatabaseInterface();
        private static readonly ILog log = LogManager.GetLogger(typeof(Logger));
        private bool sourceUpdated = true;
        private List<string> iaControls = new List<string>();
        private List<string> ccis = new List<string>();
        private List<string> responsibilities = new List<string>();
        private Dictionary<string, string> replaceDictionary = PopulateReplaceDictionary();
        private string[] persistentParameters = new string[] {
            "Vulnerability_Source_File_Name", "Source_Description", "Source_Secondary_Identifier", "Source_Name", "Source_Version", "Source_Release", "Host_Name", "Scan_IP", "Finding_Type"
        };
        private List<Tuple<string, string>> ingestedStigVulnerabilities = new List<Tuple<string, string>>(); //Item1 == rule, Item2 == ruleVersion

        public void ReadRawStig(ZipArchiveEntry rawStig)
        {
            try
            {
                log.Info(string.Format("Begin ingestion of raw STIG file {0}", rawStig.Name));
                if (DatabaseBuilder.sqliteConnection.State.ToString().Equals("Closed"))
                { DatabaseBuilder.sqliteConnection.Open(); }
                using (SQLiteTransaction sqliteTransaction = DatabaseBuilder.sqliteConnection.BeginTransaction())
                {
                    using (SQLiteCommand sqliteCommand = DatabaseBuilder.sqliteConnection.CreateCommand())
                    {
                        databaseInterface.InsertParameterPlaceholders(sqliteCommand);
                        sqliteCommand.Parameters["Finding_Type"].Value = "CKL";
                        using (XmlReader xmlReader = XmlReader.Create(rawStig.Open(), GenerateXmlReaderSettings()))
                        {
                            while (xmlReader.Read() && sourceUpdated)
                            {
                                if (xmlReader.IsStartElement())
                                {
                                    switch (xmlReader.Name)
                                    {
                                        case "Benchmark":
                                            {
                                                sqliteCommand.Parameters.Add(new SQLiteParameter("Vulnerability_Source_File_Name", rawStig.Name));
                                                ReadBenchmarkNode(sqliteCommand, xmlReader);
                                                break;
                                            }
                                        case "Group":
                                            {
                                                ReadGroupNode(sqliteCommand, xmlReader);
                                                if (!sourceUpdated)
                                                { return; }
                                                break;
                                            }
                                        default:
                                            { break; }
                                    }
                                }
                            }
                        }
                        DeleteRemovedChecks(sqliteCommand);
                    }
                    sqliteTransaction.Commit();
                }
            }
            catch (Exception exception)
            {
                log.Error("Unable to process STIG file.");
                log.Debug("Exception details: " + exception);
            }
            finally
            { DatabaseBuilder.sqliteConnection.Close(); }
        }

        private void ReadBenchmarkNode(SQLiteCommand sqliteCommand, XmlReader xmlReader)
        {
            try
            {
                sqliteCommand.Parameters["Source_Secondary_Identifier"].Value = xmlReader.GetAttribute("id");
                while (xmlReader.Read())
                {
                    if (xmlReader.IsStartElement())
                    {
                        switch (xmlReader.Name)
                        {
                            case "title":
                                {
                                    string sourceName = xmlReader.ObtainCurrentNodeValue(false).Replace('_', ' ');
                                    sourceName = sourceName.ToSanitizedSource();
                                    sqliteCommand.Parameters.Add(new SQLiteParameter("Source_Name", sourceName));
                                    break;
                                }
                            case "description":
                                {
                                    sqliteCommand.Parameters.Add(new SQLiteParameter("Source_Description", xmlReader.ObtainCurrentNodeValue(false)));
                                    break;
                                }
                            case "plain-text":
                                {
                                    string release = xmlReader.ObtainCurrentNodeValue(false);
                                    if (release.Contains(" "))
                                    {
                                        Regex regex = new Regex(Properties.Resources.RegexRawStigRelease);
                                        sqliteCommand.Parameters.Add(new SQLiteParameter("Source_Release", regex.Match(release)));
                                    }
                                    else
                                    { sqliteCommand.Parameters.Add(new SQLiteParameter("Source_Release", release)); }
                                    break;
                                }
                            case "version":
                                {
                                    sqliteCommand.Parameters.Add(new SQLiteParameter("Source_Version", xmlReader.ObtainCurrentNodeValue(false)));
                                    break;
                                }
                            case "Profile":
                                {
                                    databaseInterface.UpdateVulnerabilitySource(sqliteCommand);
                                    databaseInterface.InsertVulnerabilitySource(sqliteCommand);
                                    return;
                                }
                            default:
                                { break; }
                        }
                    }
                }
            }
            catch (Exception exception)
            {
                log.Error("Unable to process Benchmark node.");
                throw exception;
            }
        }

        private void ReadGroupNode(SQLiteCommand sqliteCommand, XmlReader xmlReader)
        {
            try
            {
                sqliteCommand.Parameters["Vulnerability_Group_ID"].Value = xmlReader.GetAttribute("id");
                while (xmlReader.Read())
                {
                    if (xmlReader.IsStartElement())
                    {
                        switch (xmlReader.Name)
                        {
                            case "title":
                                {
                                    sqliteCommand.Parameters["Vulnerability_Group_Title"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                    break;
                                }
                            case "Rule":
                                {
                                    ProcessRuleNode(sqliteCommand, xmlReader);
                                    break;
                                }
                        }
                    }
                    else if (xmlReader.NodeType == XmlNodeType.EndElement && xmlReader.Name.Equals("Group"))
                    {
                        databaseInterface.UpdateVulnerability(sqliteCommand);
                        databaseInterface.InsertVulnerability(sqliteCommand);
                        databaseInterface.MapVulnerabilityToSource(sqliteCommand);
                        if (ccis.Count > 0)
                        {
                            foreach (string cci in ccis)
                            {
                                sqliteCommand.Parameters["CCI"].Value = cci;
                                databaseInterface.MapVulnerabilityToCci(sqliteCommand);
                                sqliteCommand.Parameters["CCI"].Value = string.Empty;
                            }
                        }
                        ccis.Clear();
                        foreach (SQLiteParameter parameter in sqliteCommand.Parameters)
                        {
                            if (!persistentParameters.Contains(parameter.ParameterName))
                            { parameter.Value = string.Empty; }
                        }
                        return;
                    }
                }
            }
            catch (Exception exception)
            {
                log.Error("Unable to process Group node.");
                throw exception;
            }
        }

        private void ProcessRuleNode(SQLiteCommand sqliteCommand, XmlReader xmlReader)
        {
            try
            {
                string rule = xmlReader.GetAttribute("id");
                string ruleVersion = string.Empty;
                if (rule.Contains("_"))
                { rule = rule.Split('_')[0]; }
                if (rule.Contains("r"))
                {
                    ruleVersion = rule.Split('r')[1];
                    rule = rule.Split('r')[0];
                }
                sqliteCommand.Parameters["Unique_Vulnerability_Identifier"].Value = rule;
                sqliteCommand.Parameters["Vulnerability_Version"].Value = ruleVersion;
                sqliteCommand.Parameters["Raw_Risk"].Value = xmlReader.GetAttribute("severity").ToRawRisk();
                ingestedStigVulnerabilities.Add(new Tuple<string, string>(rule, ruleVersion));
                while (xmlReader.Read())
                {
                    if (xmlReader.IsStartElement())
                    {
                        switch (xmlReader.Name)
                        {
                            case "version":
                                {
                                    sqliteCommand.Parameters["Secondary_Vulnerability_Identifier"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                    break;
                                }
                            case "title":
                                {
                                    sqliteCommand.Parameters["Vulnerability_Title"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                    break;
                                }
                            case "description":
                                {
                                    ProcessRuleDescriptionNode(sqliteCommand, ObtainRuleDescriptionNodeValue(xmlReader));
                                    break;
                                }
                            case "dc:identifier":
                                {
                                    sqliteCommand.Parameters["Overflow"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                    break;
                                }
                            case "ident":
                                {
                                    if (xmlReader.GetAttribute("system").Equals("http://iase.disa.mil/cci"))
                                    { ccis.Add(xmlReader.ObtainCurrentNodeValue(false).Replace("CCI-", string.Empty)); }
                                    break;
                                }
                            case "fixtext":
                                {
                                    sqliteCommand.Parameters["Fix_Text"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                    break;
                                }
                            case "check-content":
                                {
                                    sqliteCommand.Parameters["Check_Content"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                    break;
                                }
                            default:
                                { break; }
                        }
                    }
                    else if (xmlReader.NodeType == XmlNodeType.EndElement && xmlReader.Name.Equals("Rule"))
                    { return; }
                }
            }
            catch (Exception exception)
            {
                log.Error("Unable to process Rule description node.");
                throw exception;
            }
        }

        private void ProcessRuleDescriptionNode(SQLiteCommand sqliteCommand, string descriptionNodeValue)
        {
            try
            {
                string rootNode = @"<root></root>";
                descriptionNodeValue = rootNode.Insert(6, descriptionNodeValue);
                using (XmlReader xmlReader = XmlReader.Create(GenerateStreamFromString(descriptionNodeValue)))
                {
                    while (xmlReader.Read())
                    {
                        if (xmlReader.IsStartElement())
                        {
                            switch (xmlReader.Name)
                            {
                                case "VulnDiscussion":
                                    {
                                        sqliteCommand.Parameters["Vulnerability_Description"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                        break;
                                    }
                                case "FalsePositives":
                                    {
                                        sqliteCommand.Parameters["False_Positives"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                        break;
                                    }
                                case "FalseNegatives":
                                    {
                                        sqliteCommand.Parameters["False_Negatives"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                        break;
                                    }
                                case "Documentable":
                                    {
                                        sqliteCommand.Parameters["Documentable"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                        break;
                                    }
                                case "Mitigations":
                                    {
                                        sqliteCommand.Parameters["Mitigations"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                        break;
                                    }
                                case "SeverityOverrideGuidance":
                                    {
                                        sqliteCommand.Parameters["Severity_Override_Guidance"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                        break;
                                    }
                                case "PotentialImpacts":
                                    {
                                        sqliteCommand.Parameters["Potential_Impacts"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                        break;
                                    }
                                case "ThirdPartyTools":
                                    {
                                        sqliteCommand.Parameters["Third_Party_Tools"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                        break;
                                    }
                                case "MitigationControl":
                                    {
                                        sqliteCommand.Parameters["Mitigation_Control"].Value = xmlReader.ObtainCurrentNodeValue(false);
                                        break;
                                    }
                                case "Responsibility":
                                    {
                                        responsibilities.Add(xmlReader.ObtainCurrentNodeValue(false));
                                        break;
                                    }
                                case "IAControls":
                                    {
                                        iaControls.Add(xmlReader.ObtainCurrentNodeValue(false));
                                        break;
                                    }
                                default:
                                    { break; }
                            }
                        }
                    }
                }
            }
            catch (Exception exception)
            {
                log.Error("Unable to process Rule description node.");
                throw exception;
            }
        }

        private XmlReaderSettings GenerateXmlReaderSettings()
        {
            try
            {
                XmlReaderSettings xmlReaderSettings = new XmlReaderSettings();
                xmlReaderSettings.IgnoreWhitespace = true;
                xmlReaderSettings.IgnoreComments = true;
                xmlReaderSettings.ValidationType = ValidationType.Schema;
                xmlReaderSettings.ValidationFlags = System.Xml.Schema.XmlSchemaValidationFlags.ProcessInlineSchema;
                xmlReaderSettings.ValidationFlags = System.Xml.Schema.XmlSchemaValidationFlags.ProcessSchemaLocation;
                xmlReaderSettings.ValidationFlags = System.Xml.Schema.XmlSchemaValidationFlags.AllowXmlAttributes;
                return xmlReaderSettings;
            }
            catch (Exception exception)
            {
                log.Error("Unable to generate XmlReaderSettings.");
                throw exception;
            }
        }

        private string ObtainRuleDescriptionNodeValue(XmlReader xmlReader)
        {
            try
            {
                xmlReader.Read();
                string value = xmlReader.Value;
                value = value.Replace("&", "&amp;");
                value = value.Replace("<", "&lt;");
                value = value.Replace(">", "&gt;");
                foreach (string key in replaceDictionary.Keys)
                {value =  value.Replace(key, replaceDictionary[key]); }
                return value;
            }
            catch (Exception exception)
            {
                log.Error("Unable to obtain currently accessed node value.");
                throw exception;
            }
        }

        private Stream GenerateStreamFromString(string streamString)
        {
            try
            {
                MemoryStream memoryStream = new MemoryStream();
                StreamWriter streamWriter = new StreamWriter(memoryStream);
                streamWriter.Write(streamString);
                streamWriter.Flush();
                memoryStream.Position = 0;
                return memoryStream;
            }
            catch (Exception exception)
            {
                log.Error("Unable to generate a Stream from the provided string.");
                throw exception;
            }
        }

        private void DeleteRemovedChecks(SQLiteCommand sqliteCommand)
        { 
            try
            {
                SQLiteCommand clonedCommand = sqliteCommand.Clone() as SQLiteCommand;
                clonedCommand.CommandText = Properties.Resources.SelectVulnerabilityIdentifiersAndVersions;
                using (SQLiteDataReader sqliteDataReader = clonedCommand.ExecuteReader())
                {
                    if (!sqliteDataReader.HasRows)
                    { return; }
                    while (sqliteDataReader.Read())
                    {
                        string rule = sqliteDataReader["Unique_Vulnerability_Identifier"].ToString();
                        string ruleVersion = sqliteDataReader["Vulnerability_Version"].ToString();
                        if (ingestedStigVulnerabilities.Count(x => x.Item1.Equals(rule) && x.Item2.Equals(ruleVersion)) == 0)
                        {
                            sqliteCommand.Parameters.Add(new SQLiteParameter("Unique_Vulnerability_Identifier", rule));
                            sqliteCommand.Parameters.Add(new SQLiteParameter("Vulnerability_Version", ruleVersion));
                            databaseInterface.DeleteVulnerability(sqliteCommand);
                            sqliteCommand.Parameters.Clear();
                        }
                    }
                }
            }
            catch (Exception exception)
            {
                log.Error(string.Format("Unable to delete removed checks from database."));
                throw exception;
            }
        }

        private static Dictionary<string,string> PopulateReplaceDictionary()
        {
            Dictionary<string, string> dictionary = new Dictionary<string, string>();
            dictionary.Add("&lt;VulnDiscussion&gt;", "<VulnDiscussion>");
            dictionary.Add("&lt;/VulnDiscussion&gt;", "</VulnDiscussion>");
            dictionary.Add("&lt;FalsePositives&gt;", "<FalsePositives>");
            dictionary.Add("&lt;/FalsePositives&gt;", "</FalsePositives>");
            dictionary.Add("&lt;FalseNegatives&gt;", "<FalseNegatives>");
            dictionary.Add("&lt;/FalseNegatives&gt;", "</FalseNegatives>");
            dictionary.Add("&lt;Documentable&gt;", "<Documentable>");
            dictionary.Add("&lt;/Documentable&gt;", "</Documentable>");
            dictionary.Add("&lt;Mitigations&gt;", "<Mitigations>");
            dictionary.Add("&lt;/Mitigations&gt;", "</Mitigations>");
            dictionary.Add("&lt;SeverityOverrideGuidance&gt;", "<SeverityOverrideGuidance>");
            dictionary.Add("&lt;/SeverityOverrideGuidance&gt;", "</SeverityOverrideGuidance>");
            dictionary.Add("&lt;PotentialImpacts&gt;", "<PotentialImpacts>");
            dictionary.Add("&lt;/PotentialImpacts&gt;", "</PotentialImpacts>");
            dictionary.Add("&lt;ThirdPartyTools&gt;", "<ThirdPartyTools>");
            dictionary.Add("&lt;/ThirdPartyTools&gt;", "</ThirdPartyTools>");
            dictionary.Add("&lt;MitigationControl&gt;", "<MitigationControl>");
            dictionary.Add("&lt;/MitigationControl&gt;", "</MitigationControl>");
            dictionary.Add("&lt;Responsibility&gt;", "<Responsibility>");
            dictionary.Add("&lt;/Responsibility&gt;", "</Responsibility>");
            dictionary.Add("&lt;IAControls&gt;", "<IAControls>");
            dictionary.Add("&lt;/IAControls&gt;", "</IAControls>");
            return dictionary;
        }
    }
}