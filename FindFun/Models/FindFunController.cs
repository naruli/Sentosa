using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.FindFun.Models
{
    public class FindFunController
    {
        public IList<Place> GetPlace(string searchValue, string listParam)
        {
            IList<Place> listPlace = GetListPlace();
            IList<Place> listPlaceChild = new List<Place>();
            int[] listId = listPlace.Select(x => x.TabID).ToArray();

            if (listParam != "0")
            {
                string[] params_ = listParam.Split(',');
                if (params_.Length != 0)
                {
                    int[] IdParams = new int[params_.Length];

                    for (int indexStart = 0; indexStart < params_.Length; indexStart++)
                    {
                        IdParams[indexStart] = Convert.ToInt32(params_[indexStart]);

                    }


                    listPlaceChild = CBO.FillCollection<Place>(DataProvider.Instance().ExecuteReader("GetPlace")).Where(x => listId.Contains((x.ParentId != null ? (int)x.ParentId : 0))).Where(x => IdParams.Contains((x.ParentId != null ? (int)x.ParentId : 0))).Where(x => x.TabName.Contains(searchValue)).ToList();

                }
                else
                {
                    listPlaceChild = CBO.FillCollection<Place>(DataProvider.Instance().ExecuteReader("GetPlace")).Where(x => listId.Contains((x.ParentId != null ? (int)x.ParentId : 0))).Where(x => x.TabName.Contains(searchValue)).ToList();

                }
            }
            else
            {
                    listPlaceChild = CBO.FillCollection<Place>(DataProvider.Instance().ExecuteReader("GetPlace")).Where(x => listId.Contains((x.ParentId != null ? (int)x.ParentId : 0))).Where(x => x.TabName.Contains(searchValue)).ToList();

            }
            
            //foreach 
            foreach (var p in listPlaceChild)
            {
                string url = DotNetNuke.Common.Globals.NavigateURL(p.TabID);
                p.UrlLinkDetail = url;

            }

            return listPlaceChild;
        }

        public IList<Place> GetListPlace()
        {
            int TabId = CBO.FillCollection<Place>(DataProvider.Instance().ExecuteReader("GetPlace")).Where(x => x.TabName.ToLower().Equals("explore")).Select(y => y.TabID).FirstOrDefault();
            IList<Place> listPlace = new List<Place>();
            listPlace =
                 CBO.FillCollection<Place>(DataProvider.Instance().ExecuteReader("GetPlace")).Where(x => x.ParentId == TabId).ToList();

            return listPlace;
        }
    }
}