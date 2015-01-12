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

namespace Sentosa.Modules.AttractionsModule.Models
{
    public class ModuleAttractionsController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage SearchAttractions(string searchValue, string order, string list, int offset, int limit)
        {
            try
            {
                var attractions = new AttractionsController().SearchAttractions(searchValue, order, list, offset, limit).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, attractions);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetAllAttractions()
        {
            try
            {
                var attractions = new AttractionsController().GetAttractions(-4).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, attractions);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetAttractions(int id)
        {
            try
            {
                var attractions = new AttractionsController().GetAttractions(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, attractions);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage ListAttractions(int id)
        {
            try
            {
                var itemList = new ListController().GetItemList(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, itemList);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class AttractionsToUpdateDTO
        {
            public int ATU_Id { get; set; }
            public string ATU_Title { get; set; }
            public string ATU_Zone { get; set; }
            public string ATU_ShortDesc { get; set; }
            public string ATU_Category { get; set; }
            public string ATU_UrlPurchase { get; set; }
            public string ATU_Author { get; set; }
            public float ATU_Latitude { get; set; }
            public float ATU_Longitude { get; set; }
            public string ATU_Editor { get; set; }
        }

        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage UpdateAttractions(AttractionsToUpdateDTO DTO)
        {
            try
            {
                var attractions = new Attractions()
                {
                    Id = DTO.ATU_Id,
                    Title = DTO.ATU_Title,
                    Zone = DTO.ATU_Zone,
                    ShortDesc = DTO.ATU_ShortDesc,
                    Category = DTO.ATU_Category,
                    UrlPurchase = DTO.ATU_UrlPurchase,
                    Author = DTO.ATU_Author,
                    Latitude = DTO.ATU_Latitude,
                    Longitude = DTO.ATU_Longitude,
                    Editor = DTO.ATU_Editor
                };
                AttractionsController ac = new AttractionsController();
                ac.UpdateAttractions(attractions);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class AttractionsToDeleteDTO
        {
            public int ATD_Id { get; set; }
        }
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage DeleteAttractions(AttractionsToDeleteDTO DTO)
        {
            try
            {
                var attractions = new Attractions()
                {
                    Id = DTO.ATD_Id
                };
                AttractionsController ac = new AttractionsController();
                ac.DeleteAttractions(attractions);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}