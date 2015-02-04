using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.InstafeedModule.Models
{
    public class Instafeed
    {
        public int Id { get; set; }
        public string Url { get; set; }
        public DateTime CreatedDate { get; set; }
    }
}