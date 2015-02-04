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
using DotNetNuke.Common;

namespace Sentosa.Modules.ExploreModule
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
    /// Because the control inherits from ExploreModuleSettingsBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class Settings : ExploreModuleModuleSettingsBase
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

                    //Basic Setting
                    if (Settings.Contains("ExploreTitle"))
                        TextTitle.Text = Settings["ExploreTitle"].ToString();

                    if (Settings.Contains("ExploreDesc"))
                        TextDescription.Text = Settings["ExploreDesc"].ToString();

                    //Attractions Thumbnail
                    filepicker1.FileFilter = Globals.glbImageFileTypes;
                    if (Settings.Contains("Image1"))
                        filepicker1.FilePath = Settings["Image1"].ToString();

                    //Beaches Thumbnail
                    filepicker2.FileFilter = Globals.glbImageFileTypes;
                    if (Settings.Contains("Image2"))
                        filepicker2.FilePath = Settings["Image2"].ToString();

                    //Nature Thumbnail
                    filepicker3.FileFilter = Globals.glbImageFileTypes;
                    if (Settings.Contains("Image3"))
                        filepicker3.FilePath = Settings["Image3"].ToString();

                    //Dining Thumbnail
                    filepicker4.FileFilter = Globals.glbImageFileTypes;
                    if (Settings.Contains("Image4"))
                        filepicker4.FilePath = Settings["Image4"].ToString();

                    //Shops Thumbnail
                    filepicker5.FileFilter = Globals.glbImageFileTypes;
                    if (Settings.Contains("Image5"))
                        filepicker5.FilePath = Settings["Image5"].ToString();

                    //Golf Thumbnail
                    filepicker6.FileFilter = Globals.glbImageFileTypes;
                    if (Settings.Contains("Image6"))
                        filepicker6.FilePath = Settings["Image6"].ToString();

                    //Hotels and Spas Thumbnail
                    filepicker7.FileFilter = Globals.glbImageFileTypes;
                    if (Settings.Contains("Image7"))
                        filepicker7.FilePath = Settings["Image7"].ToString();

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
                var explore = new Models.Explore();
                var eu = new Models.ExploreController();
                var image = new FileInfo();

                //Save Basic Setting
                if (!String.IsNullOrEmpty(TextTitle.Text))
                {
                    modules.UpdateModuleSetting(ModuleId, "ExploreTitle", TextTitle.Text);
                }
                else
                {
                    modules.UpdateModuleSetting(ModuleId, "ExploreTitle", "Explore The State");
                }

                if (!String.IsNullOrEmpty(TextDescription.Text))
                {
                    modules.UpdateModuleSetting(ModuleId, "ExploreDesc", TextDescription.Text);
                }
                else
                {
                    modules.UpdateModuleSetting(ModuleId, "ExploreDesc", "Go on a journey in The State of Fun. Discover the many different.");
                }

                //Delete All Data Thumbnail
                eu.DeleteExplore();

                //Attractions Thumbnail
                modules.UpdateModuleSetting(ModuleId, "Image1", String.Format("FileID={0}", filepicker1.FileID));
                
                image = (FileInfo)FileManager.Instance.GetFile(filepicker1.FileID);
                explore.PathImage = FileManager.Instance.GetUrl(image);
                explore.Title = "Attractions";
                explore.Description = "Attractions";
                explore.Url = "/Explore/Attractions";

                eu.AddExplore(explore);

                explore = new Models.Explore();
                eu = new Models.ExploreController();
                image = new FileInfo();
                //Beaches Thumbnail
                modules.UpdateModuleSetting(ModuleId, "Image2", String.Format("FileID={0}", filepicker2.FileID));

                image = (FileInfo)FileManager.Instance.GetFile(filepicker2.FileID);
                explore.PathImage = FileManager.Instance.GetUrl(image);
                explore.Title = "Beaches";
                explore.Description = "Beaches";
                explore.Url = "/Explore/Beaches";

                eu.AddExplore(explore);

                explore = new Models.Explore();
                eu = new Models.ExploreController();
                image = new FileInfo();
                //Nature Thumbnail
                modules.UpdateModuleSetting(ModuleId, "Image3", String.Format("FileID={0}", filepicker3.FileID));

                image = (FileInfo)FileManager.Instance.GetFile(filepicker3.FileID);
                explore.PathImage = FileManager.Instance.GetUrl(image);
                explore.Title = "Nature";
                explore.Description = "Nature";
                explore.Url = "/Explore/Nature";

                eu.AddExplore(explore);

                explore = new Models.Explore();
                eu = new Models.ExploreController();
                image = new FileInfo();
                //Dining Thumbnail
                modules.UpdateModuleSetting(ModuleId, "Image4", String.Format("FileID={0}", filepicker4.FileID));

                image = (FileInfo)FileManager.Instance.GetFile(filepicker4.FileID);
                explore.PathImage = FileManager.Instance.GetUrl(image);
                explore.Title = "Dining";
                explore.Description = "Dining";
                explore.Url = "/Explore/Dining";

                eu.AddExplore(explore);

                explore = new Models.Explore();
                eu = new Models.ExploreController();
                image = new FileInfo();
                //Shops Thumbnail
                modules.UpdateModuleSetting(ModuleId, "Image5", String.Format("FileID={0}", filepicker5.FileID));

                image = (FileInfo)FileManager.Instance.GetFile(filepicker5.FileID);
                explore.PathImage = FileManager.Instance.GetUrl(image);
                explore.Title = "Shops";
                explore.Description = "Shops";
                explore.Url = "/Explore/Shops";

                eu.AddExplore(explore);

                explore = new Models.Explore();
                eu = new Models.ExploreController();
                image = new FileInfo();
                //Golf Thumbnail
                modules.UpdateModuleSetting(ModuleId, "Image6", String.Format("FileID={0}", filepicker6.FileID));

                image = (FileInfo)FileManager.Instance.GetFile(filepicker6.FileID);
                explore.PathImage = FileManager.Instance.GetUrl(image);
                explore.Title = "Golf";
                explore.Description = "Golf";
                explore.Url = "/Explore/Golf";

                eu.AddExplore(explore);

                explore = new Models.Explore();
                eu = new Models.ExploreController();
                image = new FileInfo();
                //Hotels and Spas Thumbnail
                modules.UpdateModuleSetting(ModuleId, "Image7", String.Format("FileID={0}", filepicker7.FileID));

                image = (FileInfo)FileManager.Instance.GetFile(filepicker7.FileID);
                explore.PathImage = FileManager.Instance.GetUrl(image);
                explore.Title = "Hotels And Spas";
                explore.Description = "Hotels And Spas";
                explore.Url = "/Explore/Hotels-And-Spas";

                eu.AddExplore(explore);
                
                //the following are two sample Module Settings, using the text boxes that are commented out in the ASCX file.
                //module settings
                //modules.UpdateModuleSetting(ModuleId, "Setting1", txtSetting1.Text);
                //modules.UpdateModuleSetting(ModuleId, "Setting2", txtSetting2.Text);

                //tab module settings
                //modules.UpdateTabModuleSetting(TabModuleId, "Setting1",  txtSetting1.Text);
                //modules.UpdateTabModuleSetting(TabModuleId, "Setting2",  txtSetting2.Text);
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        #endregion
    }
}