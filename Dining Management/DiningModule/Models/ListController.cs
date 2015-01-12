using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
namespace Sentosa.Modules.DiningModule.Models
{
    public class ListController
    {

        public IList<ItemList> GetItemListDining()
        {

            return CBO.FillCollection<ItemList>(DataProvider.Instance().ExecuteReader("GetItembyIdList", 3)).Where(x => x.Id != "").ToList();

        }

        public IList<ItemList> GetItemListCuisine()
        {

            return CBO.FillCollection<ItemList>(DataProvider.Instance().ExecuteReader("GetItembyIdList", 4)).Where(x => x.Id != "").ToList();

        }
    }
}