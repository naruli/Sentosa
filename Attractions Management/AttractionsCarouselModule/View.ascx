<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.AttractionsCarouselModule.View" %>
<script type="text/javascript">
    function loadCarousel(url) {
        console.log(url);
        $.getJSON(
            url,
            function (result) {
                var parsedTaskJSONObject = jQuery.parseJSON(result);
                var counter = 0;
                $('#mainCarousel').html('');
                $('#mainCarousel').append(
                    '<ol class="carousel-indicators">' +
                    '</ol>'
                    );
                $('#mainCarousel').append(
                    '<div class="carousel-inner img-responsive" role="listbox">' +
                    '</div>'
                    );
                $.each(parsedTaskJSONObject, function () {
                    $('#mainCarousel .carousel-indicators').append(
                        '<li data-target="#mainCarousel" data-slide-to="' + counter + '" class="' + (counter == 0 ? "active" : "") + '"></li>'
                        );
                    $('#mainCarousel .carousel-inner').append(
                        '<div class="item' + (counter == 0 ? " active" : "") + '">' +
                           '<div class="item-image">' +
                               '<img src="' + this.PathImage + '" class="">' +
                           '</div>' +
                           '<div class="carousel-caption">' +
                               '<a href="#" class="close-caption">×</a>' +
                               '<div class="carousel-caption-inner orange">' +
                                   '<div class="caption-ornament cyan"></div>' +
                                   '<div class="caption-ornament yellow"></div>' +
                                   '<div class="content">' +
                                       '<h2 class="title">' + this.Caption + '</h2>' +
                                       '<p>' + this.Description + '</p>' +
                           //            '<a href="#" class="carousel-caption-btn">' + this.Link + '</a>' +
                                   '</div>' +
                               '</div>' +
                           '</div>' +
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
        loadCarousel('<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/AttractionsCarouselModule/API/ModuleCarousel/GetCarousel?Page=Attractions');
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
                    <li class="active"><a href="#">Attractions</a></li>
                </ul><!--/ .floating-breadcrumb -->
                
                <div id="mainCarousel" class="carousel slide" data-ride="carousel">
                
                </div>
            
            </div><!--/ .col-xs-12 -->
            
        </div><!--/ .row -->
    
    </div><!--/ .container-fluid -->

</section>