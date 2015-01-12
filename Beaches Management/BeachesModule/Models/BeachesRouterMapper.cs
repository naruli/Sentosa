using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.BeachesModule.Models
{
    public class BeachesRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("BeachesModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.BeachesModule.Models" });
        }
    }
}