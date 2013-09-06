using System;
using System.Collections.Generic;

namespace CRG.Reporting.Domain
{
    public class AuditMaster : IAuditEntity
    {
        public int Key { get; set; }
        public string PackageStartDate { get; set; }
        public string PackageEndDate { get; set; }
        public string PackageName { get; set; }
        public string PackageGuid { get; set; }
        public string PackageVersionGuid { get; set; }
        public bool PackageSuccessful { get; set; }
        public string OptionalFileName { get; set; }

    } // class AuditMaster

} // namespace 
