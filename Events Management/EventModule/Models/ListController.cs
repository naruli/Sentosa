using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
namespace Sentosa.Modules.EventModule.Models
{
    public class ListController
    {

        public IList<ItemList> GetItemList(int Id)
        {

            return CBO.FillCollection<ItemList>(DataProvider.Instance().ExecuteReader("GetItembyIdList", Id));


        }
    }
}