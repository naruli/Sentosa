<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="Sentosa.Modules.BeachesModule.Settings" %>


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
        $.getJSON(
           "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/BeachesModule/API/ModuleBeaches/GetBeaches?id=" + obj.getAttribute('data-id'),
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $.each(parsedTaskJSONObject, function () {
                   $('#upIdBeaches').val(this.Id);
                   $('#upTitle').val(this.Title);
                   $('#upShortDesc').val(this.ShortDesc);
                   if (this.Zone == "") {
                       $('#upZone').val('none');
                   }
                   else {
                       $('#upZone').val(this.Zone);
                   }
                   $('#upURLBrochure').val(this.UrlBrochure);
                   $('#upAuthor').val(this.Author);
                   $('#upEditor').val(this.Editor);
               });
           });

        $('#update_beaches').css('display', 'block');
        //alert('update beaches' + obj.getAttribute('data-id'));
    }

    function updateBeaches() {

        var beachesToUpdate = {
            BTU_Id: $('#upIdBeaches').val(),
            BTU_Title: $('#upTitle').val(),
            BTU_Zone: $('#upZone').val(),
            BTU_ShortDesc: $('#upShortDesc').val(),
            BTU_UrlBrochure: $('#upURLBrochure').val(),
            BTU_Author: $('#upAuthor').val(),
            BTU_Latitude: $('#upTxtlat').val(),
            BTU_Longitude: $('#upTxtlng').val(),
            BTU_Editor: '<%= UserInfo.DisplayName.ToString() %>'
        }

        var sf = $.ServicesFramework(<%:ModuleContext.ModuleId%>);

        $.ajax({
            url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/BeachesModule/API/ModuleBeaches/UpdateBeaches',
            type: "POST",
            contentType: "application/json",
            beforeSend: sf.setModuleHeaders,
            data: JSON.stringify(beachesToUpdate),
            success: function (data) {
                loadBeaches();
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
                deleteBeaches($(obj).attr('data-id'));
            }
        });
    }

    function deleteBeaches(Id) {
        var beachesId = Id;
        var beachesToDelete = {
            BTD_Id: beachesId,
        };

        var sf = $.ServicesFramework(<%:ModuleContext.ModuleId%>);

        $.ajax({
            url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/BeachesModule/API/ModuleBeaches/DeleteBeaches',
            type: "POST",
            contentType: "application/json",
            beforeSend: sf.setModuleHeaders,
            data: JSON.stringify(beachesToDelete),
            success: function (data) {
                loadBeaches();
            }
        });
    }
    function loadBeaches() {
        $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/BeachesModule/API/ModuleBeaches/GetAllBeaches",
            function (result) {
                var parsedTaskJSONObject = jQuery.parseJSON(result);
                var counter = 0;
                $('#content_beaches').html('');
                $.each(parsedTaskJSONObject, function () {
                    $('#content_beaches').append(
                        '<tr>' +
                         '<td>' + this.Id + '</td>' +
                          '<td>' + this.Title + '</td>' +
                            '<td>' + this.ShortDesc + '</td>' +
                           '<td>' + this.Zone + '</td>' +
                           '<td>' + this.UrlBrochure + '</td>' +
                          '<td>' + '<button type="button" onclick="updateRow(this);" data-id="' + this.Id + '">Update</button>' +
                          '<button type="button" onclick="deleteRow(this);"  data-id="' + this.Id + '">Delete</button>' + '</td>' +
                      '</tr>'
                    );
                    counter++;
                });
            });
    }
    loadBeaches();
</script>




    <h2 id="dnnSitePanel-ListBeaches" class="dnnFormSectionHead"><a href="" class="">List Beaches</a></h2>
	<fieldset>
     
        <div id="update_beaches" style="display:none" >
               
                <input type="hidden"  id="upIdBeaches" value=""  />
               <input type="hidden"  id="upAuthor" value=""  />
                <input type="hidden"  id="upEditor" value=""  />
                <div class="dnnFormItem">
                    <dnn:label ID="upLabel1" runat="server" Text="Title" />
                     <input type="text" value="" id="upTitle" />
                   
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
                    <dnn:label ID="upLabel6" runat="server" Text="URL Safety Brochure" />
                      <input type="text" value="" id="upURLBrochure" />
                </div>

                 <div class="dnnFormItem">
                      <button type="button" onclick="updateBeaches();return false;">Save</button>
                </div>
        </div>
      <br /><br />
      
    <table border="1" id="table_id_beaches">
         <thead>
          <tr>
             <th>ID</th>
             <th>Title</th>
             <th>Short Description</th>
             <th>Zone</th>
             <th>URL Safety Brochure</th>
             <th>Action</th>
          </tr>
         </thead>
 
         <tbody id="content_beaches">
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
    

	<h2 id="dnnSitePanel-FormBeaches" class="dnnFormSectionHead"><a href="" class="">Form Add Beaches</a></h2>
	
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
                    <dnn:label ID="lblZone1" runat="server" Text="Zone" />
                    <input id="geocomplete" type="text" placeholder="Type in an address" />
                      <div class="dnnFormItem detailsinfo">
                        <input type="hidden"  data-geo="formatted_address" name="txtFormatAddr" value=""  />
                          <input type="hidden"  data-geo="lat" name="txtlat" value=""  />
                          <input type="hidden"  data-geo="lng" name="txtlng" value=""  />
                      </div>
                </div>

                 <div class="dnnFormItem">
                    <dnn:label ID="lblUrlBrochure1" runat="server" Text="URL Safety Brochure" />
                    <asp:TextBox ID="txtUrlBrochure1" runat="server" />
                </div>
        
                
        <!--
                <asp:ObjectDataSource 
                      ID="EmployeeDetailsObjectDataSource" 
                      runat="server" />

        <asp:SqlDataSource ID="sqlManageBeaches" runat="server" />-->
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