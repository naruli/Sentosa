<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.HappeningModule.View" %>
<script type="text/javascript">
    function loadHappening(url) {
        //console.log(url);
        $.getJSON(
           url,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               var counter = 0;
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
                       $('#happeningCarousel .carousel-indicators').append(
                            '<li data-target="#happeningCarousel" data-slide-to="' + counter + '" class="' + (counter == 0 ? "active" : "") + '"></li>'
                        );
                       $('#happeningCarousel .carousel-inner').append(
                           '<div class="item' + (counter == 0 ? " active" : "") + '">' +
                                '<div class="row">' +
                                '</div>' +
                            '</div>'
                           );
                   }

                   $('#happeningCarousel .carousel-inner .item .row').append(
                       '<div class="col-xs-12 col-sm-6 col-md-3">' +
                           '<div class="box-item">' +
                               '<a href="' + (this.TypeIdRef == "P_EVENT" ? "<%=Request.Url.GetLeftPart(UriPartial.Authority)%>/State-Specials/Events/Details?Id=" + this.IdRef : "<%=Request.Url.GetLeftPart(UriPartial.Authority)%>/State-Specials/Promotions/Details?Id=" + this.IdRef) + '">' +
                                  '<img src="' + this.ContentDetail.PathImageThumb + '" alt="" title="" class="">' +
                                   '<div class="box-content">' +
                                       '<h3>' + this.ContentDetail.Title + '</h3>' +
                                       '<p>' + this.ContentDetail.ShortDesc + '</p>' +
                                   '</div>' +
                                '</a>' +
                                   '<div class="box-nav"><a href="#">' +
                                       '</a><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath.ToString())%>/portals/_default/skins/hammerflex/img/icon-map.png" alt="" title="" class=""></a>' +
                                       (this.ContentDetail.UrlPurchase != "" ? '<a href="' + this.ContentDetail.UrlPurchase + '" target="_blank"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath.ToString())%>/portals/_default/skins/hammerflex/img/icon-tag.png" alt="" title="" class=""></a>' : '') +
                                       '<a href="' + (this.TypeIdRef == "P_EVENT" ? "<%=Request.Url.GetLeftPart(UriPartial.Authority)%>/State-Specials/Events/Details?Id=" + this.IdRef : "<%=Request.Url.GetLeftPart(UriPartial.Authority)%>/State-Specials/Promotions/Details?Id=" + this.IdRef) + '">Find out more <i class="fa fa-angle-right"></i></a>' +
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
       loadHappening('<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath.ToString())%>/DesktopModules/HappeningModule/API/ModuleHappening/GetHappening');
</script>
<section id="happening-alt">

    <div class="container">
    
        <div class="circle left"></div>
        <div class="circle right"></div>
    
        <div class="row">
            
            <div class="col-xs-12">
            
                <h2 class="title">Something special happening in the State</h2>
                <p class="desc">Fun is all around in this State. Find out what is happening around Sentosa.</p>

                <div id="happeningCarousel" class="carousel slide" data-ride="carousel">
                    
                </div>
                
            </div><!--/ .col-xs-12 -->
            
        </div><!--/ .row -->
        
    </div><!--/ .container -->
    
</section>