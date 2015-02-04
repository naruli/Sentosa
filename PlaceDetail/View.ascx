<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.PlaceDetail.View" %>


<!-- DETAIL SUB MENU AND SUB PAGE-->
<script type="text/javascript">
    var this_latitude = 0;
    var this_longitude = 0;
    var this_tabname = "";
    var this_urlParent = "#";


    // Encode/decode htmlentities
    function krEncodeEntities(s) {
        return $("<div/>").text(s).html();
    }
    function krDencodeEntities(s) {
        return $("<div/>").html(s).text();
    }

    function GetPlaceDetail(url_) {
        $.getJSON(
           url_,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $.each(parsedTaskJSONObject, function () {

                   this_latitude = this.Lat;
                   this_longitude = this.Lng;
                   this_tabname = this.TabName;
                   this_urlParent = this.UrlParentId + "/showMap/yes";


                   var html = "https://maps.googleapis.com/maps/api/staticmap?center=" + this.Lat + "," + this.Lng + "&amp;zoom=15&amp;size=320x240&amp;markers=color:red%7C" + this.Lat + "," + this.Lng;
                   $('section#page-title h1').html(this.TabName);
                   $('section#page-title p').html('<img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-map-purple.png" alt="" title="" class="">&nbsp;' + this.Address);
                   $('section.page-article aside a.overlay-open').html('<img src="' + html + '" class="map img-responsive">Click to view location map');
                   if (this.SourceUrl != "" && this.SourceUrl != null) {
                       $('section.page-article aside ul.sidebar-nav li.buy a').attr('href', (this.SourceUrl.indexOf('http') > -1 ? this.SourceUrl : 'http://' + this.SourceUrl));
                       $('section.page-article aside ul.sidebar-nav li.buy a').attr('target', '_blank');
                       $('section.page-article aside ul.sidebar-nav li.buy').show();
                   }
                   else {
                       $('section.page-article aside ul.sidebar-nav li.buy').hide();
                   }
                   $('section.page-article aside ul.sidebar-nav li.social').hide();
                   $('section.page-article aside ul.sidebar-nav li.plan').hide();
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
                   $('section#page-title .overlay-open').hide();
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
          <article class="col-xs-12 col-md-9" style="z-index:1;">
                <%--<p>Surrounded with lush tropical greenery, Butterfly Park &amp; Insect Kingdom showcases the stunning beauties of mother nature. With a great variety of fluttering butterflies and exotic insects, this tamed wilderness is sure to delight you. </p>
                <p><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/article-img.jpg" alt="" title="" align="left">A must-see outdoor experience for children, tourists and nature lovers alike, Butterfly Park &amp; Insect Kingdom has wowed visitors from all over the world. With the scents, sights and sounds of an authentic tropical rainforest, it's a multi-sensory, interactive experience that's guaranteed to engage you from start to finish.</p>
                <p>Ready to experience the wild life? Visit <a href="#">www.jungle.com.sg</a> to get a headstart!</p>--%>
            </article>
          <aside class="col-xs-12 col-md-3" style="z-index:1;margin-bottom:0;">
                <ul class="sidebar-nav">
                    <li class="social" >
                        <img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/dummy-social.jpg" alt="" title="" class="">
                    </li>
                    <li class="buy"><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-dollar.png" alt="" title="" class=""> Buy tickets</a></li>
                    <li class="plan"><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-itinerary.png" alt="" title="" class=""> Add to Itinerary</a></li>
                    <li class="print"><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-print.png" alt="" title="" class=""> Print</a></li>
                    <li class="share"><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-share.png" alt="" title="" class=""> Share</a></li>
                </ul><!--/ .sidebar-nav -->
                <a href="#" class="overlay-open" data-target="overlay-map" style="z-index:1;" onclick="refreshMap();return false;">
                    
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
          <div id="map-canvas" style="position: relative; overflow: hidden; transform: translateZ(0px); background-color: rgb(229, 227, 223);"></div>
            <a class="overlay-nav pull-right" onclick="goToUrlParentLink();return false;">View full map <i class="fa fa-angle-right"></i></a>
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
<script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
<script src="<%= Request.Url.GetLeftPart(UriPartial.Authority)%>/Portals/_default/Skins/HammerFlex/js/jquery.geocomplete.min.js">
</script>
<script type="text/javascript">
    var status_refresh = false;
    function refreshMap() {
        // This is the minimum zoom level that we'll allow
        console.log('action refreh map');

        if (status_refresh == true) { return false; }

        status_refresh = true;

        $('#map-canvas').html("");//initialize map
        var center_latlng = new google.maps.LatLng(1.249404, 103.830321);
        if (this_latitude != 0 && this_longitude != 0) {
            center_latlng = new google.maps.LatLng(this_latitude, this_longitude);
        }


        var map = new google.maps.Map(document.getElementById('map-canvas'), {
            zoom: 17,
            scrollwheel: false,
            center: center_latlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });


        //Set Strict Bound
        var strictBounds = new google.maps.LatLngBounds(
          new google.maps.LatLng(1.23884941, 103.8163305),
          new google.maps.LatLng(1.25772768, 103.84328133)
        );



        // Listen for the dragend event
        google.maps.event.addListener(map, 'dragend', function () {
            if (strictBounds.contains(map.getCenter())) return;

            // We're out of bounds - Move the map back within the bounds

            var c = map.getCenter(),
                x = c.lng(),
                y = c.lat(),
                maxX = strictBounds.getNorthEast().lng(),
                maxY = strictBounds.getNorthEast().lat(),
                minX = strictBounds.getSouthWest().lng(),
                minY = strictBounds.getSouthWest().lat();

            if (x < minX) x = minX;
            if (x > maxX) x = maxX;
            if (y < minY) y = minY;
            if (y > maxY) y = maxY;

            map.setCenter(new google.maps.LatLng(y, x));
        });

        // Limit the zoom level
        google.maps.event.addListener(map, 'zoom_changed', function () {
            if (map.getZoom() < 10) map.setZoom(10);
        });


        //add marker
        if (this_latitude != 0 && this_longitude != 0) {

            var myLatlng = new google.maps.LatLng(this_latitude, this_longitude);

            var marker = new google.maps.Marker({
                position: myLatlng,
                map: map,
                title: this_tabname
            });
        }
    }

    function goToUrlParentLink() {

        var win = window.open(this_urlParent, '_blank');
        window.opener.close();
        win.focus();
    }

   </script>