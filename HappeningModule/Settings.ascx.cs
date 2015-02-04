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
using Sentosa.Modules.HappeningModule.Models;

namespace Sentosa.Modules.HappeningModule
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
    /// Because the control inherits from HappeningModuleSettingsBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class Settings : HappeningModuleModuleSettingsBase
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
                    var modules = new ModuleController();
                    //Check for existing settings and use those on this page
                    //Settings["SettingName"]

                    // uncomment to load saved settings in the text boxes

                    if(Settings.Contains("HappeningTitle"))
                        TextTitle.Text = Settings["HappeningTitle"].ToString();

                    if (Settings.Contains("HappeningDesc"))
                        TextDescription.Text = Settings["HappeningDesc"].ToString();

                    
                    var contentEvent = new HappeningController().GetContentHappeningEvent();
                    var contentPromotion = new HappeningController().GetContentHappeningPromotion();
                    var contentHappening = new HappeningController().GetHappening(TabId);

                    if (contentEvent.Count > 0)
                    {
                        Event.DataSource = contentEvent;
                        Event.DataTextField = "TabName";
                        Event.DataValueField = "TabID";
                        Event.DataBind();
                    }

                    if (contentPromotion.Count > 0)
                    {
                        Promotion.DataSource = contentPromotion;
                        Promotion.DataTextField = "TabName";
                        Promotion.DataValueField = "TabID";
                        Promotion.DataBind();
                    }

                    if (contentHappening.Count > 0)
                    {
                        foreach (var item in contentHappening)
                        {
                            if (item.TypeIdRef.Equals("P_EVENT"))
                            {
                                Event.Items.FindByValue(item.IdRef.ToString()).Selected = true;
                            }
                            else if (item.TypeIdRef.Equals("P_PROMO"))
                            {
                                Promotion.Items.FindByValue(item.IdRef.ToString()).Selected = true;
                            }
                        }
                    }
                    
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

                if (!String.IsNullOrEmpty(TextTitle.Text))
                {
                    modules.UpdateModuleSetting(ModuleId, "HappeningTitle", TextTitle.Text);
                }
                else
                {
                    modules.UpdateModuleSetting(ModuleId, "HappeningTitle", "Something special happening in the State");
                }

                if (!String.IsNullOrEmpty(TextDescription.Text))
                {
                    modules.UpdateModuleSetting(ModuleId, "HappeningDesc", TextDescription.Text);
                }
                else
                {
                    modules.UpdateModuleSetting(ModuleId, "HappeningDesc", "Fun is all around in this State. Find out what is happening around Sentosa.");
                }

                var Place = new Place();
                var happeningController = new HappeningController();
                happeningController.DeleteHappening(TabId);
                Place = happeningController.GetPlace(TabId);
                for (int index = 0; index < Event.Items.Count; index++)
                {
                    if (Event.Items[index].Selected)
                    {
                        var eventHappening = new Happening();
                        eventHappening.IdRef = int.Parse(Event.Items[index].Value);
                        eventHappening.TypeIdRef = "P_EVENT";
                        eventHappening.IsStatic = false;
                        if (Place.TabName.ToLower().Equals("home"))
                        {
                            eventHappening.IsStatic = true;
                        }
                        eventHappening.IdStaticRef = TabId;
                        happeningController.AddHappening(eventHappening);
                    }
                }

                for (int index = 0; index < Promotion.Items.Count; index++)
                {
                    if (Promotion.Items[index].Selected)
                    {
                        var promotionHappening = new Happening();
                        promotionHappening.IdRef = int.Parse(Promotion.Items[index].Value);
                        promotionHappening.TypeIdRef = "P_PROMO";
                        promotionHappening.IsStatic = false;
                        if (Place.TabName.ToLower().Equals("home"))
                        {
                            promotionHappening.IsStatic = true;
                        }
                        promotionHappening.IdStaticRef = TabId;
                        happeningController.AddHappening(promotionHappening);
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