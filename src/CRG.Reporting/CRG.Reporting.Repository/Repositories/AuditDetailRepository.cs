using System.Collections.Generic;
using CRG.Reporting.Domain;
using CRG.Reporting.Repository.AdoStorageProvider;
using CRG.Reporting.Repository.Interfaces;

namespace CRG.Reporting.Repository.Repositories
{
    public class AuditDetailRepository : IAuditDetailRepository<AuditDetail>
    {
        private readonly IAuditDetailStorageProvider<AuditDetail> _detailStorageProvider;

        public AuditDetailRepository()
        {
            _detailStorageProvider = new AdoAuditMasterDetailStorageProvider();     
        }

        public IEnumerable<AuditDetail> GetAllDetailAuditRecords(int masterKey)
        {
            return _detailStorageProvider.GetAllDetailAuditRecords(masterKey);
        }

        public AuditDetail GetSingle(int key)
        {
            return _detailStorageProvider.GetSingle(key);
        }

    } // class AuditDetailRepository

} // namespace 
