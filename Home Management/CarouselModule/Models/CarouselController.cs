using System;
using System.Collections.Generic;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.CarouselModule.Models
{
    public class CarouselController
    {
        public IList<Carousel> GetCarousel(string Page)
        {
            return CBO.FillCollection<Carousel>(DataProvider.Instance().ExecuteReader("GetCarousel", Page));
        }

        public void AddCarousel(Carousel carousel)
        {
            carousel.Id = DataProvider.Instance().ExecuteScalar<int>("AddCarousel",
                                                      carousel.Id, //id
                                                      carousel.Caption, //caption
                                                      carousel.Description, //description
                                                      carousel.Author, //author
                                                      carousel.Editor, //editor
                                                      carousel.Link, //link
                                                      carousel.Page, //name page
                                                      carousel.Zone, //Zone
                                                      carousel.ExtraInformation, //extra information
                                                      carousel.PathImage, //path image
                                                      carousel.OrderBanner //order
                                                        );
        }

        public void UpdateCarousel(Carousel carousel)
        {
            carousel.Id = DataProvider.Instance().ExecuteScalar<int>("UpdateCarousel",
                                                      carousel.Id, //id
                                                      carousel.Editor, //editor
                                                      carousel.OrderBanner //order
                                                        );
        }

        public void DeleteCarousel(Carousel carousel)
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteCarousel", carousel.Id);
        }
    }
}