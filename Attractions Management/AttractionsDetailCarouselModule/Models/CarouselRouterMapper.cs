﻿using System;
using System.Collections.Generic;
using DotNetNuke.Web.Api;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.AttractionsDetailCarouselModule.Models
{
    public class CarouselRouterMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("AttractionsDetailCarouselModule", "default", "{controller}/{action}", new[] { "Sentosa.Modules.AttractionsDetailCarouselModule.Models" });
        }
    }
}