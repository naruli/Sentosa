using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;

namespace Sentosa.Modules.Tag.Models
{
    public class TagRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {

            mapRouteManager.MapHttpRoute("Tag", "default", "{controller}/{action}", new[] { "Sentosa.Modules.Tag.Models" });
        }
    }
}