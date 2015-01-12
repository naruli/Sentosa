using System;
using System.Collections.Generic;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.DiningDetailModule.Models
{
    public class DiningDetailController
    {
        public IList<DiningDetail> GetDiningDetail(int id)
        {
            return CBO.FillCollection<DiningDetail>(DataProvider.Instance().ExecuteReader("GetDining", id));
        }

        public IList<GalleryDetail> GetGalleryDetail(int id)
        {
            return CBO.FillCollection<GalleryDetail>(DataProvider.Instance().ExecuteReader("GetGalleryDining", id));
        }

        public void AddGalleryDetail(GalleryDetail gallery)
        {

            gallery.Id = DataProvider.Instance().ExecuteScalar<int>("AddGalleryDining",
                                                      gallery.IdDetail,
                                                      gallery.Path,
                                                      gallery.Description,
                                                      gallery.Type,
                                                      gallery.Thumbnail
                                                        );
        }

        public void UpdateThumbnailGalleryDetail(GalleryDetail gallery)
        {

            gallery.IdDetail = DataProvider.Instance().ExecuteScalar<int>("UpdateThumbnailGalleryDining",
                                                      gallery.IdDetail,
                                                      gallery.Thumbnail
                                                        );
        }

        public IList<SubMenuDetail> GetSubMenuDetail(int id)
        {
            return CBO.FillCollection<SubMenuDetail>(DataProvider.Instance().ExecuteReader("GetSubMenuDining", id));
        }

        public void AddSubMenuDetail(SubMenuDetail subMenu)
        {

            subMenu.Id = DataProvider.Instance().ExecuteScalar<int>("AddSubMenuDining",
                                                      subMenu.IdDetail,
                                                      subMenu.Title,
                                                      subMenu.Status,
                                                      subMenu.Action,
                                                      subMenu.Icon
                                                        );
        }

        public IList<SubPageDetail> GetSubPageDetail(int id)
        {
            return CBO.FillCollection<SubPageDetail>(DataProvider.Instance().ExecuteReader("GetSubPageDining", id));
        }

        public void AddSubPageDetail(SubPageDetail subPage)
        {

            subPage.Id = DataProvider.Instance().ExecuteScalar<int>("AddSubPageDining",
                                                      subPage.IdDetail,
                                                      subPage.Title,
                                                      subPage.Description,
                                                      subPage.Promotion,
                                                      subPage.Template
                                                        );
        }
    }
}