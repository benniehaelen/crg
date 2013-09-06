using System.Collections.Generic;
using CRG.Reporting.Domain;

namespace CRG.Reporting.Repository.Interfaces
{
    /// <summary>
    /// This interface defines the semantics for 
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public interface IAuditMasterStorageProvider<T> where T: IAuditEntity  
    {
        /// <summary>
        /// This method returns all Entities in the Storage
        /// </summary>
        /// <returns></returns>
        IEnumerable<T> GetAllMasterAuditRecords();

        /// <summary>
        /// This method returns a single Master Audit Record
        /// from the storage
        /// </summary>
        /// <returns></returns>
        T GetSingle(int key);

    } // interface IAuditMasterStorageProvider

} // namespace 
