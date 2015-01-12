using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.AttractionsCarouselModule.Models
{
    public class CarouselRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("AttractionsCarouselModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.AttractionsCarouselModule.Models" });
        }
    }
}