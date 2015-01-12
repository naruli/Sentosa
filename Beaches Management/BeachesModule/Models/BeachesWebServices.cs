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

namespace Sentosa.Modules.BeachesModule.Models
{
    public class ModuleBeachesController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage SearchBeaches(string searchValue, string order, int offset, int limit)
        {
            try
            {
                var beaches = new BeachesController().SearchBeaches(searchValue, order, offset, limit).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, beaches);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetAllBeaches()
        {
            try
            {
                var beaches = new BeachesController().GetBeaches(-4).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, beaches);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetBeaches(int id)
        {
            try
            {
                var beaches = new BeachesController().GetBeaches(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, beaches);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class BeachesToUpdateDTO
        {
            public int BTU_Id { get; set; }
            public string BTU_Title { get; set; }
            public string BTU_Description { get; set; }
            public string BTU_Zone { get; set; }
            public string BTU_ShortDesc { get; set; }
            public string BTU_UrlBrochure { get; set; }
            public string BTU_Author { get; set; }
            public float BTU_Latitude { get; set; }
            public float BTU_Longitude { get; set; }
            public string BTU_Editor { get; set; }
        }

        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage UpdateBeaches(BeachesToUpdateDTO DTO)
        {
            try
            {
                var beaches = new Beaches()
                {
                    Id = DTO.BTU_Id,
                    Title = DTO.BTU_Title,
                    Description = DTO.BTU_Description,
                    Zone = DTO.BTU_Zone,
                    ShortDesc = DTO.BTU_ShortDesc,
                    UrlBrochure = DTO.BTU_UrlBrochure,
                    Author = DTO.BTU_Author,
                    Latitude = DTO.BTU_Latitude,
                    Longitude = DTO.BTU_Longitude,
                    Editor = DTO.BTU_Editor
                };
                BeachesController ac = new BeachesController();
                ac.UpdateBeaches(beaches);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class BeachesToDeleteDTO
        {
            public int BTD_Id { get; set; }
        }
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage DeleteBeaches(BeachesToDeleteDTO DTO)
        {
            try
            {
                var beaches = new Beaches()
                {
                    Id = DTO.BTD_Id
                };
                BeachesController ac = new BeachesController();
                ac.DeleteBeaches(beaches);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}