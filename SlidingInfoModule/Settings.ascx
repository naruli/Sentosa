<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="Sentosa.Modules.SlidingInfoModule.Settings" %>

<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>

<h2 id="dnnSitePanel-BasicSettings" class="dnnFormSectionHead"><a href="" class="">Basic Setting</a></h2>
<fieldset>
    <div class="dnnFormItem">
        <dnn:label ID="Label1" runat="server" Text="Title" />
        <asp:TextBox ID="TextTitle" runat="server" />
    </div>
</fieldset>
<h2 id="dnnSitePanel-ContentSettings" class="dnnFormSectionHead"><a href="" class="">Content List</a></h2>
<fieldset>
    <div style="width:100%;">
        <table border="0" style="width:100%;">
            <thead>
                <tr>
                    <td style="text-align:center;">Announcement</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <asp:CheckBoxList id="AnnouncementList" RepeatDirection="Vertical" RepeatLayout="Flow" runat="server">

                        </asp:CheckBoxList>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</fieldset>