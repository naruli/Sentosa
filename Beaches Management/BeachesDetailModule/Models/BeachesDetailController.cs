using System;
using System.Collections.Generic;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.BeachesDetailModule.Models
{
    public class BeachesDetailController
    {

        public IList<BeachesDetail> GetBeachesDetail(int id)
        {
            return CBO.FillCollection<BeachesDetail>(DataProvider.Instance().ExecuteReader("GetBeaches", id));
        }

        public IList<BeachesDetail> GetListBeaches(int id)
        {
            return CBO.FillCollection<BeachesDetail>(DataProvider.Instance().ExecuteReader("GetListBeaches", id));
        }

        public IList<GalleryDetail> GetGalleryDetail(int id)
        {
            return CBO.FillCollection<GalleryDetail>(DataProvider.Instance().ExecuteReader("GetGalleryBeaches", id));
        }

        public void AddGalleryDetail(GalleryDetail gallery)
        {

            gallery.Id = DataProvider.Instance().ExecuteScalar<int>("AddGalleryBeaches",
                                                      gallery.IdDetail,
                                                      gallery.Path,
                                                      gallery.Description,
                                                      gallery.Type,
                                                      gallery.Thumbnail
                                                        );
        }

        public void UpdateThumbnailGalleryDetail(GalleryDetail gallery)
        {

            gallery.IdDetail = DataProvider.Instance().ExecuteScalar<int>("UpdateThumbnailGalleryBeaches",
                                                      gallery.IdDetail,
                                                      gallery.Thumbnail
                                                        );
        }

        public IList<SubMenuDetail> GetSubMenuDetail(int id)
        {
            return CBO.FillCollection<SubMenuDetail>(DataProvider.Instance().ExecuteReader("GetSubMenuBeaches", id));
        }

        public void AddSubMenuDetail(SubMenuDetail subMenu)
        {

            subMenu.Id = DataProvider.Instance().ExecuteScalar<int>("AddSubMenuBeaches",
                                                      subMenu.IdDetail,
                                                      subMenu.Title,
                                                      subMenu.Status,
                                                      subMenu.Action,
                                                      subMenu.Icon
                                                        );
        }

        public IList<SubPageDetail> GetSubPageDetail(int id)
        {
            return CBO.FillCollection<SubPageDetail>(DataProvider.Instance().ExecuteReader("GetSubPageBeaches", id));
        }

        public void AddSubPageDetail(SubPageDetail subPage)
        {

            subPage.Id = DataProvider.Instance().ExecuteScalar<int>("AddSubPageBeaches",
                                                      subPage.IdDetail,
                                                      subPage.Title,
                                                      subPage.Description,
                                                      subPage.SafetyTitle,
                                                      subPage.SafetyInfo,
                                                      subPage.Instruction,
                                                      subPage.Template
                                                        );
        }
    }
}