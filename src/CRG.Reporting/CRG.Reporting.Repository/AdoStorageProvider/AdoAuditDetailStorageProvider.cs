using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using CRG.Reporting.Domain;
using CRG.Reporting.Repository.AdoStorageProvider.Mappers;
using CRG.Reporting.Repository.Interfaces;

namespace CRG.Reporting.Repository.AdoStorageProvider
{
    public class AdoAuditMasterDetailStorageProvider : IAuditDetailStorageProvider<AuditDetail>
    {
        private readonly string _connectionString;


        public AdoAuditMasterDetailStorageProvider()
        {
            _connectionString = ConfigurationManager.AppSettings["ConnectionString"];
        }

        public IEnumerable<AuditDetail> GetAllDetailAuditRecords(int masterKey)
        {
            const string query = "Audit.GetAllAuditPackageDetailRecords";
            var detailRecords = new List<AuditDetail>();

            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                using (var command = new SqlCommand(query, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("MasterKey", masterKey));
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var auditDetailRecord = AuditDetailMapper.MapReaderToAuditDetail(reader);
                            detailRecords.Add(auditDetailRecord);
                        }
                    }
                }
            }
            return detailRecords;
        }

        public AuditDetail GetSingle(int key)
        {
            throw new NotImplementedException();
        }

    } // class AdoAuditMasterDetailStorageProvider
}
