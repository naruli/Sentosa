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

namespace Sentosa.Modules.Zone
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from ZoneModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : ZoneModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    ShowZone();
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

        protected void ZoneSave_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(ZoneName.Text))
            {
                var zone = new Models.Zone();
                zone.ZoneName = ZoneName.Text;

                var zoneController = new Models.ZoneController();
                zoneController.AddZone(zone);

                Response.Write("<script>alert('Successfully Added!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Please Fill Zone Name!');</script>");
            }
            ZoneName.Text = "";
            ShowZone();
        }

        protected void ZoneEdit_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(ZoneName.Text))
            {
                var zone = new Models.Zone();
                zone.Id = int.Parse(ZoneId.Value);
                zone.ZoneName = ZoneName.Text;

                var zoneController = new Models.ZoneController();
                zoneController.UpdateZone(zone);

                Response.Write("<script>alert('Successfully Updated!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Please Fill Zone Name!');</script>");
            }
            ZoneName.Text = "";
            ShowZone();
        }

        protected void ShowZone()
        {
            //Load Zone Data
            var zoneScript = "";
            zoneScript += "\n$('#ZoneTable tbody').html('');";
            var zone = new Models.ZoneController().GetZones();
            if (zone.Count > 0)
            {
                var counter = 0;
                foreach (var item in zone)
                {
                    counter++;
                    zoneScript += "\n$('#ZoneTable tbody').append(" +
                                "\n\t'<tr>' +" +
                                "\n\t\t'<td>" + counter + "</td>' +" +
                                "\n\t\t'<td>" + item.ZoneName + "</td>' +" +
                                "\n\t\t'<td><button type=\"button\" onclick=\"updateZone(this);\" data-id=\"" + item.Id + "\">Update</button>' +" +
                                "\n\t\t'<button type=\"button\" onclick=\"removeZone(this);\"  data-id=\"" + item.Id + "\">Delete</button></td>' +" +
                                "\n\t'</tr>'" +
                              "\n);";
                }
            }
            else
            {
                zoneScript += "\n$('#ZoneTable tbody').append(" +
                                "\n\t'<tr><td colspan=\"3\">No Data Found.</td></tr>'" +
                              "\n);";
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "showZoneModule", zoneScript, true);
        }
    }
}