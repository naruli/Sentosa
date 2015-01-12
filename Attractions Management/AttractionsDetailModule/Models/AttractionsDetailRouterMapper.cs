using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.AttractionsDetailModule.Models
{
    public class AttractionsDetailRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("AttractionsDetailModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.AttractionsDetailModule.Models" });
        }
    }
}