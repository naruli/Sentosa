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

namespace Sentosa.Modules.WhatsNearby
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from WhatsNearbyModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : WhatsNearbyModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var modules = new ModuleController();
                if (!Settings.Contains("WhatsNearbyTitle"))
                {
                    modules.UpdateModuleSetting(ModuleId, "WhatsNearbyTitle", "What's Nearby");
                    Header.InnerText = "What's Nearby";
                }

                if (Settings.Contains("WhatsNearbyTitle"))
                    Header.InnerText = Settings["WhatsNearbyTitle"].ToString();

                if (!Settings.Contains("WhatsNearbyDesc"))
                {
                    modules.UpdateModuleSetting(ModuleId, "WhatsNearbyDesc", "Fun is all around in this State. Find out what is happening around Sentosa.");
                    Description.InnerText = "Fun is all around in this State. Find out what is happening around Sentosa.";
                }

                if (Settings.Contains("WhatsNearbyDesc"))
                    Description.InnerText = Settings["WhatsNearbyDesc"].ToString();
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