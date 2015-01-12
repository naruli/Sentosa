using System;
using System.Collections.Generic;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.AttractionsDetailModule.Models
{
    public class AttractionsDetailController
    {

        public IList<AttractionsDetail> GetAttractionsDetail(int id)
        {
            return CBO.FillCollection<AttractionsDetail>(DataProvider.Instance().ExecuteReader("GetAttractions", id));
        }

        public IList<GalleryDetail> GetGalleryDetail(int id)
        {
            return CBO.FillCollection<GalleryDetail>(DataProvider.Instance().ExecuteReader("GetGalleryAttractions", id));
        }

        public void AddGalleryDetail(GalleryDetail gallery)
        {

            gallery.Id = DataProvider.Instance().ExecuteScalar<int>("AddGalleryAttractions",
                                                      gallery.IdDetail,
                                                      gallery.Path,
                                                      gallery.Description,
                                                      gallery.Type,
                                                      gallery.Thumbnail
                                                        );
        }

        public void UpdateThumbnailGalleryDetail(GalleryDetail gallery)
        {

            gallery.IdDetail = DataProvider.Instance().ExecuteScalar<int>("UpdateThumbnailGalleryAttractions",
                                                      gallery.IdDetail,
                                                      gallery.Thumbnail
                                                        );
        }

        public IList<SubMenuDetail> GetSubMenuDetail(int id)
        {
            return CBO.FillCollection<SubMenuDetail>(DataProvider.Instance().ExecuteReader("GetSubMenuAttractions", id));
        }

        public void AddSubMenuDetail(SubMenuDetail subMenu)
        {

            subMenu.Id = DataProvider.Instance().ExecuteScalar<int>("AddSubMenuAttractions",
                                                      subMenu.IdDetail,
                                                      subMenu.Title,
                                                      subMenu.Status,
                                                      subMenu.Action,
                                                      subMenu.Icon
                                                        );
        }

        public IList<SubPageDetail> GetSubPageDetail(int id)
        {
            return CBO.FillCollection<SubPageDetail>(DataProvider.Instance().ExecuteReader("GetSubPageAttractions", id));
        }

        public void AddSubPageDetail(SubPageDetail subPage)
        {

            subPage.Id = DataProvider.Instance().ExecuteScalar<int>("AddSubPageAttractions",
                                                      subPage.IdDetail,
                                                      subPage.Title,
                                                      subPage.Description,
                                                      subPage.OpeningHour,
                                                      subPage.Price,
                                                      subPage.Instruction,
                                                      subPage.Template
                                                        );
        }
    }
}