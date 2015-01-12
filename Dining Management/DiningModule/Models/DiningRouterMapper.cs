using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.DiningModule.Models
{
    public class DiningRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("DiningModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.DiningModule.Models" });
        }
    }
}