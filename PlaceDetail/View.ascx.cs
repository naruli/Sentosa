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
using System.Collections.Generic;

namespace Sentosa.Modules.PlaceDetail
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from PlaceDetailModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : PlaceDetailModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var placeDetailScript = "";
                placeDetailScript += "GetPlaceDetail('" + (Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath) + "/DesktopModules/PlaceDetail/API/ModulePlaceDetail/GetPlace?TabId=" + TabId + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "getPlaceDetail", placeDetailScript, true);

                var gallleryDetailScript = "";
                gallleryDetailScript += "GetGalleryDetail('" + (Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath) + "/DesktopModules/PlaceDetail/API/ModulePlaceDetail/GetGallery?CommonId=" + TabId + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "getGalleryDetail", gallleryDetailScript, true);


                var subPageDetailScript = "";
                subPageDetailScript += "GetSubMenuPageDetail('" + (Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath) + "/DesktopModules/PlaceDetail/API/ModulePlaceDetail/GetSubPageDetail?TabId=" + TabId + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "getSubPageDetail", subPageDetailScript, true);

                /*example
                var carouselScript = "";
                carouselScript += "loadCarousel('" + (Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath) + "/DesktopModules/Carousel/API/ModuleCarouselPhotos/GetCarousel?CommonId=" + TabId + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "getCarousel", carouselScript, true);
            
                 * */
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