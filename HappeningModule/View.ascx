<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.HappeningModule.View" %>
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
    function loadHappening(url) {
        //console.log(url);
        $.getJSON(
           url,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               var counter = 0;
               var row = 0;
               $('#happeningCarousel').html('');
               $('#happeningCarousel').append(
                        '<ol class="carousel-indicators">' +
                        '</ol>'
                    );
               $('#happeningCarousel').append(
                        '<div class="carousel-inner" role="listbox">' +
                        '</div>'
                    );
               $.each(parsedTaskJSONObject, function () {
                   if (counter % 4 == 0) {
                       row++;
                       $('#happeningCarousel .carousel-indicators').append(
                            '<li data-target="#happeningCarousel" data-slide-to="' + (row - 1) + '" class="' + ((row - 1) == 0 ? "active" : "") + '"></li>'
                        );
                       $('#happeningCarousel .carousel-inner').append(
                           '<div class="item' + (counter == 0 ? " active" : "") + '">' +
                                '<div class="row" id="' + row + '">' +
                                '</div>' +
                            '</div>'
                           );
                   }
                   var shortDesc = krDencodeEntities(this.ContentDetail.ShortDescription);
                   $('#happeningCarousel .carousel-inner .item #'+ row).append(
                       '<div class="col-xs-12 col-sm-6 col-md-3">' +
                           '<div class="box-item">' +
                               '<a href="' + this.ContentDetail.Url + '">' +
                                  '<img src="' + this.ContentDetail.Photo + '" alt="" title="" class="">' +
                                   '<div class="box-content">' +
                                       '<h3>' + this.ContentDetail.TabName + '</h3>' +
                                       '<p>' + shortDesc.trunc(150, true) + '</p>' +
                                   '</div>' +
                                '</a>' +
                                   '<div class="box-nav"><a href="#">' +
                                       '</a><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath.ToString())%>/portals/_default/skins/hammerflex/img/icon-map.png" alt="" title="" class=""></a>' +
                                       (this.ContentDetail.SourceUrl != "" ? '<a href="' + this.ContentDetail.SourceUrl + '" target="_blank"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath.ToString())%>/portals/_default/skins/hammerflex/img/icon-tag.png" alt="" title="" class=""></a>' : '') +
                                       '<a href="' + this.ContentDetail.Url + '">Find out more <i class="fa fa-angle-right"></i></a>' +
                                   '</div>' +
                           '</div>' +
                       '</div>'
                       );
                   counter++;
               });
               if (counter > 4) {
                   $('#happeningCarousel').append(
                       '<a class="left carousel-control" href="#happeningCarousel" role="button" data-slide="prev"></a>' +
                       '<a class="right carousel-control" href="#happeningCarousel" role="button" data-slide="next"></a>'
                       );
               }
           });
       }
       loadHappening('<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath.ToString())%>/DesktopModules/HappeningModule/API/ModuleHappening/GetHappening?TabId=<%=this.TabId%>');
</script>
<section id="happening-alt">

    <div class="container">
    
        <div class="circle left"></div>
        <div class="circle right"></div>
    
        <div class="row">
            
            <div class="col-xs-12">
            
                <h2 class="title" id="Header" runat="server"></h2>
                <p class="desc" id="Description" runat="server"></p>

                <div id="happeningCarousel" class="carousel slide" data-ride="carousel">
                    
                </div>
                
            </div><!--/ .col-xs-12 -->
            
        </div><!--/ .row -->
        
    </div><!--/ .container -->
    
</section>