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

namespace Sentosa.Modules.BeachesModule
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
    /// Because the control inherits from BeachesModuleSettingsBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class Settings : BeachesModuleModuleSettingsBase
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

                var BeachesModule = new Models.Beaches();
                var BeachesController = new Models.BeachesController();
                var image = (FileInfo)FileManager.Instance.GetFile(fileThumbnail1.FileID);

                if (image != null && !String.IsNullOrEmpty(txtTitle1.Text))
                {
                    BeachesModule.Title = txtTitle1.Text;
                    BeachesModule.ShortDesc = txtShortDesc1.Text;
                    BeachesModule.Author = UserController.GetUserById(PortalId, UserId).DisplayName;
                    BeachesModule.Editor = UserController.GetUserById(PortalId, UserId).DisplayName;
                    BeachesModule.UrlBrochure = txtUrlBrochure1.Text;
                    BeachesModule.Zone = Request.Params["txtFormatAddr"].ToString();
                    BeachesModule.PathImage = FileManager.Instance.GetUrl(image);
                    BeachesModule.Latitude = float.Parse(Request.Params["txtlat"].ToString());
                    BeachesModule.Longitude = float.Parse(Request.Params["txtlng"].ToString());
                    BeachesController.AddBeaches(BeachesModule);
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