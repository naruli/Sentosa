using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Sentosa.Modules.EventsDetailModule.Models
{
    interface EventsDetailInterface
    {
        IList<EventsDetail> GetEventsDetail(int id);

        IList<GalleryDetail> GetGalleryDetail(int id);
        void AddGalleryDetail(GalleryDetail gallery);
        void UpdateThumbnailGalleryDetail(GalleryDetail gallery);
        IList<SubMenuDetail> GetSubMenuDetail(int id);
        void AddSubMenuDetail(SubMenuDetail subMenu);
        IList<SubPageDetail> GetSubPageDetail(int id);
        void AddSubPageDetail(SubPageDetail subPage);
    }
}
