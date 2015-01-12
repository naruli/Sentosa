using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.EventsDetailModule.Models
{
    public class EventsDetail
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Zone { get; set; }
        public string Status { get; set; }
        public string ShortDesc { get; set; }
        public string Category { get; set; }
        public string UrlPurchase { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime UpdateDate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string Author { get; set; }
        public string Editor { get; set; }

        public string ColorOfSubmenu { get; set; }
        public string PathImage { get; set; }
        public float longitude { get; set; }
        public float latitude { get; set; }

        public string Url { get; set; }
    }

    public class GalleryDetail
    {
        public int Id { get; set; }
        public int IdDetail { get; set; }
        public string Path { get; set; }
        public string Description { get; set; }
        public bool Type { get; set; }
        public bool Thumbnail { get; set; }
    }

    public class SubPageDetail
    {
        public int Id { get; set; }
        public int IdDetail { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Instruction { get; set; }

        public string Template { get; set; }
    }

    public class SubMenuDetail
    {
        public int Id { get; set; }
        public int IdDetail { get; set; }
        public string Title { get; set; }
        public string Status { get; set; }
        public string Action { get; set; }
        public string Icon { get; set; }
    }
}