using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.HappeningModule.Models
{
    public class HappeningController
    {
        public IList<Happening> GetHappening(int TabId)
        {

            IList<Happening> listHappening =
            CBO.FillCollection<Happening>(DataProvider.Instance().ExecuteReader("GetHappening", TabId));

            if (listHappening.Count < 1 || listHappening == null)
            {
                IList<TypePage> typePage = CBO.FillCollection<TypePage>(DataProvider.Instance().ExecuteReader("GetTypePage"));
                int TabIdHome = typePage.Where(y => y.Name.ToLower().Equals("home")).Select(x => x.TabId).FirstOrDefault();
                if(TabId != TabIdHome)
                    listHappening = CBO.FillCollection<Happening>(DataProvider.Instance().ExecuteReader("GetHappening", TabIdHome));
            }

            foreach (Happening happening in listHappening)
            {
                IList<Place> listContent =
                          CBO.FillCollection<Place>(DataProvider.Instance().ExecuteReader("GetPlace")).Where(x => x.TabID == happening.IdRef).ToList();
                happening.ContentDetail = listContent.FirstOrDefault();
                happening.ContentDetail.Url = DotNetNuke.Common.Globals.NavigateURL(happening.IdRef);
            }

            return listHappening;
        }

        public void AddHappening(Happening happening)
        {
            happening.Id = DataProvider.Instance().ExecuteScalar<int>("AddHappening",
                                                    happening.IdRef,
                                                    happening.TypeIdRef,
                                                    happening.IsStatic,
                                                    happening.IdStaticRef
                                                     );
        }

        public void DeleteHappening(int TabId)
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteHappening", TabId);
        }

        public IList<Place> GetContentHappeningEvent()
        {
            return GetContentHappening().Where(x => x.TypeHappening.Equals("P_EVENT")).ToList();
        }

        public IList<Place> GetContentHappeningPromotion()
        {
            return GetContentHappening().Where(x => x.TypeHappening.Equals("P_PROMO")).ToList();
        }

        public IList<Place> GetContentHappening()
        {
            IList<TypePage> typePage = CBO.FillCollection<TypePage>(DataProvider.Instance().ExecuteReader("GetTypePage"));
            int TabIdPromo = typePage.Where(y => y.Name.ToLower().Equals("promotions")).Select(x => x.TabId).FirstOrDefault();
            int TabIdEvent = typePage.Where(y => y.Name.ToLower().Equals("events")).Select(x => x.TabId).FirstOrDefault();
            IList<Place> listContent =
            CBO.FillCollection<Place>(DataProvider.Instance().ExecuteReader("GetPlace")).Where(x => x.ParentId == TabIdPromo || x.ParentId == TabIdEvent).ToList();

            foreach (Place item in listContent)
            {
                item.Url = DotNetNuke.Common.Globals.NavigateURL(item.TabID);
                if (item.ParentId == TabIdPromo)
                {
                    item.TypeHappening = "P_PROMO";
                }
                else if (item.ParentId == TabIdEvent)
                {
                    item.TypeHappening = "P_EVENT";
                }
            }
            return listContent;
        }

        public Place GetPlace(int _TabId)
        {
            return CBO.FillCollection<Place>(DataProvider.Instance().ExecuteReader("GetPlace")).Where(x => x.TabID == _TabId).FirstOrDefault();
        }
    }
}