<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="Sentosa.Modules.EventModule.Settings" %>

<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
<%@ Register TagName="FilePicker" TagPrefix="dnn" Src="~/controls/filepickeruploader.ascx" %>
<%@ Register Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn" %>

<script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/geocomplete/1.4/jquery.geocomplete.js"></script>
<script type="text/javascript">


    function actUpdateEvent() {

        var data = {
            Id: $('#upIdEvent').val(),
            Title: $('#upTitle').val(),
            Description: $('#upDesc').val(),
            Zone: $('#upZone').val(),
            ShortDesc: $('#upShortDesc').val(),
            Category: $('#upCategory').val(),
            UrlPurchase: $('#upURLPurchase').val(),
            StartDate: $('#upTxtStartDate1').val(),
            EndDate: $('#upTxtEndDate1').val(),
            Author: $('#upAuthor').val(),
            Latitude: $('#upTxtlat').val(),
            Longitude: $('#upTxtlng').val(),
            Url: $('#upURLCalendar').val(),
            Editor: '<%= UserInfo.DisplayName.ToString() %>'
        }

        var request = $.ajax({
            url: "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/EventModule/API/ModuleEvent/updateEvent",
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            type: "POST",
            data: JSON.stringify(data),
        });

        request.done(function (msg) {
            loadEvent('<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/EventModule/API/ModuleEvent/GetAllEvent');
            alert("Request success: " + msg);

        });

        request.fail(function (jqXHR, textStatus) {
            alert("Request failed: " + textStatus);
        });


        }


        function updateEvent(obj) {

            //alert('update shop' + obj.getAttribute('data-id'));
            $('#upCategory')
       .find('option')
       .remove()
       .end();

            $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/EventModule/API/ModuleEvent/GetListInterest",
        function (result) {

            var parsedTaskJSONObject = jQuery.parseJSON(result);
            var counter = 0;
            $.each(parsedTaskJSONObject, function () {
                if (counter > 0) {
                    $('#upCategory').append(
                      '<option value="' + this.Id + '">' + this.Value + '</option>'

                  );
                }
                counter++;
            });


        });



                $.getJSON(
                   "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/EventModule/API/ModuleEvent/GetEvent?Id=" + obj.getAttribute('data-id'),
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);


               $.each(parsedTaskJSONObject, function () {
                   var startDate = new Date(parseInt(this.StartDate.substr(6)));
                   var endDate = new Date(parseInt(this.EndDate.substr(6)));

                   $('#upIdEvent').val(this.Id);
                   $('#upCategory').val(this.Category);
                   $('#upTitle').val(this.Title);
                   $('#upDesc').val(this.Description);
                   $('#upShortDesc').val(this.ShortDesc);
                   //console.log(this.Zone);
                   if (this.Zone == "") {
                       $('#upZone').val('none');
                   }
                   else {
                       $('#upZone').val(this.Zone);
                   }
                   $('#upURLPurchase').val(this.UrlPurchase);

                   $('#upURLCalendar').val(this.Url);
                   $('#upTxtStartDate1').val((startDate.getMonth() + 1) + '/' + startDate.getDate() + '/' + startDate.getFullYear());
                   $('#upTxtEndDate1').val((endDate.getMonth() + 1) + '/' + endDate.getDate() + '/' + endDate.getFullYear());

                   $('#upAuthor').val(this.Author);
                   $('#upEditor').val(this.Editor);



               });
           });

                $('#update_event').css('display', 'block');

            }

            function deleteEvent(obj) {
                var txt;
                var r = confirm("Are You Really to Remove this Item ?");
                if (r == true) {
                    var data = {
                        Id: obj.getAttribute('data-id')
                    }

                    var request = $.ajax({
                        url: "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/EventModule/API/ModuleEvent/deleteEvent",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                type: "POST",
                data: JSON.stringify(data),
            });

                request.done(function (msg) {
                    loadEvent('<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/EventModule/API/ModuleEvent/GetAllEvent');
                    alert("Request success: " + msg);

                });

                request.fail(function (jqXHR, textStatus) {
                    alert("Request failed: " + textStatus);
                });


                } else {
                    return false;
                }
            }

            function loadEvent(url) {
                console.log(url);
                $.getJSON(
                    url,
                    function (result) {
                        var parsedTaskJSONObject = jQuery.parseJSON(result);
                        var counter = 0;
                        $('#content_event').html('');
                        $.each(parsedTaskJSONObject, function () {
                            var startDate = new Date(parseInt(this.StartDate.substr(6)));
                            var endDate = new Date(parseInt(this.EndDate.substr(6)));

                            $('#content_event').append(
                                '<tr>' +
                                 '<td>' + this.Id + '</td>' +
                                  '<td>' + this.Title + '</td>' +
                                   '<td>' + startDate.getFullYear() + '/' + (startDate.getMonth() + 1) + '/' + startDate.getDate() + '</td>' +
                                  '<td>' + endDate.getFullYear() + '/' + (endDate.getMonth() + 1) + '/' + endDate.getDate() + '</td>' +
                                  '<td>' + this.Category + '</td>' +
                                  '<td>' + this.Description + '</td>' +
                                    '<td>' + this.ShortDesc + '</td>' +
                                   '<td>' + this.Zone + '</td>' +
                                   '<td>' + this.UrlPurchase + '</td>' +
                                   '<td>' + this.Url + '</td>' +
                                  '<td>' + '<button type="button" onclick="updateEvent(this);" data-id="' + this.Id + '">Update</button>' +
                                  '<button type="button" onclick="deleteEvent(this);"  data-id="' + this.Id + '">Delete</button>' + '</td>' +
                              '</tr>'
                            );
                            counter++;
                        });
                    });
            }
            loadEvent('<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/EventModule/API/ModuleEvent/GetAllEvent');
</script>






    <h2 id="dnnSitePanel-ListEvent" class="dnnFormSectionHead"><a href="" class="">List Event</a></h2>
	<fieldset>
       <div id="update_event" style="display:none" >
               
                    <input type="hidden"  id="upIdEvent" value=""  />
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
                    <dnn:label ID="upLabel7" runat="server" Text="Start Date" />
                     <input type="text" id="upTxtStartDate1"  >
                   
                   
                </div>

                 <div class="dnnFormItem">
                    <dnn:label ID="upLabel8" runat="server" Text="End Date" />
                    <input type="text" id="upTxtEndDate1"  >
                   
                   
                </div>

                <div class="dnnFormItem">
                    <dnn:label ID="upLabel3" runat="server" Text="Description" />
                    <textarea rows="4" cols="50" id="upDesc"></textarea>
                   
                   
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
                    <dnn:label ID="upLabel9" runat="server" Text="URL Calendar" />
                      <input type="text" value="" id="upURLCalendar" />
                </div>
                 
                 <div class="dnnFormItem">
                    
                      <button type="button" onclick="actUpdateEvent();return false;">Save</button>
                </div>
                </div>
      <br /><br />
      
    <table border="1" id="table_id_event">
         <thead>
          <tr>
             <th>ID</th>
             <th>Title</th>
             <th>Start Date</th>
             <th>End Date</th>
             <th>Category</th>
             <th>Description</th>
             <th>Short Description</th>
             <th>Zone</th>
             <th>URL Purchase</th>
             <th>URL Calendar Link</th>
             <th>Action</th>
          </tr>
         </thead>
 
         <tbody id="content_event">
          <tr>
             <td></td>
             <td></td>
              <td></td>
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
    

	<h2 id="dnnSitePanel-FormEvent" class="dnnFormSectionHead"><a href="" class="">Form Add Event</a></h2>
	
    <fieldset>
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
                     <dnn:label ID="lblStartDate1" runat="server" Text="Start Date" />
                    <dnn:DnnDatePicker ID="txtStartDate1" runat="server" />
                </div>

                <div class="dnnFormItem">
                     <dnn:label ID="lblEndDate1" runat="server" Text="End Date" />
                    <dnn:DnnDatePicker ID="txtEndDate1" runat="server" />
                </div>
          

                <div class="dnnFormItem">
                    <dnn:label ID="lblDescription1" runat="server" Text="Description" />
                    <asp:TextBox ID="txtDescription1" runat="server" TextMode="MultiLine" Rows="4" Columns="50" />
                </div>
      
                 <div class="dnnFormItem">
                    <dnn:label ID="lblShortDesc1" runat="server" Text=" Short Description" />
                    <asp:TextBox ID="txtShortDesc1" runat="server" TextMode="MultiLine" Rows="4" Columns="50" />
                </div>

                  <div class="dnnFormItem">
                    <dnn:label ID="lblThumbnail1" runat="server" Text="Thumbnail" />
                    <dnn:filePicker ID="fileThumbnail1" runat="server" />
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
                
                <div class="dnnFormItem">
                    <dnn:label ID="lblUrlCal1" runat="server" Text="URL Calendar" />
                    <asp:TextBox ID="txtUrlCal1" runat="server" />
                </div>
                
        <!--
                <asp:ObjectDataSource 
                      ID="EmployeeDetailsObjectDataSource" 
                      runat="server" />

        <asp:SqlDataSource ID="sqlManageShop" runat="server" />-->
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


   
