using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetNuke.Web.Api;

namespace Sentosa.Modules.Carousel.Models
{
    public class CarouselPhotosRouterMapper : IServiceRouteMapper
    {

        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("Carousel", "default", "{controller}/{action}", new[] { "Sentosa.Modules.Carousel.Models" });
        }
    }
}