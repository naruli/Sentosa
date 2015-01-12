using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Users;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;
using DotNetNuke.Security;

namespace Sentosa.Modules.ExploreModule.Models
{
    public class ModuleExploreController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetExplore()
        {
            try
            {
                var explore = new ExploreController().GetExplore().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, explore);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}