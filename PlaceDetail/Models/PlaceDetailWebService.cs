using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Net.Http;
using System.Web.Http;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Users;
using DotNetNuke.Web.Api;
using System.Net;

namespace Sentosa.Modules.PlaceDetail.Models
{
    public class ModulePlaceDetailController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetGallery(int CommonId)
        {
            try
            {
                var galleryDetail = new GalleryController().GetGallery(CommonId).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, galleryDetail);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetPlace(int TabId)
        {
            try
            {
                var place = new PlaceDetailController().GetPlace(TabId).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, place);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetSubPageDetail(int TabId)
        {
            try
            {
                var subPageDetail = new PlaceDetailController().GetSubPagePlace(TabId).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, subPageDetail);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

     
    }
}