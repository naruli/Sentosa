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
using DotNetNuke.Services.FileSystem;
using DotNetNuke.Entities.Users;
using System.Collections.Generic;

namespace Sentosa.Modules.DiningModule
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
    /// Because the control inherits from DiningModuleSettingsBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class Settings : DiningModuleModuleSettingsBase
    {
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

                //Add Dining
                var dining = new Models.Dining();
                var diningController = new Models.DiningController();

                var image = (FileInfo)FileManager.Instance.GetFile(fileThumbnail1.FileID);

                if (image != null && !String.IsNullOrEmpty(txtTitle1.Text))
                {
                    dining.Title = txtTitle1.Text;
                    dining.ShortDesc = txtShortDesc1.Text;
                    dining.Author = UserController.GetUserById(PortalId, UserId).DisplayName;
                    dining.Editor = UserController.GetUserById(PortalId, UserId).DisplayName;
                    dining.UrlPurchase = txtUrlPurch1.Text;
                    dining.Zone = Request.Params["txtFormatAddr"].ToString();
                    dining.PathImage = FileManager.Instance.GetUrl(image);
                    dining.Latitude = float.Parse(Request.Params["txtlat"].ToString());
                    dining.Longitude = float.Parse(Request.Params["txtlng"].ToString());
                    diningController.AddDining(dining);
                }

                //Add Dining Experience if any
                var diningExperience = new Models.DiningExperience();
                IList<Models.ItemList> listDining = new Models.ListController().GetItemListDining();
                diningExperience.Id = dining.Id;
                int counter = 1;
                foreach (Models.ItemList de in listDining)
                {
                    diningExperience.Category = de.Id;
                    diningExperience.IsHave = false;
                    diningController.AddDiningExperience(diningExperience);
                    counter++;
                }
                

                //Add Cuisine Type if any
                var cuisineType = new Models.CuisineType();
                IList<Models.ItemList> listCuisine = new Models.ListController().GetItemListCuisine();
                cuisineType.Id = dining.Id;
                counter = 1;
                foreach (Models.ItemList ct in listCuisine)
                {
                    cuisineType.Category = ct.Id;
                    cuisineType.IsHave = false;
                    diningController.AddCuisineType(cuisineType);
                    counter++;
                }


                int totalDining = Int32.Parse(Request.Params["add_dining"]);
                for (int index = 1; index <= totalDining; index++)
                {
                    if (!String.IsNullOrEmpty(Request.Form["add_dining_" + index]))
                    {
                        diningExperience.Category = Request.Form["add_dining_" + index];
                        diningExperience.IsHave = true;
                        diningController.UpdateDiningExperience(diningExperience);
                    }
                }

                int totalCuisine = Int32.Parse(Request.Params["add_cuisine"]);
                for (int index = 1; index <= totalCuisine; index++)
                {
                    if (!String.IsNullOrEmpty(Request.Form["add_cuisine_" + index]))
                    {
                        cuisineType.Category = Request.Form["add_cuisine_" + index];
                        cuisineType.IsHave = true;
                        diningController.UpdateCuisineType(cuisineType);
                    }
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