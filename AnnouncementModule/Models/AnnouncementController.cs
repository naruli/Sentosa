using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.AnnouncementModule.Models
{
    public class AnnouncementModuleController
    {
        public IList<Announcement> GetAnnouncement(int Id)
        {
            return CBO.FillCollection<Announcement>(DataProvider.Instance().ExecuteReader("GetAnnouncement")).Where(x => x.Id == Id).ToList();
        }

        public IList<Announcement> GetAnnouncements()
        {
            return CBO.FillCollection<Announcement>(DataProvider.Instance().ExecuteReader("GetAnnouncement")).ToList();
        }

        public void AddAnnouncement(Announcement announcement)
        {
            announcement.Id = DataProvider.Instance().ExecuteScalar<int>("AddAnnouncement",
                                                    announcement.Content
                                                     );
        }

        public void UpdateAnnouncement(Announcement announcement)
        {
            announcement.Id = DataProvider.Instance().ExecuteScalar<int>("UpdateAnnouncement",
                                                    announcement.Id,
                                                    announcement.Content
                                                     );
        }

        public void DeleteAnnouncement(Announcement announcement)
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteAnnouncement", announcement.Id);
        }
    }
}