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
        public IList<Happening> GetHappening()
        {

            IList<Happening> listHappening =
            CBO.FillCollection<Happening>(DataProvider.Instance().ExecuteReader("GetHappening"));

            foreach (Happening happening in listHappening)
            {
                if (happening.TypeIdRef.Equals("P_EVENT"))
                {
                    //GetEvents
                    IList<Content> listEvent =
                          CBO.FillCollection<Content>(DataProvider.Instance().ExecuteReader("GetHappeningEvents", happening.IdRef));
                    happening.ContentDetail = listEvent.FirstOrDefault();
                }
                else if (happening.TypeIdRef.Equals("P_PROMO"))
                    {
                        //GetPromotions
                        IList<Content> listPromotion =
                          CBO.FillCollection<Content>(DataProvider.Instance().ExecuteReader("GetHappeningPromotions", happening.IdRef));

                        happening.ContentDetail = listPromotion.FirstOrDefault();
                    }

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

        public void DeleteHappening()
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteHappening");
        }

        public IList<Content> GetContentHappening()
        {
            IList<Content> listContent =
            CBO.FillCollection<Content>(DataProvider.Instance().ExecuteReader("GetContentHappening"));

            return listContent;
        }
    }
}