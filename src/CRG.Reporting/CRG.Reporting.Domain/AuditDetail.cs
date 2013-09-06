using System;

namespace CRG.Reporting.Domain
{
    public class AuditDetail : IAuditEntity
    {
        public int Key { get; set; }
        public int MasterKey { get; set; }
        public string PackageName { get; set; }
        public string PackageGuid { get; set; }
        public int PackageBuild { get; set; }
        public int PackageVersionMajor { get; set; }
        public int PackageVersionMinor { get; set; }
        public string PackageStartDate { get; set; }
        public string PackageEndDate { get; set; }
        public bool PackageSuccessful { get; set; }
        public string AdditionalInfo { get; set; }

    } // class AuditDetail
      
} // namespace 
