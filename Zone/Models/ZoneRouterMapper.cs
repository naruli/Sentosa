using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;

namespace Sentosa.Modules.Zone.Models
{
    public class TagRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {

            mapRouteManager.MapHttpRoute("Zone", "default", "{controller}/{action}", new[] { "Sentosa.Modules.Zone.Models" });
        }
    }
}