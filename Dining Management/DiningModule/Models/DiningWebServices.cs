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

namespace Sentosa.Modules.DiningModule.Models
{
    public class ModuleDiningController : DnnApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage SearchDining(string searchValue, string order, string listDining, string listCuisine, int offset, int limit)
        {
            try
            {
                var dining = new DiningController().SearchDining(searchValue, order, listDining, listCuisine, offset, limit).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, dining);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetAllDining()
        {
            try
            {
                var dining = new DiningController().GetDining(-4).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, dining);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetDining(int id)
        {
            try
            {
                var dining = new DiningController().GetDining(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, dining);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetDiningExperience(int id)
        {
            try
            {
                var diningExperience = new DiningController().GetDiningExperience(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, diningExperience);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetCuisineType(int id)
        {
            try
            {
                var dining = new DiningController().GetCuisineType(id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, dining);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage ListDining()
        {
            try
            {
                var itemList = new ListController().GetItemListDining().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, itemList);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage ListCuisine()
        {
            try
            {
                var itemList = new ListController().GetItemListCuisine().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, itemList);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class DiningToUpdateDTO
        {
            public int DTU_Id { get; set; }
            public string DTU_Title { get; set; }
            public string DTU_Zone { get; set; }
            public string DTU_ShortDesc { get; set; }
            public string DTU_UrlPurchase { get; set; }
            public string DTU_MenuLink { get; set; }
            public string DTU_Author { get; set; }
            public float DTU_Latitude { get; set; }
            public float DTU_Longitude { get; set; }
            public string DTU_Editor { get; set; }
        }

        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage UpdateDining(DiningToUpdateDTO DTO)
        {
            try
            {
                var dining = new Dining()
                {
                    Id = DTO.DTU_Id,
                    Title = DTO.DTU_Title,
                    Zone = DTO.DTU_Zone,
                    ShortDesc = DTO.DTU_ShortDesc,
                    UrlPurchase = DTO.DTU_UrlPurchase,
                    MenuLink = DTO.DTU_MenuLink,
                    Author = DTO.DTU_Author,
                    Latitude = DTO.DTU_Latitude,
                    Longitude = DTO.DTU_Longitude,
                    Editor = DTO.DTU_Editor
                };
                DiningController ac = new DiningController();
                ac.UpdateDining(dining);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class DiningExperienceToUpdateDTO
        {
            public int DETU_Id { get; set; }
            public string DETU_Category { get; set; }
            public bool DETU_IsHave { get; set; }
        }

        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage UpdateDiningExperience(DiningExperienceToUpdateDTO DTO)
        {
            try
            {
                var diningExperience = new DiningExperience()
                {
                    Id = DTO.DETU_Id,
                    Category = DTO.DETU_Category,
                    IsHave = DTO.DETU_IsHave
                };
                DiningController ac = new DiningController();
                ac.UpdateDiningExperience(diningExperience);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class CuisineTypeToUpdateDTO
        {
            public int CTTU_Id { get; set; }
            public string CTTU_Category { get; set; }
            public bool CTTU_IsHave { get; set; }
        }

        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage UpdateCuisineType(CuisineTypeToUpdateDTO DTO)
        {
            try
            {
                var cuisineType = new CuisineType()
                {
                    Id = DTO.CTTU_Id,
                    Category = DTO.CTTU_Category,
                    IsHave = DTO.CTTU_IsHave
                };
                DiningController ac = new DiningController();
                ac.UpdateCuisineType(cuisineType);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class DiningToDeleteDTO
        {
            public int DTD_Id { get; set; }
        }
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage DeleteDining(DiningToDeleteDTO DTO)
        {
            try
            {
                var dining = new Dining()
                {
                    Id = DTO.DTD_Id
                };
                DiningController ac = new DiningController();
                ac.DeleteDining(dining);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}