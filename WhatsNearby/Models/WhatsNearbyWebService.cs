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
namespace Sentosa.Modules.WhatsNearby.Models
{
    public class ModuleWhatsNearbyController : DnnApiController
    {

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetNearby(int TabId)
        {
            try
            {
                var nearby = new WhatsNearbyController().getContentNearby(TabId).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, nearby);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}