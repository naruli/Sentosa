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
using Sentosa.Modules.Tag.Models;

namespace Sentosa.Modules.Tag
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from TagModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : TagModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    //Initialize Dropdown Management
                    IList<TypePage> typePages = new TagController().GetTypePages();
                    IList<TypePage> contentManagements = new List<TypePage>();
                    TypePage defaultSelect = new TypePage();
                    defaultSelect.TabId = 0;
                    defaultSelect.TypeId = 0;
                    defaultSelect.Name = "-- Select Module --";

                    contentManagements.Add(defaultSelect);
                    foreach (TypePage item in typePages)
                    {
                        contentManagements.Add(item);
                    }

                    ListManagement.DataSource = contentManagements;
                    ListManagement.DataTextField = "Name";
                    ListManagement.DataValueField = "TypeId";
                    ListManagement.DataBind();

                    //Initialize Dropdown Languages
                    IList<Language> languages = new TagController().GetLanguage();
                    IList<Language> contentLanguages = new List<Language>();
                    Language defaultSelectLanguage = new Language();
                    defaultSelectLanguage.Id = 0;
                    defaultSelectLanguage.CultureName = "-- Select Language --";

                    contentLanguages.Add(defaultSelectLanguage);

                    foreach (Language item in languages)
                    {
                        contentLanguages.Add(item);
                    }

                    ListLanguage.DataSource = contentLanguages;
                    ListLanguage.DataTextField = "CultureName";
                    ListLanguage.DataValueField = "Id";
                    ListLanguage.DataBind();
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

        protected void ListManagement_SelectedIndexChanged(object sender, EventArgs e)
        {
            int Language = Int32.Parse(ListLanguage.SelectedValue);
            int Management = Int32.Parse(ListManagement.SelectedValue);
            if (Language > 0 && Management > 0)
            {
                var tagScript = "";
                tagScript += "$('#AddMode').show();";
                tagScript += "\n$('#ListMode').show();";
                var tags = new TagController().GetTags(Management, Language);
                if (tags.Count > 0)
                {
                    int counter = 0;
                    foreach (var item in tags)
                    {
                        counter++;
                        tagScript += "\n$('#TagTable tbody').append(" +
                                    "\n\t'<tr>' +" +
                                    "\n\t\t'<td>" + counter + "</td>' +" +
                                    "\n\t\t'<td>" + item.Tagname + "</td>' +" +
                                    "\n\t\t'<td><button type=\"button\" onclick=\"updateTag(this);\" data-id=\"" + item.Id + "\">Update</button>' +" +
                                    "\n\t\t'<button type=\"button\" onclick=\"removeTag(this);\"  data-id=\"" + item.Id + "\">Delete</button></td>' +" +
                                    "\n\t'</tr>'" +
                                  "\n);";
                    }
                }
                else
                {
                    tagScript += "\n$('#TagTable tbody').append(" +
                                    "\n\t'<tr><td colspan=\"3\">No Data Found.</td></tr>'" +
                                  "\n);";
                }

                Page.ClientScript.RegisterStartupScript(this.GetType(), "showListModule", tagScript, true);
            }
        }

        protected void ListLanguage_SelectedIndexChanged(object sender, EventArgs e)
        {
            int Management = Int32.Parse(ListManagement.SelectedValue);
            int Language = Int32.Parse(ListLanguage.SelectedValue);
            if (Management > 0 && Language > 0)
            {
                var tagScript = "";
                tagScript += "$('#AddMode').show();";
                tagScript += "\n$('#ListMode').show();";
                var tags = new TagController().GetTags(Management, Language);
                if (tags.Count > 0)
                {
                    int counter = 0;
                    foreach (var item in tags)
                    {
                        counter++;
                        tagScript += "\n$('#TagTable tbody').append(" +
                                    "\n\t'<tr>' +" +
                                    "\n\t\t'<td>" + counter + "</td>' +" +
                                    "\n\t\t'<td>" + item.Tagname + "</td>' +" +
                                    "\n\t\t'<td><button type=\"button\" onclick=\"updateTag(this);\" data-id=\"" + item.Id + "\">Update</button>' +" +
                                    "\n\t\t'<button type=\"button\" onclick=\"removeTag(this);\"  data-id=\"" + item.Id + "\">Delete</button></td>' +" +
                                    "\n\t'</tr>'" +
                                  "\n);";
                    }
                }
                else
                {
                    tagScript += "\n$('#TagTable tbody').append(" +
                                    "\n\t'<tr><td colspan=\"3\">No Data Found.</td></tr>'" +
                                  "\n);";
                }

                Page.ClientScript.RegisterStartupScript(this.GetType(), "showListModule", tagScript, true);
            }
        }

        protected void ListSave_Click(object sender, EventArgs e)
        {
            string tagName = ListTag.Text;

            if (!String.IsNullOrEmpty(tagName))
            {
                var tag = new Models.Tag();
                var tagController = new TagController();

                tag.TypeId = Int32.Parse(ListManagement.SelectedValue);
                tag.LanguageId = Int32.Parse(ListLanguage.SelectedValue);
                tag.Tagname = tagName;
                tagController.AddTag(tag);

                Response.Write("<script>alert('Successfully Added!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Please Fill Tag Name Field!');</script>");
            }
            ListTag.Text = "";
            ListManagement_SelectedIndexChanged(sender, e);
        }

        protected void ListEdit_Click(object sender, EventArgs e)
        {
            int commonId = int.Parse(CommonIdTag.Value);
            string tagName = ListTag.Text;
            if (!String.IsNullOrEmpty(tagName))
            {
                var tag = new Models.Tag();
                var tagController = new TagController();
                
                tag.CommonId = commonId;
                tag.TypeId = Int32.Parse(ListManagement.SelectedValue);
                tag.LanguageId = Int32.Parse(ListLanguage.SelectedValue);
                tag.Tagname = tagName;
                tagController.UpdateTag(tag);

                Response.Write("<script>alert('Successfully Updated!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Please Fill Tag Name Field!');</script>");
            }
            ListTag.Text = "";
            ListManagement_SelectedIndexChanged(sender, e);
        }
    }
}