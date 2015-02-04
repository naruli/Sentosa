<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="Sentosa.Modules.PhotoModule.Settings" %>

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