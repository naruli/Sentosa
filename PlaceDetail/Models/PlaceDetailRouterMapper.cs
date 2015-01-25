using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


using DotNetNuke.Web.Api;

namespace Sentosa.Modules.PlaceDetail.Models
{
    public class PlaceDetailRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("PlaceDetail", "default", "{controller}/{action}", new[] { "Sentosa.Modules.PlaceDetail.Models" });
        }
    }
}