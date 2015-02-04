using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.InstafeedModule.Models
{
    public class InstafeedController
    {
        public void AddInstafeed(Instafeed instafeed)
        {
            instafeed.Id = DataProvider.Instance().ExecuteScalar<int>("AddInstafeedList",
                                                    instafeed.Url
                                                     );
        }

        public void DeleteInstafeed()
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteInstafeedList");
        }
    }
}