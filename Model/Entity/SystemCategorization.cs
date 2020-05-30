using System.ComponentModel;

namespace Vulnerator.Model.Entity
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("SystemCategorization")]
    public partial class SystemCategorization : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public SystemCategorization()
        {
            GoverningPolicies = new HashSet<GoverningPolicy>();
            InterconnectedSystems = new HashSet<InterconnectedSystem>();
            JointAuthorizationOrganizations = new HashSet<JointAuthorizationOrganization>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public long SystemCategorization_ID { get; set; }

        [Required]
        [StringLength(25)]
        public string SystemClassification { get; set; }

        [Required]
        [StringLength(25)]
        public string InformationClassification { get; set; }

        [Required]
        [StringLength(25)]
        public string InformationReleasability { get; set; }

        [Required]
        [StringLength(5)]
        public string HasGoverningPolicy { get; set; }

        [Required]
        [StringLength(5)]
        public string VaryingClearanceRequirements { get; set; }

        [StringLength(500)]
        public string ClearanceRequirementDescription { get; set; }

        [Required]
        [StringLength(5)]
        public string HasAggregationImpact { get; set; }

        [Required]
        [StringLength(5)]
        public string IsJointAuthorization { get; set; }

        public long NSS_Questionnaire_ID { get; set; }

        [Required]
        [StringLength(5)]
        public string CategorizationIsApproved { get; set; }

        public virtual Group Group { get; set; }
        
        public virtual ImpactAdjustment ImpactAdjustment { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GoverningPolicy> GoverningPolicies { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<InterconnectedSystem> InterconnectedSystems { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<JointAuthorizationOrganization> JointAuthorizationOrganizations { get; set; }
    }
}
