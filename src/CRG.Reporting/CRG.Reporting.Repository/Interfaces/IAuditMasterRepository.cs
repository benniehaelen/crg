using System.Collections.Generic;
using CRG.Reporting.Domain;

namespace CRG.Reporting.Repository.Interfaces
{
    public interface IAuditMasterRepository<T> where T : IAuditEntity
    {
        /// <summary>
        /// This method returns all Master Audit Records from the Repository
        /// </summary>
        /// <returns></returns>
        IEnumerable<T> GetAllMasterAuditRecords();

        /// <summary>
        /// This method returns a single Master Audit Record
        /// from the repository
        /// </summary>
        /// <returns></returns>
        T GetSingle(int key);

    } // interface IAuditMasterRepository

} // namespace 
