using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Users;
using DotNetNuke.Web.Api;

namespace Sentosa.Modules.HappeningModule.Models
{
    public class ModuleHappeningController : DnnApiController
    {

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetContentHappening()
        {
            try
            {
                var happening = new HappeningController().GetContentHappening().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, happening);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetHappening(int TabId)
        {
            try
            {
                var happening = new HappeningController().GetHappening(TabId).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, happening);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}