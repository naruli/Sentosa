<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="Sentosa.Modules.EventsDetailModule.Settings" %>

<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
<%@ Register TagName="filePicker" TagPrefix="dnn" Src="~/controls/filepickeruploader.ascx" %>
<script type="text/javascript">
    
</script>
<h2 id="dnnSitePanel-FormSubMenuHotelSpas" class="dnnFormSectionHead"><a href="" class="">Form Add Sub Menu & Sub Page</a></h2>
	
    <fieldset>
        <div class="dnnFormItem">
            <asp:HiddenField ID="txtId1" runat="server" />
        </div>
        <div class="dnnFormItem">
            <dnn:label ID="lblTitle1" runat="server" Text="Title" />
            <asp:TextBox ID="txtTitle1" runat="server" />
        </div>

        <div class="dnnFormItem">
            <dnn:label ID="lblDescription1" runat="server" Text="Description" />
            <asp:TextBox ID="txtDescription1" runat="server" TextMode="MultiLine" Rows="4" Columns="50" />
        </div>

          <div class="dnnFormItem">
            <dnn:label ID="lblInstruction1" runat="server" Text="Instruction" />
            <asp:TextBox ID="txtInstruction1" runat="server" TextMode="MultiLine" Rows="4" Columns="50" />
        </div>

       
    </fieldset>

<h2 id="dnnSitePanel-FormGalleryHotelSpas" class="dnnFormSectionHead"><a href="" class="">Form Add Gallery</a></h2>
	
    <fieldset>
        <div class="dnnFormItem">
            <dnn:label ID="lblImage2" runat="server" Text="Image" HelpText="Max Upload is 15 Image" />
            <dnn:filePicker ID="fileImage2" runat="server" />
        </div>
        <div class="dnnFormItem">
            <dnn:label ID="lblDescription2" runat="server" Text="Description" />
            <asp:TextBox ID="txtDescription2" runat="server" TextMode="MultiLine" Rows="4" Columns="50" />
        </div>
        <div class="dnnFormItem">
            <dnn:label ID="lblIsThumbnail2" runat="server" Text="Is Thumbnail?" />
            <asp:RadioButtonList ID="rblThumbnailImage" runat="server">
                <asp:ListItem Text="Yes" Value="1" />
                <asp:ListItem Text="No" Value="0" Selected="True" />
            </asp:RadioButtonList>
        </div>
    </fieldset>
