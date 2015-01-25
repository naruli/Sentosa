using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;
namespace Sentosa.Modules.WhatsNearby.Models
{
    public class WhatsNearbyRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("WhatsNearby", "default", "{controller}/{action}", new[] { "Sentosa.Modules.WhatsNearby.Models" });
        }
    }
}