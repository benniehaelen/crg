using System;
using System.Data.SqlClient;
using CRG.Reporting.Domain;

namespace CRG.Reporting.Repository.AdoStorageProvider.Mappers
{
    public static class AuditDetailMapper
    {
        public static AuditDetail MapReaderToAuditDetail(SqlDataReader reader)
        {
            var auditDetailRecord = new AuditDetail
            {
                Key = (int)reader[0],
                MasterKey =  (int)reader[1],
                PackageName = (string)reader[2],
                PackageGuid = (string)reader[3],
                PackageBuild = (int)reader[4],
                PackageVersionMajor = (int)reader[5],
                PackageVersionMinor = (int)reader[6],
                PackageStartDate = ((DateTime)reader[7]).ToString("g"),
                PackageEndDate = ((DateTime)reader[8]).ToString("g"),
                PackageSuccessful = (bool)reader[9],
                AdditionalInfo = (string)reader[10]
            };

            return auditDetailRecord;
        }

    } // class AuditDetailMapper

}
