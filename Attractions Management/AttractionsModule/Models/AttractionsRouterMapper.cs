using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.AttractionsModule.Models
{
    public class AttractionsRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("AttractionsModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.AttractionsModule.Models" });
        }
    }
}