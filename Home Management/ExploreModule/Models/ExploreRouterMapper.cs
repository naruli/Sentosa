using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.ExploreModule.Models
{
    public class ExploreRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("ExploreModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.ExploreModule.Models" });
        }
    }
}