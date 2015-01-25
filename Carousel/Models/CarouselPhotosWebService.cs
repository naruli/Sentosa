using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetNuke.Security;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Users;
using DotNetNuke.Web.Api;

using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sentosa.Modules.Carousel.Models
{
    public class ModuleCarouselPhotosController : DnnApiController
    {
        /**
         * Get All image Carousel by Page // Common Id
         * */
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetCarousel(int CommonId)
        {
            try
            {
                var carousel = new CarouselPhotosController().GetCarousel(CommonId).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, carousel);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

    }
}