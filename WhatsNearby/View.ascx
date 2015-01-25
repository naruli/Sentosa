<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.WhatsNearby.View" %>

<script type="text/javascript">
    String.prototype.trunc =
     function (n, useWordBoundary) {
         var toLong = this.length > n,
             s_ = toLong ? this.substr(0, n - 1) : this;
         s_ = useWordBoundary && toLong ? s_.substr(0, s_.lastIndexOf(' ')) : s_;
         return toLong ? s_ + '&hellip;' : s_;
     };
    // Encode/decode htmlentities
    function krEncodeEntities(s) {
        return $("<div/>").text(s).html();
    }
    function krDencodeEntities(s) {
        return $("<div/>").html(s).text();
    }
    function loadWhatsNearby(url) {
        //console.log(url);
        $.getJSON(
           url,
           function (result) {

               var parsedTaskJSONObject = jQuery.parseJSON(result);

               var counter = 0;
               $('#container-nearby').html('');

               $.each(parsedTaskJSONObject, function () {
                   counter++;
                   var shortDesc = krDencodeEntities(this.ShortDescription);
                   $('#container-nearby').append(
                          '<div class="box-item">' +
                            '<a href="' + this.Url + '">' +
                                '<img src="' + this.Photo + '" alt="" title="" class="">' +
                                '<div class="box-content">' +
                                    '<h3>' + this.TabName + '</h3>' +
                                    '<p>' + shortDesc.trunc(150,true) + '</p>' +
                                '</div>' +
                                '</a><div class="box-nav"><a href="#">' +
                                    '</a><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath.ToString())%>/portals/_default/skins/hammerflex/img/icon-map-purple.png" alt="" title="" class=""></a>' +
                                    (this.SourceUrl != "" ? '<a href="#" data-id="' + this.SourceUrl + '" onclick="goToUrlLink(this);return false;"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath.ToString())%>/portals/_default/skins/hammerflex/img/icon-tag.png" alt="" title="" class=""></a>' : '') +
                                    '<a href="' + this.Url + '">Find out more <i class="fa fa-angle-right"></i></a>' +
                                '</div>' +
                        '</div>'

                       );




               });

           });
    }

    function goToUrlLink(obj) {

        var win = window.open('http://' + obj.getAttribute('data-id'), '_blank');
        win.focus();
    }

    var TabId_ = "<%= this.TabId %>";
    loadWhatsNearby('<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath.ToString())%>/DesktopModules/WhatsNearby/API/ModuleWhatsNearby/GetNearby?TabId=' + TabId_);
    </script>

<section id="nearby" class="four-col-boxes">
    
    <div class="container">
    
        <div class="row">
        
            <div class="col-xs-12">
            
                <h2 class="title">What's Nearby</h2>
                <p class="desc">Fun is all around in this State. Find out what is happening around Sentosa.</p>
                
                <div class="box-slider">
                    
                    <div class="box-slider-container" id="container-nearby"> </div><!--/ .box-slider-container -->
                    
                </div><!--/ .box-slider -->
                
            </div><!--/ .col-xs-12 -->
        
        </div><!--/ .row -->
    
    </div><!--/ .container -->

</section>