using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.Carousel.Models
{
    public class CarouselPhotosController
    {
        public IList<CarouselPhoto> GetCarousel(int commonId)
        {
            return CBO.FillCollection<CarouselPhoto>(DataProvider.Instance().ExecuteReader("GetCarouselPhotos", commonId)); //get by common id
        }
    }
}