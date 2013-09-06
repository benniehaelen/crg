using System.Collections.Generic;
using CRG.Reporting.Domain;
using CRG.Reporting.Repository.AdoStorageProvider;
using CRG.Reporting.Repository.Interfaces;

namespace CRG.Reporting.Repository.Repositories
{
    public class StatusCountValuesRepository : IStatusCountValuesRepository 
    {
       private readonly IStatusCountValuesStorageProvider _storageProvider;

       public StatusCountValuesRepository()
        {
            _storageProvider = new StatusCountValuesStorageProvider(); 
        }

        public IEnumerable<Domain.StatusCountValue> GetAll(StatusCountValuesParameters parameters)
        {
            return _storageProvider.GetAll(parameters);

        } // method GetAll

    } // class StatusCountValuesRepository

} // namespce
