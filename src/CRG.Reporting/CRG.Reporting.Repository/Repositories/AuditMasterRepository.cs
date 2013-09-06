using System.Collections.Generic;
using CRG.Reporting.Domain;
using CRG.Reporting.Repository.AdoStorageProvider;
using CRG.Reporting.Repository.Interfaces;

namespace CRG.Reporting.Repository.Repositories
{
    /// <summary>
    /// This class implements the AuditRepository, allowing for the querying
    /// of both Master- and Detail Audit records
    /// </summary>
    public class AuditMasterMasterRepository : IAuditMasterRepository<AuditMaster>
    {
        private readonly IAuditMasterStorageProvider<AuditMaster> _masterStorageProvider;

        public AuditMasterMasterRepository()
        {
            _masterStorageProvider = new AdoAuditMasterMasterStorageProvider();     
        }

        public IEnumerable<AuditMaster> GetAllMasterAuditRecords()
        {
            return _masterStorageProvider.GetAllMasterAuditRecords();
        }

        public AuditMaster GetSingle(int key)
        {
            return _masterStorageProvider.GetSingle(key);
        }

    } // class  AuditRepository

} // namespace
