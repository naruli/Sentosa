using System;
using System.Collections.Generic;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.BeachesModule.Models
{
    public class BeachesController
    {
        public IList<Beaches> SearchBeaches(string searchValue, string order, int offset, int limit)
        {
            return CBO.FillCollection<Beaches>(DataProvider.Instance().ExecuteReader("SearchBeaches", searchValue, order, offset, limit));
        }

        public IList<Beaches> GetBeaches(int id)
        {
            return CBO.FillCollection<Beaches>(DataProvider.Instance().ExecuteReader("GetBeaches", id));
        }

        public void AddBeaches(Beaches beaches)
        {

            beaches.Id = DataProvider.Instance().ExecuteScalar<int>("AddBeaches",
                                                      beaches.Title,
                                                      beaches.Description,
                                                      beaches.Zone,
                                                      beaches.Status,
                                                      beaches.ShortDesc,
                                                      beaches.Author,
                                                      beaches.Editor,
                                                      beaches.ColorOfSubMenu,
                                                      beaches.UrlBrochure,
                                                      beaches.PathImage,
                                                      beaches.Latitude,
                                                      beaches.Longitude
                                                        );
        }

        public void UpdateBeaches(Beaches beaches)
        {

            beaches.Id = DataProvider.Instance().ExecuteScalar<int>("UpdateBeaches",
                                                      beaches.Id,
                                                      beaches.Title,
                                                      beaches.Description,
                                                      beaches.Zone,
                                                      beaches.Status,
                                                      beaches.ShortDesc,
                                                      beaches.Editor,
                                                      beaches.ColorOfSubMenu,
                                                      beaches.UrlBrochure,
                                                      beaches.Latitude,
                                                      beaches.Longitude
                                                        );
        }

        public void DeleteBeaches(Beaches beaches)
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteBeaches", beaches.Id);
        }
    }
}