using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.EventsDetailCarouselModule.Models
{
    public class CarouselRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("EventsDetailCarouselModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.EventsDetailCarouselModule.Models" });
        }
    }
}