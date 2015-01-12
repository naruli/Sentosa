using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.HappeningModule.Models
{
    public class Happening
    {
        public int Id { get; set; }
        public int IdRef { get; set; }
        public string TypeIdRef { get; set; }
        public bool IsStatic { get; set; }
        public int IdStaticRef { get; set; }

        public Content ContentDetail { get; set; }

        public int TotalRow { get; set; }
    }

    public class Content
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Zone { get; set; }
        public string Status { get; set; }
        public string ShortDesc { get; set; }
        public string Category { get; set; }
        public string UrlPurchase { get; set; }
        public string ColorOfSubmenu { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime UpdateDate { get; set; }
        public string Author { get; set; }
        public string Editor { get; set; }

        public string StartDate { get; set; }
        public string EndDate { get; set; }

        public string Url { get; set; }
        public string TypeContent { get; set; }

        public string PathImageThumb { get; set; }
    }
}