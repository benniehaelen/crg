using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using CRG.Reporting.Domain;
using CRG.Reporting.Repository.Interfaces;
using CRG.Reporting.Repository.Repositories;

namespace CRG.Reporting.Controllers
{
    public class AuditDetailController : ApiController
    {
        private readonly IAuditDetailRepository<AuditDetail> _auditDetailRepository;

        public AuditDetailController()
        {
            _auditDetailRepository = new AuditDetailRepository();
        }

        // GET api/Audit
        public IEnumerable<AuditDetail> Get(int id)
        {
            return _auditDetailRepository.GetAllDetailAuditRecords(id);
        }
    }
}
