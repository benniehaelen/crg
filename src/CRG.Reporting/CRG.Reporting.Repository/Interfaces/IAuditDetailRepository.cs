using System.Collections.Generic;
using CRG.Reporting.Domain;

namespace CRG.Reporting.Repository.Interfaces
{
    public interface IAuditDetailRepository<T> where T : IAuditEntity
    {
        /// <summary>
        /// This method returns all Detail Audit Records from the Repository
        /// </summary>
        /// <returns></returns>
        IEnumerable<T> GetAllDetailAuditRecords(int masterKey);

        /// <summary>
        /// This method returns a single Detail Audit Record
        /// from the repository
        /// </summary>
        /// <returns></returns>
        T GetSingle(int detailKey);

    } // interface IAuditDetailRepository

} // namespace 
