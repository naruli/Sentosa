using System;
using System.Collections.Generic;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.DiningModule.Models
{
    public class DiningController
    {
        public IList<Dining> SearchDining(string searchValue, string order, string listDining, string listCuisine, int offset, int limit)
        {
            return CBO.FillCollection<Dining>(DataProvider.Instance().ExecuteReader("SearchDining", searchValue, order, listDining, listCuisine, offset, limit));
        }

        public IList<Dining> GetDining(int id)
        {
            return CBO.FillCollection<Dining>(DataProvider.Instance().ExecuteReader("GetDining", id));
        }

        public void AddDining(Dining dining)
        {

            dining.Id = DataProvider.Instance().ExecuteScalar<int>("AddDining",
                                                      dining.Title,
                                                      dining.Description,
                                                      dining.Zone,
                                                      dining.Status,
                                                      dining.ShortDesc,
                                                      dining.UrlPurchase,
                                                      dining.MenuLink,
                                                      dining.Author,
                                                      dining.Editor,
                                                      dining.ColorOfSubMenu,
                                                      dining.PathImage,
                                                      dining.Latitude,
                                                      dining.Longitude
                                                        );
        }

        public void UpdateDining(Dining dining)
        {

            dining.Id = DataProvider.Instance().ExecuteScalar<int>("UpdateDining",
                                                      dining.Id,
                                                      dining.Title,
                                                      dining.Description,
                                                      dining.Zone,
                                                      dining.Status,
                                                      dining.ShortDesc,
                                                      dining.UrlPurchase,
                                                      dining.MenuLink,
                                                      dining.Editor,
                                                      dining.ColorOfSubMenu,
                                                      dining.Latitude,
                                                      dining.Longitude
                                                        );
        }

        public void DeleteDining(Dining dining)
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteDining", dining.Id);
        }

        public IList<DiningExperience> GetDiningExperience(int id)
        {
            return CBO.FillCollection<DiningExperience>(DataProvider.Instance().ExecuteReader("GetDiningExperience", id)).Where(x => x.IsHave == true).ToList();
        }

        public void AddDiningExperience(DiningExperience diningExperience)
        {

            diningExperience.Id = DataProvider.Instance().ExecuteScalar<int>("AddDiningExperience",
                                                      diningExperience.Id,
                                                      diningExperience.Category,
                                                      diningExperience.IsHave
                                                        );
        }

        public void UpdateDiningExperience(DiningExperience diningExperience)
        {

            diningExperience.Id = DataProvider.Instance().ExecuteScalar<int>("UpdateDiningExperience",
                                                      diningExperience.Id,
                                                      diningExperience.Category,
                                                      diningExperience.IsHave
                                                        );
        }

        public IList<CuisineType> GetCuisineType(int id)
        {
            return CBO.FillCollection<CuisineType>(DataProvider.Instance().ExecuteReader("GetCuisineType", id)).Where(x => x.IsHave == true).ToList();
        }

        public void AddCuisineType(CuisineType cuisineType)
        {

            cuisineType.Id = DataProvider.Instance().ExecuteScalar<int>("AddCuisineType",
                                                      cuisineType.Id,
                                                      cuisineType.Category,
                                                      cuisineType.IsHave
                                                        );
        }

        public void UpdateCuisineType(CuisineType cuisineType)
        {

            cuisineType.Id = DataProvider.Instance().ExecuteScalar<int>("UpdateCuisineType",
                                                      cuisineType.Id,
                                                      cuisineType.Category,
                                                      cuisineType.IsHave
                                                        );
        }
    }
}