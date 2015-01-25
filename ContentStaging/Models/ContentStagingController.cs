using System;
using System.Collections.Generic;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.ContentStaging.Models
{
    public class ContentStagingController
    {

        public IList<Place> GetPlaces(string groupName)
        {
            int TabId = GetTypePage(groupName);
            return CBO.FillCollection<Place>(DataProvider.Instance().ExecuteReader("GetPlace")).Where(x => x.ParentId == TabId).OrderBy(y => y.TabName).ToList();
        }

        public Place GetPlace(int tabId)
        {
            return CBO.FillCollection<Place>(DataProvider.Instance().ExecuteReader("GetPlace")).Where(x => x.TabID == tabId).OrderBy(y => y.TabName).FirstOrDefault();
        }

        public int GetTypePage(string groupName)
        {
            return CBO.FillCollection<TypePage>(DataProvider.Instance().ExecuteReader("GetTypePage")).Where(y => y.Name.ToLower().Equals(groupName.ToLower())).Select(x => x.TabId).FirstOrDefault();
        }

        public IList<TypePage> GetTypePages()
        {
            return CBO.FillCollection<TypePage>(DataProvider.Instance().ExecuteReader("GetTypePage")).ToList();
        }

        public void AddPlace(Place place)
        {
            place.CommonId = DataProvider.Instance().ExecuteScalar<int>("UpdatePlace",
                place.TabID,
                place.ShortDescription,
                place.AdmissionInfo,
                place.OpeningHour,
                place.NatureAgeRestrictions,
                place.NatureGuidedTours,
                place.EventStartDate,
                place.EventEndDate,
                place.ZoneId,
                place.Timestamp,
                place.CommonId,
                place.LanguageId,
                place.SourceUrl,
                place.Highlight,
                place.Details,
                place.Phone,
                place.Address,
                place.OpeningTime,
                place.ClosingTime,
                place.Rank,
                place.Status,
                place.cluster_id,
                place.Price,
                place.BestStart,
                place.BestEnd,
                place.DurationEasy,
                place.DurationModerate,
                place.DurationExtreme,
                place.AllDay,
                place.IsRepeated,
                place.StartTime,
                place.EndTime,
                place.SharingSetting,
                place.PlaceId,
                place.Instruction,
                place.Lat,
                place.Lng,
                place.AllTime,
                place.Repeat,
                place.Every,
                place.Weekdays,
                place.RepeatAfter,
                place.RepeatBy,
                place.ExceptDates,
                place.start_date,
                place.end_date,
                place.Photo,
                place.Category,
                place.FiuzuSync,
                place.XmobSync);
        }

        public void DeletePlace(Place place)
        {
            DataProvider.Instance().ExecuteNonQuery("DeletePlace", place.CommonId);
        }

        public IList<StatusChoice> GetStatusChoice()
        {
            return CBO.FillCollection<StatusChoice>(DataProvider.Instance().ExecuteReader("GetStatusChoice"));
        }

        public IList<StatusSync> GetStatusSync()
        {
            return CBO.FillCollection<StatusSync>(DataProvider.Instance().ExecuteReader("GetStatusSync"));
        }

        public IList<SharingSetting> GetSharingSetting()
        {
            return CBO.FillCollection<SharingSetting>(DataProvider.Instance().ExecuteReader("GetSharingSetting"));
        }

        public IList<TypePage> GetTypePage()
        {
            return CBO.FillCollection<TypePage>(DataProvider.Instance().ExecuteReader("GetTypePage"));
        }

        public IList<WeekdayChoice> GetWeekdayChoice()
        {
            return CBO.FillCollection<WeekdayChoice>(DataProvider.Instance().ExecuteReader("GetWeekdayChoice"));
        }

        public IList<RepeatByChoice> GetRepeatByChoice()
        {
            return CBO.FillCollection<RepeatByChoice>(DataProvider.Instance().ExecuteReader("GetRepeatByChoice"));
        }

        public IList<Category> GetCategory()
        {
            return CBO.FillCollection<Category>(DataProvider.Instance().ExecuteReader("GetCategory"));
        }

        public IList<Language> GetLanguage()
        {
            return CBO.FillCollection<Language>(DataProvider.Instance().ExecuteReader("GetLanguage"));
        }

        public IList<RepeatChoice> GetRepeatChoice()
        {
            return CBO.FillCollection<RepeatChoice>(DataProvider.Instance().ExecuteReader("GetRepeatChoice"));
        }

        public IList<Zone> GetZone()
        {
            return CBO.FillCollection<Zone>(DataProvider.Instance().ExecuteReader("GetZone"));
        }

        public IList<CarouselPhoto> GetCarousel(int commonId)
        {
            return CBO.FillCollection<CarouselPhoto>(DataProvider.Instance().ExecuteReader("GetCarouselPhotos", commonId)); //get by common id
        }

        public void AddCarousel(CarouselPhoto carousel)
        {
            //return photo id
            carousel.Id = DataProvider.Instance().ExecuteScalar<int>("AddCarouselPhotos",
                                                      carousel.CommonId,//common id
                                                      carousel.Url//url
                                                        );
        }


        public void DeleteCarousel(CarouselPhoto carousel)
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteCarouselPhotos", carousel.Id);
        }

        public void DeleteAllCarousel(CarouselPhoto carousel)
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteAllCarouselPhotos", carousel.CommonId); //common id
        }

        private static int TYPE_PHOTOS = 0;
        private static int TYPE_VIDEO = 1;

        public IList<Gallery> GetGallery(int CommonId, int Type)
        {
            if (Type == TYPE_PHOTOS)//is photo
            {
                return CBO.FillCollection<Gallery>(DataProvider.Instance().ExecuteReader("GetGalleryPhotos", CommonId));
            }
            else if (Type == TYPE_VIDEO) //is video 
            {
                return CBO.FillCollection<Gallery>(DataProvider.Instance().ExecuteReader("GetGalleryVideos", CommonId));
            }
            else return null;

        }

        public void UpdateGallery(Gallery gallery)
        {
            if (gallery.Type == TYPE_PHOTOS)//is photo
            {
                gallery.Id = DataProvider.Instance().ExecuteScalar<int>("AddGalleryPhotos",
                                                     gallery.CommonId,
                                                     gallery.Url
                                                       );
            }
            else if (gallery.Type == TYPE_VIDEO) //is video 
            {
                gallery.Id = DataProvider.Instance().ExecuteScalar<int>("AddGalleryVideos",
                                                     gallery.CommonId,
                                                     gallery.Url
                                                       );
            }


        }

        public void DeleteGallery(Gallery gallery)
        {

            if (gallery.Type == TYPE_PHOTOS)//is photo
            {
                gallery.Id = DataProvider.Instance().ExecuteScalar<int>("DeleteGalleryPhotos",
                                                     gallery.Id
                                                       );
            }
            else if (gallery.Type == TYPE_VIDEO) //is video 
            {
                gallery.Id = DataProvider.Instance().ExecuteScalar<int>("DeleteGalleryVideos",
                                                     gallery.Id
                                                       );
            }


        }

        public void DeleteAllGallery(Gallery gallery)
        {

            if (gallery.Type == TYPE_PHOTOS)//is photo
            {
                gallery.Id = DataProvider.Instance().ExecuteScalar<int>("DeleteAllGalleryPhotos",
                                                     gallery.CommonId,
                                                     gallery.Id
                                                       );
            }
            else if (gallery.Type == TYPE_VIDEO) //is video 
            {
                gallery.Id = DataProvider.Instance().ExecuteScalar<int>("DeleteAllGalleryVideos",
                                                     gallery.CommonId,
                                                     gallery.Id
                                                       );
            }


        }
    }
}