using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.BeachesDetailModule.Models
{
    public class BeachesDetailRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("BeachesDetailModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.BeachesDetailModule.Models" });
        }
    }
}