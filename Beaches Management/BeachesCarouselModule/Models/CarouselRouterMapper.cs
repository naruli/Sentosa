using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.BeachesCarouselModule.Models
{
    public class CarouselRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("BeachesCarouselModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.BeachesCarouselModule.Models" });
        }
    }
}