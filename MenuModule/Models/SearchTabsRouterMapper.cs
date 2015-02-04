using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;
namespace Sentosa.Modules.MenuModule.Models
{
    public class MenuModuleRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("MenuModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.MenuModule.Models" });
        }
    }
}