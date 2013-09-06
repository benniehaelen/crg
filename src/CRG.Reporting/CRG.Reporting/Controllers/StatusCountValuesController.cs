using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using CRG.Reporting.Domain;
using CRG.Reporting.Repository.Interfaces;
using CRG.Reporting.Repository.Repositories;

namespace CRG.Reporting.Controllers
{
    public class StatusCountValuesController : ApiController
    {
        private readonly IStatusCountValuesRepository _repository;

        public StatusCountValuesController()
        {
            _repository = new StatusCountValuesRepository();
        }


        public HttpResponseMessage Post(StatusCountValuesParameters parameters)
        {
            HttpResponseMessage msg;
            
            if (parameters.StartingYear < 2009)
            {
                msg = Request.CreateErrorResponse(
                            HttpStatusCode.NotFound,
                            String.Format("Starting Year value: {0} is invalid", parameters.StartingYear));
            }
            else
            {
                var records = _repository.GetAll(parameters);
                msg = Request.CreateResponse(
                    HttpStatusCode.OK, records);
            }

            return msg;

        } // method Get
    }
}
