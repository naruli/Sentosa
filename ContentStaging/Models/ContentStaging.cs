﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.ContentStaging.Models
{
    public class Place
    {
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

    public class StatusChoice
    {
        public int Id { get; set; }
        public string Value { get; set; }
    }

    public class StatusSync
    {
        public int Id { get; set; }
        public string Status { get; set; }
    }

    public class SharingSetting
    {
        public int Id { get; set; }
        public string Value { get; set; }
    }

    public class WeekdayChoice
    {
        public int Id { get; set; }
        public string Weekday { get; set; }
        public string Constant { get; set; }
        public int Numeric { get; set; }
        public string Description { get; set; }
    }

    public class RepeatByChoice
    {
        public int Id { get; set; }
        public string RepeatBy { get; set; }
        public string Constant { get; set; }
        public int NumericValue { get; set; }
        public string Description { get; set; }
    }

    public class Category
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Constant { get; set; }
        public int NumericValue { get; set; }
        public string Description { get; set; }
    }

    public class Language
    {
        public int Id { get; set; }
        public string CultureCode { get; set; }
        public string CultureName { get; set; }
        public string FallbackCulture { get; set; }
        public int CreatedByUserID { get; set; }
        public DateTime CreatedOnDate { get; set; }
        public int LastModifiedByUserID { get; set; }
        public DateTime LastModifiedOnDate { get; set; }
    }

    public class TypePage
    {
        public int TypeId { get; set; }
        public int TabId { get; set; }
        public string Name { get; set; }
    }

    public class RepeatChoice
    {
        public int Id { get; set; }
        public string TypeofRepetition { get; set; }
        public string Constant { get; set; }
        public int NumericValue { get; set; }
        public string Description { get; set; }

    }

    public class Zone
    {
        public int Id { get; set; }
        public string ZoneName { get; set; }
    }

    public class CarouselPhoto
    {
        public int Id { get; set; }
        public int CommonId { get; set; }
        public string Url { get; set; }
        public int OrderCarousel { get; set; }
        public string Caption { get; set; }
        public string Description { get; set; }
        public string Button { get; set; }
        public string Link { get; set; }
        public bool Position { get; set; }
        public int Color { get; set; }
        public string Photo { get; set; }
    }

    public class Gallery
    {
        public int Id { get; set; }
        public int CommonId { get; set; }
        public string Url { get; set; }
        public int Type { get; set; } //0 is photo , 1 is video
        public int OrderGallery { get; set; }
    }

    public class Tag
    {
        public int Id { get; set; }
        public int CommonId { get; set; }
        public int LanguageId { get; set; }
        public int TypeId { get; set; }
        public string Tagname { get; set; }
    }

    public class TagPlace
    {
        public int Id { get; set; }
        public int TabId { get; set; }
        public int TagId { get; set; }
    }

    public class SubPagePlace
    {
        public int Id { get; set; }
        public int TabId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public int OrderSubPage { get; set; }
    }
}