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

namespace Sentosa.Modules.MenuModule.Models
{
    public class ModuleMenuController : DnnApiController
    {

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage searchTabs(string key)
        {
            try
            {
                var place = new MenuModuleController().searchTabs(key).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, place);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage testSearchTabs(string key)
        {
            try
            {
                var place = new MenuModuleController().testSearchTabs(key).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, place);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}