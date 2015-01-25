using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using System.Globalization;

namespace Sentosa.Modules.WhatsNearby.Models
{
    public class WhatsNearbyController
    {

        public IList<Place> getContentNearby(int TabId_)
        {
            
            IList<Place> listNearby = new List<Place>();
            int pick_data = 1;
            IList<ResultDistance> listNearest = new List<ResultDistance>();
            float latitude = 0;
            float longitude = 0;
           
            try
            {
                Place place_ = new Place();
                place_.Lat = "0";//initial lat
                place_.Lng = "0";//initial lng


                //get info place
                place_ = CBO.FillCollection<Place>(DataProvider.Instance().ExecuteReader("GetPlace")).Where(x => x.TabID == TabId_).FirstOrDefault();

                //check latitude and longitude
                if (place_.Lat == null || place_.Lat == "0") return listNearby;
                else if (place_.Lng == null || place_.Lng == "0") return listNearby;
                else
                {
                    //set latitude and longitude place
                    latitude = float.Parse(place_.Lat);
                    longitude = float.Parse(place_.Lng);
                }
            }
            catch (Exception ex)
            {
                return listNearby;
            }


            
            /*Dining*/
            try
            {

                listNearest = CBO.FillCollection<ResultDistance>(DataProvider.Instance().ExecuteReader("GetDiningNearest",
                                                                                    latitude,
                                                                                    longitude,
                                                                                    pick_data,
                                                                                    TabId_
                                                                                    ));//pick one
                if (listNearest.Count == 0 || listNearest == null)
                {
                    pick_data = pick_data + 1;//set pick data for next category
                }
                else
                {

                    //get data
                    for (int count = 0; count < listNearest.Count; count++)
                    {
                        Place place_dining = CBO.FillCollection<Place>(DataProvider.Instance().
                            ExecuteReader("GetPlace")).Where(x => x.TabID == listNearest.ElementAt(count).Id).FirstOrDefault();

                        //Content content = listData.FirstOrDefault();// get only first element
                        //content.TypeContent = "DINING"; //set type content dining
                        listNearby.Add(place_dining);// add data to nearest item
                    }


                }


            }
            catch (Exception ex)
            {
                pick_data = pick_data + 1;//set pick data for next category
            }

            /*Attractions*/
            try
            {
                listNearest = new List<ResultDistance>();
                listNearest = CBO.FillCollection<ResultDistance>(DataProvider.Instance().ExecuteReader("GetAttractionNearest",
                                                                                    latitude,
                                                                                    longitude,
                                                                                    pick_data,
                                                                                    TabId_));//pick one
                if (listNearest.Count == 0 || listNearest == null)
                {
                    pick_data = pick_data + 1;//set pick data for next category
                }
                else
                {

                    //get  data
                    for (int count = 0; count < listNearest.Count; count++)
                    {
                        Place place_attr = CBO.FillCollection<Place>(DataProvider.Instance().
                           ExecuteReader("GetPlace")).Where(x => x.TabID == listNearest.ElementAt(count).Id).FirstOrDefault();

                       // Content content = listData.FirstOrDefault();// get only first element
                        //content.TypeContent = "ATTRACTIONS"; //set type content dining
                        listNearby.Add(place_attr);// add data to nearest item
                    }

                    if (pick_data == listNearest.Count) pick_data = 1;
                    else
                    {
                                   
                        pick_data = (pick_data - listNearest.Count)+1;
                    
                    }


                }

            }
            catch (Exception ex)
            {
                pick_data = pick_data + 1;//set pick data for next category
            }



            /*Shop*/
            try
            {
                listNearest = new List<ResultDistance>();
                listNearest = CBO.FillCollection<ResultDistance>(DataProvider.Instance().ExecuteReader("GetShopNearest",
                                                                                    latitude,
                                                                                    longitude,
                                                                                    pick_data,
                                                                                    TabId_
                                                                                    ));//pick one
                if (listNearest.Count == 0 || listNearest == null)
                {
                    pick_data = pick_data + 1;//set pick data for next category
                }
                else
                {

                    //get  data
                    for (int count = 0; count < listNearest.Count; count++)
                    {
                        Place place_shop = CBO.FillCollection<Place>(DataProvider.Instance().
                           ExecuteReader("GetPlace")).Where(x => x.TabID == listNearest.ElementAt(count).Id).FirstOrDefault();

                        //Content content = listData.FirstOrDefault();// get only first element
                        //content.TypeContent = "SHOP"; //set type content dining
                        listNearby.Add(place_shop);// add data to nearest item
                    }

                    if (pick_data == listNearest.Count) pick_data = 1;
                    else
                    {

                        pick_data = (pick_data - listNearest.Count) + 1;

                    }
                }

            }
            catch (Exception ex)
            {
                pick_data = pick_data + 1;//set pick data for next category
            }

            /*Hotel And Spa*/
            try
            {
                listNearest = new List<ResultDistance>();
                listNearest = CBO.FillCollection<ResultDistance>(DataProvider.Instance().ExecuteReader("GetHotelSpaNearest",
                                                                                    latitude,
                                                                                    longitude,
                                                                                    pick_data,
                                                                                    TabId_
                                                                                    ));//pick one
                if (listNearest.Count == 0 || listNearest == null)
                {
                    pick_data = pick_data + 1;//set pick data for next category
                }
                else
                {

                    //get  data
                    for (int count = 0; count < listNearest.Count; count++)
                    {
                        Place place_hotel_spa = CBO.FillCollection<Place>(DataProvider.Instance().
                           ExecuteReader("GetPlace")).Where(x => x.TabID == listNearest.ElementAt(count).Id).FirstOrDefault();

                       // Content content = listData.FirstOrDefault();// get only first element
                        //content.TypeContent = "HOTELSPA"; //set type content dining
                        listNearby.Add(place_hotel_spa);// add data to nearest item
                    }


                }

            }
            catch
            {
                listNearby = new List<Place>();
            }

            if (listNearby.Count > 0)
            {
                foreach (var item in listNearby)
                {
                    item.Url = DotNetNuke.Common.Globals.NavigateURL(item.TabID);
                }
            }
            return listNearby;
        }
    }
}