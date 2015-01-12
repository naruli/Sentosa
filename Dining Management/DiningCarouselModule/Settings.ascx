<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="Sentosa.Modules.DiningCarouselModule.Settings" %>



<!-- uncomment the code below to start using the DNN Form pattern to create and update settings -->
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
            url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningCarouselModule/API/ModuleCarousel/DeleteCarousel',
            type: "POST",
            contentType: "application/json",
            beforeSend: sf.setModuleHeaders,
            data: JSON.stringify(carouselToDelete),
            success: function (data) {
                loadCarousel();
            }
        });
    }

    function loadCarousel() {
        $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningCarouselModule/API/ModuleCarousel/GetCarousel?Page=Dining",
            function (result) {
                var parsedTaskJSONObject = jQuery.parseJSON(result);
                var counter = 0;
                $('.table').html('');
                $('.table').append(
                    '<thead>' +
                        '<tr>' +
                            '<th style="text-align:center">Caption Carousel</th>' +
                            '<th style="text-align:center">Order Carousel</th>' +
                            '<th style="text-align:center">Action</th>' +
                            '<th></th>' +
                        '</tr>' +
                    '</thead>' +
                    '<tbody>'
                    );
                $.each(parsedTaskJSONObject, function () {
                    counter++;
                    $('.table').append(
                        '<tr>' +
                            '<td>' + this.Caption + '</td>' +
                            '<td style="text-align:center"><input type="text" id="txtEdited' + counter + '" name="order' + counter + '" value="' + this.OrderBanner + '" /></td>' +
                            '<td><input type="button" class="dnnSecondaryAction" name="deleteBtn" id="' + this.Id + '" onclick="removeCheckbox(this);" value="Delete Carousel" /></td>' +
                            '<td><input type="hidden" id="carouselId' + counter + '" name="carousel' + counter + '" value="' + this.Id + '" /></td>' +
                        '</tr>'
                        );
                });
                $('.table').append(
                    '</tbody>'
                    );
                $('#totalRow').val(counter);
            });
    }
    loadCarousel();
</script>
    <%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
    <%@ Register TagName="FilePicker" TagPrefix="dnn" Src="~/controls/filepickeruploader.ascx" %>
	<h2 id="dnnSitePanel-AddCarousel" class="dnnFormSectionHead"><a href="" class="dnnSectionExpanded">Add Carousel</a></h2>
	<fieldset>
        <div class="dnnFormItem">
            <dnn:Label ID="lblImage" runat="server" Text="Image" /> 
            <dnn:FilePicker ID="filepicker" runat="server" />
        </div>
        <div class="dnnFormItem">
            <dnn:label ID="lblCaption" runat="server" Text="Caption" />
            <asp:TextBox ID="txtCaption" runat="server" />
        </div>
        <div class="dnnFormItem">
            <dnn:label ID="lblDescription" runat="server" Text="Description" />
            <asp:TextBox ID="txtDescription" runat="server"  TextMode="MultiLine" Rows="4" Columns="50" />
        </div>
    </fieldset>

    <h2 id="dnnSitePanel-EditCarousel" class="dnnFormSectionHead"><a href="" class="">Edit Carousel</a></h2>
	<fieldset>
        <table class="table" align="center">
        </table>
        <div class="hidden"><input type="hidden" id="totalRow" name="totalRow" value="" /></div>
    </fieldset>