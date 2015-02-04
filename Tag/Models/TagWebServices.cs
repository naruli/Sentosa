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

namespace Sentosa.Modules.Tag.Models
{
    public class ModuleTagController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetTag(int Id)
        {
            try
            {
                var tag = new TagController().GetTag(Id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, tag);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class TagToDeleteDTO
        {
            public int Id { get; set; }
        }


        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage DeleteTag(TagToDeleteDTO DTO)
        {
            try
            {
                var tag = new Tag()
                {
                    Id = DTO.Id
                };
                TagController ac = new TagController();


                ac.DeleteTag(tag);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}