<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="Sentosa.Modules.HappeningModule.Settings" %>
<script type="text/javascript">
    function loadHappening(url) {
        //console.log(url);
        $.getJSON(
           url,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               var counterEvent = 0;
               var counterPromotion = 0;
               $('.Events').html('');
               $('.Promotions').html('');
               $('.Events').append(
                   '<table id="Events" border="0" style="width:100%;"></table>'
                   );
               $('.Promotions').append(
                   '<table id="Promotions" border="0" style="width:100%"></table>'
                   );
               $('#Events').append(
                   '<th colspan="3" style="text-align:center;">Events</th>'
                   );
               $('#Promotions').append(
                   '<th colspan="3" style="text-align:center;">Promotions</th>'
                   );
               $.each(parsedTaskJSONObject, function () {
                   if (this.TypeContent == "P_EVENT") {
                       counterEvent++;
                       $('#Events').append(
                           '<tr>' +
                           '<td style="width:10%;text-align:center;">' +
                           '<input type="checkbox" name="event' + counterEvent + '" id="event' + this.Id + '" value="' + this.Id + '"/>' +
                           '</td>' +
                           '<td colpan="2">' +
                           this.Title +
                           '</td>' +
                           '</tr>'
                           );
                   }
                   else {
                       counterPromotion++;
                       $('#Promotions').append(
                           '<tr>' +
                           '<td style="width:10%;text-align:center;">' +
                           '<input type="checkbox" name="promotion' + counterPromotion + '" id="promotion' + this.Id + '" value="' + this.Id + '"/>' +
                           '</td>' +
                           '<td colpan="2">' +
                           this.Title +
                           '</td>' +
                           '</tr>'
                           );
                   }
               });
               if (counterEvent == 0) {
                   $('#Events').append(
                       '<tr>' +
                       '<td colspan="3" style="text-align:center;">There are no list of Events</td>' +
                       '</tr>' +
                       '</table>'
                       );
               }
               if(counterPromotion == 0) {
                   $('#Promotions').append(
                       '<tr>' +
                       '<td colspan="3" style="text-align:center;">There are no list of Promotions</td>' +
                       '</tr>' +
                       '</table>'
                       );
               }
               $('#totalEvent').val(counterEvent);
               $('#totalPromotion').val(counterPromotion);
               setCheckbox('<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath.ToString())%>/DesktopModules/HappeningModule/API/ModuleHappening/GetHappening');
           });
    }

    function setCheckbox(url) {
        $.getJSON(
           url,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $.each(parsedTaskJSONObject, function () {
                   if (this.TypeIdRef == 'P_EVENT') {
                       $('#event' + this.IdRef).prop('checked', true);
                   }
                   else {
                       $('#promotion' + this.IdRef).prop('checked', true);
                   }
               });
           });
    }
    loadHappening('<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath.ToString())%>/DesktopModules/HappeningModule/API/ModuleHappening/GetContentHappening');
</script>

<!-- uncomment the code below to start using the DNN Form pattern to create and update settings -->
  

<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>

	<h2 id="dnnSitePanel-BasicSettings" class="dnnFormSectionHead"><a href="" class="">Content List</a></h2>
	<fieldset>
        <div class="Events" style="width:45%;float:left">
            
        </div>
        <div class="Promotions" style="width:45%;float:right">
            
        </div>
        <input type="hidden" id="totalEvent" name="listEvent" value="" />
        <input type="hidden" id="totalPromotion" name="listPromotion" value="" />
    </fieldset>


