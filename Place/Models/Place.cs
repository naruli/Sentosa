using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.Place.Models
{
    public class Place
    {
        public int Total { get; set; }
        public int TabID { get; set; }
        public int TabOrder { get; set; }
        public Nullable<int> PortalID { get; set; }
        public string TabName { get; set; }
        public bool IsVisible { get; set; }
        public Nullable<int> ParentId { get; set; }
        public string IconFile { get; set; }
        public bool DisableLink { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string KeyWords { get; set; }
        public bool IsDeleted { get; set; }
        public string Url { get; set; }
        public string SkinSrc { get; set; }
        public string ContainerSrc { get; set; }
        public Nullable<System.DateTime> StartDate { get; set; }
        public Nullable<System.DateTime> EndDate { get; set; }
        public Nullable<int> RefreshInterval { get; set; }
        public string PageHeadText { get; set; }
        public bool IsSecure { get; set; }
        public bool PermanentRedirect { get; set; }
        public double SiteMapPriority { get; set; }
        public Nullable<int> CreatedByUserID { get; set; }
        public Nullable<System.DateTime> CreatedOnDate { get; set; }
        public Nullable<int> LastModifiedByUserID { get; set; }
        public Nullable<System.DateTime> LastModifiedOnDate { get; set; }
        public string IconFileLarge { get; set; }
        public string CultureCode { get; set; }
        public Nullable<int> ContentItemID { get; set; }
        public System.Guid UniqueId { get; set; }
        public System.Guid VersionGuid { get; set; }
        public Nullable<System.Guid> DefaultLanguageGuid { get; set; }
        public System.Guid LocalizedVersionGuid { get; set; }
        public int Level { get; set; }
        public string TabPath { get; set; }
        public string ShortDescription { get; set; }
        public string AdmissionInfo { get; set; }
        public string OpeningHour { get; set; }
        public string NatureAgeRestrictions { get; set; }
        public string NatureGuidedTours { get; set; }
        public string EventStartDate { get; set; }
        public string EventEndDate { get; set; }
        public Nullable<int> ZoneId { get; set; }
        public string Timestamp { get; set; }
        public Nullable<int> CommonId { get; set; }
        public Nullable<int> LanguageId { get; set; }
        public string SourceUrl { get; set; }
        public string Highlight { get; set; }
        public string Details { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public string OpeningTime { get; set; }
        public string ClosingTime { get; set; }
        public string Rank { get; set; }
        public Nullable<int> Status { get; set; }
        public string cluster_id { get; set; }
        public string Price { get; set; }
        public string BestStart { get; set; }
        public string BestEnd { get; set; }
        public string DurationEasy { get; set; }
        public string DurationModerate { get; set; }
        public string DurationExtreme { get; set; }
        public Nullable<bool> AllDay { get; set; }
        public Nullable<bool> IsRepeated { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public Nullable<int> SharingSetting { get; set; }
        public Nullable<int> PlaceId { get; set; }
        public string Instruction { get; set; }
        public string Lat { get; set; }
        public string Lng { get; set; }
        public Nullable<bool> AllTime { get; set; }
        public Nullable<int> Repeat { get; set; }
        public Nullable<int> Every { get; set; }
        public Nullable<int> Weekdays { get; set; }
        public Nullable<int> RepeatAfter { get; set; }
        public Nullable<int> RepeatBy { get; set; }
        public string ExceptDates { get; set; }
        public string start_date { get; set; }
        public string end_date { get; set; }
        public string Photo { get; set; }
        public Nullable<int> Category { get; set; }
        public Nullable<int> FiuzuSync { get; set; }
        public Nullable<int> XmobSync { get; set; }
    }

    public class TypePage
    {
        public int TypeId { get; set; }
        public int TabId { get; set; }
        public string Name { get; set; }
    }

    public class Tag
    {
        public int Id { get; set; }
        public int CommonId { get; set; }
        public int LanguageId { get; set; }
        public int TypeId { get; set; }
        public string TagName { get; set; }
    }
}