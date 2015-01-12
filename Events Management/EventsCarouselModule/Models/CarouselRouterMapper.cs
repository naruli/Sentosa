using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.EventsCarouselModule.Models
{
    public class CarouselRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("EventsCarouselModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.EventsCarouselModule.Models" });
        }
    }
}