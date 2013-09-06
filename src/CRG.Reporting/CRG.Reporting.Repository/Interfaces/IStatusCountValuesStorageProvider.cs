using System.Collections.Generic;
using CRG.Reporting.Domain;

namespace CRG.Reporting.Repository.Interfaces
{
    public interface IStatusCountValuesStorageProvider
    {
        IEnumerable<StatusCountValue> GetAll(StatusCountValuesParameters parameters);
    }
}
