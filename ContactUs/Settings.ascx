<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="Sentosa.Modules.ContactUs.Settings" %>

<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>

<h2 id="dnnSitePanel-BasicSettings" class="dnnFormSectionHead"><a href="" class="">Basic Setting</a></h2>
<fieldset>
    <div class="dnnFormItem">
        <dnn:label ID="Label1" runat="server" Text="Email Admin" />
        <asp:TextBox ID="TextEmail" runat="server" />
    </div>
    <div class="dnnFormItem">
        <dnn:label ID="Label2" runat="server" Text="Agreement" />
        <asp:TextBox ID="TextAgreement" TextMode="MultiLine" runat="server" />
    </div>
</fieldset>