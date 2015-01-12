using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
namespace Sentosa.Modules.EventsDetailModule.Models
{
    public class EventsDetailController : EventsDetailInterface
    {
        public IList<EventsDetail> GetEventsDetail(int id)
        {
            return CBO.FillCollection<EventsDetail>(DataProvider.Instance().ExecuteReader("GetEvents", id));
        }

        public IList<GalleryDetail> GetGalleryDetail(int id)
        {
            return CBO.FillCollection<GalleryDetail>(DataProvider.Instance().ExecuteReader("GetGalleryEvents", id));
        }

        public void AddGalleryDetail(GalleryDetail gallery)
        {
            gallery.Id = DataProvider.Instance().ExecuteScalar<int>("AddGalleryEvents",
                                                    gallery.IdDetail,
                                                    gallery.Path,
                                                    gallery.Description,
                                                    gallery.Type,
                                                    gallery.Thumbnail
                                                      );
        }

        public void UpdateThumbnailGalleryDetail(GalleryDetail gallery)
        {
            gallery.Id = DataProvider.Instance().ExecuteScalar<int>("UpdateThumbnailGalleryEvents",
                                                     gallery.Id,
                                                     gallery.IdDetail,
                                                     gallery.Thumbnail
                                                       );
        }

        public IList<SubMenuDetail> GetSubMenuDetail(int id)
        {
            return CBO.FillCollection<SubMenuDetail>(DataProvider.Instance().ExecuteReader("GetSubMenuEvents", id));
        }

        public void AddSubMenuDetail(SubMenuDetail subMenu)
        {
            subMenu.Id = DataProvider.Instance().ExecuteScalar<int>("AddSubMenuEvents",
                                                       subMenu.IdDetail,
                                                       subMenu.Title,
                                                       subMenu.Status,
                                                       subMenu.Action,
                                                       subMenu.Icon
                                                         );
        }

        public IList<SubPageDetail> GetSubPageDetail(int id)
        {
            return CBO.FillCollection<SubPageDetail>(DataProvider.Instance().ExecuteReader("GetSubPageEvents", id));
        }

        public void AddSubPageDetail(SubPageDetail subPage)
        {
            subPage.Id = DataProvider.Instance().ExecuteScalar<int>("AddSubPageEvents",
                                                     subPage.IdDetail,
                                                     subPage.Title,
                                                     subPage.Description,
                                                     subPage.Instruction,
                                                     subPage.Template
                                                       );
        }
    }
}