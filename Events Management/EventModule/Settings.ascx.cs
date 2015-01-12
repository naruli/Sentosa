/*
' Copyright (c) 2014  Sentosa.com
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
using DotNetNuke.Entities.Modules;
using DotNetNuke.Services.Exceptions;
using System.Collections.Generic;
using DotNetNuke.Services.FileSystem;

namespace Sentosa.Modules.EventModule
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The Settings class manages Module Settings
    /// 
    /// Typically your settings control would be used to manage settings for your module.
    /// There are two types of settings, ModuleSettings, and TabModuleSettings.
    /// 
    /// ModuleSettings apply to all "copies" of a module on a site, no matter which page the module is on. 
    /// 
    /// TabModuleSettings apply only to the current module on the current page, if you copy that module to
    /// another page the settings are not transferred.
    /// 
    /// If you happen to save both TabModuleSettings and ModuleSettings, TabModuleSettings overrides ModuleSettings.
    /// 
    /// Below we have some examples of how to access these settings but you will need to uncomment to use.
    /// 
    /// Because the control inherits from EventModuleSettingsBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class Settings : EventModuleModuleSettingsBase
    {
        public static int LIST_INTEREST_GROUP = 2; //list Event
        #region Base Method Implementations

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// LoadSettings loads the settings from the Database and displays them
        /// </summary>
        /// -----------------------------------------------------------------------------
        public override void LoadSettings()
        {
            try
            {
                if (Page.IsPostBack == false)
                {
                    //Check for existing settings and use those on this page
                    //Settings["SettingName"]

                    /* uncomment to load saved settings in the text boxes
                    if(Settings.Contains("Setting1"))
                        txtSetting1.Text = Settings["Setting1"].ToString();
			
                    if (Settings.Contains("Setting2"))
                        txtSetting2.Text = Settings["Setting2"].ToString();

                    */
                    IList<Models.ItemList> listItem = new Models.ListController().GetItemList(LIST_INTEREST_GROUP);
                    cmbCategory1.DataSource = listItem;
                    cmbCategory1.DataTextField = "Value";
                    cmbCategory1.DataValueField = "Id";
                    cmbCategory1.DataBind();
                }
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// UpdateSettings saves the modified settings to the Database
        /// </summary>
        /// -----------------------------------------------------------------------------
        public override void UpdateSettings()
        {
            try
            {
                var modules = new ModuleController();

                //the following are two sample Module Settings, using the text boxes that are commented out in the ASCX file.
                //module settings
                //modules.UpdateModuleSetting(ModuleId, "Setting1", txtSetting1.Text);
                //modules.UpdateModuleSetting(ModuleId, "Setting2", txtSetting2.Text);

                //tab module settings
                //modules.UpdateTabModuleSetting(TabModuleId, "Setting1",  txtSetting1.Text);
                //modules.UpdateTabModuleSetting(TabModuleId, "Setting2",  txtSetting2.Text);
                var EventModel = new Models.Event();
                var EventController = new Models.EventController();
                var image = (FileInfo)FileManager.Instance.GetFile(fileThumbnail1.FileID);
                if (image != null && !String.IsNullOrEmpty(txtTitle1.Text))
                {
                    EventModel.Title = txtTitle1.Text;
                    EventModel.Description = txtDescription1.Text;
                    EventModel.ShortDesc = txtShortDesc1.Text;
                    EventModel.Category = cmbCategory1.SelectedValue;
                    EventModel.UrlPurchase = txtUrlPurch1.Text;
                    EventModel.Zone = Request.Params["txtFormatAddr"].ToString();
                    EventModel.Url = txtUrlCal1.Text;
                    EventModel.PathImage = FileManager.Instance.GetUrl(image);
                    EventModel.StartDate = Convert.ToDateTime(txtStartDate1.SelectedDate.ToString());
                    EventModel.EndDate = Convert.ToDateTime(txtEndDate1.SelectedDate.ToString());

                    EventModel.Author = UserInfo.DisplayName.ToString();
                    EventModel.Editor = UserInfo.DisplayName.ToString();

                    EventModel = EventController.saveEvent(EventModel);

                    float Latitude = float.Parse(Request.Params["txtlat"].ToString());

                    float Longitude = float.Parse(Request.Params["txtlng"].ToString());
                    //set zone details
                    EventController.SaveZoneDetails(EventModel.Id, Latitude, Longitude);


                }
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        #endregion
    }
}