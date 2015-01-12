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

namespace Sentosa.Modules.DiningDetailModule.Models
{
    public class ModuleDiningDetailController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetDiningDetail(int id)
        {
            try
            {
                var diningDetail = new DiningDetailController().GetDiningDetail(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, diningDetail);
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
                var galleryDetail = new DiningDetailController().GetGalleryDetail(id).ToJson();
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
                var subMenuDetail = new DiningDetailController().GetSubMenuDetail(id).ToJson();
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
                var subPageDetail = new DiningDetailController().GetSubPageDetail(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, subPageDetail);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}