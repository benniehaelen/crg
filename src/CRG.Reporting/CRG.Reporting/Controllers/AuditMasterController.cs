using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using CRG.Reporting.Domain;
using CRG.Reporting.Repository.Interfaces;
using CRG.Reporting.Repository.Repositories;

namespace CRG.Reporting.Controllers
{
    public class AuditMasterController : ApiController
    {
        private readonly IAuditMasterRepository<AuditMaster> _auditMasterRepository;

        public AuditMasterController()
        {
            _auditMasterRepository = new AuditMasterMasterRepository();
        }

        // GET api/Audit
        public IEnumerable<AuditMaster> Get()
        {
            return _auditMasterRepository.GetAllMasterAuditRecords();
        }

        //Get api/Audit/1
        public HttpResponseMessage Get(int id)
        {
            HttpResponseMessage msg;

            var record = _auditMasterRepository.GetSingle(id);
            if (record != null)
            {
                msg = Request.CreateResponse(
                            HttpStatusCode.OK,
                            record);
            }
            else
            {
                msg = Request.CreateErrorResponse(
                            HttpStatusCode.NotFound,
                            String.Format("Audit Record with key: {0} not found", id));
            }

            return msg;
        }


    } // class AuditController

} // namespace 
