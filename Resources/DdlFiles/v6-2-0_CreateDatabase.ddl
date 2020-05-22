PRAGMA user_version = 1;

CREATE TABLE Accessibility
	(
	 Accessibility_ID INTEGER PRIMARY KEY ,
	 LogicalAccess NVARCHAR (25) NOT NULL ,
	 PhysicalAccess NVARCHAR (25) NOT NULL ,
	 AvScan NVARCHAR (25) NOT NULL ,
	 DODIN_ConnectionPeriodicity NVARCHAR (25) NOT NULL,
	 FOREIGN KEY (Accessibility_ID) REFERENCES StepOneQuestionnaire(Accessibility_ID)
	);
CREATE TABLE AdditionalTestConsiderations
	(
        AdditionalTestConsideration_ID INTEGER PRIMARY KEY,
	 AdditionalTestConsiderationTitle NVARCHAR (25) ,
	 AdditionalTestConsiderationDetails NVARCHAR (1000)
	);
CREATE TABLE AuthorizationToConnectOrInterim_ATC
	(
	 AuthorizationToConnectOrInterim_ATC_ID INTEGER PRIMARY KEY ,
	 AuthorizationToConnectOrInterim_ATC_GrantedDate DATE NOT NULL ,
	 AuthorizationToConnectOrInterim_ATC_ExpirationDate DATE NOT NULL ,
	 AuthorizationToConnectOrInterim_ATC_CND_ServiceProvider NVARCHAR (25)
	);
CREATE TABLE AuthorizationToConnectOrInterim_ATC_AuthorizationToConnectOrInterim_ATC_PendingItems
	(
	 AuthorizationToConnectOrInterim_ATC_AuthorizationToConnectOrInterim_ATC_PendingItems INTEGER PRIMARY KEY,
	 AuthorizationToConnectOrInterim_ATC_ID INTEGER NOT NULL ,
	 AuthorizationToConnectOrInterim_ATC_PendingItem_ID INTEGER NOT NULL ,
	 FOREIGN KEY (AuthorizationToConnectOrInterim_ATC_ID) REFERENCES AuthorizationToConnectOrInterim_ATC(AuthorizationToConnectOrInterim_ATC_ID),
	 FOREIGN KEY (AuthorizationToConnectOrInterim_ATC_PendingItem_ID) REFERENCES AuthorizationToConnectOrInterim_ATC_PendingItems(AuthorizationToConnectOrInterim_ATC_PendingItem_ID)
	);
CREATE TABLE AuthorizationToConnectOrInterim_ATC_PendingItems
	(
	 AuthorizationToConnectOrInterim_ATC_PendingItem_ID INTEGER PRIMARY KEY ,
	 AuthorizationToConnectOrInterim_ATC_PendingItem NVARCHAR (50) NOT NULL ,
	 AuthorizationToConnectOrInterim_ATC_PendingItemDueDate DATE NOT NULL
	);
CREATE TABLE AuthorizationConditions
	(
	 AuthorizationCondition_ID INTEGER PRIMARY KEY ,
	 AuthorizationCondition NVARCHAR (500) NOT NULL ,
	 AuthorizationConditionCompletionDate DATE NOT NULL ,
	 AuthorizationConditionIsCompleted INTEGER NOT NULL
	);
CREATE TABLE AuthorizationInformation
	(
	 AuthorizationInformation_ID INTEGER PRIMARY KEY ,
	 SecurityPlanApprovalStatus NVARCHAR (25) NOT NULL ,
	 SecurityPlanApprovalDate DATE ,
	 AuthorizationStatus NVARCHAR (25) NOT NULL ,
	 HasAuthorizationDocumentation INTEGER NOT NULL ,
	 AssessmentCompletionDate DATE ,
	 AuthorizationDate DATE ,
	 AuthorizationTerminationDate DATE ,
	 FOREIGN KEY (AuthorizationInformation_ID) REFERENCES StepOneQuestionnaire(AuthorizationInformation_ID)
	);
CREATE TABLE AuthorizationInformation_AuthorizationConditions
	(
	 AuthorizationInformation_AuthorizationConditions_ID INTEGER PRIMARY KEY,
	 AuthorizationInformation_ID INTEGER NOT NULL ,
	 AuthorizationCondition_ID INTEGER NOT NULL ,
	 UNIQUE (AuthorizationInformation_ID, AuthorizationCondition_ID) ON CONFLICT IGNORE,
	 FOREIGN KEY (AuthorizationInformation_ID) REFERENCES AuthorizationInformation(AuthorizationInformation_ID),
	 FOREIGN KEY (AuthorizationCondition_ID) REFERENCES AuthorizationConditions(AuthorizationCondition_ID)
	);
CREATE TABLE AvailabilityLevels
	(
        AvailabilityLevel_ID INTEGER PRIMARY KEY ,
	 AvailabilityLevel NVARCHAR (25) NOT NULL
	);
CREATE TABLE Buildings
	(
	 Building_ID INTEGER PRIMARY KEY ,
	 HasRealTimeAccessControl INTEGER NOT NULL ,
	 HasHVAC INTEGER NOT NULL ,
	 HasRealTimeSecurityMonitoring INTEGER NOT NULL ,
	 PIT_Determination_ID INTEGER,
	 FOREIGN KEY (Building_ID) REFERENCES PIT_Determination(PIT_Determination_ID)
	);
CREATE TABLE Business
	(
	 Business_ID INTEGER PRIMARY KEY ,
	 MissionCriticality NVARCHAR (25) NOT NULL ,
	 GoverningMissionArea NVARCHAR (25) NOT NULL ,
	 DOD_Component NVARCHAR (25) NOT NULL ,
	 ACQ_Category NVARCHAR (25) NOT NULL ,
	 ACQ_Phase NVARCHAR (25) NOT NULL ,
	 SoftwareCategory NVARCHAR (25) NOT NULL ,
	 SystemOwnershipAndControl NVARCHAR (50) NOT NULL ,
	 OtherInformation NVARCHAR (2000) ,
	 FOREIGN KEY (Business_ID) REFERENCES StepOneQuestionnaire(Business_ID)
	);
CREATE TABLE CalibrationSystems
	(
	 Calibration_ID INTEGER PRIMARY KEY ,
	 IsBuiltInCalibration INTEGER NOT NULL ,
	 IsPortableCalibration INTEGER NOT NULL ,
     PIT_Determination_ID INTEGER,
	 FOREIGN KEY (Calibration_ID) REFERENCES PIT_Determination(PIT_Determination_ID)
	);
CREATE TABLE Categories
	(
	 Category_ID INTEGER PRIMARY KEY ,
	 CategoryName NVARCHAR (25) NOT NULL
	);
CREATE TABLE CCIs
	(
	 CCI_ID INTEGER PRIMARY KEY ,
	 CCI_Number NVARCHAR (25) NOT NULL ,
	 CCI_Definition NVARCHAR (500) NOT NULL ,
	 CCI_Type NVARCHAR (25) NOT NULL,
	 CCI_Status NVARCHAR (25) NOT NULL
	);
CREATE TABLE Certifications
	(
	 Certification_ID INTEGER PRIMARY KEY ,
	 CertificationName NVARCHAR (50) NOT NULL
	);
CREATE TABLE CombatSystems
	(
	 CombatSystem_ID INTEGER PRIMARY KEY ,
	 IsCommandAndControl INTEGER NOT NULL ,
	 IsCombatIdentification INTEGER NOT NULL ,
	 HasRealTimeTrackManagement INTEGER NOT NULL ,
	 CanIssueForceOrders INTEGER NOT NULL ,
	 CanControlTroopMovement INTEGER NOT NULL ,
	 CanControlEngagementCoordination INTEGER NOT NULL ,
     PIT_Determination_ID INTEGER,
	 FOREIGN KEY (CombatSystem_ID) REFERENCES PIT_Determination(PIT_Determination_ID)
	);
CREATE TABLE CommonControlPackages
	(
	 CCP_ID INTEGER PRIMARY KEY ,
	 CCP_Name NVARCHAR (100) NOT NULL
	);
CREATE TABLE CommunicationSystems
	(
	 CommunicationSystem_ID INTEGER PRIMARY KEY ,
	 IsVoiceCommunication INTEGER NOT NULL ,
	 IsSatelliteCommunication INTEGER NOT NULL ,
	 IsTacticalCommunication INTEGER NOT NULL ,
	 IsISDN_VTC_System INTEGER NOT NULL ,
	 HasInterrogatorsTransponders INTEGER NOT NULL ,
     PIT_Determination_ID INTEGER,
	 FOREIGN KEY (CommunicationSystem_ID) REFERENCES PIT_Determination(PIT_Determination_ID)
	);
CREATE TABLE ConfidentialityLevels
	(
	 ConfidentialityLevel_ID INTEGER PRIMARY KEY ,
	 Confidentiality_Level NVARCHAR (25) NOT NULL
	);
CREATE TABLE ConnectedSystems
	(
	 ConnectedSystem_ID INTEGER PRIMARY KEY ,
	 ConnectedSystemName NVARCHAR (100) NOT NULL ,
	 IsAuthorized INTEGER NOT NULL
	);
CREATE TABLE Connections
	(
	 Connection_ID INTEGER PRIMARY KEY ,
	 IsInternetConnected INTEGER ,
	 IsDODIN_Connected INTEGER ,
	 IsDMZ_Connected INTEGER ,
	 IsVPN_Connected INTEGER ,
	 IsCND_ServiceProvider INTEGER ,
	 IsEnterpriseServicesProvider INTEGER
	);
CREATE TABLE Connectivity
	(
	 Connectivity_ID INTEGER PRIMARY KEY ,
	 ConnectivityName NVARCHAR (25) NOT NULL ,
	 HasOwnCircuit INTEGER NOT NULL ,
	 CommandCommunicationsSecurityDesginatorNumber NVARCHAR (25) NOT NULL ,
	 CommandCommunicationsSecurityDesginatorLocation NVARCHAR (50) NOT NULL ,
	 CommandCommunicationsSecurityDesginatorSupport NVARCHAR (100) NOT NULL
	);
CREATE TABLE Contacts
	(
	 Contact_ID INTEGER PRIMARY KEY ,
	 FirstName NVARCHAR (25) NOT NULL ,
	 LastName NVARCHAR (50) NOT NULL ,
	 Email NVARCHAR (50) NOT NULL ,
	 Phone NVARCHAR (20) ,
	 Title_ID INTEGER NOT NULL ,
	 Organization_ID INTEGER NOT NULL ,
	 FOREIGN KEY (Title_ID) REFERENCES Titles(Title_ID),
	 FOREIGN KEY (Organization_ID) REFERENCES Organizations(Organization_ID)
	);
CREATE TABLE ContactsCertifications
	(
	 ContactsCertifications_ID INTEGER PRIMARY KEY,
	 Contact_ID INTEGER NOT NULL ,
	 Certification_ID INTEGER NOT NULL ,
	 UNIQUE (Contact_ID, Certification_ID) ON CONFLICT IGNORE,
	 FOREIGN KEY (Contact_ID) REFERENCES Contacts(Contact_ID),
	 FOREIGN KEY (Certification_ID) REFERENCES Certifications(Certification_ID)
	);
CREATE TABLE ControlApplicabilityAssessment
	(
	 CAA_ID INTEGER PRIMARY KEY ,
	 CAA_Name NVARCHAR (50) NOT NULL
	);
CREATE TABLE ControlSelection
	(
	 ControlSelection_ID INTEGER PRIMARY KEY ,
	 IsTierOneApplied INTEGER NOT NULL ,
	 TierOneAppliedJustification NVARCHAR (50) NOT NULL ,
	 IsTierTwoApplied INTEGER NOT NULL ,
	 TierTwoAppliedJustification NVARCHAR (50) NOT NULL ,
	 IsTierThreeApplied INTEGER NOT NULL ,
	 TierThreeAppliedJustification NVARCHAR (50) NOT NULL ,
	 IsCNSS_1253_Applied INTEGER NOT NULL ,
	 CNSS_1253_AppliedJustification NVARCHAR (50) NOT NULL ,
	 IsSpaceApplied INTEGER NOT NULL ,
	 SpaceAppliedJustification NVARCHAR (50) NOT NULL ,
	 IsCDS_Applied INTEGER NOT NULL ,
	 CDS_AppliedJustification NVARCHAR (50) ,
	 IsIntelligenceApplied INTEGER NOT NULL ,
	 IntelligenceAppliedJustification NVARCHAR (50) NOT NULL ,
	 IsClassifiedApplied INTEGER NOT NULL ,
	 ClassifiedAppliedJustification NVARCHAR (50) NOT NULL ,
	 IsOtherApplied INTEGER NOT NULL ,
	 OtherAppliedJustification NVARCHAR (50) NOT NULL ,
	 AreCompensatingControlsApplied INTEGER NOT NULL ,
	 CompensatingControlsAppliedJustification NVARCHAR (50) NOT NULL ,
	 HasNA_BaselineControls INTEGER NOT NULL ,
	 NA_BaselineControlsAppliedJustification NVARCHAR (100) NOT NULL ,
	 AreBaselineControlsModified INTEGER NOT NULL ,
	 BaselineIsModifiedJustification NVARCHAR (100) NOT NULL ,
	 IsBaselineRiskModified INTEGER NOT NULL ,
	 BaselineRiskIsModificationJustification NVARCHAR (100) NOT NULL ,
	 IsBaselineScopeApproved INTEGER NOT NULL ,
	 BaselineScopeIsApprovedJustification NVARCHAR (100) NOT NULL ,
	 AreInheritableControlsDefined INTEGER NOT NULL ,
	 InheritableControlsAreDefinedJustification NVARCHAR (100) NOT NULL
	);
CREATE TABLE ControlSets
	(
	 ControlSet_ID INTEGER PRIMARY KEY ,
	 ControlSetName NVARCHAR (50) NOT NULL
	);
CREATE TABLE CustomTestCases
	(
	 CustomTestCase_ID INTEGER PRIMARY KEY ,
	 TestCaseName NVARCHAR (25) NOT NULL ,
	 TestCaseDescription NVARCHAR (500) NOT NULL ,
	 TestCaseBackground NVARCHAR (500) NOT NULL ,
	 TestCaseClassification NVARCHAR (25) NOT NULL ,
	 TestCaseSeverity NVARCHAR (25) NOT NULL ,
	 TestCaseAssessmentProcedure NVARCHAR (500) NOT NULL ,
	 TestCase_CCI NVARCHAR (25) NOT NULL ,
	 TestCase_NIST_Control NVARCHAR (25) NOT NULL
	);
CREATE TABLE DADMS_Networks
	(
	 DADMS_Network_ID INTEGER PRIMARY KEY ,
	 DADMS_NetworkName NVARCHAR (50) NOT NULL
	);
CREATE TABLE DiagnosticTestingSystems
	(
	 DiagnosticTesting_ID INTEGER PRIMARY KEY ,
	 BuiltInTestingEquipment NVARCHAR (5) NOT NULL ,
	 PortableTestingEquipment NVARCHAR (5) NOT NULL
	);
CREATE TABLE DitprDonNumbers
	(
	 DITPR_DON_Number_ID INTEGER PRIMARY KEY ,
	 DITPR_DON_Number INTEGER NOT NULL
	);
CREATE TABLE EncryptionTechniques
	(
	 EncryptionTechnique_ID INTEGER PRIMARY KEY ,
	 EncryptionTechnique NVARCHAR (100) NOT NULL ,
	 KeyManagement NVARCHAR (500) NOT NULL
	);
CREATE TABLE EntranceCriteria
	(
	 EntranceCriteria_ID INTEGER PRIMARY KEY ,
	 EntranceCriteria NVARCHAR (100) NOT NULL
	);
CREATE TABLE EnumeratedDomainUsersSettings
	(
     EnumeratedDomainUsersSettings_ID Integer PRIMARY KEY,
     EnumeratedWindowsUser_ID INTEGER NOT NULL ,
     WindowsDomainSettings_ID INTEGER NOT NULL ,
	 UNIQUE (EnumeratedWindowsUser_ID, WindowsDomainSettings_ID) ON CONFLICT IGNORE,
	 FOREIGN KEY (EnumeratedWindowsUser_ID) REFERENCES EnumeratedWindowsUsers(EnumeratedWindowsUser_ID),
	 FOREIGN KEY (WindowsDomainSettings_ID) REFERENCES WindowsDomainUserSettings(WindowsDomainSettings_ID)
	);
CREATE TABLE EnumeratedLocalWindowsUsersSettings
	(
	 EnumeratedLocalWindowsUsersSettings_ID INTEGER PRIMARY KEY,
     EnumeratedWindowsUser_ID INTEGER NOT NULL ,
     WindowsLocalSettings_ID INTEGER NOT NULL ,
	 UNIQUE (EnumeratedWindowsUser_ID, WindowsLocalSettings_ID) ON CONFLICT IGNORE,
	 FOREIGN KEY (EnumeratedWindowsUser_ID) REFERENCES EnumeratedWindowsUsers(EnumeratedWindowsUser_ID),
	 FOREIGN KEY (WindowsLocalSettings_ID) REFERENCES WindowsLocalUserSettings(WindowsLocalSettings_ID)
	);
CREATE TABLE EnumeratedWindowsGroups
	(
	 EnumeratedWindowsGroup_ID INTEGER PRIMARY KEY ,
	 EnumeratedWindowsGroupName NVARCHAR (50) NOT NULL
	);
CREATE TABLE EnumeratedWindowsGroupsUsers
	(
        EnumeratedWindowsGroup_ID INTEGER NOT NULL ,
     EnumeratedWindowsUser_ID INTEGER NOT NULL ,
	 FOREIGN KEY (EnumeratedWindowsGroup_ID) REFERENCES EnumeratedWindowsGroups(EnumeratedWindowsGroup_ID),
	 FOREIGN KEY (EnumeratedWindowsUser_ID) REFERENCES EnumeratedWindowsUsers(EnumeratedWindowsUser_ID)
	);
CREATE TABLE EnumeratedWindowsUsers
	(
        EnumeratedWindowsUser_ID INTEGER PRIMARY KEY ,
	 EnumeratedWindowsUserName NVARCHAR (25) NOT NULL ,
	 IsGuestAccount NVARCHAR (5) NOT NULL ,
	 IsDomainAccount NVARCHAR (5) NOT NULL ,
	 IsLocalAccount NVARCHAR (5) NOT NULL,
	 UNIQUE (EnumeratedWindowsUserName) ON CONFLICT IGNORE
	);
CREATE TABLE ExitCriteria
	(
	 ExitCriteria_ID INTEGER PRIMARY KEY ,
	 ExitCriteria NVARCHAR (100) NOT NULL
	);
CREATE TABLE ExternalSecurityServices
	(
	 ExternalSecurityServices_ID INTEGER PRIMARY KEY ,
	 ExternalSecurityService NVARCHAR (50) NOT NULL ,
	 ServiceDescription NVARCHAR (500) NOT NULL ,
	 SecurityRequirementsDescription NVARCHAR (500) NOT NULL ,
	 RiskDetermination NVARCHAR (100) NOT NULL
	);
CREATE TABLE FindingTypes
	(
	 FindingType_ID INTEGER PRIMARY KEY ,
	 FindingType NVARCHAR (25) NOT NULL
	);
CREATE TABLE FISMA
	(
	 FISMA_ID INTEGER PRIMARY KEY ,
	 SecurityReviewCompleted NVARCHAR (5) NOT NULL ,
	 SecurityReviewDate DATE ,
	 ContingencyPlanRequired NVARCHAR (5) NOT NULL ,
	 ContingencyPlanTested NVARCHAR (5) ,
	 ContingencyPlanTestDate DATE ,
	 PIA_Required NVARCHAR (5) NOT NULL ,
	 PIA_Date DATE ,
	 PrivacyActNoticeRequired NVARCHAR (5) NOT NULL ,
	 eAuthenticationRiskAssessmentRequired NVARCHAR (5) NOT NULL ,
	 eAuthenticationRiskAssessmentDate DATE ,
	 ReportableToFISMA NVARCHAR (5) NOT NULL ,
	 ReportableToERS NVARCHAR (5) NOT NULL ,
	 FOREIGN KEY (FISMA_ID) REFERENCES StepOneQuestionnaire(FISMA_ID)
	);
CREATE TABLE GoverningPolicies
	(
	 GoverningPolicy_ID INTEGER PRIMARY KEY ,
	 GoverningPolicyName NVARCHAR (50)
	);
CREATE TABLE Groups
	(
	 Group_ID INTEGER PRIMARY KEY ,
	 GroupName NVARCHAR (50) NOT NULL UNIQUE ON CONFLICT IGNORE,
	 GroupAcronym NVARCHAR (25) ,
	 GroupTier INTEGER NOT NULL,
	 IsAccreditation NVARCHAR (5) ,
	 Accreditation_eMASS_ID NVARCHAR (25) ,
	 IsPlatform NVARCHAR (5) ,
	 Organization_ID INTEGER ,
	 Confidentiality_ID INTEGER ,
	 Integrity_ID INTEGER ,
	 Availability_ID INTEGER ,
	 SystemCategorization_ID INTEGER ,
	 AccreditationVersion NVARCHAR (25) ,
	 CybersafeGrade CHAR (1) ,
	 FISCAM_Applies NVARCHAR (5) ,
	 ControlSelection_ID INTEGER ,
	 HasForeignNationals NVARCHAR (5) ,
	 SystemType NVARCHAR (25) ,
	 RDTE_Zone CHAR (1) ,
	 StepOneQuestionnaire_ID INTEGER ,
	 SAP_ID INTEGER ,
	 PIT_Determination_ID INTEGER,
	 FOREIGN KEY (Confidentiality_ID) REFERENCES ConfidentialityLevels(ConfidentialityLevel_ID),
	 FOREIGN KEY (Integrity_ID) REFERENCES IntegrityLevels(IntegrityLevel_ID),
	 FOREIGN KEY (Availability_ID) REFERENCES AvailabilityLevels(AvailabilityLevel_ID),
	 FOREIGN KEY (SystemCategorization_ID) REFERENCES SystemCategorization(SystemCategorization_ID),
	 FOREIGN KEY (ControlSelection_ID) REFERENCES ControlSelection(ControlSelection_ID),
	 FOREIGN KEY (StepOneQuestionnaire_ID) REFERENCES StepOneQuestionnaire(StepOneQuestionnaire_ID),
	 FOREIGN KEY (SAP_ID) REFERENCES SAPs(SAP_ID),
	 FOREIGN KEY (PIT_Determination_ID) REFERENCES PIT_Determination(PIT_Determination_ID),
	 FOREIGN KEY (Organization_ID) REFERENCES Organizations(Organization_ID)
	);
CREATE TABLE GroupsIATA_Standards
	(
	 Group_ID INTEGER NOT NULL ,
	 IATA_Standard_ID INTEGER NOT NULL,
	 FOREIGN KEY (Group_ID) REFERENCES Groups(Group_ID),
	 FOREIGN KEY (IATA_Standard_ID) REFERENCES IATA_Standards(IATA_Standard_ID)
	);
CREATE TABLE GroupsConnectedSystems
	(
	    GroupsConnectedSystems_ID INTEGER PRIMARY KEY ,
	 Group_ID INTEGER NOT NULL ,
	 ConnectedSystem_ID INTEGER NOT NULL,
	 FOREIGN KEY (Group_ID) REFERENCES Groups(Group_ID),
	 FOREIGN KEY (ConnectedSystem_ID) REFERENCES ConnectedSystems(ConnectedSystem_ID)
	);
CREATE TABLE GroupsConnections
	(
	    GroupsConnections_ID INTEGER PRIMARY KEY ,
	 Group_ID INTEGER NOT NULL ,
	 Connection_ID INTEGER NOT NULL,
	 FOREIGN KEY (Group_ID) REFERENCES Groups(Group_ID),
	 FOREIGN KEY (Connection_ID) REFERENCES Connections(Connection_ID)
	);
CREATE TABLE GroupsCCIs
	(
	 GroupsCCIs_ID INTEGER PRIMARY KEY,
	 Group_ID INTEGER NOT NULL ,
	 CCI_ID INTEGER NOT NULL ,
	 IsInherited NVARCHAR (5) ,
	 InheritedFrom NVARCHAR (50) ,
	 Inheritable NVARCHAR (5) ,
	 ImplementationStatus NVARCHAR (25) ,
	 ImplementationNotes NVARCHAR (500) ,
	 UNIQUE (Group_ID, CCI_ID) ON CONFLICT IGNORE,
	 FOREIGN KEY (Group_ID) REFERENCES Groups(Group_ID),
	 FOREIGN KEY (CCI_ID) REFERENCES CCIs(CCI_ID)
	);
CREATE TABLE GroupsOverlays
	(
	    GroupOverlay_ID INTEGER PRIMARY KEY ,
	 Group_ID INTEGER NOT NULL ,
	 Overlay_ID INTEGER NOT NULL ,
	 FOREIGN KEY (Group_ID) REFERENCES Groups(Group_ID),
	 FOREIGN KEY (Overlay_ID) REFERENCES Overlays(Overlay_ID)
	);
CREATE TABLE GroupsWaivers
	(
	    GroupWaiver_ID INTEGER PRIMARY KEY ,
	 Group_ID INTEGER NOT NULL ,
	 Waiver_ID INTEGER NOT NULL ,
	 WaiverGrantedDate DATE NOT NULL ,
	 WaiverExpirationDate DATE NOT NULL ,
	 FOREIGN KEY (Group_ID) REFERENCES Groups(Group_ID),
	 FOREIGN KEY (Waiver_ID) REFERENCES Waivers(Waiver_ID)
	);
CREATE TABLE GroupsMitigationsOrConditions
	(
	    GroupMitigationOrCondition_ID INTEGER PRIMARY KEY ,
	 MitigationOrCondition_ID INTEGER NOT NULL ,
	 Group_ID INTEGER NOT NULL ,
	 Vulnerability_ID INTEGER NOT NULL ,
	 UNIQUE (MitigationOrCondition_ID, Group_ID, Vulnerability_ID) ON CONFLICT IGNORE,
	 FOREIGN KEY (MitigationOrCondition_ID) REFERENCES MitigationsOrConditions(MitigationOrCondition_ID),
	 FOREIGN KEY (Group_ID) REFERENCES Groups(Group_ID) ,
	 FOREIGN KEY (Vulnerability_ID) REFERENCES Vulnerabilities(Vulnerability_ID)
	);
CREATE TABLE GroupsContacts
	(
	    GroupContact_ID INTEGER PRIMARY KEY ,
	 Group_ID INTEGER NOT NULL ,
	 Contact_ID INTEGER NOT NULL ,
	 FOREIGN KEY (Group_ID) REFERENCES Groups(Group_ID),
	 FOREIGN KEY (Contact_ID) REFERENCES Contacts(Contact_ID)
	);
CREATE TABLE Hardware
	(
	 Hardware_ID INTEGER PRIMARY KEY,
	 DisplayedHostName NVARCHAR (50),
	 HostName NVARCHAR (50),
	 FQDN NVARCHAR (100),
	 NetBIOS NVARCHAR (100) ,
	 ScanIP NVARCHAR (25),
	 Found21745 NVARCHAR (5),
	 Found26917 NVARCHAR (5),
	 IsVirtualServer NVARCHAR (5) ,
	 NIAP_Level NVARCHAR (25) ,
	 Manufacturer NVARCHAR (25) ,
	 ModelNumber NVARCHAR (50) ,
	 IsIA_Enabled NVARCHAR (5) ,
	 SerialNumber NVARCHAR (50) ,
	 Role NVARCHAR (25),
	 LifecycleStatus_ID INTEGER ,
	 OS NVARCHAR (100),
	 FOREIGN KEY (LifecycleStatus_ID) REFERENCES LifecycleStatuses(LifecycleStatus_ID),
	 UNIQUE (ScanIP, HostName, FQDN, NetBIOS) ON CONFLICT IGNORE
	);
CREATE TABLE HardwareMitigationsOrConditions
	(
	    HardwareMitigationOrCondition_ID INTEGER PRIMARY KEY ,
	 Hardware_ID INTEGER NOT NULL ,
	 MitigationOrCondition_ID INTEGER NOT NULL ,
	 FOREIGN KEY (Hardware_ID) REFERENCES Hardware(Hardware_ID),
	 FOREIGN KEY (MitigationOrCondition_ID) REFERENCES MitigationsOrConditions(MitigationOrCondition_ID)
	);
CREATE TABLE HardwarePortsProtocols
	(
	    HardwarePortsProtocols_ID INTEGER PRIMARY KEY ,
	 Hardware_ID INTEGER NOT NULL ,
	 PortsProtocols_ID INTEGER NOT NULL ,
	 ReportInAccreditation NVARCHAR (5) ,
	 DiscoveredService NVARCHAR (25) ,
	 DisplayService NVARCHAR (50),
	 Direction NVARCHAR (25) ,
	 BoundaryCrossed NVARCHAR (25) ,
	 DoD_Compliant NVARCHAR (5) ,
	 Classification NVARCHAR (25) ,
	 PRIMARY KEY (Hardware_ID, PortsProtocols_ID, DiscoveredService) ON CONFLICT IGNORE ,
	 FOREIGN KEY (Hardware_ID) REFERENCES Hardware(Hardware_ID),
	 FOREIGN KEY (PortsProtocols_ID) REFERENCES PortsProtocols(PortsProtocols_ID)
	);
CREATE TABLE HardwareContacts
	(
	    HardwareContact_ID INTEGER PRIMARY KEY ,
	 Hardware_ID INTEGER NOT NULL ,
	 Contact_ID INTEGER NOT NULL ,
	 FOREIGN KEY (Hardware_ID) REFERENCES Hardware(Hardware_ID),
	 FOREIGN KEY (Contact_ID) REFERENCES Contacts(Contact_ID)
	);
CREATE TABLE HardwareEnumeratedWindowsGroups
	(
	    HardwareEnumeratedWindowGroup_ID INTEGER PRIMARY KEY ,
	 Hardware_ID INTEGER NOT NULL ,
	 Group_ID INTEGER NOT NULL ,
        UNIQUE (Hardware_ID, Group_ID) ON CONFLICT IGNORE ,
            FOREIGN KEY (Hardware_ID) REFERENCES Hardware(Hardware_ID),
	 FOREIGN KEY (Group_ID) REFERENCES EnumeratedWindowsGroups(EnumeratedWindowsGroup_ID)
	);
CREATE TABLE HardwareGroups
	(
	    HardwareGroup_ID INTEGER PRIMARY KEY ,
	 Hardware_ID INTEGER NOT NULL ,
	 Group_ID INTEGER NOT NULL ,
        UNIQUE (Hardware_ID, Group_ID) ON CONFLICT IGNORE,
	 FOREIGN KEY (Hardware_ID) REFERENCES Hardware(Hardware_ID),
	 FOREIGN KEY (Group_ID) REFERENCES Groups(Group_ID)
	 
	);
CREATE TABLE Hardware_IP_Addresses
	(
	    Hardware_IP_Address_ID INTEGER PRIMARY KEY ,
	 Hardware_ID INTEGER NOT NULL ,
	 IP_Address_ID INTEGER NOT NULL ,
	 UNIQUE (Hardware_ID, IP_Address_ID) ON CONFLICT IGNORE,
	 FOREIGN KEY (Hardware_ID) REFERENCES Hardware(Hardware_ID),
	 FOREIGN KEY (IP_Address_ID) REFERENCES Ip_Addresses(IP_Address_ID)
	);
CREATE TABLE Hardware_MAC_Addresses
	(
	    Hardware_MAC_Address_ID INTEGER PRIMARY KEY ,
	 Hardware_ID INTEGER NOT NULL ,
	 MAC_Address_ID INTEGER NOT NULL ,
	 UNIQUE (Hardware_ID, MAC_Address_ID) ON CONFLICT IGNORE,
	 FOREIGN KEY (Hardware_ID) REFERENCES Hardware(Hardware_ID),
	 FOREIGN KEY (MAC_Address_ID) REFERENCES MAC_Addresses(MAC_Address_ID)
	);
CREATE TABLE HardwareLocation
	(
	    HardwareLocation_ID INTEGER PRIMARY KEY ,
	 Hardware_ID INTEGER NOT NULL ,
	 Location_ID INTEGER NOT NULL ,
	 IsBaselineLocation NVARCHAR (5) NOT NULL ,
	 IsDeploymentLocation NVARCHAR (5) NOT NULL ,
	 IsTestLocation NVARCHAR (5) NOT NULL ,
	 UNIQUE (Hardware_ID, Location_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (Hardware_ID) REFERENCES Hardware(Hardware_ID),
	 FOREIGN KEY (Location_ID) REFERENCES Locations(Location_ID)
	);
CREATE TABLE HardwareVulnerabilitySources
	(
	    HardwareVulnerabilitySource_ID INTEGER PRIMARY KEY ,
	 Hardware_ID INTEGER NOT NULL,
	 VulnerabilitySource_ID INTEGER NOT NULL,
	 FOREIGN KEY (Hardware_ID) REFERENCES Hardware(Hardware_ID),
	 FOREIGN KEY (VulnerabilitySource_ID) REFERENCES VulnerabilitySources(VulnerabilitySource_ID),
	 UNIQUE (Hardware_ID, VulnerabilitySource_ID) ON CONFLICT IGNORE
	);
CREATE TABLE IA_Controls
	(
	  IA_Control_ID INTEGER PRIMARY KEY ,
	  IA_ControlNumber NVARCHAR (10) NOT NULL,
	  Impact NVARCHAR (10) NOT NULL ,
	  IA_ControlSubjectArea NVARCHAR (50) NOT NULL ,
	  IA_ControlName NVARCHAR (100) NOT NULL ,
	  IA_ControlDescription NVARCHAR (250) NOT NULL ,
	  ThreatVulnerabilityCountermeasures NVARCHAR (2000) NOT NULL ,
	  GeneralImplementationGuidance NVARCHAR (2000) NOT NULL ,
	  SystemSpecificGuidanceResources NVARCHAR (2000) NOT NULL
	);
CREATE TABLE IATA_Standards
	(
	 IATA_Standard_ID INTEGER PRIMARY KEY ,
	 StandardTitle NVARCHAR (50) NOT NULL ,
	 StandardDescription NVARCHAR (1000) NOT NULL
	);
CREATE TABLE ImpactAdjustments
	(
	 ImpactAdjustment_ID INTEGER PRIMARY KEY ,
	 AdjustedConfidentiality NVARCHAR (25) NOT NULL ,
	 AdjustedIntegrity NVARCHAR (25) NOT NULL ,
	 AdjustedAvailability NVARCHAR (25) NOT NULL ,
	 FOREIGN KEY (ImpactAdjustment_ID) REFERENCES SystemCategorizationInformationTypes(ImpactAdjustment_ID)
	);
CREATE TABLE InformationSystemOwners
	(
	 InformationSystemOwner_ID INTEGER NOT NULL ,
	 Contact_ID INTEGER NOT NULL ,
	 FOREIGN KEY (InformationSystemOwner_ID) REFERENCES Overview(InformationSystemOwner_ID),
	 FOREIGN KEY (Contact_ID) REFERENCES Contacts(Contact_ID)
	);
CREATE TABLE InformationTypes
	(
	 InformationType_ID INTEGER PRIMARY KEY ,
	 InfoTypeId NVARCHAR (25) NOT NULL ,
	 InfoTypeName NVARCHAR (50) NOT NULL ,
	 BaselineConfidentiality NVARCHAR ,
	 BaselineIntegrity NVARCHAR ,
	 BaselineAvailability NVARCHAR ,
	 EnhancedConfidentiality NVARCHAR ,
	 EnhancedIntegrity NVARCHAR ,
	 EnhancedAvailability NVARCHAR
	);
CREATE TABLE InformationTypesMissionAreas
	(
	 InformationType_ID INTEGER NOT NULL ,
	 MissionArea_ID INTEGER NOT NULL ,
	 FOREIGN KEY (InformationType_ID) REFERENCES InformationTypes(InformationType_ID),
	 FOREIGN KEY (MissionArea_ID) REFERENCES MissionAreas(MissionArea_ID)
	);
CREATE TABLE IntegrityLevels
	(
	 IntegrityLevel_ID INTEGER PRIMARY KEY ,
	 IntegrityLevel NVARCHAR (25) NOT NULL
	);
CREATE TABLE InterconnectedSystems
	(
	 InterconnectedSystem_ID INTEGER PRIMARY KEY ,
	 InterconnectedSystemName NVARCHAR (50) NOT NULL
	);
CREATE TABLE IP_Addresses
	(
	 IP_Address_ID INTEGER PRIMARY KEY ,
	 IP_Address NVARCHAR (25) NOT NULL UNIQUE ON CONFLICT IGNORE
	);
CREATE TABLE JointAuthorizationOrganizations
	(
	 JointOrganization_ID INTEGER PRIMARY KEY ,
	 JointOrganizationName NVARCHAR (50) NOT NULL
	);
CREATE TABLE LifecycleStatuses
	(
	 LifecycleStatus_ID INTEGER PRIMARY KEY ,
	 LifecycleStatus NVARCHAR (25) NOT NULL
	);
CREATE TABLE Limitations
	(
	 Limitation_ID INTEGER PRIMARY KEY ,
	 LimitationSummary NVARCHAR (100) NOT NULL ,
	 LimitationBackground NVARCHAR (500) NOT NULL ,
	 LimitationDetails NVARCHAR (500) NOT NULL ,
	 IsTestException NVARCHAR (5) NOT NULL
	);
CREATE TABLE Locations
	(
	 Location_ID INTEGER PRIMARY KEY ,
	 LocationName NVARCHAR (50) NOT NULL ,
	 StreetAddressOne NVARCHAR (50) NOT NULL ,
	 StreeAddressTwo NVARCHAR (50) NOT NULL ,
	 BuildingNumber NVARCHAR (25) ,
	 FloorNumber INTEGER ,
	 RoomNumber INTEGER ,
	 City NVARCHAR (25) ,
	 State NVARCHAR (25) ,
	 Country NVARCHAR (25) NOT NULL ,
	 ZipCode INTEGER ,
	 APO_FPO NVARCHAR (50) ,
	 OSS_AccreditationDate DATE ,
	 IsBaselineLocationGlobal NVARCHAR (5) ,
	 IsDeploymentLocationGlobal NVARCHAR (5) ,
	 IsTestLocationGlobal NVARCHAR (5)
	);
CREATE TABLE MAC_Addresses
	(
	  MAC_Address_ID INTEGER PRIMARY KEY ,
	  MAC_Address NVARCHAR (50) NOT NULL UNIQUE ON CONFLICT IGNORE
	);
CREATE TABLE MedicalTechnologies
	(
	 MedicalTechnology_ID INTEGER PRIMARY KEY ,
	 MedicalImaging NVARCHAR (5) NOT NULL ,
	 MedicalMonitoring NVARCHAR (5) NOT NULL
	);
CREATE TABLE MissionAreas
	(
	 MissionArea_ID INTEGER PRIMARY KEY ,
	 MissionArea NVARCHAR (25) NOT NULL
	);
CREATE TABLE MitigationsOrConditions
	(
	 MitigationOrCondition_ID INTEGER PRIMARY KEY ,
	 ImpactDescription NVARCHAR (2000) ,
	 PredisposingConditions NVARCHAR (2000) ,
	 TechnicalMitigation NVARCHAR (2000) ,
	 ProposedMitigation NVARCHAR (2000) ,
	 ThreatRelevance NVARCHAR (10) ,
	 SeverityPervasiveness NVARCHAR (10) ,
	 Likelihood NVARCHAR (10) ,
	 Impact NVARCHAR (10) ,
	 Risk NVARCHAR (10) ,
	 ResidualRisk NVARCHAR (10) ,
	 ResidualRiskAfterProposed NVARCHAR (10) ,
	 MitigatedStatus NVARCHAR (25) ,
	 EstimatedCompletionDate DATE ,
	 ApprovalDate DATE ,
	 ExpirationDate DATE ,
	 IsApproved NVARCHAR (5) ,
	 Approver NVARCHAR (100)
	);
CREATE TABLE NavigationTransportationSystems
	(
	 NavigationSystem_ID INTEGER PRIMARY KEY ,
	 ShipAircraftControl NVARCHAR (5) NOT NULL ,
	 IntegratedBridge NVARCHAR (5) NOT NULL ,
	 ElectronicCharts NVARCHAR (5) NOT NULL ,
	 GPS NVARCHAR (5) NOT NULL ,
	 WSN NVARCHAR (5) NOT NULL ,
	 InertialNavigation NVARCHAR (5) NOT NULL ,
	 DeadReckoningDevice NVARCHAR (5) NOT NULL
	);
CREATE TABLE NetworkConnectionRules
	(
	 NetworkConnectionRule_ID INTEGER PRIMARY KEY ,
	 NetworkConnectionName NVARCHAR (25) NOT NULL ,
	 ConnectionRule NVARCHAR (100) NOT NULL
	);
CREATE TABLE NIST_Controls
	(
	 NIST_Control_ID INTEGER PRIMARY KEY ,
	 ControlFamily NVARCHAR (25) NOT NULL ,
	 ControlNumber INTEGER NOT NULL ,
	 ControlEnhancement INTEGER ,
	 ControlTitle NVARCHAR (50) NOT NULL ,
	 ControlText NVARCHAR (500) NOT NULL ,
	 Supplemental_Guidance NVARCHAR (500) NOT NULL ,
	 Monitoring_Frequency NVARCHAR (10)
	);
CREATE TABLE NIST_Controls_IATA_Standards
	(
	    NIST_ControlIATA_Standard_ID INTEGER PRIMARY KEY ,
	 NIST_Control_ID INTEGER NOT NULL ,
	 IATA_Standard_ID INTEGER NOT NULL ,
	 UNIQUE (NIST_Control_ID, IATA_Standard_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (NIST_Control_ID) REFERENCES NIST_Controls(NIST_Control_ID),
	 FOREIGN KEY (IATA_Standard_ID) REFERENCES IATA_Standards(IATA_Standard_ID)
	);
CREATE TABLE NIST_ControlsAvailabilityLevels
	(
	    NIST_ControlAvailabilityLevel_ID INTEGER PRIMARY KEY ,
	 NIST_Control_ID INTEGER NOT NULL ,
	 AvailabilityLevel_ID INTEGER NOT NULL ,
	 NSS_SystemsOnly NVARCHAR (10) NOT NULL,
	 UNIQUE (NIST_Control_ID, AvailabilityLevel_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (NIST_Control_ID) REFERENCES NIST_Controls(NIST_Control_ID),
	 FOREIGN KEY (AvailabilityLevel_ID) REFERENCES AvailabilityLevels(AvailabilityLevel_ID)
	);
CREATE TABLE NIST_ControlsCCIs
	(
	    NIST_ControlCCI_ID INTEGER PRIMARY KEY ,
	 NIST_Control_ID INTEGER NOT NULL ,
	 CCI_ID INTEGER NOT NULL ,
	 DOD_AssessmentProcedureMapping NVARCHAR (10),
	 ControlIndicator NVARCHAR (25) NOT NULL,
	 ImplementationGuidance NVARCHAR(1000) NOT NULL,
	 AssessmentProcedureText NVARCHAR(1000) NOT NULL,
	 UNIQUE (NIST_Control_ID, CCI_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (NIST_Control_ID) REFERENCES NIST_Controls(NIST_Control_ID),
	 FOREIGN KEY (CCI_ID) REFERENCES CCIs(CCI_ID)
	);
CREATE TABLE NIST_ControlsCAAs
	(
	    NIST_ControlCAA_ID INTEGER PRIMARY KEY ,
	 NIST_Control_ID INTEGER NOT NULL ,
	 CAA_ID INTEGER NOT NULL ,
	 LegacyDifficulty NVARCHAR (10) NOT NULL,
	 Applicability NVARCHAR (25) NOT NULL,
	 UNIQUE (NIST_Control_ID, CAA_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (NIST_Control_ID) REFERENCES NIST_Controls(NIST_Control_ID) ,
	 FOREIGN KEY (CAA_ID) REFERENCES ControlApplicabilityAssessment(CAA_ID)
	);
CREATE TABLE NIST_ControlsConfidentialityLevels
	(
	 NIST_Control_ID INTEGER PRIMARY KEY ,
	 ConfidentialityLevel_ID INTEGER NOT NULL ,
	 NSS_Systems_Only NVARCHAR (10) NOT NULL,
	 UNIQUE (NIST_Control_ID, ConfidentialityLevel_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (NIST_Control_ID) REFERENCES NIST_Controls(NIST_Control_ID),
	 FOREIGN KEY (ConfidentialityLevel_ID) REFERENCES ConfidentialityLevels(ConfidentialityLevel_ID)
	);
CREATE TABLE NIST_ControlsControlSets
	(
	    NIST_ControlsControlSet_ID INTEGER PRIMARY KEY ,
	 NIST_Control_ID INTEGER NOT NULL ,
	 ControlSet_ID INTEGER NOT NULL ,
	 UNIQUE (NIST_Control_ID, ControlSet_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (NIST_Control_ID) REFERENCES NIST_Controls(NIST_Control_ID),
	 FOREIGN KEY (ControlSet_ID) REFERENCES ControlSets(ControlSet_ID)
	);
CREATE TABLE NIST_ControlsCCPs
	(
	    NIST_ControlCCP_ID INTEGER PRIMARY KEY ,
	 NIST_Control_ID INTEGER NOT NULL ,
	 CCP_ID INTEGER NOT NULL ,
	 UNIQUE (NIST_Control_ID, CCP_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (NIST_Control_ID) REFERENCES NIST_Controls(NIST_Control_ID),
	 FOREIGN KEY (CCP_ID) REFERENCES CommonControlPackages(CCP_ID)
	);
CREATE TABLE NIST_ControlsIntegrityLevels
	(
	    NIST_ControlIntegrityLevel_ID INTEGER PRIMARY KEY ,
	 NIST_Control_ID INTEGER NOT NULL ,
	 IntegrityLevel_ID INTEGER NOT NULL ,
	 NSS_Systems_Only NVARCHAR (10) NOT NULL,
	 FOREIGN KEY (NIST_Control_ID) REFERENCES NIST_Controls(NIST_Control_ID),
	 FOREIGN KEY (IntegrityLevel_ID) REFERENCES IntegrityLevels(IntegrityLevel_ID)
	);
CREATE TABLE NIST_ControlsOverlays
	(
	    NIST_ControlOverlay_ID INTEGER PRIMARY KEY ,
	 NIST_Control_ID INTEGER NOT NULL ,
	 Overlay_ID INTEGER NOT NULL ,
	 UNIQUE (NIST_Control_ID, Overlay_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (NIST_Control_ID) REFERENCES NIST_Controls(NIST_Control_ID),
	 FOREIGN KEY (Overlay_ID) REFERENCES Overlays(Overlay_ID)
	);
CREATE TABLE NssQuestionnaire
	(
	 NssQuestionnaire_ID INTEGER PRIMARY KEY ,
	 InvolvesIntelligenceActivities NVARCHAR (5) NOT NULL ,
	 InvolvesCryptoActivities NVARCHAR (5) NOT NULL ,
	 InvolvesCommandAndControl NVARCHAR (5) NOT NULL ,
	 IsMilitaryCritical NVARCHAR (5) NOT NULL ,
	 IsBusinessInfo NVARCHAR (5) NOT NULL ,
	 HasExecutiveOrderProtections NVARCHAR (5) NOT NULL ,
	 IsNss NVARCHAR (5) NOT NULL
	);
CREATE TABLE Organizations
	(
	 Organization_ID INTEGER PRIMARY KEY ,
	 OrganizationName NVARCHAR (100) NOT NULL,
	 OrganizationAcronym NVARCHAR (100)
	);
CREATE TABLE Overlays
	(
	 Overlay_ID INTEGER PRIMARY KEY ,
	 Overlay NVARCHAR (25) NOT NULL
	);
CREATE TABLE Overview
	(
	 Overview_ID INTEGER PRIMARY KEY ,
	 RegistrationType NVARCHAR (25) NOT NULL ,
	 InformationSystemOwner_ID INTEGER NOT NULL ,
	 SystemType_ID INTEGER NOT NULL ,
	 DVS_Site NVARCHAR (100) ,
	 FOREIGN KEY (Overview_ID) REFERENCES StepOneQuestionnaire(Overview_ID),
	 FOREIGN KEY (SystemType_ID) REFERENCES SystemTypes(SystemType_ID)
	);
CREATE TABLE PIT_Determination
	(
	 PIT_Determination_ID INTEGER PRIMARY KEY ,
	 ReceivesInfo NVARCHAR (5) NOT NULL ,
	 TransmitsInfo NVARCHAR (5) NOT NULL ,
	 ProcessesInfo NVARCHAR (5) NOT NULL ,
	 StoresInfo NVARCHAR (5) NOT NULL ,
	 DisplaysInfo NVARCHAR (5) NOT NULL ,
	 EmbeddedInSpecialPurpose NVARCHAR (5) NOT NULL ,
	 IsDedicatedSpecialPurposeSystem NVARCHAR (5) NOT NULL ,
	 IsEssentialSpecialPurposeSystem NVARCHAR (5) NOT NULL ,
	 PerformsGeneralServices NVARCHAR (5) NOT NULL ,
	 IsTacticalDecisionAid NVARCHAR (5) ,
	 OtherSystemTypeDescription NVARCHAR (100) 
	);
CREATE TABLE PortsProtocols
	(
	 PortsProtocols_ID INTEGER PRIMARY KEY,
	 Port INTEGER NOT NULL,
	 Protocol NVARCHAR (25) NOT NULL ,
	 UNIQUE (Port, Protocol) ON CONFLICT IGNORE
	);
CREATE TABLE RelatedDocuments
	(
	 RelatedDocument_ID INTEGER PRIMARY KEY ,
	 RelatedDocumentName NVARCHAR (50) NOT NULL ,
	 RelationshipDescription NVARCHAR (100) NOT NULL
	);
CREATE TABLE RelatedTesting
	(
	 RelatedTesting_ID INTEGER PRIMARY KEY ,
	 TestTitle NVARCHAR (50) NOT NULL ,
	 DateConducted DATE NOT NULL ,
	 RelatedSystemTested NVARCHAR (50) NOT NULL ,
	 ResponsibleOrganization NVARCHAR (100) NOT NULL ,
	 TestingImpact NVARCHAR (500) NOT NULL
	);
CREATE TABLE ResearchWeaponsSystems
	(
	 ResearchWeaponsSystem_ID INTEGER PRIMARY KEY ,
	 RDTE_Network NVARCHAR (5) NOT NULL ,
	 RDTE_ConnectedSystem NVARCHAR (5) NOT NULL ,
	 PIT_Determination_ID INTEGER,
	 FOREIGN KEY (PIT_Determination_ID) REFERENCES PIT_Determination(PIT_Determination_ID)
	);
CREATE TABLE ResponsibilityRoles
	(
	  Role_ID INTEGER PRIMARY KEY ,
	  RoleTitle NVARCHAR (25) NOT NULL
	);
CREATE TABLE SAP_AdditionalTestConsiderations
	(
	    SAP_AdditionalTestConsiderations_ID INTEGER PRIMARY KEY ,
	 SAP_ID INTEGER NOT NULL ,
        AdditionalTestConsideration_ID INTEGER NOT NULL ,
    UNIQUE (SAP_ID, AdditionalTestConsideration_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (SAP_ID) REFERENCES SAPs(SAP_ID),
	 FOREIGN KEY (AdditionalTestConsideration_ID) REFERENCES AdditionalTestConsiderations(AdditionalTestConsideration_ID)
	);
CREATE TABLE SAP_CustomTestCases
	(
	    SAP_CustomTestCase_ID INTEGER PRIMARY KEY ,
	 SAP_ID INTEGER NOT NULL ,
	 CustomTestCase_ID INTEGER NOT NULL ,
	 UNIQUE (SAP_ID, CustomTestCase_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (SAP_ID) REFERENCES SAPs(SAP_ID),
	 FOREIGN KEY (CustomTestCase_ID) REFERENCES CustomTestCases(CustomTestCase_ID)
	);
CREATE TABLE SAP_EntranceCriteria
	(
	    SAP_EntranceCriteria_ID INTEGER PRIMARY KEY ,
	 SAP_ID INTEGER NOT NULL ,
	 EntranceCriteria_ID INTEGER NOT NULL ,
	 UNIQUE (SAP_ID, EntranceCriteria_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (SAP_ID) REFERENCES SAPs(SAP_ID),
	 FOREIGN KEY (EntranceCriteria_ID) REFERENCES EntranceCriteria(EntranceCriteria_ID)
	);
CREATE TABLE SAP_ExitCriteria
	(
	    SAP_ExitCriteria_ID INTEGER PRIMARY KEY ,
	 SAP_ID INTEGER NOT NULL ,
	 ExitCriteria_ID INTEGER NOT NULL ,
	 UNIQUE (SAP_ID, ExitCriteria_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (SAP_ID) REFERENCES SAPs(SAP_ID),
	 FOREIGN KEY (ExitCriteria_ID) REFERENCES ExitCriteria(ExitCriteria_ID)
	);
CREATE TABLE SAP_Limitiations
	(
	    SAP_Limitation_ID INTEGER PRIMARY KEY ,
	 SAP_ID INTEGER NOT NULL ,
	 Limitation_ID INTEGER NOT NULL ,
	 UNIQUE (SAP_ID, Limitation_ID) ON CONFLICT IGNORE ,
	 FOREIGN KEY (SAP_ID) REFERENCES SAPs(SAP_ID),
	 FOREIGN KEY (Limitation_ID) REFERENCES Limitations(Limitation_ID)
	);
/*TODO: Start here*/
CREATE TABLE SAP_RelatedDocuments
	(
	 SAP_ID INTEGER NOT NULL ,
	 RelatedDocument_ID INTEGER NOT NULL ,
	 FOREIGN KEY (SAP_ID) REFERENCES SAPs(SAP_ID),
	 FOREIGN KEY (RelatedDocument_ID) REFERENCES RelatedDocuments(RelatedDocument_ID)
	);
CREATE TABLE SAP_RelatedTesting
	(
	 SAP_ID INTEGER NOT NULL ,
	 RelatedTesting_ID INTEGER NOT NULL,
	 FOREIGN KEY (SAP_ID) REFERENCES SAPs(SAP_ID),
	 FOREIGN KEY (RelatedTesting_ID) REFERENCES RelatedTesting(RelatedTesting_ID)
	);
CREATE TABLE SAP_TestReferences
	(
	 SAP_ID INTEGER NOT NULL ,
	 TestReference_ID INTEGER NOT NULL ,
	 FOREIGN KEY (SAP_ID) REFERENCES SAPs(SAP_ID),
	 FOREIGN KEY (TestReference_ID) REFERENCES TestReferences(TestReference_ID)
	);
CREATE TABLE SAP_TestScheduleItems
	(
	 SAP_ID INTEGER NOT NULL ,
	 TestScheduleItem_ID INTEGER NOT NULL ,
	 FOREIGN KEY (SAP_ID) REFERENCES SAPs(SAP_ID),
	 FOREIGN KEY (TestScheduleItem_ID) REFERENCES TestScheduleItems(TestScheduleItem_ID)
	);
CREATE TABLE SAPs
	(
	 SAP_ID INTEGER PRIMARY KEY ,
	 Scope NVARCHAR (50) NOT NULL ,
	 Limitations NVARCHAR (500) NOT NULL ,
	 TestConfiguration NVARCHAR (2000) NOT NULL ,
	 LogisiticsSupport NVARCHAR (1000) NOT NULL ,
	 Security NVARCHAR (1000) NOT NULL
	);
CREATE TABLE ScapScores
	(
	 SCAP_Score_ID INTEGER PRIMARY KEY ,
	 Score INTEGER NOT NULL ,
	 Hardware_ID INTEGER NOT NULL ,
	 Finding_Source_File_ID INTEGER NOT NULL ,
	 Vulnerability_Source_ID INTEGER NOT NULL,
	 Scan_Date DATE NOT NULL ,
	 UNIQUE (Hardware_ID, Finding_Source_File_ID, Vulnerability_Source_ID) ON CONFLICT IGNORE,
	 FOREIGN KEY (Hardware_ID) REFERENCES Hardware(Hardware_ID),
	 FOREIGN KEY (Finding_Source_File_ID) REFERENCES UniqueFindingsSourceFiles(Finding_Source_File_ID),
	 FOREIGN KEY (Vulnerability_Source_ID) REFERENCES VulnerabilitySources(VulnerabilitySource_ID)
	);
CREATE TABLE Sensors
	(
	 Sensor_ID INTEGER PRIMARY KEY ,
	 RADAR NVARCHAR (5) NOT NULL ,
	 Acoustic NVARCHAR (5) NOT NULL ,
	 VisualAndImaging NVARCHAR (5) NOT NULL ,
	 RemoteVehicle NVARCHAR (5) NOT NULL ,
	 PassiveElectronicWarfare NVARCHAR (5) NOT NULL ,
	 ISR NVARCHAR (5) NOT NULL ,
	 National NVARCHAR (5) NOT NULL ,
	 NavigationAndControl NVARCHAR (5) NOT NULL ,
	 PIT_Determination_ID INTEGER NOT NULL,
	 FOREIGN KEY (PIT_Determination_ID) REFERENCES PIT_Determination(PIT_Determination_ID)
	);
CREATE TABLE PortServices
	(
	 PortService_ID INTEGER PRIMARY KEY,
	 PortServiceName NVARCHAR (100) NOT NULL UNIQUE ON CONFLICT IGNORE,
	 PortServiceAcronym NVARCHAR (50),
	 PortsProtocols_ID INTEGER NOT NULL,
	 UNIQUE (PortServiceName, PortsProtocols_ID) ON CONFLICT IGNORE,
	 FOREIGN KEY (PortsProtocols_ID) REFERENCES PortsProtocols(PortsProtocols_ID)
	 
	);
CREATE TABLE PortServicesSoftware
	(
	 PortServiceSoftware_ID INTEGER PRIMARY KEY,
	 PortService_ID INTEGER NOT NULL,
	 Software_ID INTEGER NOT NULL,
	 UNIQUE (PortService_ID, Software_ID) ON CONFLICT IGNORE,
	 FOREIGN KEY (PortService_ID) REFERENCES PortServices(PortService_ID),
	 FOREIGN KEY (Software_ID) REFERENCES Software(Software_ID)
	 
	);
CREATE TABLE Software
	(
	 Software_ID INTEGER PRIMARY KEY ,
	 Discovered_Software_Name NVARCHAR (50) NOT NULL UNIQUE ON CONFLICT IGNORE,
	 Displayed_Software_Name NVARCHAR (100) NOT NULL ,
	 Software_Acronym NVARCHAR (25) ,
	 Software_Version NVARCHAR (25) ,
	 Function NVARCHAR (500) ,
	 DADMS_ID NVARCHAR (25) ,
	 DADMS_Disposition NVARCHAR (25) ,
	 DADMS_LDA DATE ,
	 Has_Custom_Code NVARCHAR (5) ,
	 IaOrIa_Enabled NVARCHAR (5) ,
	 Is_OS_Or_Firmware NVARCHAR (5) ,
	 FAM_Accepted NVARCHAR (5) ,
	 Externally_Authorized NVARCHAR (5) ,
	 ReportInAccreditation_Global NVARCHAR (5) ,
	 ApprovedForBaseline_Global NVARCHAR (5) ,
	 BaselineApprover_Global NVARCHAR (50) ,
	 Instance NVARCHAR (25)
	);
CREATE TABLE Software_DADMS_Networks
	(
	 Software_ID INTEGER NOT NULL ,
	 DADMS_Network_ID INTEGER NOT NULL ,
	 FOREIGN KEY (Software_ID) REFERENCES Software(Software_ID),
	 FOREIGN KEY (DADMS_Network_ID) REFERENCES DADMS_Networks(DADMS_Network_ID)
	);
CREATE TABLE SoftwareContacts
	(
	 Software_ID INTEGER NOT NULL ,
	 Contact_ID INTEGER NOT NULL ,
	 FOREIGN KEY (Software_ID) REFERENCES Software(Software_ID),
	 FOREIGN KEY (Contact_ID) REFERENCES Contacts(Contact_ID)
	);
CREATE TABLE SoftwareHardware
	(
	 Software_ID INTEGER NOT NULL ,
	 Hardware_ID INTEGER NOT NULL ,
	 Install_Date DATE NOT NULL,
	 ReportInAccreditation NVARCHAR (5) ,
	 ApprovedForBaseline NVARCHAR (5) ,
	 BaselineApprover NVARCHAR (50) ,
	 FOREIGN KEY (Software_ID) REFERENCES Software(Software_ID),
	 FOREIGN KEY (Hardware_ID) REFERENCES Hardware(Hardware_ID),
	 UNIQUE (Software_ID, Hardware_ID) ON CONFLICT IGNORE
	);
CREATE TABLE SpecialPurposeConsoles
	(
	 SpecialPurposeConsole_ID INTEGER PRIMARY KEY ,
	 WarFighting NVARCHAR (5) NOT NULL ,
	 InputOutputConsole NVARCHAR (5) NOT NULL ,
	 FOREIGN KEY (SpecialPurposeConsole_ID) REFERENCES PIT_Determination(SpecialPurposeConsole_ID)
	);
CREATE TABLE StepOneQuestionnaire
	(
	 StepOneQuestionnaire_ID INTEGER PRIMARY KEY ,
	 SystemDescription NVARCHAR (2000) NOT NULL ,
	 MissionDescription NVARCHAR (2000) NOT NULL ,
	 CONOPS_Statement NVARCHAR (2000) NOT NULL ,
	 IsTypeAuthorization NVARCHAR (5) NOT NULL ,
	 RMF_Activity NVARCHAR (25) NOT NULL ,
	 Accessibility_ID INTEGER NOT NULL ,
	 Overview_ID INTEGER NOT NULL ,
	 PortsProtocolsM_RegistrationNumber NVARCHAR (25) NOT NULL ,
	 AuthorizationInformation_ID INTEGER NOT NULL ,
	 FISMA_ID INTEGER NOT NULL ,
	 Business_ID INTEGER NOT NULL ,
	 SystemEnterpriseArchitecture NVARCHAR (2000) NOT NULL ,
	 AuthorizationToConnectOrInterim_ATC_ID INTEGER ,
	 NistControlSet NVARCHAR (50) NOT NULL,
	 FOREIGN KEY (AuthorizationToConnectOrInterim_ATC_ID) REFERENCES AuthorizationToConnectOrInterim_ATC(AuthorizationToConnectOrInterim_ATC_ID)
	);
CREATE TABLE StepOneQuestionnaire_Connectivity
	(
	 StepOneQuestionnaire_ID INTEGER NOT NULL ,
	 Connectivity_ID INTEGER NOT NULL ,
	 FOREIGN KEY (StepOneQuestionnaire_ID) REFERENCES StepOneQuestionnaire(StepOneQuestionnaire_ID),
	 FOREIGN KEY (Connectivity_ID) REFERENCES Connectivity(Connectivity_ID)
	);
CREATE TABLE StepOneQuestionnaire_DitprDonNumbers
	(
	 StepOneQuestionnaire_ID INTEGER NOT NULL ,
	 DITPR_DON_Number_ID INTEGER NOT NULL ,
	 FOREIGN KEY (StepOneQuestionnaire_ID) REFERENCES StepOneQuestionnaire(StepOneQuestionnaire_ID),
	 FOREIGN KEY (DITPR_DON_Number_ID) REFERENCES DitprDonNumbers(DITPR_DON_Number_ID)
	);
CREATE TABLE StepOneQuestionnaire_ExternalSecurityServices
	(
	 StepOneQuestionnaire_ID INTEGER NOT NULL ,
	 ExternalSecurityServices_ID INTEGER NOT NULL ,
	 FOREIGN KEY (StepOneQuestionnaire_ID) REFERENCES StepOneQuestionnaire(StepOneQuestionnaire_ID),
	 FOREIGN KEY (ExternalSecurityServices_ID) REFERENCES ExternalSecurityServices(ExternalSecurityServices_ID)
	);
CREATE TABLE StepOneQuestionnaireEncryptionTechniques
	(
	 StepOneQuestionnaire_ID INTEGER NOT NULL ,
	 EncryptionTechnique_ID INTEGER NOT NULL ,
	 FOREIGN KEY (StepOneQuestionnaire_ID) REFERENCES StepOneQuestionnaire(StepOneQuestionnaire_ID),
	 FOREIGN KEY (EncryptionTechnique_ID) REFERENCES EncryptionTechniques(EncryptionTechnique_ID)
	);
CREATE TABLE StepOneQuestionnaireNetworkConnectionRules
	(
	 StepOneQuestionnaire_ID INTEGER NOT NULL ,
	 NetworkConnectionRule_ID INTEGER NOT NULL ,
	 FOREIGN KEY (StepOneQuestionnaire_ID) REFERENCES StepOneQuestionnaire(StepOneQuestionnaire_ID),
	 FOREIGN KEY (NetworkConnectionRule_ID) REFERENCES NetworkConnectionRules(NetworkConnectionRule_ID)
	);
CREATE TABLE StepOneQuestionnaireUserCategories
	(
	 StepOneQuestionnaire_ID INTEGER NOT NULL ,
	 UserCategory_ID INTEGER NOT NULL ,
	 FOREIGN KEY (StepOneQuestionnaire_ID) REFERENCES StepOneQuestionnaire(StepOneQuestionnaire_ID),
	 FOREIGN KEY (UserCategory_ID) REFERENCES UserCategories(UserCategory_ID)
	);
CREATE TABLE SystemCategorization
	(
	 SystemCategorization_ID INTEGER PRIMARY KEY ,
	 SystemClassification NVARCHAR (25) NOT NULL ,
	 InformationClassification NVARCHAR (25) NOT NULL ,
	 InformationReleasability NVARCHAR (25) NOT NULL ,
	 HasGoverningPolicy NVARCHAR (5) NOT NULL ,
	 VaryingClearanceRequirements NVARCHAR (5) NOT NULL ,
	 ClearanceRequirementDescription NVARCHAR (500) ,
	 HasAggergationImpact NVARCHAR (5) NOT NULL ,
	 IsJointAuthorization NVARCHAR (5) NOT NULL ,
	 NssQuestionnaire_ID INTEGER NOT NULL ,
	 CategorizationIsApproved NVARCHAR (5) NOT NULL ,
	 FOREIGN KEY (NssQuestionnaire_ID) REFERENCES NssQuestionnaire(NssQuestionnaire_ID)
	);
CREATE TABLE SystemCategorizationGoverningPolicies
	(
	 SystemCategorization_ID INTEGER NOT NULL ,
	 GoverningPolicy_ID INTEGER NOT NULL ,
	 FOREIGN KEY (SystemCategorization_ID) REFERENCES SystemCategorization(SystemCategorization_ID),
	 FOREIGN KEY (GoverningPolicy_ID) REFERENCES GoverningPolicies(GoverningPolicy_ID)
	);
CREATE TABLE SystemCategorizationInformationTypes
	(
	 SystemCategorizationInformationTypes_ID INTEGER NOT NULL ,
	 SystemCategorization_ID INTEGER NOT NULL ,
	 Description NVARCHAR (500) NOT NULL ,
	 InformationType_ID INTEGER NOT NULL ,
	 ImpactAdjustment_ID INTEGER NOT NULL ,
	 FOREIGN KEY (SystemCategorization_ID) REFERENCES SystemCategorization(SystemCategorization_ID),
	 FOREIGN KEY (InformationType_ID) REFERENCES InformationTypes(InformationType_ID)
	);
CREATE TABLE SystemCategorizationInterconnectedSystems
	(
	 SystemCategorization_ID INTEGER NOT NULL ,
	 InterconnectedSystem_ID INTEGER NOT NULL ,
	 FOREIGN KEY (SystemCategorization_ID) REFERENCES SystemCategorization(SystemCategorization_ID),
	 FOREIGN KEY (InterconnectedSystem_ID) REFERENCES InterconnectedSystems(InterconnectedSystem_ID)
	);
CREATE TABLE SystemCategorizationJointOrganizations
	(
	 SystemCategorization_ID INTEGER NOT NULL ,
	 JointOrganization_ID INTEGER NOT NULL ,
	 FOREIGN KEY (SystemCategorization_ID) REFERENCES SystemCategorization(SystemCategorization_ID),
	 FOREIGN KEY (JointOrganization_ID) REFERENCES JointAuthorizationOrganizations(JointOrganization_ID)
	);
CREATE TABLE SystemTypes
	(
	 SystemType_ID INTEGER PRIMARY KEY ,
	 SystemType NVARCHAR (100) NOT NULL
	);
CREATE TABLE TacticalSupportDatabases
	(
	 TacticalSupportDatabase_ID INTEGER PRIMARY KEY ,
	 ElectronicWarfare NVARCHAR (5) NOT NULL ,
	 Intelligence NVARCHAR (5) NOT NULL ,
	 Environmental NVARCHAR (5) NOT NULL ,
	 Acoustic NVARCHAR (5) NOT NULL ,
	 Geographic NVARCHAR (5) NOT NULL ,
	 FOREIGN KEY (TacticalSupportDatabase_ID) REFERENCES PIT_Determination(TacticalSupportDatabase_ID)
	);
CREATE TABLE TestReferences
	(
	 TestReference_ID INTEGER PRIMARY KEY ,
	 TestReferenceName NVARCHAR (100)
	);
CREATE TABLE TestScheduleItems
	(
	 TestScheduleItem_ID INTEGER PRIMARY KEY ,
	 TestEvent NVARCHAR (100) ,
	 Category_ID INTEGER NOT NULL ,
	 DurationInDays INTEGER NOT NULL ,
	 FOREIGN KEY (Category_ID) REFERENCES Categories(Category_ID)
	);
CREATE TABLE Titles
	(
	 Title_ID INTEGER PRIMARY KEY ,
	 Title NVARCHAR (25) NOT NULL
	);
CREATE TABLE TrainingSimulationSystems
	(
	 TrainingSimulationSystem_ID INTEGER PRIMARY KEY ,
	 FlightSimulator NVARCHAR (5) NOT NULL ,
	 BridgeSimulator NVARCHAR (5) NOT NULL ,
	 ClassroomNetworkOther NVARCHAR (5) NOT NULL ,
	 EmbeddedTactical NVARCHAR (5) NOT NULL ,
	 FOREIGN KEY (PIT) REFERENCES PIT_Determination(TrainingSimulation_ID)
	);
CREATE TABLE UniqueFindings
	(
	 Unique_Finding_ID INTEGER PRIMARY KEY ,
	 Instance_Identifier NVARCHAR(50) ,
	 Tool_Generated_Output NVARCHAR ,
	 Comments NVARCHAR ,
	 Finding_Details NVARCHAR ,
	 First_Discovered DATE NOT NULL,
	 Last_Observed DATE NOT NULL,
	 Delta_Analysis_Required NVARCHAR (5) NOT NULL ,
	 Finding_Type_ID INTEGER NOT NULL ,
	 Finding_Source_File_ID INTEGER NOT NULL ,
	 Status NVARCHAR (25) NOT NULL ,
	 Vulnerability_ID INTEGER NOT NULL ,
	 Hardware_ID INTEGER ,
	 Software_ID INTEGER ,
	 Severity_Override NVARCHAR (25),
	 Severity_Override_Justification NVARCHAR (2000),
	 Technology_Area NVARCHAR (100),
	 Web_DB_Site NVARCHAR(500),
	 Web_DB_Instance NVARCHAR(100),
	 Classification NVARCHAR (25),
	 CVSS_Environmental_Score NVARCHAR (5) ,
	 CVSS_Environmental_Vector NVARCHAR (25) ,
	 MitigationOrCondition_ID INTEGER ,
	 FOREIGN KEY (Finding_Type_ID) REFERENCES FindingTypes(FindingType_ID),
	 FOREIGN KEY (Vulnerability_ID) REFERENCES Vulnerabilities(Vulnerability_ID),
	 FOREIGN KEY (Hardware_ID) REFERENCES Hardware(Hardware_ID),
	 FOREIGN KEY (Software_ID) REFERENCES Software(Software_ID),
	 FOREIGN KEY (Finding_Source_File_ID) REFERENCES UniqueFindingsSourceFiles(Finding_Source_File_ID),
	 FOREIGN KEY (MitigationOrCondition_ID) REFERENCES MitigationsOrConditions(MitigationOrCondition_ID) ,
	 UNIQUE (Instance_Identifier, Hardware_ID, Software_ID, Vulnerability_ID) ON CONFLICT IGNORE
	);
CREATE TABLE UniqueFindingsSourceFiles
	(
	 Finding_Source_File_ID INTEGER PRIMARY KEY ,
	 Finding_Source_File_Name NVARCHAR (500) NOT NULL UNIQUE ON CONFLICT IGNORE
	);
CREATE TABLE UserCategories
	(
	 UserCategory_ID INTEGER PRIMARY KEY ,
	 UserCategory NVARCHAR (25)
	);
CREATE TABLE UtilityDistribution
	(
	 UtilityDistribution_ID INTEGER PRIMARY KEY ,
	 SCADA NVARCHAR (5) NOT NULL ,
	 UtilitiesEngineering NVARCHAR (5) NOT NULL ,
	 MeteringAndControl NVARCHAR (5) NOT NULL ,
	 MechanicalMonitoring NVARCHAR (5) NOT NULL ,
	 DamageControlMonitoring NVARCHAR (5) NOT NULL ,
	 FOREIGN KEY (UtilityDistribution_ID) REFERENCES PIT_Determination(UtilityDistribution_ID)
	);
CREATE TABLE VulnerabilitiesCCIs
	(
	 Vulnerability_ID INTEGER NOT NULL ,
	 CCI_ID INTEGER NOT NULL ,
	 PRIMARY KEY (Vulnerability_ID, CCI_ID) ,
	 FOREIGN KEY (Vulnerability_ID) REFERENCES Vulnerabilities(Vulnerability_ID),
	 FOREIGN KEY (CCI_ID) REFERENCES CCIs(CCI_ID)
	);
CREATE TABLE Vulnerabilities_IA_Controls
	(
	 Vulnerability_ID INTEGER NOT NULL ,
	 IA_Control_ID INTEGER NOT NULL ,
	 FOREIGN KEY (Vulnerability_ID) REFERENCES Vulnerabilities(Vulnerability_ID),
	 FOREIGN KEY (IA_Control_ID) REFERENCES IA_Controls(IA_Control_ID)
	);
CREATE TABLE Vulnerabilities
	(
	 Vulnerability_ID INTEGER PRIMARY KEY ,
	 Unique_Vulnerability_Identifier NVARCHAR (50) UNIQUE ON CONFLICT IGNORE NOT NULL,
	 Vulnerability_Group_ID NVARCHAR (25) ,
	 Vulnerability_Group_Title NVARCHAR (100) ,
	 Secondary_Vulnerability_Identifier NVARCHAR (25),
	 VulnerabilityFamilyOrClass NVARCHAR (100) ,
	 Vulnerability_Version NVARCHAR (25) ,
	 Vulnerability_Release NVARCHAR (25) ,
	 Vulnerability_Title NVARCHAR (100) NOT NULL ,
	 Vulnerability_Description NVARCHAR ,
	 Risk_Statement NVARCHAR ,
	 Fix_Text NVARCHAR ,
	 Published_Date DATE ,
	 Modified_Date DATE ,
	 Fix_Published_Date DATE ,
	 Raw_Risk NVARCHAR (25) NOT NULL ,
	 CVSS_Base_Score NVARCHAR (5) ,
	 CVSS_Base_Vector NVARCHAR (25) ,
	 CVSS_Temporal_Score NVARCHAR (5) ,
	 CVSS_Temporal_Vector NVARCHAR (25) ,
	 Check_Content NVARCHAR (2000),
	 False_Positives NVARCHAR (2000),
	 False_Negatives NVARCHAR (2000),
	 Documentable NVARCHAR (5),
	 Mitigations NVARCHAR (2000),
	 Mitigation_Control NVARCHAR (2000),
	 Potential_Impacts NVARCHAR (2000),
	 Third_Party_Tools NVARCHAR (500),
	 Security_Override_Guidance NVARCHAR (2000) ,
	 Overflow NVARCHAR (2000),
	 Is_Active NVARCHAR (5)
	);
CREATE TABLE Vulnerabilities_RoleResponsibilities
	(
	  Vulnerability_ID INTEGER NOT NULL ,
	  Role_ID INTEGER NOT NULL ,
	  FOREIGN KEY (Vulnerability_ID) REFERENCES Vulnerabilities(Vulnerability_ID),
	  FOREIGN KEY (Role_ID) REFERENCES ResponsibilityRoles(Role_ID)
	);
CREATE TABLE Vulnerabilities_VulnerabilitySources
	(
	  Vulnerability_ID INTEGER NOT NULL ,
	  Vulnerability_Source_ID INTEGER NOT NULL ,
	  PRIMARY KEY (Vulnerability_ID, Vulnerability_Source_ID) ON CONFLICT IGNORE,
	  FOREIGN KEY (Vulnerability_ID) REFERENCES Vulnerabilities(Vulnerability_ID),
	  FOREIGN KEY (Vulnerability_Source_ID) REFERENCES VulnerabilitySources(VulnerabilitySource_ID)
	);
CREATE TABLE Vulnerabilities_VulnerabilityReferences
	(
		Vulnerability_ID INTEGER NOT NULL,
		Reference_ID INTEGER NOT NULL,
		UNIQUE (Vulnerability_ID, Reference_ID) ON CONFLICT IGNORE,
		FOREIGN KEY (Vulnerability_ID) REFERENCES Vulnerabilities(Vulnerability_ID),
		FOREIGN KEY (Reference_ID) REFERENCES VulnerabilityReferences(Reference_ID)
	);
CREATE TABLE VulnerabilityReferences
	(
		Reference_ID INTEGER PRIMARY KEY,
		Reference NVARCHAR (50),
		Reference_Type NVARCHAR (10),
		UNIQUE (Reference, Reference_Type) ON CONFLICT IGNORE
	);
CREATE TABLE VulnerabilitySources
	(
        VulnerabilitySource_ID INTEGER PRIMARY KEY ,
	 Source_Name NVARCHAR (100) NOT NULL,
	 Source_Secondary_Identifier NVARCHAR (100),
	 Vulnerability_Source_File_Name NVARCHAR (500) ,
	 Source_Description NVARCHAR (2000) ,
	 Source_Version NVARCHAR (25) NOT NULL,
	 Source_Release NVARCHAR (25) NOT NULL,
	 UNIQUE (Source_Name, Source_Version, Source_Release) ON CONFLICT IGNORE
	);
CREATE TABLE Waivers
	(
	 Waiver_ID INTEGER PRIMARY KEY ,
	 Waiver_Name NVARCHAR (100) NOT NULL
	);
CREATE TABLE WeaponsSystems
	(
	 WeaponsSystem_ID INTEGER PRIMARY KEY ,
	 FireControlAndTargeting NVARCHAR (5) NOT NULL ,
	 Missile NVARCHAR (5) NOT NULL ,
	 Gun NVARCHAR (5) NOT NULL ,
	 Torpedoes NVARCHAR (5) NOT NULL ,
	 ActiveElectronicWarfare NVARCHAR (5) NOT NULL ,
	 Launchers NVARCHAR (5) NOT NULL ,
	 Decoy NVARCHAR (5) NOT NULL ,
	 Vehicles NVARCHAR (5) NOT NULL ,
	 Tanks NVARCHAR (5) NOT NULL ,
	 Artillery NVARCHAR (5) NOT NULL ,
	 ManDeployableWeapons NVARCHAR (5) NOT NULL ,
	 FOREIGN KEY (WeaponsSystem_ID) REFERENCES PIT_Determination(WeaponsSystem_ID)
	);
CREATE TABLE WindowsDomainUserSettings
	(
        WindowsDomainSettings_ID INTEGER PRIMARY KEY ,
	 DomainIsDisabled NVARCHAR (5) NOT NULL ,
	 DomainIsDisabledAutomatically NVARCHAR (5) NOT NULL ,
	 DomainCantChangePW NVARCHAR (5) NOT NULL ,
	 DomainNeverChangedPW NVARCHAR (5) NOT NULL ,
	 DomainNeverLoggedOn NVARCHAR (5) NOT NULL ,
	 DomainPW_NeverExpires NVARCHAR (5) NOT NULL
	);
CREATE TABLE WindowsLocalUserSettings
	(
        WindowsLocalSettings_ID INTEGER PRIMARY KEY ,
	 LocalIsDisabled NVARCHAR (5) NOT NULL ,
	 LocalIsDisabledAutomatically NVARCHAR (5) NOT NULL ,
	 LocalCantChangePW NVARCHAR (5) NOT NULL ,
	 LocalNeverChangedPW NVARCHAR (5) NOT NULL ,
	 LocalNeverLoggedOn NVARCHAR (5) NOT NULL ,
	 LocalPW_NeverExpires NVARCHAR (5) NOT NULL
	);
CREATE TABLE RequiredReports
	(
	 Required_Report_ID INTEGER PRIMARY KEY ,
	 Displayed_Report_Name NVARCHAR (50) NOT NULL ,
	 Report_Type NVARCHAR (10) NOT NULL ,
	 Is_Report_Enabled NVARCHAR (5) NOT NULL,
	 Is_Report_Selected NVARCHAR (5) NOT NULL,
	 Report_Category_ID INTEGER NOT NULL ,
	 FOREIGN KEY (Report_Category_ID) REFERENCES ReportCategories(Report_Category_ID)
	);
CREATE TABLE ReportCategories
	(
	 Report_Category_ID INTEGER PRIMARY KEY,
	 Report_Category_Name NVARCHAR (25) NOT NULL
	);
CREATE TABLE ReportFindingTypes
	(
	 Required_Report_ID INTEGER NOT NULL,
	 Finding_Type_ID INTEGER NOT NULL,
	 UserName NVARCHAR (50) NOT NULL,
	 FOREIGN KEY (Required_Report_ID) REFERENCES RequiredReports(Required_Report_ID),
	 FOREIGN KEY (Finding_Type_ID) REFERENCES FindingTypes(FindingType_ID),
	 UNIQUE (Required_Report_ID, Finding_Type_ID, UserName) ON CONFLICT IGNORE
	);
CREATE TABLE ReportSeverities
	(
	 Required_Report_ID INTEGER NOT NULL,
	 UserName NVARCHAR (50) NOT NULL,
	 ReportCatI INTEGER NOT NULL,
	 ReportCatII INTEGER NOT NULL,
	 ReportCatIII INTEGER NOT NULL,
	 ReportCatIV INTEGER NOT NULL,
	 FOREIGN KEY (Required_Report_ID) REFERENCES RequiredReports(Required_Report_ID),
	 UNIQUE (Required_Report_ID, UserName) ON CONFLICT IGNORE
	);
INSERT INTO Groups VALUES (NULL, 'All', NULL, 1, 'False', NULL, 'False', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'False', NULL, 'False', NULL, NULL, NULL, NULL, NULL);
INSERT INTO FindingTypes VALUES (NULL, 'ACAS');
INSERT INTO FindingTypes VALUES (NULL, 'Fortify');
INSERT INTO FindingTypes VALUES (NULL, 'CKL');
INSERT INTO FindingTypes VALUES (NULL, 'XCCDF');
INSERT INTO FindingTypes VALUES (NULL, 'WASSP');
INSERT INTO AvailabilityLevels VALUES (NULL, 'High');
INSERT INTO AvailabilityLevels VALUES (NULL, 'Moderate');
INSERT INTO AvailabilityLevels VALUES (NULL, 'Low');
INSERT INTO ConfidentialityLevels VALUES (NULL, 'High');
INSERT INTO ConfidentialityLevels VALUES (NULL, 'Moderate');
INSERT INTO ConfidentialityLevels VALUES (NULL, 'Low');
INSERT INTO IntegrityLevels VALUES (NULL, 'High');
INSERT INTO IntegrityLevels VALUES (NULL, 'Moderate');
INSERT INTO IntegrityLevels VALUES (NULL, 'Low');
INSERT INTO Overlays VALUES (NULL, 'Classified');
INSERT INTO Overlays VALUES (NULL, 'CDS Access');
INSERT INTO Overlays VALUES (NULL, 'CDS Multilevel');
INSERT INTO Overlays VALUES (NULL, 'CDS Transfer');
INSERT INTO Overlays VALUES (NULL, 'Intelligence A');
INSERT INTO Overlays VALUES (NULL, 'Intelligence B');
INSERT INTO Overlays VALUES (NULL, 'Intelligence C');
INSERT INTO Overlays VALUES (NULL, 'NC3');
INSERT INTO Overlays VALUES (NULL, 'Privacy Low');
INSERT INTO Overlays VALUES (NULL, 'Privacy High');
INSERT INTO Overlays VALUES (NULL, 'Privacy Moderate');
INSERT INTO Overlays VALUES (NULL, 'Privacy PHI');
INSERT INTO Overlays VALUES (NULL, 'Space');
INSERT INTO LifecycleStatuses VALUES (NULL, 'Uncategorized');
INSERT INTO LifecycleStatuses VALUES (NULL, 'Pending');
INSERT INTO LifecycleStatuses VALUES (NULL, 'Active');
INSERT INTO LifecycleStatuses VALUES (NULL, 'Decommissioned');
INSERT INTO ReportCategories VALUES (NULL, 'Vulnerability Management');
INSERT INTO ReportCategories VALUES (NULL, 'Configuration Management');
INSERT INTO ReportCategories VALUES (NULL, 'RMF');
INSERT INTO RequiredReports VALUES (NULL, 'Excel Summary', 'Excel', 'True', 'True', (SELECT Report_Category_ID FROM ReportCategories WHERE Report_Category_Name = 'Vulnerability Management'));
INSERT INTO RequiredReports VALUES (NULL, 'POA&M / RAR', 'Excel', 'True', 'True', (SELECT Report_Category_ID FROM ReportCategories WHERE Report_Category_Name = 'Vulnerability Management'));
INSERT INTO RequiredReports VALUES (NULL, 'SCAP & STIG Discrepancies', 'Excel', 'True', 'True', (SELECT Report_Category_ID FROM ReportCategories WHERE Report_Category_Name = 'Vulnerability Management'));
INSERT INTO RequiredReports VALUES (NULL, 'Vulnerability Deep Dive (By Finding Type)', 'Excel', 'True', 'True', (SELECT Report_Category_ID FROM ReportCategories WHERE Report_Category_Name = 'Vulnerability Management'));
INSERT INTO RequiredReports VALUES (NULL, 'Test Plan', 'Excel', 'True', 'True', (SELECT Report_Category_ID FROM ReportCategories WHERE Report_Category_Name = 'Vulnerability Management'));
INSERT INTO RequiredReports VALUES (NULL, 'OS Breakdown', 'Excel', 'False', 'False', (SELECT Report_Category_ID FROM ReportCategories WHERE Report_Category_Name = 'Configuration Management'));
INSERT INTO RequiredReports VALUES (NULL, 'User Breakdown', 'Excel', 'False', 'False', (SELECT Report_Category_ID FROM ReportCategories WHERE Report_Category_Name = 'Configuration Management'));
INSERT INTO RequiredReports VALUES (NULL, 'PDF Summary', 'PDF', 'False', 'False', (SELECT Report_Category_ID FROM ReportCategories WHERE Report_Category_Name = 'Vulnerability Management'));