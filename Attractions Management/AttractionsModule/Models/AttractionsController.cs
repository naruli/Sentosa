using System;
using System.Collections.Generic;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.AttractionsModule.Models
{
    public class AttractionsController
    {
        public IList<Attractions> SearchAttractions(string searchValue, string order, string list, int offset, int limit)
        {
            return CBO.FillCollection<Attractions>(DataProvider.Instance().ExecuteReader("SearchAttractions", searchValue, order, list, offset, limit));
        }

        public IList<Attractions> GetAttractions(int id)
        {
            return CBO.FillCollection<Attractions>(DataProvider.Instance().ExecuteReader("GetAttractions", id));
        }

        public void AddAttractions(Attractions attractions)
        {

            attractions.Id = DataProvider.Instance().ExecuteScalar<int>("AddAttractions",
                                                      attractions.Title,
                                                      attractions.Description,
                                                      attractions.Zone,
                                                      attractions.Status,
                                                      attractions.ShortDesc,
                                                      attractions.Category,
                                                      attractions.UrlPurchase,
                                                      attractions.Author,
                                                      attractions.Editor,
                                                      attractions.ColorOfSubMenu,
                                                      attractions.PathImage,
                                                      attractions.Latitude,
                                                      attractions.Longitude
                                                        );
        }

        public void UpdateAttractions(Attractions attractions)
        {

            attractions.Id = DataProvider.Instance().ExecuteScalar<int>("UpdateAttractions",
                                                      attractions.Id,
                                                      attractions.Title,
                                                      attractions.Description,
                                                      attractions.Zone,
                                                      attractions.Status,
                                                      attractions.ShortDesc,
                                                      attractions.Category,
                                                      attractions.UrlPurchase,
                                                      attractions.Editor,
                                                      attractions.ColorOfSubMenu,
                                                      attractions.Latitude,
                                                      attractions.Longitude
                                                        );
        }

        public void DeleteAttractions(Attractions attractions)
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteAttractions", attractions.Id);
        }
    }
}