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
using Sentosa.Modules.ContactUs.Models;

namespace Sentosa.Modules.ContactUs
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from ContactUsModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : ContactUsModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var modules = new ModuleController();
                if (!Settings.Contains("Agreement"))
                {
                    modules.UpdateModuleSetting(ModuleId, "Agreement", "I have read and agree to the terms and conditions as set out in Sentosa Leisure Management Pte Ltd's (“SLM”) Data Protection Policy, including as to how my personal data may be collected, used, disclosed and processed, and confirm that all information and details of myself are true, correct and complete. Where I have provided personal data of individuals other than myself, I warrant and represent that I am validly acting on behalf of each of these individuals, and have obtained their individual consents, to disclose their personal data to SLM and for SLM to collect, use, disclose and process their personal data for such purposes as out in the Data Protection Policy.");
                    txtAgreement.InnerText = "I have read and agree to the terms and conditions as set out in Sentosa Leisure Management Pte Ltd's (“SLM”) Data Protection Policy, including as to how my personal data may be collected, used, disclosed and processed, and confirm that all information and details of myself are true, correct and complete. Where I have provided personal data of individuals other than myself, I warrant and represent that I am validly acting on behalf of each of these individuals, and have obtained their individual consents, to disclose their personal data to SLM and for SLM to collect, use, disclose and process their personal data for such purposes as out in the Data Protection Policy.";
                }

                if (!Settings.Contains("Email"))
                {
                    modules.UpdateModuleSetting(ModuleId, "Email", "admin@sentosa.com.sg");
                }

                if (Settings.Contains("Agreement"))
                    txtAgreement.InnerText = Settings["Agreement"].ToString();
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var contactUs = new Models.ContactUs();
            var contactUsController = new ContactUsController();

            contactUs.Salutation = dropSalutation.SelectedValue;
            contactUs.FirstName = txtFirstName.Text;
            contactUs.LastName = txtLastName.Text;
            contactUs.EmailAddress = txtAddress.Text;
            contactUs.ContactNo = txtContactNo.Text;
            contactUs.Country = dropCountry.SelectedValue;
            contactUs.Category = dropCategory.SelectedValue;
            contactUs.Feedback = txtFeedback.Text;

            if (String.IsNullOrEmpty(contactUs.Salutation) || String.IsNullOrEmpty(contactUs.Country) || String.IsNullOrEmpty(contactUs.Category) || String.IsNullOrEmpty(contactUs.Feedback))
            {
                Response.Write("<script>alert('Please fill all required (*) field!');</script>");
            }
            else if (!chkAgreement.Checked)
            {
                Response.Write("<script>alert('Please check agreement field!');</script>");
            }
            else
            {
                contactUsController.AddContactUs(contactUs);

                Response.Write("<script>alert('Successfully Submit Form!');</script>");

                ClearField();
            }
        }

        private void ClearField()
        {
            dropSalutation.ClearSelection();
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtAddress.Text = "";
            txtContactNo.Text = "";
            dropCountry.ClearSelection();
            dropCategory.ClearSelection();
            txtFeedback.Text = "";
        }
    }
}