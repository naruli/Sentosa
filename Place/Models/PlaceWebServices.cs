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

namespace Sentosa.Modules.Place.Models
{
    public class ModulePlaceController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetPlace(string groupname, int offset, int limit, string searchValue, string sortBy, string list)
        {
            try
            {
                var place = new PlaceController().GetPlace(groupname, offset, limit, searchValue, sortBy, list).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, place);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage ListPlace(string groupname)
        {
            try
            {
                var itemList = new PlaceController().GetList(groupname).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, itemList);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }       
    }
}