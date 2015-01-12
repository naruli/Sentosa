using System;
using System.Collections.Generic;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.ExploreModule.Models
{
    public class ExploreController
    {
        public IList<Explore> GetExplore()
        {
            return CBO.FillCollection<Explore>(DataProvider.Instance().ExecuteReader("GetExplore"));
        }

        public void AddExplore(Explore explore)
        {
            explore.Id = DataProvider.Instance().ExecuteScalar<int>("AddExplore",
                                                      explore.Id, //id
                                                      explore.Title, // Title
                                                      explore.Description, //description
                                                      explore.PathImage, //order
                                                      explore.Url //url
                                                        );
        }

        public void DeleteExplore()
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteExplore");
        }
    }
}