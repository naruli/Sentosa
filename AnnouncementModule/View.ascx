<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.AnnouncementModule.View" %>

<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
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
    function updateAnnouncement(obj) {

        var id = obj.getAttribute('data-id');
        $.getJSON(
           "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/AnnouncementModule/API/ModuleAnnouncement/GetAnnouncement?Id=" + id,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $.each(parsedTaskJSONObject, function () {
                   $('#<%= AnnouncementId.ClientID %>').val(this.Id);
                   $('#<%= AnnouncementContent.ClientID %>').val(this.Content);
               });
           });

           $('#<%= SaveAnnouncement.ClientID %>').hide();
           $('#<%= EditAnnouncement.ClientID %>').show();
        //alert('update shop' + obj.getAttribute('data-id'));
       }

    function removeAnnouncement(obj) {
           var DeleteClickedID = $(obj).attr('data-id');
           $.dnnConfirm({
               text: 'You sure you want to delete',
               yesText: 'Yep,delete',
               noText: 'Cancel',
               title: 'Delete Confirmation',
               callbackTrue: function () {
                   deleteAnnouncement(DeleteClickedID);
                   $(obj).parent().parent().remove();
               }
           });
       }

    function deleteAnnouncement(DeleteClickedID) {
           var announcementId = DeleteClickedID;
           var announcementToDelete = {
               Id: announcementId
           };

           var sf = $.ServicesFramework(<%:ModuleContext.ModuleId%>);

           $.ajax({
               url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/AnnouncementModule/API/ModuleAnnouncement/DeleteAnnouncement',
            type: "POST",
            contentType: "application/json",
            beforeSend: sf.setModuleHeaders,
            data: JSON.stringify(announcementToDelete),
            success: function (data) {
                alert('Successfully Deleted!');
            }
        });
    }
</script>

<div class="dnnFormItem">
    <dnn:label ID="Label1" runat="server" Text="Announcement" />
    <asp:HiddenField ID="AnnouncementId" runat="server" />
    <asp:TextBox runat="server" TextMode="MultiLine" ID="AnnouncementContent" />
</div>
<div class="dnnFormItem">
    <dnn:label ID="Label2" runat="server" Text="" />
    <asp:Button ID="SaveAnnouncement" CssClass="dnnPrimaryAction" Text="Add" OnClick="SaveAnnouncement_Click" runat="server" />
    <asp:Button ID="EditAnnouncement" CssClass="dnnPrimaryAction" Text="Edit" OnClick="EditAnnouncement_Click" runat="server" />
</div>


<div class="dnnFormItem">
    <table id="AnnouncementTable" style="width:100%;border:1px solid black;text-align:center">
        <thead style="border:1px solid black;">
            <tr>
                <td style="width:10%">No.</td>
                <td style="width:60%">Announcement</td>
                <td style="width:30%">Action</td>
            </tr>
        </thead>
        <tbody style="border:1px solid black;">
        </tbody>
    </table>
</div>