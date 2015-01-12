﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.AttractionsModule.Models
{
    public class Attractions
    {
        public int Total { get; set; }
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
        public string Author { get; set; }
        public string Editor { get; set; }
        public string ColorOfSubMenu { get; set; }
        public string PathImage { get; set; }
        public float Latitude { get; set; }
        public float Longitude { get; set; }
    }
}