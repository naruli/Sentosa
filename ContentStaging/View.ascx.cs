/*
' Copyright (c) 2015  Sentosa.com
'  All rights reserved.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
' DEALINGS IN THE SOFTWARE.
' 
*/

using System;
using DotNetNuke.Security;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Modules.Actions;
using DotNetNuke.Services.Localization;
using Sentosa.Modules.ContentStaging.Models;
using System.Collections.Generic;
using DotNetNuke.Services.FileSystem;

namespace Sentosa.Modules.ContentStaging
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from ContentStagingModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : ContentStagingModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    //Initialize Dropdown Module
                    IList<TypePage> typePages = new ContentStagingController().GetTypePages();
                    IList<TypePage> parent = new List<TypePage>();
                    TypePage defaultSelect = new TypePage();
                    defaultSelect.TabId = 0;
                    defaultSelect.TypeId = 0;
                    defaultSelect.Name = "-- Select Module --";

                    parent.Add(defaultSelect);
                    foreach (TypePage item in typePages)
                    {
                        parent.Add(item);
                    }

                    ContentModule.DataSource = parent;
                    ContentModule.DataTextField = "Name";
                    ContentModule.DataValueField = "TabId";
                    ContentModule.DataBind();

                    //Initialize Dropdown Tab Content
                    IList<Place> child = new List<Place>();
                    Place defaultSelectPlace = new Place();
                    defaultSelectPlace.TabID = 0;
                    defaultSelectPlace.TabName = "-- Select Tab Content --";

                    child.Add(defaultSelectPlace);

                    ContentTab.DataSource = child;
                    ContentTab.DataTextField = "TabName";
                    ContentTab.DataValueField = "TabID";
                    ContentTab.DataBind();

                    //Initialize Dropdown Languages
                    IList<Language> languages = new ContentStagingController().GetLanguage();
                    IList<Language> contentLanguages = new List<Language>();
                    Language defaultSelectLanguage = new Language();
                    defaultSelectLanguage.Id = 0;
                    defaultSelectLanguage.CultureName = "-- Select Language --";
                    
                    contentLanguages.Add(defaultSelectLanguage);

                    foreach (Language item in languages)
                    {
                        contentLanguages.Add(item);
                    }

                    ContentLanguage.DataSource = contentLanguages;
                    ContentLanguage.DataTextField = "CultureName";
                    ContentLanguage.DataValueField = "Id";
                    ContentLanguage.DataBind();

                    //Initialize Dropdown Zones
                    IList<Zone> zones = new ContentStagingController().GetZone();
                    IList<Zone> contentZonez = new List<Zone>();
                    Zone defaultSelectZones = new Zone();
                    defaultSelectZones.ZoneId = 0;
                    defaultSelectZones.ZoneName = "-- Select Zone --";

                    contentZonez.Add(defaultSelectZones);

                    foreach (Zone item in zones)
                    {
                        contentZonez.Add(item);
                    }

                    ContentZone.DataSource = contentZonez;
                    ContentZone.DataTextField = "ZoneName";
                    ContentZone.DataValueField = "ZoneId";
                    ContentZone.DataBind();

                    //Initialize Dropdown Repeat Chioce
                    IList<RepeatChoice> repeats = new ContentStagingController().GetRepeatChoice();
                    IList<RepeatChoice> contentRepeats = new List<RepeatChoice>();
                    RepeatChoice defaultSelectRepeats = new RepeatChoice();
                    defaultSelectRepeats.Id = 0;
                    defaultSelectRepeats.TypeofRepetition = "-- Select Repeat --";

                    contentRepeats.Add(defaultSelectRepeats);

                    foreach (RepeatChoice item in repeats)
                    {
                        contentRepeats.Add(item);
                    }

                    ContentRepeat.DataSource = contentRepeats;
                    ContentRepeat.DataTextField = "TypeofRepetition";
                    ContentRepeat.DataValueField = "Id";
                    ContentRepeat.DataBind();

                    //Initialize Dropdown Weekday Chioce
                    IList<WeekdayChoice> weekdays = new ContentStagingController().GetWeekdayChoice();
                    IList<WeekdayChoice> contentWeekdays = new List<WeekdayChoice>();
                    WeekdayChoice defaultSelectWeekdays = new WeekdayChoice();
                    defaultSelectWeekdays.Id = 0;
                    defaultSelectWeekdays.Weekday = "-- Select Weekday --";

                    contentWeekdays.Add(defaultSelectWeekdays);

                    foreach (WeekdayChoice item in weekdays)
                    {
                        contentWeekdays.Add(item);
                    }

                    ContentWeekdays.DataSource = contentWeekdays;
                    ContentWeekdays.DataTextField = "Weekday";
                    ContentWeekdays.DataValueField = "Id";
                    ContentWeekdays.DataBind();

                    //Initialize Dropdown Repeat By Chioce
                    IList<RepeatByChoice> repeatsBy = new ContentStagingController().GetRepeatByChoice();
                    IList<RepeatByChoice> contentRepeatsBy = new List<RepeatByChoice>();
                    RepeatByChoice defaultSelectRepeatsBy = new RepeatByChoice();
                    defaultSelectRepeatsBy.Id = 0;
                    defaultSelectRepeatsBy.RepeatBy = "-- Select Module --";

                    contentRepeatsBy.Add(defaultSelectRepeatsBy);

                    foreach (RepeatByChoice item in repeatsBy)
                    {
                        contentRepeatsBy.Add(item);
                    }

                    ContentRepeatBy.DataSource = contentRepeatsBy;
                    ContentRepeatBy.DataTextField = "RepeatBy";
                    ContentRepeatBy.DataValueField = "Id";
                    ContentRepeatBy.DataBind();

                    //Initialize Dropdown Repeat By Chioce
                    IList<Category> category = new ContentStagingController().GetCategory();
                    IList<Category> contentCategory = new List<Category>();
                    Category defaultSelectCategory = new Category();
                    defaultSelectCategory.Id = 0;
                    defaultSelectCategory.Name = "-- Select Category --";

                    contentCategory.Add(defaultSelectCategory);

                    foreach (Category item in category)
                    {
                        contentCategory.Add(item);
                    }

                    ContentCategory.DataSource = contentCategory;
                    ContentCategory.DataTextField = "Name";
                    ContentCategory.DataValueField = "Id";
                    ContentCategory.DataBind();

                    //Initialize Dropdown Fiuzu Sync
                    IList<StatusSync> fiuzu = new ContentStagingController().GetStatusSync();
                    IList<StatusSync> contentFiuzu = new List<StatusSync>();
                    StatusSync defaultSelectFiuzu = new StatusSync();
                    defaultSelectFiuzu.Id = 0;
                    defaultSelectFiuzu.Status = "-- Select Fiuzu Sync --";

                    contentFiuzu.Add(defaultSelectFiuzu);

                    foreach (StatusSync item in fiuzu)
                    {
                        contentFiuzu.Add(item);
                    }

                    ContentFiuzuSync.DataSource = contentFiuzu;
                    ContentFiuzuSync.DataTextField = "Status";
                    ContentFiuzuSync.DataValueField = "Id";
                    ContentFiuzuSync.DataBind();

                    //Initialize Dropdown Xmob Sync
                    IList<StatusSync> xmob = new ContentStagingController().GetStatusSync();
                    IList<StatusSync> contentXmob = new List<StatusSync>();
                    StatusSync defaultSelectXmob = new StatusSync();
                    defaultSelectXmob.Id = 0;
                    defaultSelectXmob.Status = "-- Select Xmob Sync --";

                    contentXmob.Add(defaultSelectXmob);

                    foreach (StatusSync item in xmob)
                    {
                        contentXmob.Add(item);
                    }

                    ContentXmobSync.DataSource = contentXmob;
                    ContentXmobSync.DataTextField = "Status";
                    ContentXmobSync.DataValueField = "Id";
                    ContentXmobSync.DataBind();

                    //Initialize Dropdown Status
                    IList<StatusChoice> status = new ContentStagingController().GetStatusChoice();
                    IList<StatusChoice> contentStatus = new List<StatusChoice>();
                    StatusChoice defaultSelectStatus = new StatusChoice();
                    defaultSelectStatus.Id = 0;
                    defaultSelectStatus.Value = "-- Select Status --";

                    contentStatus.Add(defaultSelectStatus);

                    foreach (StatusChoice item in status)
                    {
                        contentStatus.Add(item);
                    }

                    ContentStatus.DataSource = contentStatus;
                    ContentStatus.DataTextField = "Value";
                    ContentStatus.DataValueField = "Id";
                    ContentStatus.DataBind();

                    //Initialize Dropdown Sharing Setting
                    IList<SharingSetting> sharingSetting = new ContentStagingController().GetSharingSetting();
                    IList<SharingSetting> contentSharingSetting = new List<SharingSetting>();
                    SharingSetting defaultSelectSharingSetting = new SharingSetting();
                    defaultSelectSharingSetting.Id = 0;
                    defaultSelectSharingSetting.Value = "-- Select Sharing Setting --";

                    contentSharingSetting.Add(defaultSelectSharingSetting);

                    foreach (SharingSetting item in sharingSetting)
                    {
                        contentSharingSetting.Add(item);
                    }

                    ContentSharingSetting.DataSource = contentSharingSetting;
                    ContentSharingSetting.DataTextField = "Value";
                    ContentSharingSetting.DataValueField = "Id";
                    ContentSharingSetting.DataBind();
                }


            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        public ModuleActionCollection ModuleActions
        {
            get
            {
                var actions = new ModuleActionCollection
                    {
                        {
                            GetNextActionID(), Localization.GetString("EditModule", LocalResourceFile), "", "", "",
                            EditUrl(), false, SecurityAccessLevel.Edit, true, false
                        }
                    };
                return actions;
            }
        }

        protected void Parent_SelectedIndexChanged(object sender, EventArgs e)
        {
            var menuScript = "";
            int ParentId = Int32.Parse(ContentModule.SelectedValue);
            if (ParentId > 0)
            {
                string ParentName = ContentModule.SelectedItem.Text.ToLower();
                IList<Place> places = new ContentStagingController().GetPlaces(ParentName);
                IList<Place> child = new List<Place>();
                Place defaultSelect = new Place();
                defaultSelect.TabID = 0;
                defaultSelect.TabName = "-- Select Tab Content --";

                child.Add(defaultSelect);

                foreach (Place item in places)
                {
                    child.Add(item);
                }

                ContentTab.DataSource = child;
                ContentTab.DataTextField = "TabName";
                ContentTab.DataValueField = "TabID";
                ContentTab.DataBind();

                //Load Carousel Data
                var carousel = new ContentStagingController().GetCarousel(ParentId);
                if (carousel.Count > 0)
                {
                    foreach (var item in carousel)
                    {
                        menuScript += "$('#CarouselTable tbody').append(" +
                                    "\n\t'<tr>' +" +
                                    "\n\t\t'<td><img src=\"" + item.Url + "\" class=\"\" style=\"max-width: 270px;max-height: 100px;min-width:270px;min-height:100px\"></td>' +" +
                                    "\n\t\t'<td><input type=\"button\" name=\"deleteBtn\" id=\"" + item.Id + "\" onclick=\"removeCheckbox(this);\" value=\"Delete\" /></td>' +" +
                                    "\n\t'</tr>'" +
                                  "\n);";
                    }
                }
                else
                {
                    menuScript += "$('#CarouselTable tbody').append(" +
                                    "\n\t'<tr><td colspan=\"2\">No Data Found.</td></tr>'" +
                                  ");";
                }
                
                //Load Menu by Parent
                
                menuScript += "$('#panels-demo').show();";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "showMenuModule", menuScript, true);
            }
            else
            {
                ContentTab.ClearSelection();
            }
        }

        protected void Child_SelectedIndexChanged(object sender, EventArgs e)
        {
            var menuScript = "";
            menuScript += "$('#panels-demo').show();";
            int childId = Int32.Parse(ContentTab.SelectedValue);
            if (childId > 0)
            {
                if (!ContentModule.SelectedItem.Text.ToLower().Equals("home"))
                {
                    menuScript += "$('#ContentMenu').show();";
                    menuScript += "$('#GalleryMenu').show();";
                    menuScript += "$('#SubPageMenu').show();";
                }
                //Load Carousel Data
                var carousel = new ContentStagingController().GetCarousel(childId);
                if (carousel.Count > 0)
                {
                    foreach (var item in carousel)
                    {
                        menuScript += "$('#CarouselTable tbody').append(" +
                                    "\n\t'<tr>' +" +
                                    "\n\t\t'<td><img src=\"" + item.Url + "\" class=\"\" style=\"max-width: 270px;max-height: 100px;min-width:270px;min-height:100px\"></td>' +" +
                                    "\n\t\t'<td><input type=\"button\" name=\"deleteBtn\" id=\"" + item.Id + "\" onclick=\"removeCheckbox(this);\" value=\"Delete\" /></td>' +" +
                                    "\n\t'</tr>'" +
                                  "\n);";
                    }
                }
                else
                {
                    menuScript += "$('#CarouselTable tbody').append(" +
                                    "\n\t'<tr><td colspan=\"2\">No Data Found.</td></tr>'" +
                                  ");";
                }

                //Load Gallery Photo Data
                var galleryPhotos = new ContentStagingController().GetGallery(childId, 0);
                var galleryVideos = new ContentStagingController().GetGallery(childId, 1);
                if (galleryPhotos.Count > 0)
                {
                    foreach (var item in galleryPhotos)
                    {
                        menuScript += "$('#GalleryTable tbody').append(" +
                                    "\n\t'<tr>' +" +
                                    "\n\t\t'<td><img src=\"" + item.Url + "\" class=\"\" style=\"max-width: 270px;max-height: 100px;min-width:270px;min-height:100px\"></td>' +" +
                                    "\n\t\t'<td><input type=\"button\" name=\"deleteBtn\" id=\"" + item.Id + "_" + item.Type + "\" onclick=\"removeGallery(this);\" value=\"Delete\" /></td>' +" +
                                    "\n\t'</tr>'" +
                                  "\n);";
                    }
                }
                if (galleryVideos.Count > 0)
                {
                    foreach (var item in galleryVideos)
                    {
                        menuScript += "$('#GalleryTable tbody').append(" +
                                    "\n\t'<tr>' +" +
                                    "\n\t\t'<td><video width=\"270\" height=\"100\" controls><source src=\"" + item.Url + "\" type=\"video/" + item.Url.Split('.')[item.Url.Split('.').Length - 1].ToLower() + "\"></video></td>' +" +
                                    "\n\t\t'<td><input type=\"button\" name=\"deleteBtn\" id=\"" + item.Id + "_" + item.Type + "\" onclick=\"removeGallery(this);\" value=\"Delete\" /></td>' +" +
                                    "\n\t'</tr>'" +
                                  "\n);";
                    }
                }
                if(galleryPhotos.Count < 1 && galleryVideos.Count < 1)
                {
                    menuScript += "$('#GalleryTable tbody').append(" +
                                    "\n\t'<tr><td colspan=\"2\">No Data Found.</td></tr>'" +
                                  ");";
                }

                Place detail = new ContentStagingController().GetPlace(childId);
                //Clear All DatePicker
                ContentEventStart.Clear();
                ContentEventEnd.Clear();
                ContentExceptDate.Clear();
                ContentStartDate.Clear();
                ContentEndDate.Clear();

                ContentLanguage.ClearSelection();

                ContentZone.ClearSelection();
                ContentRepeat.ClearSelection();
                ContentWeekdays.ClearSelection();
                ContentRepeatBy.ClearSelection();

                ContentCategory.ClearSelection();
                ContentFiuzuSync.ClearSelection();
                ContentXmobSync.ClearSelection();
                ContentStatus.ClearSelection();
                ContentSharingSetting.ClearSelection();

                ContentShortDesc.Text = detail.ShortDescription;
                ContentAdmission.Text = detail.AdmissionInfo;
                ContentOpeningHours.Text = detail.OpeningHour;
                ContentNatureAge.Text = detail.NatureAgeRestrictions;
                ContentNatureGuide.Text = detail.NatureGuidedTours;
                ContentHighlights.Text = detail.Highlight;
                ContentDetails.Text = detail.Details;
                ContentPhone.Text = detail.Phone;
                ContentAddress.Text = detail.Address;
                ContentOpeningTime.Text = detail.OpeningTime;
                ContentClosingTime.Text = detail.ClosingTime;
                ContentRank.Text = detail.Rank;
                ContentPrice.Text = detail.Price;
                ContentBestStart.Text = detail.BestStart;
                ContentBestEnd.Text = detail.BestEnd;
                ContentDurationEasy.Text = detail.DurationEasy;
                ContentDurationModerate.Text = detail.DurationModerate;
                ContentDurationExtreme.Text = detail.DurationExtreme;
                ContentLatitude.Text = detail.Lat;
                ContentLongitude.Text = detail.Lng;
                ContentAllDay.Checked = false;
                ContentRepeated.Checked = false;
                ContentStartTime.Text = detail.StartTime;
                ContentEndTime.Text = detail.EndTime;
                ContentInstruction.Text = detail.Instruction;
                ContentAllTime.Checked = false;
                ContentEvery.Text = "1";
                ContentRepeatAfter.Text = "0";
                ContentImage.FilePath = String.Format("FileID={0}", ContentImage.FileID);

                if (detail.CommonId != null)
                {
                    ContentShortDesc.Text = detail.ShortDescription;
                    ContentAdmission.Text = detail.AdmissionInfo;
                    ContentOpeningHours.Text = detail.OpeningHour;
                    ContentNatureAge.Text = detail.NatureAgeRestrictions;
                    ContentNatureGuide.Text = detail.NatureGuidedTours;
                    if (detail.EventEndDate != "")
                        ContentEventStart.SelectedDate = Convert.ToDateTime(detail.EventStartDate.Split(' ')[0]);
                    if (detail.EventEndDate != "")
                        ContentEventEnd.SelectedDate = Convert.ToDateTime(detail.EventEndDate.Split(' ')[0]);
                    ContentLanguage.SelectedValue = detail.LanguageId.ToString();
                    ContentHighlights.Text = detail.Highlight;
                    ContentDetails.Text = detail.Details;
                    ContentPhone.Text = detail.Phone;
                    ContentAddress.Text = detail.Address;
                    ContentOpeningTime.Text = detail.OpeningTime;
                    ContentClosingTime.Text = detail.ClosingTime;
                    ContentRank.Text = detail.Rank;
                    ContentPrice.Text = detail.Price;
                    ContentBestStart.Text = detail.BestStart;
                    ContentBestEnd.Text = detail.BestEnd;
                    ContentDurationEasy.Text = detail.DurationEasy;
                    ContentDurationModerate.Text = detail.DurationModerate;
                    ContentDurationExtreme.Text = detail.DurationExtreme;
                    ContentAllDay.Checked = (bool)detail.AllDay;
                    ContentRepeated.Checked = (bool)detail.IsRepeated;
                    ContentStartTime.Text = detail.StartTime;
                    ContentEndTime.Text = detail.EndTime;
                    ContentInstruction.Text = detail.Instruction;
                    ContentZone.SelectedValue = detail.ZoneId.ToString();
                    ContentLatitude.Text = detail.Lat.ToString();
                    ContentLongitude.Text = detail.Lng.ToString();
                    ContentAllTime.Checked = (bool)detail.AllTime;
                    ContentRepeat.SelectedValue = detail.Repeat.ToString();
                    ContentEvery.Text = detail.Every.ToString();
                    ContentWeekdays.SelectedValue = detail.Weekdays.ToString();
                    ContentRepeatAfter.Text = detail.RepeatAfter.ToString();
                    ContentRepeatBy.SelectedValue = detail.RepeatBy.ToString();
                    if(detail.ExceptDates != "")
                        ContentExceptDate.SelectedDate = Convert.ToDateTime(detail.ExceptDates.Split(' ')[0]);
                    if(detail.start_date != "")
                        ContentStartDate.SelectedDate = Convert.ToDateTime(detail.start_date.Split(' ')[0]);
                    if (detail.end_date != "")
                        ContentEndDate.SelectedDate = Convert.ToDateTime(detail.end_date.Split(' ')[0]);
                    if (Settings.Contains("image_" + detail.CommonId))
                        ContentImage.FilePath = Settings["image_" + detail.CommonId].ToString();
                    
                    ContentCategory.SelectedValue = detail.Category.ToString();
                    ContentFiuzuSync.SelectedValue = detail.FiuzuSync.ToString();
                    ContentXmobSync.SelectedValue = detail.XmobSync.ToString();
                    ContentStatus.SelectedValue = detail.Status.ToString();
                    ContentSharingSetting.SelectedValue = detail.SharingSetting.ToString();
                }
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "showMenuTab", menuScript, true);
        }

        protected void ContentSave_Click(object sender, EventArgs e)
        {
            int ParentId = Int32.Parse(ContentModule.SelectedValue);
            int childId = Int32.Parse(ContentTab.SelectedValue);
            if (ParentId > 0 && childId > 0)
            {
                var contentModule = new Place();
                var contentController = new ContentStagingController();

                contentModule.TabID = Int32.Parse(ContentTab.SelectedValue);
                contentModule.ShortDescription = ContentShortDesc.Text;
                contentModule.AdmissionInfo = ContentAdmission.Text;
                contentModule.OpeningHour = ContentOpeningHours.Text;
                contentModule.NatureAgeRestrictions = ContentNatureAge.Text;
                contentModule.NatureGuidedTours = ContentNatureGuide.Text;
                contentModule.EventStartDate = ContentEventStart.SelectedDate.ToString();
                contentModule.EventEndDate = ContentEventEnd.SelectedDate.ToString();
                contentModule.LanguageId = Int32.Parse(ContentLanguage.SelectedValue);
                contentModule.Highlight = ContentHighlights.Text;
                contentModule.Details = ContentDetails.Text;
                contentModule.Phone = ContentPhone.Text;
                contentModule.Address = ContentAddress.Text;
                contentModule.OpeningTime = ContentOpeningTime.Text;
                contentModule.ClosingTime = ContentClosingTime.Text;
                contentModule.Rank = ContentRank.Text;
                contentModule.Price = ContentPrice.Text;
                contentModule.BestStart = ContentBestStart.Text;
                contentModule.BestEnd = ContentBestEnd.Text;
                contentModule.DurationEasy = ContentDurationEasy.Text;
                contentModule.DurationModerate = ContentDurationModerate.Text;
                contentModule.DurationExtreme = ContentDurationExtreme.Text;
                contentModule.AllDay = ContentAllDay.Checked;
                contentModule.IsRepeated = ContentRepeated.Checked;
                contentModule.StartTime = ContentStartTime.Text;
                contentModule.EndTime = ContentEndTime.Text;
                contentModule.Instruction = ContentInstruction.Text;
                contentModule.ZoneId = Int32.Parse(ContentZone.SelectedValue);
                contentModule.Lat = ContentLatitude.Text;
                contentModule.Lng = ContentLongitude.Text;
                contentModule.AllTime = ContentAllTime.Checked;
                contentModule.Repeat = Int32.Parse(ContentRepeat.SelectedValue);
                contentModule.Every = (ContentEvery.Text != "" ? Int32.Parse(ContentEvery.Text) : 1);
                contentModule.Weekdays = Int32.Parse(ContentWeekdays.SelectedValue);
                contentModule.RepeatAfter = (ContentRepeatAfter.Text != "" ? Int32.Parse(ContentRepeatAfter.Text) : 0);
                contentModule.RepeatBy = Int32.Parse(ContentRepeatBy.SelectedValue);
                contentModule.ExceptDates = ContentExceptDate.SelectedDate.ToString();
                contentModule.start_date = ContentStartDate.SelectedDate.ToString();
                contentModule.end_date = ContentEndDate.SelectedDate.ToString();
                
                var image = (FileInfo)FileManager.Instance.GetFile(ContentImage.FileID);
                if(image != null)
                {
                   contentModule.Photo = Request.Url.GetLeftPart(UriPartial.Authority) + FileManager.Instance.GetUrl(image);
                }
                
                contentModule.Category = Int32.Parse(ContentCategory.SelectedValue);
                contentModule.FiuzuSync = Int32.Parse(ContentFiuzuSync.SelectedValue);
                contentModule.XmobSync = Int32.Parse(ContentXmobSync.SelectedValue);
                contentModule.Status = Int32.Parse(ContentStatus.SelectedValue);
                contentModule.SharingSetting = Int32.Parse(ContentSharingSetting.SelectedValue);

                contentController.AddPlace(contentModule);

                var modules = new ModuleController();
                if (image != null)
                    modules.UpdateModuleSetting(ModuleId, "image_" + contentModule.CommonId, String.Format("FileID={0}", ContentImage.FileID));

                Response.Write("<script>alert('Successfully Updated!');</script>");

                Child_SelectedIndexChanged(sender, e);
            }
            else
            {
                if (ParentId > 0)
                {
                    Response.Write("<script>alert('Please Select Tab Content Dropdown!');</script>");
                }
                else
                {
                    Response.Write("<script>alert('Please Select Module Dropdown!');</script>");
                }
            }
            
        }

        protected void CarouselSave_Click(object sender, EventArgs e)
        {
            int ParentId = Int32.Parse(ContentModule.SelectedValue);
            int childId = Int32.Parse(ContentTab.SelectedValue);
            var carouselModule = new CarouselPhoto();
            var carouselController = new ContentStagingController();
            if (ParentId > 0 && childId > 0)
            {
                var image = (FileInfo)FileManager.Instance.GetFile(CarouselImage.FileID);
                if (image != null)
                {
                    carouselModule.Url = Request.Url.GetLeftPart(UriPartial.Authority) + FileManager.Instance.GetUrl(image);
                    carouselModule.CommonId = childId;
                    carouselController.AddCarousel(carouselModule);

                    Response.Write("<script>alert('Successfully Updated!');</script>");

                    Child_SelectedIndexChanged(sender, e);
                }
                else
                {
                    Response.Write("<script>alert('Please Select Image!');</script>");
                }
            }
            else
            {
                var image = (FileInfo)FileManager.Instance.GetFile(CarouselImage.FileID);
                if (image != null)
                {
                    carouselModule.Url = Request.Url.GetLeftPart(UriPartial.Authority) + FileManager.Instance.GetUrl(image);
                    carouselModule.CommonId = ParentId;
                    carouselController.AddCarousel(carouselModule);

                    Response.Write("<script>alert('Successfully Updated!');</script>");

                    Parent_SelectedIndexChanged(sender, e);
                }
                else
                {
                    Response.Write("<script>alert('Please Select Image!');</script>");
                }
            }
        }

        protected void GallerySave_Click(object sender, EventArgs e)
        {
            int ParentId = Int32.Parse(ContentModule.SelectedValue);
            int childId = Int32.Parse(ContentTab.SelectedValue);
            var galleryModule = new Gallery();
            var galleryController = new ContentStagingController();
            if (ParentId > 0 && childId > 0)
            {
                var imageType = "jpg, jpeg, jpe, gif, bmp, png";
                var videoType = "mp4, webm, ogg";
                var image = (FileInfo)FileManager.Instance.GetFile(GalleryImage.FileID);
                if (image != null)
                {
                    var fileType = image.FileName.Split('.')[image.FileName.Split('.').Length - 1].ToLower();
                    galleryModule.Url = Request.Url.GetLeftPart(UriPartial.Authority) + FileManager.Instance.GetUrl(image);
                    galleryModule.CommonId = childId;
                    if (imageType.Contains(fileType))
                    {
                        galleryModule.Type = 0;
                        galleryController.UpdateGallery(galleryModule);
                        Response.Write("<script>alert('Successfully Updated!');</script>");
                    }
                    else if (videoType.Contains(fileType))
                    {
                        galleryModule.Type = 1;
                        galleryController.UpdateGallery(galleryModule);
                        Response.Write("<script>alert('Successfully Updated!');</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('File Format Incorrect!\nImage : " + imageType +".\nVideo : " + videoType + ".');</script>");
                    }

                    Child_SelectedIndexChanged(sender, e);
                }
                else
                {
                    Response.Write("<script>alert('Please Select Image!');</script>");
                }
            }
        }
    }
}