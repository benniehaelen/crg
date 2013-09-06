using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CRG.Reporting.Domain;

namespace CRG.Reporting.Repository.Interfaces
{
    interface IAuditDetailStorageProvider<T> where T : IAuditEntity  
    {
        /// <summary>
        /// This method returns all Detail Entities in the Storage
        /// for the passed-in master Key
        /// </summary>
        /// <returns></returns>
        IEnumerable<T> GetAllDetailAuditRecords(int masterKey);

        /// <summary>
        /// This method returns a single Detail Audit Record
        /// from the storage
        /// </summary>
        /// <returns></returns>
        T GetSingle(int key);

    }
}
