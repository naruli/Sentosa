using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;

namespace Sentosa.Modules.SlidingInfoModule.Models
{
    public class SlidingInfoModuleRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {

            mapRouteManager.MapHttpRoute("SlidingInfoModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.SlidingInfoModule.Models" });
        }
    }
}