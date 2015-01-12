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
namespace Sentosa.Modules.EventsDetailModule.Models
{
    public class ModuleEventsDetailController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetEventsDetail(int id)
        {
            try
            {
                var EventsDetail = new EventsDetailController().GetEventsDetail(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, EventsDetail);
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
                var galleryDetail = new EventsDetailController().GetGalleryDetail(id).ToJson();
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
                var subMenuDetail = new EventsDetailController().GetSubMenuDetail(id).ToJson();
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
                var subPageDetail = new EventsDetailController().GetSubPageDetail(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, subPageDetail);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}