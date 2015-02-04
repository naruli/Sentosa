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
using Sentosa.Modules.AnnouncementModule.Models;

namespace Sentosa.Modules.AnnouncementModule
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from AnnouncementModuleModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : AnnouncementModuleModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if(!Page.IsPostBack)
                {
                    ShowAnnouncement();
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

        protected void SaveAnnouncement_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(AnnouncementContent.Text))
            {
                var announcement = new Announcement();
                announcement.Content = AnnouncementContent.Text;

                var announcementController = new AnnouncementModuleController();
                announcementController.AddAnnouncement(announcement);

                Response.Write("<script>alert('Successfully Added!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Please Fill Announcement!');</script>");
            }
            AnnouncementContent.Text = "";
            ShowAnnouncement();
        }

        protected void EditAnnouncement_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(AnnouncementContent.Text))
            {
                var announcement = new Announcement();
                announcement.Id = int.Parse(AnnouncementId.Value);
                announcement.Content = AnnouncementContent.Text;

                var announcementController = new AnnouncementModuleController();
                announcementController.UpdateAnnouncement(announcement);

                Response.Write("<script>alert('Successfully Updated!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Please Fill Announcement!');</script>");
            }
            AnnouncementContent.Text = "";
            ShowAnnouncement();
        }

        protected void ShowAnnouncement() {
            var announcements = new AnnouncementModuleController().GetAnnouncements();
            var announcementScript = "$('#" + EditAnnouncement.ClientID + "').hide();";
            announcementScript += "\n$('#AnnouncementTable tbody').html('');";
            if (announcements.Count > 0)
            {
                var counter = 0;
                foreach (var item in announcements)
                {
                    counter++;
                    announcementScript += "\n$('#AnnouncementTable tbody').append(" +
                                "\n\t'<tr>' +" +
                                "\n\t\t'<td>" + counter + "</td>' +" +
                                "\n\t\t'<td>" + item.Content + "</td>' +" +
                                "\n\t\t'<td><button type=\"button\" onclick=\"updateAnnouncement(this);\" data-id=\"" + item.Id + "\">Update</button>' +" +
                                "\n\t\t'<button type=\"button\" onclick=\"removeAnnouncement(this);\"  data-id=\"" + item.Id + "\">Delete</button></td>' +" +
                                "\n\t'</tr>'" +
                              "\n);";
                }
            }
            else
            {
                announcementScript += "\n$('#AnnouncementTable tbody').append(" +
                                "\n\t'<tr><td colspan=\"3\">No Data Found.</td></tr>'" +
                              "\n);";
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "showAnnouncementModule", announcementScript, true);
        }
    }
}