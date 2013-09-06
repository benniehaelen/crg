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
    public class AdoAuditMasterMasterStorageProvider : IAuditMasterStorageProvider<AuditMaster>
    {
        private readonly string _connectionString;
            

        public AdoAuditMasterMasterStorageProvider()
        {
            _connectionString = ConfigurationManager.AppSettings["ConnectionString"];
        }

        public IEnumerable<AuditMaster> GetAllMasterAuditRecords()
        {
            string query = "Audit.GetAllAuditPackageMasterRecords";
            var records = new List<AuditMaster>();

            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                using (var command = new SqlCommand(query, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var auditMasterRecord = AuditMasterMapper.MapReaderToAuditMaster(reader);
                            records.Add(auditMasterRecord);
                        }
                    }
                }
            }

            return records;
        }


        private IEnumerable<AuditDetail> GetAuditDetailRecords(int masterKey)
        {
            string query = "Audit.GetAllAuditPackageDetailRecords";
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

        public AuditMaster GetSingle(int key)
        {
            string query = "Audit.GetAuditPackageMasterRecord";
            AuditMaster auditMasterRecord = null;

            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                using (var command = new SqlCommand(query, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("MasterKey", key));
                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            auditMasterRecord = AuditMasterMapper.MapReaderToAuditMaster(reader);
                        }
                    }
                }
            }

            return auditMasterRecord;

        } // method GetSingle


    } // class AdoAuditStorageProvider

} // namespace 
