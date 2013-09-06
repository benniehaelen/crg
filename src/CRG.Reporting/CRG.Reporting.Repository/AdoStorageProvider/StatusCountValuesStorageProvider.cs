using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CRG.Reporting.Domain;
using CRG.Reporting.Repository.AdoStorageProvider.Mappers;
using CRG.Reporting.Repository.Interfaces;

namespace CRG.Reporting.Repository.AdoStorageProvider
{
    public class StatusCountValuesStorageProvider : IStatusCountValuesStorageProvider 
    {
        private readonly string _connectionString;


        public StatusCountValuesStorageProvider()
        {
            _connectionString = ConfigurationManager.AppSettings["ConnectionString"];
        }

        public IEnumerable<StatusCountValue> GetAll(StatusCountValuesParameters parameters)
        {
            string query = "DW.usp_GetStatusCountValues";
            var records = new List<StatusCountValue>();

            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                using (var command = new SqlCommand(query, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("startingYear", (int)parameters.StartingYear));
                    command.Parameters.Add(new SqlParameter("endingYear", (int)parameters.EndingYear));
                    command.Parameters.Add(new SqlParameter("caseWorkerKey", (int?)parameters.CaseWorkerKey));

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var statusCountValueRecord = StatusCountValueMapper.MapReaderToStatusCountValue(reader);
                            records.Add(statusCountValueRecord);

                        } // while reader
                    } // using reader
                } // using command
            } // using connection

            return records;

        } // method GetAll

    } // class StatusCountValuesStorageProvider

} // namespace 
