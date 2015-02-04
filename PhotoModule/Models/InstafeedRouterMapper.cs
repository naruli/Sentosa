using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;

namespace Sentosa.Modules.PhotoModule.Models
{
    public class InstafeedModuleRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {

            mapRouteManager.MapHttpRoute("PhotoModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.PhotoModule.Models" });
        }
    }
}