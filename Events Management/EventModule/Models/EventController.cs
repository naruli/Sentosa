using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.EventModule.Models
{
    public class EventController : EventInterface
    {
        public IList<Event> GetEvent(int Id)
        {
            return CBO.FillCollection<Event>(DataProvider.Instance().ExecuteReader("GetEvents", Id));
        }

        public Event saveEvent(Event event_)
        {
            event_.Id = DataProvider.Instance().ExecuteScalar<int>("AddEvent",
                                                    event_.Title,
                                                    event_.Description,
                                                    event_.Zone,
                                                    event_.Status,
                                                    event_.ShortDesc,
                                                    event_.Category,
                                                    event_.UrlPurchase,
                                                    event_.ColorOfSubmenu,
                                                    event_.PathImage,
                                                    event_.StartDate,
                                                    event_.EndDate,
                                                    event_.Author,
                                                    event_.Editor,
                                                    event_.Url
                                                      );
            return event_;
        }

        public Event updateEvent(Event event_)
        {
            event_.Id = DataProvider.Instance().ExecuteScalar<int>("UpdateEvent",
                                                    event_.Id,
                                                    event_.Title,
                                                    event_.Description,
                                                    event_.Zone,
                                                    event_.Status,
                                                    event_.ShortDesc,
                                                    event_.Category,
                                                    event_.UrlPurchase,
                                                    event_.ColorOfSubmenu,
                                                    event_.StartDate,
                                                    event_.EndDate,
                                                    event_.Author,
                                                    event_.Editor,
                                                    event_.Url
                                                      );
            return event_;
        }

        public bool deleteEventById(int Id)
        {
            try
            {
                DataProvider.Instance().ExecuteNonQuery("DeleteEvent", Id);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }


        public IList<Event> SearchEvents(string searchValue, string order, string list, int offset, int limit)
        {
            return CBO.FillCollection<Event>(DataProvider.Instance().ExecuteReader("SearchEvents", searchValue, order, list, offset, limit));
        }

        public ZoneDetail GetZoneDetails(int Id)
        {
            ZoneDetail zone = new ZoneDetail();
            try
            {
                IList<ZoneDetail> listZone = CBO.FillCollection<ZoneDetail>(DataProvider.Instance().ExecuteReader("GetZoneEvent", Id));
                zone = listZone.FirstOrDefault();
                return zone;
            }
            catch (Exception ex)
            {
                return zone;
            }
        }

        public bool SaveZoneDetails(int Id, float Lat, float Lng)
        {
            try
            {
                DataProvider.Instance().ExecuteNonQuery("AddZoneEvent", Id, Lat, Lng);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool DeleteZoneDetails(int Id)
        {
            try
            {
                DataProvider.Instance().ExecuteNonQuery("DeleteZoneEvent", Id);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}