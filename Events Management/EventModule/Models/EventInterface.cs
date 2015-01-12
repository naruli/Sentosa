using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Sentosa.Modules.EventModule.Models
{
    interface EventInterface
    {
        /**
      * Get List Event (All or One Element)
      * 
      * return List Event
      * */
        IList<Event> GetEvent(int Id);


        /**
         * Save Promotion
         * 
         * return Promotion
         * */
        Event saveEvent(Event event_);


        /**
         * Update Promotion
         * 
         * return Promotion
         * */
        Event updateEvent(Event event_);



        /**
         * Delete Promotion
         * 
         * return bool (if true delete is success , if false delete is failed)
         * */
        bool deleteEventById(int Id);

        IList<Event> SearchEvents(string searchValue, string order, string list, int offset, int limit);

        ZoneDetail GetZoneDetails(int Id);
        bool SaveZoneDetails(int Id, float Lat, float Lng);
        bool DeleteZoneDetails(int Id);
    }
}
