<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="Sentosa.Modules.HappeningModule.Settings" %>

<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx"%>
<h2 id="dnnSitePanel-BasicSettings" class="dnnFormSectionHead"><a href="" class="">Basic Setting</a></h2>
<fieldset>
    <div class="dnnFormItem">
        <dnn:label ID="Label1" runat="server" Text="Title" />
        <asp:TextBox ID="TextTitle" runat="server" />
    </div>
    <div class="dnnFormItem">
        <dnn:label ID="Label2" runat="server" Text="Description" />
        <dnn:TextEditor ID="TextDescription" runat="server" Height="500" Width="100%" />
    </div>
</fieldset>
<h2 id="dnnSitePanel-ContentSettings" class="dnnFormSectionHead"><a href="" class="">Content List</a></h2>
<fieldset>
    <div class="Events" style="width:45%;float:left">
        <table id="Events" border="0" style="width:100%;">
            <thead>
                <tr>
                    <td style="text-align:center;">Events</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <asp:CheckBoxList id="Event" RepeatDirection="Vertical" RepeatLayout="Flow" runat="server">

                        </asp:CheckBoxList>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="Promotions" style="width:45%;float:right">
        <table id="Table1" border="0" style="width:100%;">
            <thead>
                <tr>
                    <td style="text-align:center;">Promotions</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <asp:CheckBoxList id="Promotion" RepeatDirection="Vertical" RepeatLayout="Flow" runat="server">

                        </asp:CheckBoxList>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <input type="hidden" id="totalEvent" name="listEvent" value="" />
    <input type="hidden" id="totalPromotion" name="listPromotion" value="" />
</fieldset>


