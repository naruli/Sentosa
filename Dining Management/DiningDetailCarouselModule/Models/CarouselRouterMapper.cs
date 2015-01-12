using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.DiningDetailCarouselModule.Models
{
    public class CarouselRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("DiningDetailCarouselModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.DiningDetailCarouselModule.Models" });
        }
    }
}