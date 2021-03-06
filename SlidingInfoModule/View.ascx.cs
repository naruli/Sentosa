﻿/*
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
using Sentosa.Modules.SlidingInfoModule.Models;
using System.Web.UI.HtmlControls;

namespace Sentosa.Modules.SlidingInfoModule
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from SlidingInfoModuleModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : SlidingInfoModuleModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                var modules = new ModuleController();
                if (!Settings.Contains("AnnouncementTitle"))
                {
                    modules.UpdateModuleSetting(ModuleId, "AnnouncementTitle", "Announcement");
                    Header.InnerText = "Announcement";
                }

                if (Settings.Contains("AnnouncementTitle"))
                    Header.InnerText = Settings["AnnouncementTitle"].ToString();

                var showAnnouncement = new SlidingInfoController().ShowAnnouncements(TabId);
                if (showAnnouncement.Count > 0)
                {
                    var counter = 0;
                    foreach (var item in showAnnouncement)
                    {
                        HtmlGenericControl li = new HtmlGenericControl("li");
                        li.InnerText = item.Content;
                        if (counter == 0)
                        {
                            li.Attributes.Add("class", "active");
                        }
                        tabs.Controls.Add(li);
                        counter++;
                    }
                }
                else
                {
                    AnnouncementPane.Visible = false;
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
    }
}