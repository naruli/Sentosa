using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;

namespace Sentosa.Modules.ContactUs.Models
{
    public class InstafeedModuleRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {

            mapRouteManager.MapHttpRoute("InstafeedModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.InstafeedModule.Models" });
        }
    }
}