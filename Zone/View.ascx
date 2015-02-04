<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.Zone.View" %>
<!-- Zone -->
    <%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
    <%@ Register Src="~/controls/SectionHeadControl.ascx" TagName="SectionHead" TagPrefix="dnn" %>
    <%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx"%>
    <%@ Register Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn" %>
<style>
    table {
        border-collapse: collapse;
        border-color:CadetBlue;
    }

    table, td, th {
        border: 1px solid black;
    }
</style>
<script type="text/javascript">
    function updateZone(obj) {

        var id = obj.getAttribute('data-id');
        $.getJSON(
           "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/Zone/API/ModuleZone/GetZone?Id=" + id,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $.each(parsedTaskJSONObject, function () {
                   $('#<%= ZoneId.ClientID %>').val(this.Id);
                   $('#<%= ZoneName.ClientID %>').val(this.ZoneName);
               });
           });

           $('#AddButton').hide();
           $('#EditButton').show();
        //alert('update shop' + obj.getAttribute('data-id'));
       }

       function removeZone(obj) {
           var DeleteClickedID = $(obj).attr('data-id');
           $.dnnConfirm({
               text: 'You sure you want to delete',
               yesText: 'Yep,delete',
               noText: 'Cancel',
               title: 'Delete Confirmation',
               callbackTrue: function () {
                   deleteZone(DeleteClickedID);
                   $(obj).parent().parent().remove();
               }
           });
       }

       function deleteZone(DeleteClickedID) {
           var zoneId = DeleteClickedID;
           var zoneToDelete = {
               Id: zoneId
           };

           var sf = $.ServicesFramework(<%:ModuleContext.ModuleId%>);

        $.ajax({
            url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/Zone/API/ModuleZone/DeleteZone',
            type: "POST",
            contentType: "application/json",
            beforeSend: sf.setModuleHeaders,
            data: JSON.stringify(zoneToDelete),
            success: function (data) {
                alert('Successfully Deleted!');
            }
        });
    }
</script>
<div class="dnnFormItem">
    <dnn:Label ID="Label1" runat="server" Text="Zone Name" />
    <asp:HiddenField ID="ZoneId" runat="server" />
    <asp:TextBox ID="ZoneName" runat="server" />
</div>
<div id="AddButton">
    <div class="dnnFormItem">
        <dnn:label ID="Label2" runat="server" Text="" />
        <asp:Button ID="ZoneSave" CssClass="dnnPrimaryAction" OnClick="ZoneSave_Click" Text="Add Zone" runat="server" />
    </div>
</div>
<div id="EditButton" style="display:none;">
    <div class="dnnFormItem">
        <dnn:label ID="Label3" runat="server" Text="" />
        <asp:Button ID="ZoneEdit" CssClass="dnnPrimaryAction" OnClick="ZoneEdit_Click" Text="Save Zone" runat="server" />
    </div>
</div>

<div class="dnnFormItem">
    <dnn:label ID="Label4" runat="server" Text="" />
    <table id="ZoneTable" style="width:50%;border:1px solid black;text-align:center">
        <thead style="border:1px solid black;">
            <tr>
                <td style="width:20%">No.</td>
                <td style="width:40%">Zone Name</td>
                <td style="width:40%">Action</td>
            </tr>
        </thead>
        <tbody style="border:1px solid black;">
        </tbody>
    </table>
</div>