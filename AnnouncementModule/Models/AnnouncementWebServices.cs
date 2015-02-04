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

namespace Sentosa.Modules.AnnouncementModule.Models
{
    public class ModuleAnnouncementController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetAnnouncement(int Id)
        {
            try
            {
                var announcement = new AnnouncementModuleController().GetAnnouncement(Id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, announcement);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class AnnouncementToDeleteDTO
        {
            public int Id { get; set; }
        }


        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage DeleteAnnouncement(AnnouncementToDeleteDTO DTO)
        {
            try
            {
                var announcement = new Announcement()
                {
                    Id = DTO.Id
                };
                AnnouncementModuleController ac = new AnnouncementModuleController();


                ac.DeleteAnnouncement(announcement);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}