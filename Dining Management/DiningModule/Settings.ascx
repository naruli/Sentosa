<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="Sentosa.Modules.DiningModule.Settings" %>


<!-- uncomment the code below to start using the DNN Form pattern to create and update settings -->
<%--  

<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>

	<h2 id="dnnSitePanel-BasicSettings" class="dnnFormSectionHead"><a href="" class="dnnSectionExpanded"><%=LocalizeString("BasicSettings")%></a></h2>
	<fieldset>
        <div class="dnnFormItem">
            <dnn:Label ID="lblSetting1" runat="server" /> 
 
            <asp:TextBox ID="txtSetting1" runat="server" />
        </div>
        <div class="dnnFormItem">
            <dnn:label ID="lblSetting2" runat="server" />
            <asp:TextBox ID="txtSetting2" runat="server" />
        </div>
    </fieldset>


--%>
<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
<%@ Register TagName="filePicker" TagPrefix="dnn" Src="~/controls/filepickeruploader.ascx" %>

<script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
<script src="<%= Request.Url.GetLeftPart(UriPartial.Authority)%>/Portals/_default/Skins/HammerFlex/js/jquery.geocomplete.min.js"></script>
<script type="text/javascript">



    function updateRow(obj) {
        diningExperience('UpDining', 'up_dining_row', 'up_dining');
        cuisineType('UpCuisine', 'up_cuisine_row', 'up_cuisine');

        setDiningExperience(obj.getAttribute('data-id'), 'up_dining');
        setCuisineType(obj.getAttribute('data-id'), 'up_cuisine');
        $.getJSON(
           "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningModule/API/ModuleDining/GetDining?id=" + obj.getAttribute('data-id'),
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $.each(parsedTaskJSONObject, function () {
                   $('#upIdDining').val(this.Id);
                   $('#upTitle').val(this.Title);
                   $('#upShortDesc').val(this.ShortDesc);
                   if (this.Zone == "") {
                       $('#upZone').val('none');
                   }
                   else {
                       $('#upZone').val(this.Zone);
                   }
                   $('#upURLPurchase').val(this.UrlPurchase);
                   $('#upAuthor').val(this.Author);
                   $('#upEditor').val(this.Editor);
               });
           });

        $('#update_dining').css('display', 'block');
        //alert('update dining' + obj.getAttribute('data-id'));
    }

    function updateDining() {

        var diningToUpdate = {
            DTU_Id: $('#upIdDining').val(),
            DTU_Title: $('#upTitle').val(),
            DTU_Zone: $('#upZone').val(),
            DTU_ShortDesc: $('#upShortDesc').val(),
            DTU_UrlPurchase: $('#upURLPurchase').val(),
            DTU_Author: $('#upAuthor').val(),
            DTU_Latitude: $('#upTxtlat').val(),
            DTU_Longitude: $('#upTxtlng').val(),
            DTU_Editor: '<%= UserInfo.DisplayName.ToString() %>'
        }

        var sf = $.ServicesFramework(<%:ModuleContext.ModuleId%>);

        $.ajax({
            url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningModule/API/ModuleDining/UpdateDining',
            type: "POST",
            contentType: "application/json",
            beforeSend: sf.setModuleHeaders,
            data: JSON.stringify(diningToUpdate),
            success: function (data) {
                $('#UpDining input[type="checkbox"]').each(function (index, value) {
                    var diningExperienceToUpdate = {
                        DETU_Id: $('#upIdDining').val(),
                        DETU_Category: $(this).val(),
                        DETU_IsHave: (this.checked ? true : false)
                    }

                    $.ajax({
                        url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningModule/API/ModuleDining/UpdateDiningExperience',
                        type: "POST",
                        contentType: "application/json",
                        beforeSend: sf.setModuleHeaders,
                        data: JSON.stringify(diningExperienceToUpdate)
                    });
                });

                $('#UpCuisine input[type="checkbox"]').each(function (index, value) {
                    var cuisineTypeToUpdate = {
                        CTTU_Id: $('#upIdDining').val(),
                        CTTU_Category: $(this).val(),
                        CTTU_IsHave: (this.checked ? true : false)
                    }

                    $.ajax({
                        url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningModule/API/ModuleDining/UpdateCuisineType',
                        type: "POST",
                        contentType: "application/json",
                        beforeSend: sf.setModuleHeaders,
                        data: JSON.stringify(cuisineTypeToUpdate)
                    });
                });
                loadDining();
            }
        });
    }


    function deleteRow(obj) {
        $.dnnConfirm({
            text: 'You sure you want to delete',
            yesText: 'Yep,delete',
            noText: 'Cancel',
            title: 'Delete Confirmation',
            callbackTrue: function () {
                deleteDining($(obj).attr('data-id'));
            }
        });
    }

    function deleteDining(Id) {
        var diningId = Id;
        var diningToDelete = {
            DTD_Id: diningId,
        };

        var sf = $.ServicesFramework(<%:ModuleContext.ModuleId%>);

        $.ajax({
            url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningModule/API/ModuleDining/DeleteDining',
            type: "POST",
            contentType: "application/json",
            beforeSend: sf.setModuleHeaders,
            data: JSON.stringify(diningToDelete),
            success: function (data) {
                loadDining();
            }
        });
    }
    function loadDining() {
        $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningModule/API/ModuleDining/GetAllDining",
            function (result) {
                var parsedTaskJSONObject = jQuery.parseJSON(result);
                var counter = 0;
                $('#content_dining').html('');
                $.each(parsedTaskJSONObject, function () {
                    $('#content_dining').append(
                        '<tr>' +
                         '<td>' + this.Id + '</td>' +
                          '<td>' + this.Title + '</td>' +
                            '<td>' + this.ShortDesc + '</td>' +
                           '<td>' + this.Zone + '</td>' +
                           '<td>' + this.UrlPurchase + '</td>' +
                          '<td>' + '<button type="button" onclick="updateRow(this);" data-id="' + this.Id + '">Update</button>' +
                          '<button type="button" onclick="deleteRow(this);"  data-id="' + this.Id + '">Delete</button>' + '</td>' +
                      '</tr>'
                    );
                    counter++;
                });
            });
    }

    function diningExperience(idTable, idRow, idMode) {
        $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningModule/API/ModuleDining/ListDining",
            function (result) {
                var parsedTaskJSONObject = jQuery.parseJSON(result);
                var counter = 0;
                var row = 0;
                $('#' + idTable).html('');
                $.each(parsedTaskJSONObject, function () {
                    if (counter % 4 == 0) {
                        row++;
                        $('#' + idTable).append(
                            '<tr id="' + idRow + '_' + row + '">' +
                            '</tr>'
                        );
                    }
                    counter++;
                    $('#' + idRow + '_' + row).append(
                        '<td>' +
                            '<label><input type="checkbox" name="' + idMode + '_' + counter + '" id="' + idMode + '_' + this.Id + '" value="' + this.Id + '"><span>' + this.Value + '</span></label>' +
                        '</td>'
                        );
                });
                $('#' + idTable).parent().append(
                    '<input type="hidden" name="' + idMode + '" id="' + idMode + '" value="" />'
                    );
                $('#' + idMode).val(counter);
            });
    }

    function cuisineType(idTable, idRow, idMode) {
        $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningModule/API/ModuleDining/ListCuisine",
            function (result) {
                var parsedTaskJSONObject = jQuery.parseJSON(result);
                var counter = 0;
                var row = 0;
                $('#' + idTable).html('');
                $.each(parsedTaskJSONObject, function () {
                    if (counter % 5 == 0) {
                        row++;
                        $('#' + idTable).append(
                            '<tr id="' + idRow + '_' + row + '">' +
                            '</tr>'
                        );
                    }
                    counter++;
                    $('#' + idRow + '_' + row).append(
                        '<td>' +
                            '<label><input type="checkbox" name="' + idMode + '_' + counter + '" id="' + idMode + '_' + this.Id + '" value="' + this.Id + '"><span>' + this.Value + '</span></label>' +
                        '</td>'
                        );
                });
                $('#' + idTable).parent().append(
                    '<input type="hidden" name="' + idMode + '" id="' + idMode + '" value="" />'
                    );
                $('#'+ idMode).val(counter);
            });
    }

    function setDiningExperience(Id, IdMode) {
        $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningModule/API/ModuleDining/GetDiningExperience?Id=" + Id,
            function (result) {
                var parsedTaskJSONObject = jQuery.parseJSON(result);
                $.each(parsedTaskJSONObject, function () {
                    $('#' + IdMode + '_' + this.Category).prop('checked', true);
                });
            });
    }

    function setCuisineType(Id, IdMode) {
        $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningModule/API/ModuleDining/GetCuisineType?Id=" + Id,
            function (result) {
                var parsedTaskJSONObject = jQuery.parseJSON(result);
                $.each(parsedTaskJSONObject, function () {
                    $('#' + IdMode + '_' + this.Category).prop('checked', true);
                });
            });
    }
    loadDining();
    diningExperience('Dining', 'dining_row', 'add_dining');
    cuisineType('Cuisine', 'cuisine_row', 'add_cuisine');
</script>




    <h2 id="dnnSitePanel-ListDining" class="dnnFormSectionHead"><a href="" class="">List Dining</a></h2>
	<fieldset>
     
        <div id="update_dining" style="display:none" >
               
                <input type="hidden"  id="upIdDining" value=""  />
                <input type="hidden"  id="upAuthor" value=""  />
                <input type="hidden"  id="upEditor" value=""  />
                <div class="dnnFormItem">
                    <dnn:label ID="upLabel1" runat="server" Text="Title" />
                     <input type="text" value="" id="upTitle" />
                   
                </div>
      
                 <div class="dnnFormItem">
                    <dnn:label ID="upLabel2" runat="server" Text=" Short Description" />
                     <textarea rows="4" cols="50" id="upShortDesc"></textarea>
                   
                </div>

                <div class="dnnFormItem">
                    <dnn:label ID="upLabel3" runat="server" Text="Dining Experience" />
                    <table border="0" id="UpDining">
                        
                    </table>
                </div>

                <div class="dnnFormItem">
                    <dnn:label ID="upLabel4" runat="server" Text="Cuisine Type" />
                    <table border="0" id="UpCuisine">
                        
                    </table>
                </div>

                <div class="dnnFormItem">
                    <dnn:label ID="upLabel5" runat="server" Text="Zone" />
                    <input id="upZone" type="text" placeholder="Type in an address" />

                      <div class="dnnFormItem Updetailsinfo">
                        <input type="hidden"  data-geo-up="formatted_address" id="upTxtFormatAddr" name="upTxtFormatAddr" value=""  />
                          <input type="hidden"  data-geo-up="lat" id="upTxtlat" name="upTxtlat" value=""  />
                          <input type="hidden"  data-geo-up="lng" id="upTxtlng" name="upTxtlng" value=""  />
                      </div>

                </div>

                 <div class="dnnFormItem">
                    <dnn:label ID="upLabel6" runat="server" Text="URL Purchase" />
                    <input type="text" value="" id="upURLPurchase" />

                </div>

                 <div class="dnnFormItem">
                      <button type="button" onclick="updateDining();return false;">Save</button>

                </div>
        </div>
      <br /><br />
      
    <table border="1" id="table_id_dining">
        <colgroup>
            <col width="10px" />
            <col width="100px" />
            <col width="150px" />
            <col width="150px" />
            <col width="100px" />
        </colgroup>
         <thead>
          <tr>
             <th>ID</th>
             <th>Title</th>
             <th>Short Description</th>
             <th>Zone</th>
             <th>URL Purchase</th>
             <th>Action</th>
          </tr>
         </thead>
 
         <tbody id="content_dining">
          <tr>
             <td></td>
             <td></td>
              <td></td>
             <td></td>
              <td></td>
             <td></td>
          </tr>
          
         </tbody>
    </table>

   
    
    </fieldset>
    

	<h2 id="dnnSitePanel-FormDining" class="dnnFormSectionHead"><a href="" class="">Form Add Dining</a></h2>
	
    <fieldset>
               <div class="dnnFormItem">
                    <dnn:label ID="lblThumbnail1" runat="server" Text="Thumbnail" />
                    <dnn:filePicker ID="fileThumbnail1" runat="server" />
                </div>

               <div class="dnnFormItem">
                    <dnn:label ID="lblTitle1" runat="server" Text="Title" />
                    <asp:TextBox ID="txtTitle1" runat="server" />
                </div>
      
                 <div class="dnnFormItem">
                    <dnn:label ID="lblShortDesc1" runat="server" Text=" Short Description" />
                    <asp:TextBox ID="txtShortDesc1" runat="server" TextMode="MultiLine" Rows="4" Columns="50" />
                </div>

                <div class="dnnFormItem">
                    <dnn:label ID="lblDining1" runat="server" Text="Dining Experience" />
                    <table border="0" id="Dining">
                        
                    </table>
                </div>

                <div class="dnnFormItem">
                    <dnn:label ID="lblCuisine" runat="server" Text="Cuisine Type" />
                    <table border="0" id="Cuisine">
                        
                    </table>
                </div>

                <div class="dnnFormItem">
                    <dnn:label ID="lblZone1" runat="server" Text="Zone" />
                    <input id="geocomplete" type="text" placeholder="Type in an address" />
                      <div class="dnnFormItem detailsinfo">
                        <input type="hidden"  data-geo="formatted_address" name="txtFormatAddr" value=""  />
                          <input type="hidden"  data-geo="lat" name="txtlat" value=""  />
                          <input type="hidden"  data-geo="lng" name="txtlng" value=""  />
                      </div>
                </div>

                 <div class="dnnFormItem">
                    <dnn:label ID="lblUrlPurch1" runat="server" Text="URL Purchase" />
                    <asp:TextBox ID="txtUrlPurch1" runat="server" />
                </div>
        
                
        <!--
                <asp:ObjectDataSource 
                      ID="EmployeeDetailsObjectDataSource" 
                      runat="server" />

        <asp:SqlDataSource ID="sqlManageDining" runat="server" />-->
    </fieldset>

<script>
    jQuery(function () {

        $("#geocomplete").geocomplete({
            details: ".detailsinfo",
            detailsAttribute: "data-geo"
        });

        $("#upZone").geocomplete({
            details: ".Updetailsinfo",
            detailsAttribute: "data-geo-up"
        });

    });
</script>