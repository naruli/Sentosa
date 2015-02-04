using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.SlidingInfoModule.Models
{
    public class Announcement
    {
        public int Id { get; set; }
        public string Content { get; set; }
    }

    public class AnnouncementPlace
    {
        public int Id { get; set; }
        public int TabId { get; set; }
        public int AnnouncementId { get; set; }
    }

    public class Weather
    {
    }
}