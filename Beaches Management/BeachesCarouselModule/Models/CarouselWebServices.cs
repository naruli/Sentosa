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
using DotNetNuke.Security;

namespace Sentosa.Modules.BeachesCarouselModule.Models
{
    public class ModuleCarouselController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetCarousel(string Page)
        {
            try
            {
                var carousel = new CarouselController().GetCarousel(Page).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, carousel);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class CarouselToDeleteDTO
        {
            public int CTD_Id { get; set; }
        }
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage DeleteCarousel(CarouselToDeleteDTO DTO)
        {
            try
            {
                var carousel = new Carousel()
                {
                    Id = DTO.CTD_Id
                };
                CarouselController cc = new CarouselController();
                cc.DeleteCarousel(carousel);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}