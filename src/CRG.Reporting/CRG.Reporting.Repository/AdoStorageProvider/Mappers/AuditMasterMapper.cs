using System;
using System.Data.SqlClient;
using CRG.Reporting.Domain;

namespace CRG.Reporting.Repository.AdoStorageProvider.Mappers
{
    public static class AuditMasterMapper
    {
        public static AuditMaster MapReaderToAuditMaster(SqlDataReader reader)
        {
            var auditMasterRecord = new AuditMaster
            {
                Key = (int)reader[0],
                PackageStartDate = ((DateTime)reader[1]).ToString("g"),
                PackageEndDate = ((DateTime)reader[2]).ToString("g"),
                PackageName = (string)reader[3],
                PackageGuid = (string)reader[4],
                PackageVersionGuid = (string)reader[5],
                PackageSuccessful = (bool)reader[6],
                OptionalFileName = (string)reader[7]
            };

            return auditMasterRecord;
        }
    }
}
