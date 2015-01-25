using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.PlaceDetail.Models
{
    public class GalleryController
    {
   
        public IList<Gallery> GetGallery(int CommonId)
        {

            IList<Gallery> listGallery = new List<Gallery>();
            IList<Gallery> listPhoto = CBO.FillCollection<Gallery>(DataProvider.Instance().ExecuteReader("GetGalleryPhotos", CommonId));
            IList<Gallery> listVideo =  CBO.FillCollection<Gallery>(DataProvider.Instance().ExecuteReader("GetGalleryVideos", CommonId));
           //get gallery photo
            if (listPhoto.Count > 0 || listPhoto == null)
            {
                for (int count = 0; count < listPhoto.Count; count++)
                {
                    listGallery.Add(listPhoto.ElementAt(count));
                }
            }
            //get gallery video
            if (listVideo.Count > 0 || listVideo == null)
            {
                for (int count = 0; count < listVideo.Count; count++)
                {
                    listGallery.Add(listVideo.ElementAt(count));
                }
            }


            return listGallery;

        }

      
    }
}