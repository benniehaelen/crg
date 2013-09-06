using System.Data.SqlClient;
using CRG.Reporting.Domain;

namespace CRG.Reporting.Repository.AdoStorageProvider.Mappers
{
    public static class StatusCountValueMapper
    {
        public static StatusCountValue MapReaderToStatusCountValue(SqlDataReader reader)
        {
            var statusCountValue = new StatusCountValue
            {
                MonthKey = (int)reader[0],
                Year = (int)reader[1],
                MonthName = (string)reader[2],
                Repossessed = (int)reader[3],
                OnHold = (int)reader[4],
                Closed = (int)reader[5],
                Open = (int)reader[6],
                Reassigned = (int)reader[7],
                NeedInfo = (int)reader[8],
                ClosedPositiveResolution = (int)reader[9],
                Completed = (int)reader[10],
                PendingClose = (int)reader[11],
                PendingOnHold = (int)reader[12]
            };

            return statusCountValue;

        } // method MapReaderToStatusCountValue

    } // class StatusCountValueMapper

} // namespace 
