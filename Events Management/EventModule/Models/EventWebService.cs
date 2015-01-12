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
namespace Sentosa.Modules.EventModule.Models
{
    public class ModuleEventController : DnnApiController
    {

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage SearchEvents(string searchValue, string order, string list, int offset, int limit)
        {
            try
            {
                var events = new EventController().SearchEvents(searchValue, order, list, offset, limit).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, events);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }


        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetListInterest()
        {
            try
            {

                int LIST_INTEREST_GROUP = 2;
                var event_ = new ListController().GetItemList(LIST_INTEREST_GROUP).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, event_);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }


        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetAllEvent()
        {
            try
            {


                var event_ = new EventController().GetEvent(-4).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, event_);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }


        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetEvent(int Id)
        {
            try
            {


                var event_ = new EventController().GetEvent(Id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, event_);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }


        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage saveEvent(
           EventToCreateDTO event_)
        {
            try
            {

                Event eventNew = new Event();
                //shopNew.Id = 1;
                eventNew.Title = event_.Title;
                eventNew.Description = event_.Description;
                eventNew.Zone = event_.Zone;
                eventNew.ShortDesc = event_.ShortDesc;
                eventNew.Category = event_.Category;
                eventNew.UrlPurchase = event_.UrlPurchase;
                eventNew.StartDate = event_.StartDate;
                eventNew.EndDate = event_.EndDate;
                eventNew.ColorOfSubmenu = "orange";
                //shopNew.CreateDate = DateTime.Now;
                //shopNew.UpdateDate = DateTime.Now;
                eventNew.Editor = event_.Editor;
                eventNew.Author = event_.Author;
                eventNew.Status = "PBL"; //Publish 
                eventNew.Url = event_.Url;


                var events = new EventController().saveEvent(eventNew).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, events);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage updateEvent(
          EventToCreateDTO event_)
        {
            try
            {

                Event eventNew = new Event();
                eventNew.Id = event_.Id;
                eventNew.Title = event_.Title;
                eventNew.Description = event_.Description;
                eventNew.Zone = event_.Zone;
                eventNew.ShortDesc = event_.ShortDesc;
                eventNew.Category = event_.Category;
                eventNew.UrlPurchase = event_.UrlPurchase;
                eventNew.StartDate = event_.StartDate;
                eventNew.EndDate = event_.EndDate;
                eventNew.ColorOfSubmenu = "orange";
                //shopNew.CreateDate = DateTime.Now;
                //shopNew.UpdateDate = DateTime.Now;
                eventNew.Editor = event_.Editor;
                eventNew.Author = event_.Author;
                eventNew.Status = "PBL"; //Publish 
                eventNew.Url = event_.Url;

                IList<Event> eventList = new EventController().GetEvent(event_.Id);
                Event eventSelected = eventList.FirstOrDefault();
                var events = new EventController().updateEvent(eventNew).ToJson();
                try
                {
                    if (event_.Latitude != "" || event_.Latitude != null)
                    {

                        if (!eventSelected.Zone.Equals(event_.Zone))
                        {
                            new EventController().DeleteZoneDetails(event_.Id);
                            new EventController().SaveZoneDetails(event_.Id, float.Parse(event_.Latitude), float.Parse(event_.Longitude));
                        }

                    }
                    return Request.CreateResponse(HttpStatusCode.OK, events);
                }
                catch (Exception ex)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, events);
                }


            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }

        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public HttpResponseMessage deleteEvent(
           EventToCreateDTO event_)
        {
            try
            {


                var events = new EventController().deleteEventById(event_.Id).ToJson();
                return Request.CreateResponse(HttpStatusCode.OK, events);
            }
            catch (Exception exc)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, exc);
            }
        }
    }

    public class EventToCreateDTO
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Zone { get; set; }
        public string ShortDesc { get; set; }
        public string Category { get; set; }
        public string UrlPurchase { get; set; }

        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }

        public string Url { get; set; }

        public string Author { get; set; }
        public string Editor { get; set; }
        public string Latitude { get; set; }
        public string Longitude { get; set; }
    }
}