using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.BeachesDetailModule.Models
{
    public class BeachesDetail
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Zone { get; set; }
        public string Status { get; set; }
        public string ShortDesc { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime UpdateDate { get; set; }
        public string Author { get; set; }
        public string Editor { get; set; }
        public string ColorOfSubMenu { get; set; }
        public string UrlBrochure { get; set; }
        public string PathImage { get; set; }
        public float Longitude { get; set; }
        public float Latitude { get; set; }
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
        public string SafetyTitle { get; set; }
        public string SafetyInfo { get; set; }
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