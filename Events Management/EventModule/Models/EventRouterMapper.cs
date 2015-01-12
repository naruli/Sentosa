using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;
namespace Sentosa.Modules.EventModule.Models
{
    public class EventRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("EventModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.EventModule.Models" });
        }
    }
}