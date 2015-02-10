<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.FindFun.View" %>
<script type="text/javascript">
    // Encode/decode htmlentities
    String.prototype.trunc =
     function (n, useWordBoundary) {
         var toLong = this.length > n,
             s_ = toLong ? this.substr(0, n - 1) : this;
         s_ = useWordBoundary && toLong ? s_.substr(0, s_.lastIndexOf(' ')) : s_;
         return toLong ? s_ + '&hellip;' : s_;
     };
    function krEncodeEntities(s) {
        return $("<div/>").text(s).html();
    }
    function krDencodeEntities(s) {
        return $("<div/>").html(s).text();
    }
    $(document).ready(function () {
        var searchValue = "<%=(Request.Params["keywords"] != null ? Request.Params["keywords"].ToString() : "") %>";
        var list = "<%=(Request.Params["list"] != null ? Request.Params["list"].ToString() : "0") %>";

        $('#keywords').attr('placeholder', 'Search All Activities');
        listPlace(list);

        $('#keywords').val(searchValue);

        console.log("search value: " + searchValue);
        console.log("list: " + list);

    });

    function listPlace(paramList) {
        $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/FindFun/API/ModuleFindFun/getListPage",
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               var counter = 0;
               $('.form-filter').html('');
               $('.form-filter').append(
                    '<div class="col-xs-2 col-md-1">' +
                        '<div class="checkbox-wrapper">' +
                            '<label><input type="checkbox" id="0" onclick="searchByTag(this);"><span>All</span></label>' +
                        '</div>' +
                    '</div>' +
                    '<div id="interestList" class="col-xs-10 col-md-11">' +
                    '</div>'
                   );
               $.each(parsedTaskJSONObject, function () {
                   $('#interestList').append(
                            '<div class="checkbox-wrapper">' +
                                '<label><input type="checkbox" id="' + this.TabID + '" onclick="searchByTag(this);"><span>' + this.TabName + '</span></label>' +
                            '</div>'
                       );
                   counter++;
               });
               setList();
               var eachList = paramList.split(',');
               if (eachList[0] != "") {
                   $('.tag-lists').html('');
                   for (index = 0; index < eachList.length; index++) {
                       var dataId = eachList[index];
                       var dataText = $('#' + dataId).parent().find('span').html();
                       $('.tag-lists').html($('.tag-lists').html() + '<div class="item" data-id="' + dataId + '">' + dataText + '<a href="#" class="remove-tag">&times;</a></div>');
                   }
                   setCheckbox();
                   setRemoval();
               }
           });
     }

     function search(e) {
         var enterKey = 13;
         if (e.which == enterKey) {
             if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
                 var listParam = "";
                 $('section#filter-bar .tag-lists .item').each(function (index, value) {
                     listParam += $(this).attr('data-id') + ",";
                 });
                 listParam = listParam.substring(0, listParam.length - 1);
                 if (listParam == "") {
                     listParam = "0";
                 }
                 $('#list').val(listParam);
                 $('#search-page').val("1");
                 theForm.submit();
             }
         }
     }

     function searchByTag(obj) {
         if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
             var listParam = "";
             $('section#filter-bar .tag-lists .item').each(function (index, value) {
                 listParam += $(this).attr('data-id') + ",";
             });
             if (listParam.indexOf("0") > -1) {
                 listParam = $(obj).attr('id');
             }
             else {
                 listParam += $(obj).attr('id');
             }

             if ($(obj).attr('id') == "0") {
                 listParam = $(obj).attr('id');
             }
             //listParam = listParam.substring(0, listParam.length - 1);
             if (listParam == "") {
                 listParam = "0";
             }
             $('#list').val(listParam);
             $('#search-page').val("1");
             theForm.submit();
         }
     }

     /* Tag removal */
     function setRemoval() {
         var tagList = $('section#filter-bar .tag-lists');
         var tagListItem = $('section#filter-bar .tag-lists .item');
         var tagListCount = tagListItem.length;
         tagListItem.each(function (index, value) {
             $(this).on('click', function () {
                 var dataId = $(this).attr('data-id');
                 $('section#filter-bar .filter-expanded input[type="checkbox"]').each(function (index, value) {
                     if ($(this).attr('id') == dataId) {
                         $(this).prop('checked', '');
                     }
                 });
                 $(this).stop().fadeOut('fast');
                 $(this).remove();
                 return false;
             });
         });
     }

     function setList() {
         var tagCount = $('section#filter-bar .filter-expanded input[type="checkbox"]').length;
         $('section#filter-bar .filter-expanded input[type="checkbox"]').each(function (index, value) {
             $(this).on('change', function () {
                 var dataId = $(this).attr('id');
                 var dataText = $(this).parent().find('span').html();
                 var itemCount = $('section#filter-bar .tag-lists > .item[data-id="0"]').length;
                 if (this.checked) {
                     if (dataId == "0") {
                         $('section#filter-bar .tag-lists .item').each(function (index, value) {
                             $(this).stop().fadeOut('fast');
                             $(this).remove();
                         });
                         $('section#filter-bar .filter-expanded input[type="checkbox"]').each(function (index, value) {
                             if ($(this).attr('id') != "0") {
                                 $(this).prop('checked', '');
                             }
                         });
                     }
                     if (!itemCount > 0) {
                         $('.tag-lists').html($('.tag-lists').html() + '<div class="item" data-id="' + dataId + '">' + dataText + '<a href="#" class="remove-tag">&times;</a></div>');
                         setRemoval();
                     }
                     else {
                         $('.tag-lists').html('<div class="item" data-id="' + dataId + '">' + dataText + '<a href="#" class="remove-tag">&times;</a></div>');
                         setRemoval();
                         $('section#filter-bar .filter-expanded input[type="checkbox"]').each(function (index, value) {
                             if ($(this).attr('id') == "0") {
                                 $(this).prop('checked', '');
                             }
                         });
                     }
                 }
                 else {
                     $('section#filter-bar .tag-lists > .item[data-id="' + dataId + '"]').stop().fadeOut('fast');
                     $('section#filter-bar .tag-lists > .item[data-id="' + dataId + '"]').remove();
                 }
             });
         });
     }

     function setCheckbox() {
         var tagList = $('section#filter-bar .tag-lists');
         var tagListItem = $('section#filter-bar .tag-lists .item');
         var tagListCount = tagListItem.length;
         tagListItem.each(function (index, value) {
             var dataId = $(this).attr('data-id');
             $('section#filter-bar .filter-expanded input[type="checkbox"]').each(function (index, value) {
                 if ($(this).attr('id') == dataId) {
                     $(this).prop('checked', 'checked');
                 }
                 else {
                     $(this).prop('checked', '');
                 }
             });
         });
     }
</script>
  <section id="search-bar" style="margin-top:50px;">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-md-9">
                <!--
                <a href="#" onclick="showGrid(); return false;" class="btn-listing"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-listing-grid.png"></a>
                <a href="#" onclick="showMap(); return false;" class="btn-listing"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-listing-map.png"></a>
                -->
            </div><!--/ .col-xs-12 -->
            <div class="col-xs-12 col-md-3">
                <div class="form-search">
                    <input type="search" name="keywords" id="keywords" class="form-control" onkeyup="search(event);" placeholder="Search All Activities">
                </div>
            </div><!--/ .col-xs-12 -->
        </div><!--/ .row -->
    </div><!--/ .container -->
</section>
  
<section id="filter-bar">
    <div class="container">
        <a href="#" class="filter-expand"><i class="fa fa-caret-down"></i></a>
        <div class="row">
            <div class="col-xs-12">
                <h3 class="title" style="color:white">Filter by interests:</h3>
                <div class="tag-lists">
                </div><!--/ .tags -->
                <a href="#" class="pull-right reset-filter"><i class="fa fa-refresh"></i> <span>Reset filters</span></a>
                <div class="clearfix"><input type="hidden" id="list" name="list" /></div>
            </div><!--/ .col-xs-12 -->
        </div><!--/ .row -->
        <div class="row filter-expanded">
            <div class="form-filter">
            </div>
        </div><!--/ .row -->
    </div><!--/ .container -->
</section>
<section id="page" class="">
  <div class="container">
    </div><!--/ .container -->
    <section id="map-bar">
      <div id="map_canvas" style="width: 100%; min-height:511px; position: absolute; float:left;z-index:1;min-height:"></div>
    </section>
</section>
<script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
<script src="<%= Request.Url.GetLeftPart(UriPartial.Authority)%>/Portals/_default/Skins/HammerFlex/js/jquery.geocomplete.min.js">
</script>
