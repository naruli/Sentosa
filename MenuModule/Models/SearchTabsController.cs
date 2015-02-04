using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.MenuModule.Models
{
    public class MenuModuleController
    {

        public IList<Result> searchTabs(string key)
        {
            IList<Result> listResult = new List<Result>();

            IList<Result> listTopSearch = new List<Result>();
            int top = 6;
            
            //Get Suggested
            listResult = CBO.FillCollection<Result>(DataProvider.Instance().ExecuteReader("SearchTabs", key));
            
            //Get Top Search
            listTopSearch = CBO.FillCollection<Result>(DataProvider.Instance().ExecuteReader("GetTopSearchTabs",top));

            foreach (var p in listResult)
            {
                string url = DotNetNuke.Common.Globals.NavigateURL(p.TabID);
                p.Url = url;
            }

            for (int count = 0; count < listTopSearch.Count; count++)
            {
                Result _result = new Result();
                _result = listTopSearch.ElementAt(count);

                string url = DotNetNuke.Common.Globals.NavigateURL(_result.TabID);
                _result.Url = url;

                listResult.Add(_result);
            }


            return listResult;
        }

        public IList<Result> testSearchTabs(string key)
        {
            IList<Result> listResult = new List<Result>();
            for(int count = 0; count < 7; count++)
            {
                Result result_ = new Result();
                result_.TabID = (count + 1);
                result_.TabName = "TabName_" + (count + 1);
                result_.ShortDescription = "ShortDesc_" + (count + 1);
                result_.Url = "URL_" + (count + 1);
                result_._CountView = (count + 1);
                if (count % 2 == 0)
                {
                    result_.TypeSearch = "top";
                }
                else
                {
                    result_.TypeSearch = "suggested";
                }


                listResult.Add(result_);

            }


            return listResult;
        }
    }
}