using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.BeachesDetailCarouselModule.Models
{
    public class CarouselRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("BeachesDetailCarouselModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.BeachesDetailCarouselModule.Models" });
        }
    }
}