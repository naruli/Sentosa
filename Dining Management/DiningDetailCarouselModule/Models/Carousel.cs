using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.DiningDetailCarouselModule.Models
{
    public class Carousel
    {
        public int Id { get; set; }
        public string Caption { get; set; }
        public string Description { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime UpdateDate { get; set; }
        public string Author { get; set; }
        public string Editor { get; set; }
        public string Link { get; set; }
        public string Page { get; set; }
        public string Zone { get; set; }
        public string ExtraInformation { get; set; }
        public int OrderBanner { get; set; }
        public string PathImage { get; set; }
    }

    public class Dining
    {
        public int Total { get; set; }
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Zone { get; set; }
        public string Status { get; set; }
        public string ShortDesc { get; set; }
        public string UrlPurchase { get; set; }
        public string MenuLink { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime UpdateDate { get; set; }
        public string Author { get; set; }
        public string Editor { get; set; }
        public string ColorOfSubMenu { get; set; }
        public string PathImage { get; set; }
    }
}