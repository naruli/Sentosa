<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.Tag.View" %>
<!-- Tag -->
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
    function updateTag(obj) {

        var id = obj.getAttribute('data-id');
        $.getJSON(
           "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/Tag/API/ModuleTag/GetTag?Id=" + id,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $.each(parsedTaskJSONObject, function () {
                   $('#<%= CommonIdTag.ClientID %>').val(this.CommonId);
                   $('#<%= ListTag.ClientID %>').val(this.Tagname);
               });
           });

           $('#AddButton').hide();
           $('#EditButton').show();
        //alert('update shop' + obj.getAttribute('data-id'));
    }

    function removeTag(obj) {
        var DeleteClickedID = $(obj).attr('data-id');
        $.dnnConfirm({
            text: 'You sure you want to delete',
            yesText: 'Yep,delete',
            noText: 'Cancel',
            title: 'Delete Confirmation',
            callbackTrue: function () {
                deleteTag(DeleteClickedID);
                $(obj).parent().parent().remove();
            }
        });
    }

    function deleteTag(DeleteClickedID) {
        var tagId = DeleteClickedID;
        var tagToDelete = {
            Id: tagId
        };

        var sf = $.ServicesFramework(<%:ModuleContext.ModuleId%>);

        $.ajax({
            url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/Tag/API/ModuleTag/DeleteTag',
            type: "POST",
            contentType: "application/json",
            beforeSend: sf.setModuleHeaders,
            data: JSON.stringify(tagToDelete),
            success: function (data) {
                alert('Successfully Deleted!');
            }
        });
    }
</script>
    <div class="dnnFormItem">
        <dnn:label ID="Label2" runat="server" Text="Management" />
        <asp:DropDownList id="ListManagement" runat="server" OnSelectedIndexChanged="ListManagement_SelectedIndexChanged" AutoPostBack="true">
               
        </asp:DropDownList>
       </div>
    <div class="dnnFormItem">
        <dnn:label ID="Label42" runat="server" Text="Language" />
        <asp:DropDownList id="ListLanguage" runat="server" OnSelectedIndexChanged="ListLanguage_SelectedIndexChanged" AutoPostBack="true">
               
        </asp:DropDownList>
    </div>
    <div id="AddMode" style="display:none;">
        <div class="dnnFormItem">
            <dnn:Label ID="TagField" runat="server" Text="Tag Name" /> 
            <asp:HiddenField ID="CommonIdTag" runat="server" />
            <asp:TextBox ID="ListTag" runat="server" />
        </div>
        <div id="AddButton">
            <div class="dnnFormItem">
                <dnn:label ID="AddField" runat="server" Text="" />
                <asp:Button ID="ListSave" CssClass="dnnPrimaryAction" OnClick="ListSave_Click" Text="Add Tag" runat="server" />
            </div>
        </div>
        <div id="EditButton" style="display:none;">
            <div class="dnnFormItem">
                <dnn:label ID="EditField" runat="server" Text="" />
                <asp:Button ID="ListEdit" CssClass="dnnPrimaryAction" OnClick="ListEdit_Click" Text="Save Tag" runat="server" />
            </div>
        </div>
    </div>
    <div id="ListMode" style="display:none;">
        <div class="dnnFormItem">
            <dnn:label ID="TableField" runat="server" Text="" />
            <table id="TagTable" style="width:50%;border:1px solid black;text-align:center">
                <thead style="border:1px solid black;">
                    <tr>
                        <td style="width:20%">No.</td>
                        <td style="width:40%">Tag Name</td>
                        <td style="width:40%">Action</td>
                    </tr>
                </thead>
                <tbody style="border:1px solid black;">
                </tbody>
            </table>
        </div>
    </div>