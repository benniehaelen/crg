using System.Collections.Generic;
using CRG.Reporting.Domain;

namespace CRG.Reporting.Repository.Interfaces
{
    public interface IStatusCountValuesRepository
    {
        IEnumerable<StatusCountValue> GetAll(StatusCountValuesParameters parameters);

    } // interface IStatusCountValuesRepository
}
