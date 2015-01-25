using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.PlaceDetail.Models
{
    public class PlaceDetailController
    {
        public IList<Place> GetPlace(int _TabId)
        {
            IList<Place> place = new List<Place>();
            place.Add(CBO.FillCollection<Place>(DataProvider.Instance().ExecuteReader("GetPlace")).Where(x => x.TabID == _TabId).FirstOrDefault());
            return place;
        }

        public IList<SubPage> GetSubMenuPlace(int _TabId)
        {
            Place place_ = GetPlace(_TabId).FirstOrDefault();
            string [] listTitle = {"Overview","Tickets","Visitor Information"};
            IList<SubPage> listSubPage = new List<SubPage>();
            /**
             *   
             * public string Title { get; set; } //title submenu : overview , ticket , visitor information
                public string Description { get; set; } //detail {sub menu : Overview}
                public string Instruction { get; set; } //Instruction {sub menu : Visitor Information}
                public string OpeningHour { get; set; } //opening hour {sub menu : Visitor Information}
                public string NatureGuidedTours { get; set; } //nature guided {sub menu : Visitor Information}
                public string Price { get; set; } //pricing of attraction {sub menu : Visitor Information}
                public string AdmissionInfo { get; set; } //ticket (attraction,event) 
             * 
             * */
            for (int count = 0; count < listTitle.Length; count++)
            {
                SubPage subPage = new SubPage();
                bool _insertMode = false;
                switch (listTitle[count])
                {
                    case "Overview":    if (place_.Details != null || place_.Details != "") {subPage.Description = place_.Details;
                                            _insertMode = true;
                                        }                            
                                        break;
                    //case "Tickets":     if (place_.AdmissionInfo != null || place_.AdmissionInfo != "")
                    //                    {
                    //                       subPage.AdmissionInfo = place_.AdmissionInfo;
                    //                        _insertMode = true;
                    //                    }
                    //                    break;
                    //case "Visitor Information":
                    //                    subPage.Instruction = (place_.Instruction != null || place_.Instruction != "")?place_.Instruction:null;
                    //                    subPage.OpeningHour = (place_.OpeningHour != null || place_.OpeningHour != "") ? place_.OpeningHour : null;
                    //                    subPage.NatureGuidedTours = (place_.NatureGuidedTours != null || place_.NatureGuidedTours != "") ? place_.NatureGuidedTours : null;
                    //                    subPage.Price = (place_.Price != null || place_.Price != "") ? place_.Price : null;
                    //                    _insertMode = true;
                    //                    break;
                };

                if (_insertMode == true)
                {
                    subPage.Title = listTitle[count];
                    listSubPage.Add(subPage);
                }
            }

            return listSubPage;
        }
    }
}