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

namespace Sentosa.Modules.Zone.Models
{
    public class ModuleZoneController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetZone(int Id)
        {
            try
            {
                var zone = new ZoneController().GetZone(Id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, zone);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class ZoneToDeleteDTO
        {
            public int Id { get; set; }
        }


        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage DeleteZone(ZoneToDeleteDTO DTO)
        {
            try
            {
                var zone = new Zone()
                {
                    Id = DTO.Id
                };
                ZoneController ac = new ZoneController();


                ac.DeleteZone(zone);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}