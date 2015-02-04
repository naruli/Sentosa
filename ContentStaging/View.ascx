<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.ContentStaging.View" %>
<!-- ContentStaging -->
    <%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
    <%@ Register TagName="FilePicker" TagPrefix="dnn" Src="~/controls/filepickeruploader.ascx" %>
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
    jQuery(function ($) {
        var setupModule = function () {
            $('#panels-demo').dnnPanels();
            $('#panels-demo .dnnFormExpandContent a').dnnExpandAll({
                targetArea: '#panels-demo'
            });
        };
        setupModule();
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            // note that this will fire when _any_ UpdatePanel is triggered,
            // which may or may not cause an issue
            setupModule();
        });
    });
</script>
<script type="text/javascript">
    function removeCheckbox(obj) {
        var DeleteClickedID = $(obj).attr('id');
        $.dnnConfirm({
            text: 'You sure you want to delete',
            yesText: 'Yep,delete',
            noText: 'Cancel',
            title: 'Delete Confirmation',
            callbackTrue: function () {
                deleteCarousel(DeleteClickedID);
                $(obj).parent().parent().remove();
            }
        });
    }

    function deleteCarousel(DeleteClickedID) {
        var carouselId = DeleteClickedID;
        var carouselToDelete = {
            CTD_Id: carouselId,
        };

        var sf = $.ServicesFramework(<%:ModuleContext.ModuleId%>);

        $.ajax({
            url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/ContentStaging/API/ModuleContentStaging/DeleteCarousel',
            type: "POST",
            contentType: "application/json",
            beforeSend: sf.setModuleHeaders,
            data: JSON.stringify(carouselToDelete),
            success: function (data) {
                alert('Successfully Deleted!');
            }
        });
    }

    function removeGallery(obj) {
        var DeleteClickedID = $(obj).attr('id');
        $.dnnConfirm({
            text: 'You sure you want to delete',
            yesText: 'Yep,delete',
            noText: 'Cancel',
            title: 'Delete Confirmation',
            callbackTrue: function () {
                deleteGallery(DeleteClickedID);
                $(obj).parent().parent().remove();
            }
        });
    }

    function deleteGallery(DeleteClickedID) {
        var galleryId = DeleteClickedID.split('_');
        var galleryToDelete = {
            Id: galleryId[0],
            Type: galleryId[1]
        };

        var sf = $.ServicesFramework(<%:ModuleContext.ModuleId%>);

        $.ajax({
            url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/ContentStaging/API/ModuleContentStaging/DeleteGallery',
            type: "POST",
            contentType: "application/json",
            beforeSend: sf.setModuleHeaders,
            data: JSON.stringify(galleryToDelete),
            success: function (data) {
                alert('Successfully Deleted!');
            }
        });
    }

    function updateSubPage(obj) {

        var id = obj.getAttribute('data-id').split('.');
        $.getJSON(
           "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/ContentStaging/API/ModuleContentStaging/GetSubPagePlace?Id=" + id[0],
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $.each(parsedTaskJSONObject, function () {
                   $('#<%= IdSubPage.ClientID %>').val(this.Id);
                   $('#<%= SubPageTitle.ClientID %>').val(this.Title);
                   $('#' + id[1]).val(this.Description);
               });
           });
        
        $('#AddMode').hide();
        $('#EditMode').show();
        //alert('update shop' + obj.getAttribute('data-id'));
    }
</script>

    <div class="dnnFormItem">
        <dnn:label ID="Label2" runat="server" Text="Module" />
        <asp:DropDownList id="ContentModule" runat="server" OnSelectedIndexChanged="Parent_SelectedIndexChanged" AutoPostBack="true">
               
        </asp:DropDownList>
       </div>
    <div class="dnnFormItem">
        <dnn:label ID="Label42" runat="server" Text="Tab ID Content" />
        <asp:DropDownList id="ContentTab" runat="server" OnSelectedIndexChanged="Child_SelectedIndexChanged" AutoPostBack="true">
               
        </asp:DropDownList>
    </div>

        
    <div class="dnnForm" id="panels-demo" style="display:none;">
        <div class="dnnFormExpandContent"><a href="">Expand All</a></div>
        <div id="CarouselMenu">
            <h2 id="Carousel" class="dnnFormSectionHead"><a href="#">Carousel</a></h2>
            <fieldset class="dnnClear">
                <div class="dnnFormItem">
                    <dnn:Label ID="Label48" runat="server" Text="Image" /> 
                    <dnn:FilePicker ID="CarouselImage" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label49" runat="server" Text="" />
                    <asp:Button ID="CarouselSave" CssClass="dnnPrimaryAction" OnClick="CarouselSave_Click" Text="Submit" runat="server" />
                </div>

                <div class="dnnFormItem">
                    <table id="CarouselTable" style="width:100%;border:1px solid black;text-align:center">
                        <thead style="border:1px solid black;">
                            <tr>
                                <td style="width:30%">Image Preview</td>
                                <td style="width:70%">Action</td>
                            </tr>
                        </thead>
                        <tbody style="border:1px solid black;">
                        </tbody>
                    </table>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label61" runat="server" Text="" />
                    <asp:HiddenField ID="ListCarousel" Value="0" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label62" runat="server" Text="" />
                    <asp:Button ID="CarouselOrderSave" CssClass="dnnPrimaryAction" OnClick="CarouselOrderSave_Click" Text="Save Order" runat="server" />
                </div>
            </fieldset>
        </div>
        <div id="ContentMenu" style="display:none;">
            <h2 id="Content" class="dnnFormSectionHead"><a href="#">Content</a></h2>
            <fieldset class="dnnClear">
                <div class="dnnFormItem">
                    <dnn:label ID="Label6" runat="server" Text="Short Description" />
                    <asp:TextBox ID="ContentShortDesc" TextMode="MultiLine" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label7" runat="server" Text="Admission" />
                    <dnn:TextEditor ID="ContentAdmission" runat="server" Height="500" Width="100%" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label8" runat="server" Text="Opening Hours" />
                    <asp:TextBox ID="ContentOpeningHours" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label9" runat="server" Text="Nature Age Restrictions" />
                    <dnn:TextEditor ID="ContentNatureAge" runat="server" Height="500" Width="100%" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label10" runat="server" Text="Nature Guided Tours" />
                    <dnn:TextEditor ID="ContentNatureGuide" runat="server" Height="500" Width="100%" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label11" runat="server" Text="Event Start Date" />
                    <dnn:DnnDatePicker ID="ContentEventStart" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label12" runat="server" Text="Event End Date" />
                    <dnn:DnnDatePicker ID="ContentEventEnd" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label13" runat="server" Text="language" />
                    <asp:DropDownList id="ContentLanguage" runat="server">
               
                    </asp:DropDownList>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label58" runat="server" Text="Online Store Url" />
                    <asp:TextBox ID="ContentSourceUrl" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label14" runat="server" Text="Highlights" />
                    <dnn:TextEditor ID="ContentHighlights" runat="server" Height="500" Width="100%" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label15" runat="server" Text="Details" />
                    <dnn:TextEditor ID="ContentDetails" runat="server" Height="500" Width="100%" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label16" runat="server" Text="Phone Number" />
                    <asp:TextBox ID="ContentPhone" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label17" runat="server" Text="Address" />
                    <dnn:TextEditor ID="ContentAddress" runat="server" Height="500" Width="100%" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label18" runat="server" Text="Opening Time" />
                    <asp:TextBox ID="ContentOpeningTime" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label19" runat="server" Text="Closing Time" />
                    <asp:TextBox ID="ContentClosingTime" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label20" runat="server" Text="Rank" />
                    <asp:TextBox ID="ContentRank" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label21" runat="server" Text="Price" />
                    <asp:TextBox ID="ContentPrice" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label22" runat="server" Text="Best Start" />
                    <asp:TextBox ID="ContentBestStart" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label23" runat="server" Text="Best End" />
                    <asp:TextBox ID="ContentBestEnd" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label24" runat="server" Text="Duration Easy" />
                    <asp:TextBox ID="ContentDurationEasy" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label25" runat="server" Text="Duration Moderate" />
                    <asp:TextBox ID="ContentDurationModerate" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label26" runat="server" Text="Duration Extreme" />
                    <asp:TextBox ID="ContentDurationExtreme" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label27" runat="server" Text="All Day" />
                    <asp:CheckBox id="ContentAllDay" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label28" runat="server" Text="is Repeated" />
                    <asp:CheckBox id="ContentRepeated" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label29" runat="server" Text="Start Time" />
                    <asp:TextBox ID="ContentStartTime" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label30" runat="server" Text="End Time" />
                    <asp:TextBox ID="ContentEndTime" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label31" runat="server" Text="Instruction" />
                    <dnn:TextEditor ID="ContentInstruction" runat="server" Height="500" Width="100%" />
                </div>
                <div class="dnnFormItem">
                        <dnn:label ID="lblZone1" runat="server" Text="Zone" />
                        <asp:DropDownList id="ContentZone" runat="server">
               
                        </asp:DropDownList>
                 </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label3" runat="server" Text="Latitude" />
                    <asp:TextBox ID="ContentLatitude" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label4" runat="server" Text="Longitude" />
                    <asp:TextBox ID="ContentLongitude" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label32" runat="server" Text="All Time" />
                    <asp:CheckBox id="ContentAllTime" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label33" runat="server" Text="Repeat" />
                    <asp:DropDownList id="ContentRepeat" runat="server">
               
                    </asp:DropDownList>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label34" runat="server" Text="Every" />
                    <asp:TextBox ID="ContentEvery" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label35" runat="server" Text="Weekdays" />
                    <asp:DropDownList id="ContentWeekdays" runat="server">
               
                    </asp:DropDownList>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label36" runat="server" Text="Repeat After" />
                    <asp:TextBox ID="ContentRepeatAfter" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label37" runat="server" Text="Repeat By" />
                    <asp:DropDownList id="ContentRepeatBy" runat="server">
               
                    </asp:DropDownList>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label38" runat="server" Text="Except Date" />
                    <dnn:DnnDatePicker ID="ContentExceptDate" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label39" runat="server" Text="Start Date" />
                    <dnn:DnnDatePicker ID="ContentStartDate" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label40" runat="server" Text="End Date" />
                    <dnn:DnnDatePicker ID="ContentEndDate" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:Label ID="lblImage" runat="server" Text="Image" /> 
                    <dnn:FilePicker ID="ContentImage" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label50" runat="server" Text="Tag" />
                    <asp:CheckBoxList id="ContentTag" RepeatDirection="Horizontal" RepeatColumns="4" RepeatLayout="Flow" runat="server">

                    </asp:CheckBoxList>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label41" runat="server" Text="Category" />
                    <asp:DropDownList id="ContentCategory" runat="server">
               
                    </asp:DropDownList>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label43" runat="server" Text="Fiuzu Sync" />
                    <asp:DropDownList id="ContentFiuzuSync" runat="server">
               
                    </asp:DropDownList>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label44" runat="server" Text="Xmob Sync" />
                    <asp:DropDownList id="ContentXmobSync" runat="server">
               
                    </asp:DropDownList>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label45" runat="server" Text="Status" />
                    <asp:DropDownList id="ContentStatus" runat="server">
               
                    </asp:DropDownList>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label46" runat="server" Text="Sharing Setting" />
                    <asp:DropDownList id="ContentSharingSetting" runat="server">
               
                    </asp:DropDownList>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label47" runat="server" Text="" />
                    <asp:Button ID="ContentSave" CssClass="dnnPrimaryAction" OnClick="ContentSave_Click" Text="Submit" runat="server" />
                </div>
            </fieldset>
        </div>
        <div id="GalleryMenu" style="display:none;">
            <h2 id="Gallery" class="dnnFormSectionHead"><a href="#">Gallery</a></h2>
            <fieldset class="dnnClear">
                <div class="dnnFormItem">
                    <dnn:Label ID="Label1" runat="server" Text="Image" /> 
                    <dnn:FilePicker ID="GalleryImage" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label5" runat="server" Text="" />
                    <asp:Button ID="GallerySave" CssClass="dnnPrimaryAction" OnClick="GallerySave_Click" Text="Submit" runat="server" />
                </div>

                <div class="dnnFormItem">
                    <table id="GalleryTable" style="width:100%;border:1px solid black;text-align:center">
                        <thead style="border:1px solid black;">
                            <tr>
                                <td style="width:30%">Preview</td>
                                <td style="width:70%">Action</td>
                            </tr>
                        </thead>
                        <tbody style="border:1px solid black;">
                        </tbody>
                    </table>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label59" runat="server" Text="" />
                    <asp:HiddenField ID="ListPhoto" Value="0" runat="server" />
                    <asp:HiddenField ID="ListVideo" Value="0" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label60" runat="server" Text="" />
                    <asp:Button ID="GalleryOrderSave" CssClass="dnnPrimaryAction" OnClick="GalleryOrderSave_Click" Text="Save Order" runat="server" />
                </div>
            </fieldset>
        </div>
        <div id="SubPageMenu" style="display:none;">
            <h2 id="SubPage" class="dnnFormSectionHead"><a href="#">Sub Page</a></h2>
            <fieldset class="dnnClear">
                <div class="dnnFormItem">
                    <dnn:label ID="Label51" runat="server" Text="" />
                    <asp:HiddenField ID="IdSubPage" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label52" runat="server" Text="Title" />
                    <asp:TextBox ID="SubPageTitle" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label53" runat="server" Text="Description" />
                    <dnn:TextEditor ID="SubPageDescription" runat="server" Height="500" Width="100%" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label54" runat="server" Text="" />
                    <asp:Button ID="SubPageSave" CssClass="dnnPrimaryAction" OnClick="SubPageSave_Click" Text="Add Sub Page" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label55" runat="server" Text="" />
                    <asp:Button ID="SubPageEdit" CssClass="dnnPrimaryAction" OnClick="SubPageEdit_Click" Text="Edit Sub Page" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label56" runat="server" Text="Sub Page" />
                    <asp:DropDownList id="SubPageList" OnSelectedIndexChanged="SubPageList_SelectedIndexChanged" AutoPostBack="true" runat="server">
               
                    </asp:DropDownList>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label57" runat="server" Text="" />
                    <asp:Button ID="SubPageDelete" CssClass="dnnPrimaryAction" OnClick="SubPageDelete_Click" Text="Delete Sub Page" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label64" runat="server" Text="" />
                    <table id="SubPageTable" style="width:50%;border:1px solid black;text-align:center">
                        <thead style="border:1px solid black;">
                            <tr>
                                <td style="width:20%">No.</td>
                                <td style="width:40%">Title</td>
                                <td style="width:40%">Order</td>
                            </tr>
                        </thead>
                        <tbody style="border:1px solid black;">
                        </tbody>
                    </table>
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label65" runat="server" Text="" />
                    <asp:HiddenField ID="ListSubPage" Value="0" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn:label ID="Label63" runat="server" Text="" />
                    <asp:Button ID="SubPageOrderSave" CssClass="dnnPrimaryAction" OnClick="SubPageOrderSave_Click" Text="Save Order" runat="server" />
                </div>
            </fieldset>
        </div>
    </div>
