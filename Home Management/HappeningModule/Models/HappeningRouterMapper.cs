using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;

namespace Sentosa.Modules.HappeningModule.Models
{
    public class HappeningRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {

            mapRouteManager.MapHttpRoute("HappeningModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.HappeningModule.Models" });
        }
    }
}