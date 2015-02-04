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

namespace Sentosa.Modules.InstafeedModule.Models
{
    public class ModuleInstafeedController : DnnApiController
    {
        public class InstafeedToAddDTO
        {
            public string Url { get; set; }
        }


        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage AddInstafeed(InstafeedToAddDTO DTO)
        {
            try
            {
                var instafeed = new Instafeed()
                {
                    Url = DTO.Url
                };


                InstafeedController ac = new InstafeedController();
                ac.AddInstafeed(instafeed);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage DeleteInstafeed()
        {
            try
            {
                InstafeedController ac = new InstafeedController();
                ac.DeleteInstafeed();
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}