<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.DiningDetailCarouselModule.View" %>
<script type="text/javascript">
    function loadCarousel(url) {
        console.log(url);
        $.getJSON(
            url,
            function (result) {
                var parsedTaskJSONObject = jQuery.parseJSON(result);
                var counter = 0;
                $('#mainCarousel').html('');
                //$.each(parsedTaskJSONObject, function () {
                //    $('#mainCarousel').append(
                //        (counter == 0 ? '<ol class="carousel-indicators">' : '') +
                //        '<li data-target="#mainCarousel" data-slide-to="' + counter + '" class="' + (counter == 0 ? "active" : "") + '"></li>'
                //        );
                //    counter++;
                //});
                //$('#mainCarousel').append(
                //    '</ol>'
                //    );

                $('#mainCarousel').append(
                    '<div class="carousel-inner" role="listbox">' +
                    '</div>'
                    );
                $.each(parsedTaskJSONObject, function () {
                    $('#mainCarousel .carousel-inner').append(
                        '<div class="item' + (counter == 0 ? " active" : "") + '">' +
                           '<div class="item-image">' +
                               '<img src="' + this.PathImage + '" class="" style="max-width:100%;max-height:100%;min-width:100%;min-height:100%">' +
                           '</div>' +
                           //'<div class="carousel-caption">' +
                           //    '<a href="#" class="close-caption">×</a>' +
                           //    '<div class="carousel-caption-inner orange">' +
                           //        '<div class="caption-ornament cyan"></div>' +
                           //        '<div class="caption-ornament yellow"></div>' +
                           //        '<div class="content">' +
                           //            '<h2 class="title">' + this.Caption + '</h2>' +
                           //            '<p>' + this.Description + '</p>' +
                           //            '<a href="#" class="carousel-caption-btn">' + this.Link + '</a>' +
                           //        '</div>' +
                           //    '</div>' +
                           //'</div>' +
                        '</div>'
                        );
                    counter++;
                });
                if (counter > 1) {
                    $('#mainCarousel').append(
                        '<a class="left carousel-control" href="#mainCarousel" role="button" data-slide="prev">' +
                           '<img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/nav-slider-left.png" alt="Previous">' +
                            '<span class="sr-only">Previous</span>' +
                         '</a>' +
                         '<a class="right carousel-control" href="#mainCarousel" role="button" data-slide="next">' +
                            '<img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/nav-slider-right.png" alt="Next">' +
                            '<span class="sr-only">Next</span>' +
                         '</a>'
                         );
                }
                setCaption();
            });
        }
        function setCaption() {
            $('#mainCarousel a.close-caption').on('click', function () {
                $(this).toggleClass('hiding');
                $(this).next().stop().fadeToggle('medium', function () {
                    // $( this ).prev().toggleClass( 'hiding' );
                });
                return false;
            });
        }
        function loadDiningDetail(IdDetail) {
            $.getJSON(
              "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningDetailCarouselModule/API/ModuleCarousel/GetDiningDetail?id=" + IdDetail,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $.each(parsedTaskJSONObject, function () {
                   $('section#page-header ul.floating-breadcrumb li.active a').html(this.Title);
               });
           });
     }
     var Id = "<%=Request.QueryString["Id"]%>";
    loadCarousel('<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/DiningDetailCarouselModule/API/ModuleCarousel/GetCarousel?Page=DDetail' + Id);
    loadDiningDetail(Id);
</script>
<section id="page-header">

    <div class="container-fluid">
    
        <div class="row">
        
            <div class="col-xs-12 nopadding">
                
                <ul class="floating-breadcrumb">
                    <li><a href="#">Home</a></li>
                    <li>•</li>
                    <li><a href="#">Explore</a></li>
                    <li>•</li>
                    <li><a href="#">Dining</a></li>
                    <li>•</li>
                    <li class="active"><a href="#"></a></li>
                </ul><!--/ .floating-breadcrumb -->
                
                <div id="mainCarousel" class="carousel slide" data-ride="carousel">
                
                </div>
            
            </div><!--/ .col-xs-12 -->
            
        </div><!--/ .row -->
    
    </div><!--/ .container-fluid -->

</section>