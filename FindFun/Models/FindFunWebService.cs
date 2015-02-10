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

namespace Sentosa.Modules.FindFun.Models
{
    public class ModuleFindFunController : DnnApiController
    {

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage getAllFindFun(string searchValue,string listParam)
        {
            try
            {
                var place = new FindFunController().GetPlace(searchValue,listParam).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, place);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage getListPage()
        {
            try
            {
                var place = new FindFunController().GetListPlace().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, place);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}