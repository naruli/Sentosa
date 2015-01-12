<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="Sentosa.Modules.AttractionsModule.Settings" %>


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
        $('#upCategory').find('option').remove().end();

        var Id = 2;
        $.getJSON(
        "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/AttractionsModule/API/ModuleAttractions/ListAttractions?id=" + Id,
        function (result) {
            var parsedTaskJSONObject = jQuery.parseJSON(result);
            $.each(parsedTaskJSONObject, function () {
                $('#upCategory').append(
                      '<option value="' + this.Id + '">' + this.Value + '</option>'
                  );
            });
        });

        $.getJSON(
           "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/AttractionsModule/API/ModuleAttractions/GetAttractions?id=" + obj.getAttribute('data-id'),
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $.each(parsedTaskJSONObject, function () {
                   $('#upIdAttractions').val(this.Id);
                   $('#upCategory').val(this.Category);
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

        $('#update_attractions').css('display', 'block');
        //alert('update attractions' + obj.getAttribute('data-id'));
    }

    function updateAttractions() {

        var attractionsToUpdate = {
            ATU_Id: $('#upIdAttractions').val(),
            ATU_Title: $('#upTitle').val(),
            ATU_Zone: $('#upZone').val(),
            ATU_ShortDesc: $('#upShortDesc').val(),
            ATU_Category: $('#upCategory').val(),
            ATU_UrlPurchase: $('#upURLPurchase').val(),
            ATU_Author: $('#upAuthor').val(),
            ATU_Latitude: $('#upTxtlat').val(),
            ATU_Longitude: $('#upTxtlng').val(),
            ATU_Editor: '<%= UserInfo.DisplayName.ToString() %>'
        }

        var sf = $.ServicesFramework(<%:ModuleContext.ModuleId%>);

        $.ajax({
            url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/AttractionsModule/API/ModuleAttractions/UpdateAttractions',
            type: "POST",
            contentType: "application/json",
            beforeSend: sf.setModuleHeaders,
            data: JSON.stringify(attractionsToUpdate),
            success: function (data) {
                loadAttractions();
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
                deleteAttractions($(obj).attr('data-id'));
            }
        });
    }

    function deleteAttractions(Id) {
        var attractionsId = Id;
        var attractionsToDelete = {
            ATD_Id: attractionsId,
        };

        var sf = $.ServicesFramework(<%:ModuleContext.ModuleId%>);

        $.ajax({
            url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/AttractionsModule/API/ModuleAttractions/DeleteAttractions',
            type: "POST",
            contentType: "application/json",
            beforeSend: sf.setModuleHeaders,
            data: JSON.stringify(attractionsToDelete),
            success: function (data) {
                loadAttractions();
            }
        });
    }
    function loadAttractions() {
        $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/AttractionsModule/API/ModuleAttractions/GetAllAttractions",
            function (result) {
                var parsedTaskJSONObject = jQuery.parseJSON(result);
                var counter = 0;
                $('#content_attractions').html('');
                $.each(parsedTaskJSONObject, function () {
                    $('#content_attractions').append(
                        '<tr>' +
                         '<td>' + this.Id + '</td>' +
                          '<td>' + this.Title + '</td>' +
                          '<td>' + this.Category + '</td>' +
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
    loadAttractions();
</script>




    <h2 id="dnnSitePanel-ListAttractions" class="dnnFormSectionHead"><a href="" class="">List Attractions</a></h2>
	<fieldset>
     
        <div id="update_attractions" style="display:none" >
               
                <input type="hidden"  id="upIdAttractions" value=""  />
                <input type="hidden"  id="upAuthor" value=""  />
                <input type="hidden"  id="upEditor" value=""  />
                <div class="dnnFormItem">
                    <dnn:label ID="upLabel1" runat="server" Text="Title" />
                     <input type="text" value="" id="upTitle" />
                   
                </div>

                <div class="dnnFormItem">
                    <dnn:label ID="upLabel2" runat="server" Text="Category" />
                     
                    <select id="upCategory">
                    
                    </select>
                </div>
      
                 <div class="dnnFormItem">
                    <dnn:label ID="upLabel4" runat="server" Text=" Short Description" />
                     <textarea rows="4" cols="50" id="upShortDesc"></textarea>
                   
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
                      <button type="button" onclick="updateAttractions();return false;">Save</button>

                </div>
        </div>
      <br /><br />
      
    <table border="1" id="table_id_attractions">
         <thead>
          <tr>
             <th>ID</th>
             <th>Title</th>
             <th>Category</th>
             <th>Short Description</th>
             <th>Zone</th>
             <th>URL Purchase</th>
             <th>Action</th>
          </tr>
         </thead>
 
         <tbody id="content_attractions">
          <tr>
             <td></td>
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
    

	<h2 id="dnnSitePanel-FormAttractions" class="dnnFormSectionHead"><a href="" class="">Form Add Attractions</a></h2>
	
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
                    <dnn:label ID="lblCategory1" runat="server" Text="Category" />
                     <asp:DropDownList id="cmbCategory1" runat="server">
               
                     </asp:DropDownList>
                </div>
      
                 <div class="dnnFormItem">
                    <dnn:label ID="lblShortDesc1" runat="server" Text=" Short Description" />
                    <asp:TextBox ID="txtShortDesc1" runat="server" TextMode="MultiLine" Rows="4" Columns="50" />
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

        <asp:SqlDataSource ID="sqlManageAttractions" runat="server" />-->
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