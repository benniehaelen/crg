using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CRG.Reporting.Domain;
using CRG.Reporting.Repository.Interfaces;
using CRG.Reporting.Repository.Repositories;

namespace CRG.Reporting.TestAuditRepository
{
    class Program
    {
        static void Main(string[] args)
        {
            var repository = new AuditMasterMasterRepository();
            foreach (var record in repository.GetAllMasterAuditRecords())
            {
                Console.WriteLine("Master Key: {0}", record.Key);
            }
        }
    }
}
