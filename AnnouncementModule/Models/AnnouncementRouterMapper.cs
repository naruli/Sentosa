using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;

namespace Sentosa.Modules.AnnouncementModule.Models
{
    public class AnnouncementModuleRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {

            mapRouteManager.MapHttpRoute("AnnouncementModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.AnnouncementModule.Models" });
        }
    }
}