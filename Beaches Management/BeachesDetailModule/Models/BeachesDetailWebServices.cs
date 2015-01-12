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

namespace Sentosa.Modules.BeachesDetailModule.Models
{
    public class ModuleBeachesDetailController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetBeachesDetail(int id)
        {
            try
            {
                var natureDetail = new BeachesDetailController().GetBeachesDetail(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, natureDetail);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetListBeaches(int id)
        {
            try
            {
                var listBeaches = new BeachesDetailController().GetListBeaches(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, listBeaches);
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
                var galleryDetail = new BeachesDetailController().GetGalleryDetail(id).ToJson();
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
                var subMenuDetail = new BeachesDetailController().GetSubMenuDetail(id).ToJson();
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
                var subPageDetail = new BeachesDetailController().GetSubPageDetail(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, subPageDetail);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}