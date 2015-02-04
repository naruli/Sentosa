using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.PhotoModule.Models
{
    public class InstafeedController
    {
        public IList<Instafeed> GetInstafeed()
        {
            return CBO.FillCollection<Instafeed>(DataProvider.Instance().ExecuteReader("GetInstafeedList"));
        }
    }
}