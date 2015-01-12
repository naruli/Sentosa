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

namespace Sentosa.Modules.AttractionsDetailModule.Models
{
    public class ModuleAttractionsDetailController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetAttractionsDetail(int id)
        {
            try
            {
                var attractionsDetail = new AttractionsDetailController().GetAttractionsDetail(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, attractionsDetail);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetGalleryDetail(int id)
        {
            try
            {
                var galleryDetail = new AttractionsDetailController().GetGalleryDetail(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, galleryDetail);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetSubMenuDetail(int id)
        {
            try
            {
                var subMenuDetail = new AttractionsDetailController().GetSubMenuDetail(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, subMenuDetail);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetSubPageDetail(int id)
        {
            try
            {
                var subPageDetail = new AttractionsDetailController().GetSubPageDetail(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, subPageDetail);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}