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
using Sentosa.Modules.PhotoModule.Models;
using System.Web.UI.HtmlControls;

namespace Sentosa.Modules.PhotoModule
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from PhotoModuleModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : PhotoModuleModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var modules = new ModuleController();
                if (!Settings.Contains("PhotoTitle"))
                {
                    modules.UpdateModuleSetting(ModuleId, "PhotoTitle", "#thestateoffun as it happens");
                    Header.InnerText = "#thestateoffun as it happens";
                }

                if (Settings.Contains("PhotoTitle"))
                    Header.InnerText = Settings["PhotoTitle"].ToString();

                if (!Settings.Contains("PhotoDesc"))
                {
                    modules.UpdateModuleSetting(ModuleId, "PhotoDesc", "A look at what is going on in The State right now.");
                    Description.InnerText = "A look at what is going on in The State right now.";
                }

                if (Settings.Contains("PhotoDesc"))
                    Description.InnerText = Settings["PhotoDesc"].ToString();

                var instafeed = new InstafeedController().GetInstafeed();
                if (instafeed.Count > 0)
                {
                    foreach (var item in instafeed)
                    {
                        HtmlGenericControl li = new HtmlGenericControl("li");
                        HtmlGenericControl a = new HtmlGenericControl("a");
                        HtmlGenericControl div = new HtmlGenericControl("div");
                        HtmlGenericControl img = new HtmlGenericControl("img");

                        //img Tag
                        img.Attributes.Add("src", item.Url);
                        img.Attributes.Add("alt", String.Empty);
                        img.Attributes.Add("title", String.Empty);
                        img.Attributes.Add("style", "width:220px;height:220px;");

                        //div Tag
                        div.Attributes.Add("class", "shadow");

                        //a Tag
                        a.Attributes.Add("href", "#");
                        a.Controls.Add(div);
                        a.Controls.Add(img);

                        //li Tag
                        li.Controls.Add(a);

                        InstafeedList.Controls.Add(li);
                    }
                }
                else
                {
                    InstafeedList.Visible = false;
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