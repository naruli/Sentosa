using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;
namespace Sentosa.Modules.FindFun.Models
{
    public class FindFunRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("FindFun", "default", "{controller}/{action}", new[] { "Sentosa.Modules.FindFun.Models" });
        }
    }
}