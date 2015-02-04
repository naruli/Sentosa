using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.MenuModule.Models
{
    public class Result
    {
        public int TabID { get; set; }
        public string TabName { get; set; }
        public string ShortDescription { get; set; }
        public string Url { get; set; }
        public int _CountView { get; set; }
        public string TypeSearch { get; set; }
    }
}