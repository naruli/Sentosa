using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


using DotNetNuke.Web.Api;
namespace Sentosa.Modules.EventsDetailModule.Models
{
    public class EventsDetailRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("EventsDetailModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.EventsDetailModule.Models" });
        }
    }
}