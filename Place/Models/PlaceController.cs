using System;
using System.Collections.Generic;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.Place.Models
{
    public class PlaceController
    {
        public IList<Place> GetPlace(string groupname, int offset, int limit, string searchValue, string sortBy, string list)
        {
            int TabId = CBO.FillCollection<TypePage>(DataProvider.Instance().ExecuteReader("GetTypePage")).Where(y => y.Name.ToLower().Equals(groupname.ToLower())).Select(x => x.TabId).FirstOrDefault();
            var place = CBO.FillCollection<Place>(DataProvider.Instance().ExecuteReader("GetPlace")).Where(x => x.ParentId == TabId).OrderBy(y => y.TabName);
            if (groupname.ToLower().Equals("events"))
            {
                place = place.Where(x => DateTime.Now.Date >= (!String.IsNullOrEmpty(x.EventStartDate) ? Convert.ToDateTime(x.EventStartDate).Date : DateTime.Now.Date) && DateTime.Now.Date <= (!String.IsNullOrEmpty(x.EventEndDate) ? Convert.ToDateTime(x.EventEndDate).Date : DateTime.Now.Date)).OrderBy(y => y.TabName);
            }
            if (!list.Equals("0"))
            {
                int[] listed = list.Split(',').Select(int.Parse).ToArray();
                int[] dupTabId = CBO.FillCollection<TagPlace>(DataProvider.Instance().ExecuteReader("GetTagTab")).Where(x => listed.Contains(x.TagId)).Select(x => x.TabId).ToArray();
                int[] tabId = dupTabId.Distinct().ToArray();
                place = place.Where(x => tabId.Contains(x.TabID)).OrderBy(y => y.TabName);
            }
            if (!String.IsNullOrEmpty(searchValue))
            {
                place = place.Where(x => x.TabName.ToLower().Contains(searchValue.ToLower())).OrderBy(y => y.TabName);
            }

            if (!String.IsNullOrEmpty(sortBy))
            {
                switch (sortBy.ToLower())
                {
                    case "name": place = place.OrderBy(y => y.TabName);
                        break;

                    case "description": place = place.OrderBy(y => y.ShortDescription);
                        break;

                    case "date": place = place.OrderByDescending(y => y.CreatedOnDate);
                        break;
                }
            }
            IList<Place> places = new List<Place>();
            if (place != null)
            {
                int totalPlace = place.Count();
                var dumpPlace = place.ToList();
                if (offset != -4)
                {
                    //Get Places by offset and limit
                    offset = ((offset - 1) * limit);
                    int remaining = totalPlace - offset;

                    if (remaining < limit)
                        limit = remaining;

                    dumpPlace = place.Skip(offset).Take(limit).ToList();
                    foreach (var item in dumpPlace)
                    {
                        item.Total = totalPlace;
                        item.Url = DotNetNuke.Common.Globals.NavigateURL(item.TabID);
                        places.Add(item);
                    }
                }
                else
                {
                    //Get All Places
                    foreach (var item in dumpPlace)
                    {
                        item.Total = totalPlace;
                        item.Url = DotNetNuke.Common.Globals.NavigateURL(item.TabID);
                        places.Add(item);
                    }
                }
            }

            return places;
        }

        public IList<Tag> GetList(string groupname)
        {
            int TypeId = CBO.FillCollection<TypePage>(DataProvider.Instance().ExecuteReader("GetTypePage")).Where(y => y.Name.ToLower().Equals(groupname.ToLower())).Select(x => x.TypeId).FirstOrDefault();
            var tag = CBO.FillCollection<Tag>(DataProvider.Instance().ExecuteReader("GetTag")).Where(x => x.TypeId == TypeId && x.LanguageId == 1);

            return tag.ToList();
        }
    }
}