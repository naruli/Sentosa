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
using DotNetNuke.Common;
using DotNetNuke.Common.Utilities;

namespace Sentosa.Modules.FindFun
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from FindFunModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : FindFunModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var currentUrl = Globals.NavigateURL(
                                this.TabId,
                                this.Request.QueryString["ctl"],
                                UrlUtils.GetQSParamsForNavigateURL()).ToLower();

         
                string imagename = "";
                string mapScript = "";

                var searchValue = (Request.Params["keywords"] != null ? Request.Params["keywords"].ToString() : "");
                var list = (Request.Params["list"] != null ? Request.Params["list"].ToString() : "0");
        
                //Response.Write("<script>alert('" + groupname + "');</script>");
                //var places = new Models.PlaceController().GetPlace(groupname, -4, 16, searchValue, sortBy, list);
                var places = new Models.FindFunController().GetPlace(searchValue, list);


                mapScript += "var map = new google.maps.Map(document.getElementById('map_canvas'), {" +
                                 "\n\tzoom: 16," +
                                 "\n\tdisableDefaultUI: true," +
                                 "\n\tscrollwheel: false," +
                                 "\n\tcenter: new google.maps.LatLng(1.249404,103.830321)," +
                                 "\n\tmapTypeId: google.maps.MapTypeId.ROADMAP" +
                             "\n});";

                mapScript += "\n\n";

                mapScript += "var strictBounds = new google.maps.LatLngBounds(" +
                                 "\n\tnew google.maps.LatLng(1.23884941, 103.8163305)," +
                                 "\n\tnew google.maps.LatLng(1.25772768, 103.84328133)" +
                               "\n);";

                mapScript += "\n\n";

                mapScript += "google.maps.event.addListener(map, 'dragend', function() {" +
                                 "\n\tif (strictBounds.contains(map.getCenter())) return;" +
                                 "\n\tvar c = map.getCenter()," +
                                     "\n\t\tx = c.lng()," +
                                     "\n\t\ty = c.lat()," +
                                     "\n\t\tmaxX = strictBounds.getNorthEast().lng()," +
                                     "\n\t\tmaxY = strictBounds.getNorthEast().lat()," +
                                     "\n\t\tminX = strictBounds.getSouthWest().lng()," +
                                     "\n\t\tminY = strictBounds.getSouthWest().lat();" +
                                 "\n\tif (x < minX) x = minX;" +
                                 "\n\tif (x > maxX) x = maxX;" +
                                 "\n\tif (y < minY) y = minY;" +
                                 "\n\tif (y > maxY) y = maxY;" +
                                 "\n\tmap.setCenter(new google.maps.LatLng(y, x));" +
                               "\n});";

                mapScript += "\n\n";

                mapScript += "google.maps.event.addListener(map, 'zoom_changed', function() {" +
                                 "\n\tif (map.getZoom() < 10) map.setZoom(10);" +
                               "\n});";

                mapScript += "\n\n";
                if (places != null)
                {
                    foreach (var item in places)
                    {
                        switch (item.ParentId)
                        {
                            case 95: imagename = "icon-atractions.png"; break;
                            case 96: imagename = "icon-natures.png"; break;
                            case 97: imagename = "icon-shops.png"; break;
                            case 98: imagename = "icon-hotels.png"; break;
                            case 99: imagename = "icon-beaches.png"; break;
                            case 100: imagename = "icon-dining.png"; break;
                            case 101: imagename = "icon-golf.png"; break;
                            case 120: imagename = "icon-promo.png"; break; //icon restaurant not yet
                        };


                        if (item.Lat != "" && item.Lng != "")
                        {
                            mapScript += "var image = '" + Request.Url.GetLeftPart(UriPartial.Authority) + "/portals/0/images/dnn/" + imagename + "';" +
                                      "\nvar beachMarker_" + item.CommonId + " = new google.maps.Marker({" +
                                          "\n\tposition: new google.maps.LatLng(" + item.Lat + "," + item.Lng + ")," +
                                          "\n\tmap: map," +
                                          "\n\ticon: image" +
                                      "\n});";

                            mapScript += "\n\n";

                            mapScript += "var shortDesc = krDencodeEntities('" + item.ShortDescription + "');" +
                                            "\nvar contentString_" + item.CommonId + " = " +
                                              "\n\t'<div id=\"content\" style=\"min-height:420px;min-width:270px;max-height:420px;max-width:270px\">'+" +
                                              "\n\t'<div class=\"box-item\" style=\"min-height:420px;min-width:263px;max-width:263px\">' +" +
                                                         "\n\t\t'<a href=\"" + item.Url + "\">' +" +
                                                            "\n\t\t'<img src=\"" + item.Photo + "\" alt=\"\" title=\"\" class=\"\" style=\"min-height:159px;min-width:261px;max-height:159px;max-width:261px;\">'+" +
                                                             "\n\t\t'<div class=\"box-content\">' +" +
                                                                 "\n\t\t\t'<h3>" + item.TabName + "</h3>' +" +
                                                                 "\n\t\t\t'<p>' + shortDesc.trunc(150, true) + '</p>' +" +
                                                             "\n\t\t'</div>' +" +
                                                          "\n\t'</a>' +" +
                                                             "\n\t'<div class=\"box-nav\"><a href=\"" + item.Url + "\">' +" +
                                                                 "\n\t\t'</a><a href=\"#\"><img src=\"" + (Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath) + "/portals/_default/skins/hammerflex/img/icon-map.png\" alt=\"\" title=\"\" class=\"\"></a>' +" +
                                                                 (item.SourceUrl != "" ? "\n\t\t'<a href=\"http://" + item.SourceUrl + "\" target=\"_blank\"><img src=\"" + (Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath) + "/portals/_default/skins/hammerflex/img/icon-tag.png\" alt=\"\" title=\"\" class=\"\"></a>' +" : "") +
                                                                 "\n\t\t'<a href=\"" + item.Url + "\">Find out more <i class=\"fa fa-angle-right\"></i></a>' +" +
                                                             "\n\t'</div>' +" +
                                                     "\n'</div>' +" +
                                              "\n'</div>';";

                            mapScript += "\n\n";

                            mapScript += "var infowindow_" + item.CommonId + " = new google.maps.InfoWindow({" +
                                              "\n\tcontent: contentString_" + item.CommonId + "," +
                                              "\n\tmaxWidth: 500" +
                                            "\n});";

                            mapScript += "\n\n";

                            mapScript += "google.maps.event.addListener(beachMarker_" + item.CommonId + ", 'click', function() {" +
                                            "\n\tinfowindow_" + item.CommonId + ".open(map,beachMarker_" + item.CommonId + ");" +
                                          "\n});";

                            mapScript += "\n\n";
                        }
                    }
                }
                //mapScript += "});";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "map-script", mapScript, true);
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