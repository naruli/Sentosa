using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.DiningDetailModule.Models
{
    public class DiningDetailRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("DiningDetailModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.DiningDetailModule.Models" });
        }
    }
}