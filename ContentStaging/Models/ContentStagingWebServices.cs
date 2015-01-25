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

namespace Sentosa.Modules.ContentStaging.Models
{
    public class ModuleContentStagingController : DnnApiController
    {

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetPlaces(string groupname)
        {
            try
            {
                var places = new ContentStagingController().GetPlaces(groupname).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, places);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetPlace(int tabId)
        {
            try
            {
                var place = new ContentStagingController().GetPlace(tabId).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, place);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }


        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetTypePage(string groupname)
        {
            try
            {
                var place = new ContentStagingController().GetTypePage(groupname).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, place);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class PlaceToUpdateDTO
        {
            public int TabID { get; set; }
            public string ShortDescription { get; set; }
            public string AdmissionInfo { get; set; }
            public string OpeningHour { get; set; }
            public string NatureAgeRestrictions { get; set; }
            public string NatureGuidedTours { get; set; }
            public string EventStartDate { get; set; }
            public string EventEndDate { get; set; }
            public Nullable<int> ZoneId { get; set; }
            public string Timestamp { get; set; }
            public Nullable<int> CommonId { get; set; }
            public Nullable<int> LanguageId { get; set; }
            public string SourceUrl { get; set; }
            public string Highlight { get; set; }
            public string Details { get; set; }
            public string Phone { get; set; }
            public string Address { get; set; }
            public string OpeningTime { get; set; }
            public string ClosingTime { get; set; }
            public string Rank { get; set; }
            public Nullable<int> Status { get; set; }
            public string cluster_id { get; set; }
            public string Price { get; set; }
            public string BestStart { get; set; }
            public string BestEnd { get; set; }
            public string DurationEasy { get; set; }
            public string DurationModerate { get; set; }
            public string DurationExtreme { get; set; }
            public Nullable<bool> AllDay { get; set; }
            public Nullable<bool> IsRepeated { get; set; }
            public string StartTime { get; set; }
            public string EndTime { get; set; }
            public Nullable<int> SharingSetting { get; set; }
            public Nullable<int> PlaceId { get; set; }
            public string Instruction { get; set; }
            public string Lat { get; set; }
            public string Lng { get; set; }
            public Nullable<bool> AllTime { get; set; }
            public Nullable<int> Repeat { get; set; }
            public Nullable<int> Every { get; set; }
            public Nullable<int> Weekdays { get; set; }
            public Nullable<int> RepeatAfter { get; set; }
            public Nullable<int> RepeatBy { get; set; }
            public string ExceptDates { get; set; }
            public string start_date { get; set; }
            public string end_date { get; set; }
            public string Photo { get; set; }
            public Nullable<int> Category { get; set; }
            public Nullable<int> FiuzuSync { get; set; }
            public Nullable<int> XmobSync { get; set; }
        }

        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage UpdatePlace(PlaceToUpdateDTO DTO)
        {
            try
            {
                var place = new Place()
                {
              TabID = DTO.TabID,
              ShortDescription = DTO.ShortDescription,
              AdmissionInfo = DTO.AdmissionInfo,
              OpeningHour = DTO.OpeningHour,
              NatureAgeRestrictions =DTO.NatureAgeRestrictions,
              NatureGuidedTours = DTO.NatureGuidedTours,
              EventStartDate = DTO.EventStartDate,
              EventEndDate = DTO.EventEndDate,
              ZoneId = DTO.ZoneId,
              Timestamp = DTO.Timestamp,
              CommonId = DTO.CommonId,
              LanguageId = DTO.LanguageId,
              SourceUrl = DTO.SourceUrl,
              Highlight = DTO.Highlight,
              Details = DTO.Details,
              Phone = DTO.Phone,
              Address = DTO.Address,
              OpeningTime = DTO.OpeningTime,
              ClosingTime = DTO.ClosingTime,
              Rank = DTO.Rank,
              Status = DTO.Status,
              cluster_id = DTO.cluster_id,
              Price = DTO.Price,
              BestStart = DTO.BestStart,
              BestEnd = DTO.BestEnd,
              DurationEasy = DTO.DurationEasy,
              DurationModerate = DTO.DurationModerate,
              DurationExtreme = DTO.DurationExtreme,
              AllDay = DTO.AllDay,
              IsRepeated = DTO.IsRepeated,
              StartTime = DTO.StartTime,
              EndTime = DTO.EndTime,
              SharingSetting = DTO.SharingSetting,
              PlaceId = DTO.PlaceId,
              Instruction = DTO.Instruction,
              Lat = DTO.Lat,
              Lng = DTO.Lng,
              AllTime = DTO.AllTime,
              Repeat = DTO.Repeat,
              Every = DTO.Every,
              Weekdays = DTO.Weekdays,
              RepeatAfter = DTO.RepeatAfter,
              RepeatBy = DTO.RepeatBy,
              ExceptDates = DTO.ExceptDates,
              start_date = DTO.start_date,
              end_date = DTO.end_date,
              Photo = DTO.Photo,
              Category = DTO.Category,
              FiuzuSync = DTO.FiuzuSync,
              XmobSync = DTO.XmobSync
                };

                ContentStagingController ac = new ContentStagingController();
                ac.AddPlace(place);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
               return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class PlaceToDeleteDTO
        {
         
            public Nullable<int> CommonId { get; set; }
           
           
        }
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage DeletePlace(PlaceToDeleteDTO DTO)
        {
           try
            {
                var place = new Place()
                {
                    CommonId = DTO.CommonId
                };
                ContentStagingController ac = new ContentStagingController();
                ac.DeletePlace(place);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
       }

        /*List */
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage ListLanguage()
        {
            try
            {
                var itemList = new ContentStagingController().GetLanguage().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, itemList);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }


        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage ListCategory()
        {
            try
            {
                var itemList = new ContentStagingController().GetCategory().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, itemList);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage ListRepeatByChoice()
        {
            try
            {
                var itemList = new ContentStagingController().GetRepeatByChoice().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, itemList);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage ListWeekdayChoice()
        {
            try
            {
                var itemList = new ContentStagingController().GetWeekdayChoice().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, itemList);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage ListTypePage()
        {
            try
            {
                var itemList = new ContentStagingController().GetTypePage().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, itemList);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage ListSharingSetting()
        {
            try
            {
                var itemList = new ContentStagingController().GetSharingSetting().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, itemList);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage ListStatusSync()
        {
            try
            {
                var itemList = new ContentStagingController().GetStatusSync().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, itemList);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage ListStatusChoice()
        {
            try
            {
                var itemList = new ContentStagingController().GetStatusChoice().ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, itemList);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class CarouselToDeleteDTO
        {
            public int CTD_Id { get; set; } //photo id
        }

        public class CarouselToUpdateDTO
        {
            public int CommonId { get; set; } //common id
            public string Url { get; set; } //Url
        }


        /**
         * Get All image Carousel by Page // Common Id
         * */
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetCarousel(int CommonId)
        {
            try
            {
                var carousel = new ContentStagingController().GetCarousel(CommonId).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, carousel);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }



        /**
         * Delete Carousel Photo by Common Id and Photo Id
         * */
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage DeleteCarousel(CarouselToDeleteDTO DTO)
        {
            try
            {
                var carousel = new CarouselPhoto();
                carousel.Id = DTO.CTD_Id; //photos id

                ContentStagingController cc = new ContentStagingController();
                cc.DeleteCarousel(carousel);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }




        /**
         * Add Carousel Photo by Common Id and Photo Id
         * */
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage UpdateCarousel(CarouselToUpdateDTO DTO)
        {
            try
            {
                var carousel = new CarouselPhoto();
                carousel.CommonId = DTO.CommonId; //common id 
                carousel.Url = DTO.Url;

                ContentStagingController cc = new ContentStagingController();
                cc.AddCarousel(carousel);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetGallery(int CommonId, int Type)
        {
            try
            {
                var galleryDetail = new ContentStagingController().GetGallery(CommonId, Type).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, galleryDetail);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class GalleryToUpdateDTO
        {
            public int CommonId { get; set; }
            public string Url { get; set; }
            public int Type { get; set; } //0 is photo , 1 is video
        }


        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage UpdateGallery(GalleryToUpdateDTO DTO)
        {
            try
            {
                var gallery = new Gallery()
                {
                    CommonId = DTO.CommonId,
                    Type = DTO.Type,
                    Url = DTO.Url
                };


                ContentStagingController ac = new ContentStagingController();
                ac.UpdateGallery(gallery);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        public class GalleryToDeleteDTO
        {
            public int Id { get; set; }
            public int Type { get; set; } //0 is photo , 1 is video
        }


        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage DeleteGallery(GalleryToDeleteDTO DTO)
        {
            try
            {
                var gallery = new Gallery()
                {
                    Id = DTO.Id,
                    Type = DTO.Type
                };
                ContentStagingController ac = new ContentStagingController();


                ac.DeleteGallery(gallery);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }
}