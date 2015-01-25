using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.Place.Models
{
    public class PlaceRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("Place", "default", "{controller}/{action}", new[] { "Sentosa.Modules.Place.Models" });
        }
    }
}