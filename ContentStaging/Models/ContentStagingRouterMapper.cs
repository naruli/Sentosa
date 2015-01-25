using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.ContentStaging.Models
{
    public class ContentStagingRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("ContentStaging", "default", "{controller}/{action}", new[] { "Sentosa.Modules.ContentStaging.Models" });
        }
    }
}