using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.SlidingInfoModule.Models
{
    public class SlidingInfoController
    {

        public IList<Announcement> GetAnnouncements()
        {
            return CBO.FillCollection<Announcement>(DataProvider.Instance().ExecuteReader("GetAnnouncement")).ToList();
        }

        public IList<AnnouncementPlace> GetAnnouncementPlaces(int TabId)
        {
            return CBO.FillCollection<AnnouncementPlace>(DataProvider.Instance().ExecuteReader("GetTabAnnouncement")).Where(x => x.TabId == TabId).ToList();
        }

        public void AddAnnouncementPlace(AnnouncementPlace announcementPlace)
        {
            announcementPlace.Id = DataProvider.Instance().ExecuteScalar<int>("AddTabAnnouncement",
                                                    announcementPlace.TabId,
                                                    announcementPlace.AnnouncementId
                                                     );
        }

        public void DeleteAnnouncementPlace(int TabId)
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteTabAnnouncement", TabId);
        }

        public IList<Announcement> ShowAnnouncements(int TabId)
        {
            int[] announcementId = GetAnnouncementPlaces(TabId).Select(x => x.AnnouncementId).ToArray();

            return GetAnnouncements().Where(x => announcementId.Contains(x.Id)).ToList();
        }
    }
}