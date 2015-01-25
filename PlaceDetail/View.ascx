<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.PlaceDetail.View" %>


<!-- DETAIL SUB MENU AND SUB PAGE-->
<script type="text/javascript">
    
    // Encode/decode htmlentities
    function krEncodeEntities(s){
        return $("<div/>").text(s).html();
    }
    function krDencodeEntities(s){
        return $("<div/>").html(s).text();
    }

    function GetPlaceDetail(url_) {
        $.getJSON(
           url_,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $.each(parsedTaskJSONObject, function () {
                   var html = "https://maps.googleapis.com/maps/api/staticmap?center=" + this.Lat + "," + this.Lng + "&amp;zoom=15&amp;size=320x240&amp;markers=color:red%7C" + this.Lat + "," + this.Lng;
                   //var html = "https://maps.googleapis.com/maps/api/staticmap?center=Palawan+Island,SG&amp;zoom=15&amp;size=320x240&amp;markers=color:red%7CPalawan+Island,SG";
                   //alert(html);
                   $('section#page-title h1').html(this.TabName);
                   $('section#page-title p').html('<img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-map-purple.png" alt="" title="" class="">&nbsp;' + this.TabName);
                   $('section.page-article aside a.overlay-open').html('<img src="' + html + '" class="map img-responsive">');
               });
           });
        }


    function GetGalleryDetail(url_) {
           $.getJSON(
              url_,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               var counter = 0;
               $('div#overlay-photos #overlayCarousel .carousel-inner').html('');
               $('div#overlay-photos .image-lists .image-lists-inner').html('');
               $.each(parsedTaskJSONObject, function () {
                   counter++;
                   $('div#overlay-photos #overlayCarousel .carousel-inner').append(
                        '<div class="item' + (counter == 1 ? " active" : "") + '">' +
                            '<img src="' + this.Url + '" alt="">' +
                            '<div class="carousel-caption">' + this.Url + '</div>' +
                        '</div><!--/.item -->'
                       );
                   $('div#overlay-photos .image-lists .image-lists-inner').append(
                        '<li><a href="#" class="" data-target="#overlayCarousel" data-item="' + counter + '"><img src="' + this.Url + '" alt=""></a></li>'
                       );
               });
               if (counter == 0) {
                   $('div#overlay-photos .overlay-inner').html('');
                   $('div#overlay-photos .overlay-inner').append(
                       '<h1 class="title">Gallery</h1>'
                       );
               }
               else if (counter > 1) {
                   $('div#overlay-photos #overlayCarousel').append(
                        '<a class="left carousel-control" href="#overlayCarousel" role="button" data-slide="prev">' +
                            '<img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/nav-slider-left.png" alt="">' +
                        '</a>' +
                        '<a class="right carousel-control" href="#overlayCarousel" role="button" data-slide="next">' +
                            '<img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/nav-slider-right.png" alt="">' +
                        '</a>'
                       );
                   setGallery();
               }
           });
   }

    function GetSubMenuPageDetail(url_) {
       $.getJSON(
            url_,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               var counter = 0;
               $('nav.sub-nav ul').html('');
               $('section.page-article article').html('');
               $.each(parsedTaskJSONObject, function () {
                   $('nav.sub-nav ul').append(
                       '<li id="' + counter + '" class="' + (counter == 0 ? "active" : "") + '"><a href="#" onclick="showSection(this);return false;">' + this.Title + '</a></li>'
                       );
                   $('section.page-article article').append(
                       '<div id="' + counter + '" style="display:' + (counter == 0 ? "block" : "none") + '">' +
                       (this.Description != null ? krDencodeEntities(this.Description) : '') +
                       (this.AdmissionInfo != null ? krDencodeEntities(this.AdmissionInfo) : '') +
                       (this.OpeningHour != null ? '<p>Opening Hours : ' + this.OpeningHour + '</p>' : '') +
                       (this.Price != null ? '<p>Pricing : ' + this.Price + '</p>' : '') +
                       (this.Instruction != null ? krDencodeEntities(this.Instruction) : '') +
                       (this.NatureGuidedTours != null ? krDencodeEntities(this.NatureGuidedTours) : '') +
                       '</div>'
                       );
                   counter++;
               });
               if (counter == 0) {
                   $('nav.sub-nav ul').append(
                       '<li class=""><a href="#">&nbsp;</a></li>'
                       );
               }
           });
    }

    function showSection(obj) {
        var currentId = $(obj).parent().attr('id');
        $('nav.sub-nav ul li').each(function (index, value) {
            var dataId = $(this).attr('id');
            if (currentId == dataId) {
                $(this).addClass('active');
            } else {
                $(this).removeClass('active');
            }
        });
        $('section.page-article article div').each(function (index, value) {
            var dataId = $(this).attr('id');
            if (currentId == dataId) {
                $(this).css('display', 'block');
            } else {
                $(this).css('display', 'none');
            }
        });
    }

    function setGallery() {
        /* Carousel custom navigation */
        if ($('#overlay-photos .image-lists').length > 0) {
            $('#overlay-photos .image-lists > ul.image-lists-inner > li > a').each(function (index, value) {
                $(this).on('click', function () {
                    var dataTarget = $(this).attr('data-target') + '.carousel';
                    var dataItem = $(this).attr('data-item');
                    var newCaption = '';

                    if ($('' + dataTarget).length > 0) {
                        $(dataTarget).carousel(1 * (dataItem - 1));
                    }
                    return false;
                });
            });
        }
        /* Carousel custom caption */
        $('#overlayCarousel').on('slid.bs.carousel', function (relatedTarget) {
            var theCaption = $('#overlay-photos .carousel-inner > .item.active > .carousel-caption');
            var newCaption = theCaption.html();
            theCaption.stop().fadeOut('fast', function () {
                $('#overlay-photos > .overlay-box > .overlay-inner .share > p').html(newCaption);
                $('#overlay-photos > .overlay-box > .overlay-inner .share > p').stop().fadeIn('fast');
            });
        });

        /* Carousel toggle autoplay */
        if ($('#overlay-photos a.overlay-toggle').length > 0) {
            $('#overlay-photos a.overlay-toggle').each(function (index, value) {
                $(this).on('click', function () {
                    var dataTarget = $(this).attr('data-target') + '.carousel';
                    if ($(dataTarget).length > 0) {
                        if (!$(this).hasClass('toggle')) {
                            $(dataTarget).carousel({ interval: 500, pause: false });
                            $(this).addClass('toggle');
                            $(this).html('<i class="fa fa-stop"></i> Stop slideshow');
                        }
                        else {
                            $(dataTarget).carousel({ interval: false, pause: 'hover' });
                            $(this).removeClass('toggle');
                            $(this).html('<i class="fa fa-play"></i> Play slideshow');
                        }
                    }
                    return false;
                });
            });
        }

    }
   
    //GetPlaceDetail(Id);
    //GetGalleryDetail(Id);
    //GetSubMenuPageDetail(Id);
</script>
<section id="page-title">
    <div class="container">
        <div class="row">
            <div class="col-xs-10">
                <p></p>
                <h1></h1>
            </div><!--/ .col-xs-12 -->
            <div class="col-xs-2">
                <a href="#" class="icon overlay-open" data-target="overlay-photos"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-title-photos.png"></a>
            </div><!--/ .col-xs-2 -->
        </div><!--/ .row -->
    </div><!--/ .container -->
</section><!--/ #page-title -->
<nav class="sub-nav">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <ul>
                    <%--<li class="active"><a href="#">Overview</a></li>
                    <li><a href="#">Tickets</a></li>
                    <li><a href="#">Visitor Informations</a></li>--%>
                </ul>
            </div><!--/ .col-xs-12 -->
        </div><!--/ .row -->
    </div><!--/ .container -->
</nav><!--/ .sub-nav -->
<section class="page-article">
    <div class="container">
        <div class="row">
            <article class="col-xs-12 col-md-9">
                <%--<p>Surrounded with lush tropical greenery, Butterfly Park &amp; Insect Kingdom showcases the stunning beauties of mother nature. With a great variety of fluttering butterflies and exotic insects, this tamed wilderness is sure to delight you. </p>
                <p><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/article-img.jpg" alt="" title="" align="left">A must-see outdoor experience for children, tourists and nature lovers alike, Butterfly Park &amp; Insect Kingdom has wowed visitors from all over the world. With the scents, sights and sounds of an authentic tropical rainforest, it's a multi-sensory, interactive experience that's guaranteed to engage you from start to finish.</p>
                <p>Ready to experience the wild life? Visit <a href="#">www.jungle.com.sg</a> to get a headstart!</p>--%>
            </article>
            <aside class="col-xs-12 col-md-3">
                <ul class="sidebar-nav">
                    <li class="social">
                        <img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/dummy-social.jpg" alt="" title="" class="">
                    </li>
                    <li><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-dollar.png" alt="" title="" class=""> Buy tickets</a></li>
                    <li><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-itinerary.png" alt="" title="" class=""> Add to Itinerary</a></li>
                    <li><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-print.png" alt="" title="" class=""> Print</a></li>
                    <li><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-share.png" alt="" title="" class=""> Share</a></li>
                </ul><!--/ .sidebar-nav -->
                <a href="#" class="overlay-open" data-target="overlay-map">
                    <%--<img src="https://maps.googleapis.com/maps/api/staticmap?center=Palawan+Island,SG&amp;zoom=15&amp;size=320x240&amp;markers=color:red%7CPalawan+Island,SG" class="map img-responsive">--%>
                </a>
            </aside>
        </div><!--/ .row -->
    </div><!--/ .container -->
</section><!--/ #page-article -->
<div class="overlay" id="overlay-map" style="display: none;">
    <div class="overlay-box">
        <a href="#" class="overlay-close"></a>
        <div class="overlay-inner">
            <h1 class="title">Map</h1>
            <div id="map-canvas" style="position: relative; overflow: hidden; transform: translateZ(0px); background-color: rgb(229, 227, 223);"><div class="gm-style" style="position: absolute; left: 0px; top: 0px; overflow: hidden; width: 100%; height: 100%; z-index: 0;"><div style="position: absolute; left: 0px; top: 0px; overflow: hidden; width: 100%; height: 100%; z-index: 0; cursor: url(https://maps.gstatic.com/mapfiles/openhand_8_8.cur) 8 8, default;"><div style="position: absolute; left: 0px; top: 0px; z-index: 1; width: 100%; transform-origin: 0px 0px 0px; transform: matrix(1, 0, 0, 1, 0, 0);"><div style="transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 100; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div style="position: absolute; left: 0px; top: 0px; z-index: 1;"><div style="width: 256px; height: 256px; transform: translateZ(0px); position: absolute; left: -141px; top: -236px;"></div><div style="width: 256px; height: 256px; transform: translateZ(0px); position: absolute; left: -141px; top: 20px;"></div></div></div></div><div style="transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 101; width: 100%;"></div><div style="transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 102; width: 100%;"></div><div style="transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 103; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: -1;"><div style="position: absolute; left: 0px; top: 0px; z-index: 1;"><div style="width: 256px; height: 256px; overflow: hidden; transform: translateZ(0px); position: absolute; left: -141px; top: -236px;"></div><div style="width: 256px; height: 256px; overflow: hidden; transform: translateZ(0px); position: absolute; left: -141px; top: 20px;"></div></div></div></div><div style="position: absolute; z-index: 0; left: 0px; top: 0px;"><div style="overflow: hidden;"></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div style="position: absolute; left: 0px; top: 0px; z-index: 1;"><div style="width: 256px; height: 256px; transform: translateZ(0px); position: absolute; left: -141px; top: -236px;"><img src="https://mts1.googleapis.com/vt?pb=!1m4!1m3!1i16!2i61177!3i41980!2m3!1e0!2sm!3i285000000!3m9!2sid-ID!3sUS!5e18!12m1!1e47!12m3!1e37!2m1!1ssmartmaps!4e0" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; transform: translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px);"></div><div style="width: 256px; height: 256px; transform: translateZ(0px); position: absolute; left: -141px; top: 20px;"><img src="https://mts1.googleapis.com/vt?pb=!1m4!1m3!1i16!2i61177!3i41981!2m3!1e0!2sm!3i285000000!3m9!2sid-ID!3sUS!5e18!12m1!1e47!12m3!1e37!2m1!1ssmartmaps!4e0" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; transform: translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px) translateZ(0px);"></div></div></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 2; width: 100%; height: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 3; width: 100%; transform-origin: 0px 0px 0px; transform: matrix(1, 0, 0, 1, 0, 0);"><div style="transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 104; width: 100%;"></div><div style="transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 105; width: 100%;"></div><div style="transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 106; width: 100%;"></div><div style="transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 107; width: 100%;"></div></div></div><div style="margin-left: 5px; margin-right: 5px; z-index: 1000000; position: absolute; left: 0px; bottom: 0px;"><a target="_blank" href="http://maps.google.com/maps?ll=-45.077092,156.058329&amp;z=16&amp;t=m&amp;hl=id-ID&amp;gl=US&amp;mapclient=apiv3" title="Klik untuk melihat area ini di Google Maps" style="position: static; overflow: visible; float: none; display: inline;"><div style="width: 62px; height: 26px; cursor: pointer;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/google_white2.png" draggable="false" style="position: absolute; left: 0px; top: 0px; width: 62px; height: 26px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div></a></div><div class="gmnoprint" style="z-index: 1000001; position: absolute; right: 100px; bottom: 0px; width: 12px;"><div draggable="false" class="gm-style-cc" style="-webkit-user-select: none;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="width: auto; height: 100%; margin-left: 1px; background-color: rgb(245, 245, 245);"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right;"><a style="color: rgb(68, 68, 68); text-decoration: none; cursor: pointer; display: none;">Data Peta</a><span style="display: none;"></span></div></div></div><div style="padding: 15px 21px; border: 1px solid rgb(171, 171, 171); font-family: Roboto, Arial, sans-serif; color: rgb(34, 34, 34); -webkit-box-shadow: rgba(0, 0, 0, 0.2) 0px 4px 16px; box-shadow: rgba(0, 0, 0, 0.2) 0px 4px 16px; z-index: 10000002; display: none; width: 0px; height: 0px; position: absolute; left: 5px; top: 5px; background-color: white;"><div style="padding: 0px 0px 10px; font-size: 16px;">Data Peta</div><div style="font-size: 13px;"></div><div style="width: 13px; height: 13px; overflow: hidden; position: absolute; opacity: 0.7; transform: translateZ(0px); right: 12px; top: 12px; z-index: 10000; cursor: pointer;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/mapcnt3.png" draggable="false" style="position: absolute; left: -2px; top: -336px; width: 59px; height: 492px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div></div><div class="gmnoscreen" style="position: absolute; right: 0px; bottom: 0px;"><div style="font-family: Roboto, Arial, sans-serif; font-size: 11px; color: rgb(68, 68, 68); direction: ltr; text-align: right; background-color: rgb(245, 245, 245);"></div></div><div class="gmnoprint gm-style-cc" draggable="false" style="z-index: 1000001; position: absolute; -webkit-user-select: none; right: 0px; bottom: 0px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="width: auto; height: 100%; margin-left: 1px; background-color: rgb(245, 245, 245);"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right;"><a href="http://www.google.com/intl/id-ID_US/help/terms_maps.html" target="_blank" style="text-decoration: none; cursor: pointer; color: rgb(68, 68, 68);">Syarat Penggunaan</a></div></div><div draggable="false" class="gm-style-cc" style="-webkit-user-select: none; display: none; position: absolute; right: 0px; bottom: 0px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="width: auto; height: 100%; margin-left: 1px; background-color: rgb(245, 245, 245);"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right;"><a target="_new" title="Laporkan kesalahan dalam peta jalan atau citra ke Google" href="https://www.google.com/maps/@-45.077092,156.058329,16z/data=!10m1!1e1!12b1?source=apiv3" style="font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); text-decoration: none; position: relative;">Laporkan kesalahan peta</a></div></div><div class="gmnoprint" draggable="false" controlwidth="32" controlheight="84" style="margin: 5px; -webkit-user-select: none; position: absolute; left: 0px; top: 0px;"><div controlwidth="32" controlheight="40" style="cursor: url(https://maps.gstatic.com/mapfiles/openhand_8_8.cur) 8 8, default; position: absolute; left: 0px; top: 0px;"><div style="width: 32px; height: 40px; overflow: hidden; position: absolute; left: 0px; top: 0px;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/cb_scout2.png" draggable="false" style="position: absolute; left: -9px; top: -102px; width: 1028px; height: 214px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div><div style="width: 32px; height: 40px; overflow: hidden; position: absolute; left: 0px; top: 0px; visibility: hidden;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/cb_scout2.png" draggable="false" style="position: absolute; left: -107px; top: -102px; width: 1028px; height: 214px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div><div style="width: 32px; height: 40px; overflow: hidden; position: absolute; left: 0px; top: 0px; visibility: hidden;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/cb_scout2.png" draggable="false" style="position: absolute; left: -58px; top: -102px; width: 1028px; height: 214px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div><div style="width: 32px; height: 40px; overflow: hidden; position: absolute; left: 0px; top: 0px; visibility: hidden;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/cb_scout2.png" draggable="false" style="position: absolute; left: -205px; top: -102px; width: 1028px; height: 214px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div></div><div class="gmnoprint" controlwidth="0" controlheight="0" style="opacity: 0.6; display: none; position: absolute;"><div title="Putar peta 90 derajat" style="width: 22px; height: 22px; overflow: hidden; position: absolute; cursor: pointer;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/mapcnt3.png" draggable="false" style="position: absolute; left: -38px; top: -360px; width: 59px; height: 492px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div></div><div class="gmnoprint" controlwidth="20" controlheight="39" style="position: absolute; left: 6px; top: 45px;"><div style="width: 20px; height: 39px; overflow: hidden; position: absolute;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/mapcnt3.png" draggable="false" style="position: absolute; left: -39px; top: -401px; width: 59px; height: 492px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div><div title="Perbesar" style="position: absolute; left: 0px; top: 2px; width: 20px; height: 17px; cursor: pointer;"></div><div title="Perkecil" style="position: absolute; left: 0px; top: 19px; width: 20px; height: 17px; cursor: pointer;"></div></div></div><div class="gmnoprint gm-style-mtc" style="margin: 5px; z-index: 0; position: absolute; cursor: pointer; text-align: left; width: 85px; right: 0px; top: 0px;"><div draggable="false" title="Ubah gaya peta" style="direction: ltr; overflow: hidden; text-align: left; position: relative; color: rgb(0, 0, 0); font-family: Roboto, Arial, sans-serif; -webkit-user-select: none; font-size: 11px; padding: 1px 6px; border-radius: 2px; -webkit-background-clip: padding-box; border: 1px solid rgba(0, 0, 0, 0.14902); -webkit-box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; font-weight: 500; background-color: rgb(255, 255, 255); background-clip: padding-box;">Peta<img src="https://maps.gstatic.com/mapfiles/arrow-down.png" draggable="false" style="-webkit-user-select: none; border: 0px; padding: 0px; margin: -2px 0px 0px; position: absolute; right: 6px; top: 50%; width: 7px; height: 4px;"></div><div style="z-index: -1; padding-top: 2px; -webkit-background-clip: padding-box; border-width: 0px 1px 1px; border-right-style: solid; border-bottom-style: solid; border-left-style: solid; border-right-color: rgba(0, 0, 0, 0.14902); border-bottom-color: rgba(0, 0, 0, 0.14902); border-left-color: rgba(0, 0, 0, 0.14902); -webkit-box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; position: relative; text-align: left; display: none; background-color: white; background-clip: padding-box;"><div draggable="false" title="Tunjukkan peta jalan" style="color: rgb(86, 86, 86); font-family: Roboto, Arial, sans-serif; -webkit-user-select: none; font-size: 11px; padding: 3px; font-weight: 500; background-color: rgb(255, 255, 255);">Peta</div><div draggable="false" title="Tunjukkan citra satelit" style="color: rgb(86, 86, 86); font-family: Roboto, Arial, sans-serif; -webkit-user-select: none; font-size: 11px; padding: 3px; background-color: rgb(255, 255, 255);">Satelit</div><div style="margin: 1px 0px; border-top-width: 1px; border-top-style: solid; border-top-color: rgb(235, 235, 235);"></div><div draggable="false" title="Perkecil untuk melihat peta jalan dengan medan" style="color: rgb(184, 184, 184); font-family: Roboto, Arial, sans-serif; -webkit-user-select: none; font-size: 11px; padding: 3px 8px 3px 3px; direction: ltr; text-align: left; white-space: nowrap; background-color: rgb(255, 255, 255);"><span role="checkbox" style="box-sizing: border-box; position: relative; line-height: 0; font-size: 0px; margin: 0px 5px 0px 0px; display: inline-block; border: 1px solid rgb(241, 241, 241); border-radius: 1px; width: 13px; height: 13px; vertical-align: middle; background-color: rgb(255, 255, 255);"><div style="position: absolute; left: 1px; top: -2px; width: 13px; height: 11px; overflow: hidden; display: none;"><img src="https://maps.gstatic.com/mapfiles/mv/imgs8.png" draggable="false" style="position: absolute; left: -52px; top: -44px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; width: 68px; height: 67px;"></div></span><label style="vertical-align: middle; cursor: pointer;">Medan</label></div><div style="margin: 1px 0px; border-top-width: 1px; border-top-style: solid; border-top-color: rgb(235, 235, 235); display: none;"></div><div draggable="false" title="Perbesar untuk melihat tampilan 45 derajat" style="color: rgb(184, 184, 184); font-family: Roboto, Arial, sans-serif; -webkit-user-select: none; font-size: 11px; padding: 3px 8px 3px 3px; direction: ltr; text-align: left; white-space: nowrap; display: none; background-color: rgb(255, 255, 255);"><span role="checkbox" style="box-sizing: border-box; position: relative; line-height: 0; font-size: 0px; margin: 0px 5px 0px 0px; display: inline-block; border: 1px solid rgb(241, 241, 241); border-radius: 1px; width: 13px; height: 13px; vertical-align: middle; background-color: rgb(255, 255, 255);"><div style="position: absolute; left: 1px; top: -2px; width: 13px; height: 11px; overflow: hidden; display: none;"><img src="https://maps.gstatic.com/mapfiles/mv/imgs8.png" draggable="false" style="position: absolute; left: -52px; top: -44px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; width: 68px; height: 67px;"></div></span><label style="vertical-align: middle; cursor: pointer;">45°</label></div><div draggable="false" title="Tunjukkan citra dengan nama jalan" style="color: rgb(0, 0, 0); font-family: Roboto, Arial, sans-serif; -webkit-user-select: none; font-size: 11px; padding: 3px 8px 3px 3px; direction: ltr; text-align: left; white-space: nowrap; display: none; background-color: rgb(255, 255, 255);"><span role="checkbox" style="box-sizing: border-box; position: relative; line-height: 0; font-size: 0px; margin: 0px 5px 0px 0px; display: inline-block; border: 1px solid rgb(198, 198, 198); border-radius: 1px; width: 13px; height: 13px; vertical-align: middle; background-color: rgb(255, 255, 255);"><div style="position: absolute; left: 1px; top: -2px; width: 13px; height: 11px; overflow: hidden;"><img src="https://maps.gstatic.com/mapfiles/mv/imgs8.png" draggable="false" style="position: absolute; left: -52px; top: -44px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; width: 68px; height: 67px;"></div></span><label style="vertical-align: middle; cursor: pointer;">Label</label></div></div></div></div></div>
            <a class="overlay-nav pull-right">View full map <i class="fa fa-angle-right"></i></a>
            <div class="clearfix"></div>
        </div><!--/ .overlay-inner -->
    </div><!--/ .overlay-box -->
</div>
<div class="overlay" id="overlay-photos" style="display: none;">
    <div class="overlay-box">
        <a href="#" class="overlay-close"></a>
        <div class="overlay-inner">
            <h1 class="title">Gallery</h1>
            <div id="overlayCarousel" class="carousel slide" data-ride="carousel" data-interval="false">
                <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox">
                </div>
                <!-- Controls -->
            </div><!--/ .carousel -->
            <div class="share">
                <p class="pull-left"></p>
                <a href="#" class="pull-right"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-share.png" alt="" title=""> Share</a>
                <div class="clearfix"></div>
            </div><!--/ .share -->
            <div class="image-lists">
                <ul class="image-lists-inner">
                </ul><!--/ .image-lists-inner -->
            </div><!--/ .image-lists --> 
            <a class="overlay-nav overlay-toggle pull-left" data-target="#overlayCarousel"><i class="fa fa-play"></i> Play slideshow</a>
            <div class="clearfix"></div>
        </div><!--/ .overlay-inner -->
    </div><!--/ .overlay-box -->
</div>