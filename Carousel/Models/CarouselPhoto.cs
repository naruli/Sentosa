using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.Carousel.Models
{
    public class CarouselPhoto
    {
        public int Id { get; set; }
        public int CommonId { get; set; }
        public string Url { get; set; }
        public int OrderCarousel { get; set; }
        public string Caption { get; set; }
        public string Description { get; set; }
        public string Button { get; set; }
        public string Link { get; set; }
        public bool Position { get; set; }
        public int Color { get; set; }
    }
}