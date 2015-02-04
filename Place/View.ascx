<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.Place.View" %>
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
        var limit = "16";
        var searchByGrid = "<%=(Request.Params["search-by-grid"] != null ? Request.Params["search-by-grid"].ToString() : "false")%>";
        var offset = "<%=(Request.Params["page-nav-list"] != null ? Request.Params["page-nav-list"].ToString() : "1")%>";
        var searchValue = "<%=(Request.Params["keywords"] != null ? Request.Params["keywords"].ToString() : "")%>";
        var list = "<%=(Request.Params["list"] != null ? Request.Params["list"].ToString() : "0")%>";
        var sortBy = "<%=(Request.Params["sort-by"] != null ? Request.Params["sort-by"].ToString() : "name")%>";
        var isMap = "<%=(Request.QueryString["showMap"] != null ? Request.QueryString["showMap"].ToString():"no")%>";

        var groupName = "";
        var url = theForm.action.toLowerCase();
        if (url.indexOf("attractions") > -1) {
            groupName = "attractions";
        }
        else if (url.indexOf("beaches") > -1) {
            groupName = "beaches";
        }
        else if (url.indexOf("nature") > -1) {
            groupName = "nature";
        }
        else if (url.indexOf("events") > -1) {
            groupName = "events";
        }
        else if (url.indexOf("dining") > -1) {
            groupName = "dining";
        }
        else if (url.indexOf("shops") > -1) {
            groupName = "shops";
        }
        else if (url.indexOf("golf") > -1) {
            groupName = "golf";
        }
        else if (url.indexOf("promotions") > -1) {
            groupName = "promotions";
        }
        else if (url.indexOf("islander") > -1) {
            groupName = "islander";
        }
        else if (url.indexOf("hotel") > -1) {
            groupName = "hotel and spas";
        }
        else if (url.indexOf("find") > -1) {
            groupName = "find fun";
        }
        else if (url.indexOf("getting") > -1) {
            groupName = "getting around";
        }
        else if (url.indexOf("plan") > -1) {
            groupName = "plan your itinerary";
        }
        $('#keywords').attr('placeholder', 'Search within ' + groupName);
        listPlace(groupName, list);
        searchPlace(searchValue, list, offset, limit, groupName, sortBy, isMap);

        $('#keywords').val(searchValue);
        //console.log(offset);
        //console.log('Parameter : ' + searchValue + ', ' + sortBy + ', ' + list);


    });

    function searchPlace(paramSearch, paramList, paramOffset, paramLimit, paramGroup, paramSortBy, paramIsMap) {
        $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/Place/API/ModulePlace/GetPlace?groupname=" + paramGroup + "&offset=" + paramOffset + "&limit=" + paramLimit + "&searchValue=" + paramSearch + "&sortBy=" + paramSortBy + "&list=" + paramList,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $('section#page .container').html('');
               $('section#page .container').append(
                   '<div class="row page-nav">' +
                        '<div class="col-xs-4 col-md-9">' +
                            '<span id="result" class="nav-title"></span>' +
                        '</div>' +
                        '<div class="col-xs-8 col-md-3 nopadding padding-xs">' +
                            '<div class="form-sort"' + (paramIsMap == "yes" ? ' style="display:none;"' : '') + '>' +
                                '<label>Sort by:</label>' +
                                '<div class="select-wrapper">' +
                                    '<select id="sorting" name="sort-by" class="form-control" onchange="searchByTrigger();">' +
                                        '<option value="name"' + (paramSortBy == "name" ? " selected" : "") + '>Name</option>' +
                                        '<option value="description"' + (paramSortBy == "description" ? " selected" : "") + '>Description</option>' +
                                        '<option value="date"' + (paramSortBy == "date" ? " selected" : "") + '>Date</option>' +
                                    '</select>' +
                                '</div>' +
                            '</div>' +
                        '</div>' +
                    '</div>'
               );
               var counter = 0;
               var row = 0;
               var total = 0;
               $.each(parsedTaskJSONObject, function () {
                   if (counter == 0) {
                       total = this.Total;
                   }
                   if (counter % 4 == 0) {
                       row++;
                       $('section#page .container').append(
                           '<div class="row page_' + row + '"' + (paramIsMap == "yes" ? ' style="display:none;"' : '') + '>' +
                           '</div>'
                           );
                   }
                   var shortDesc = krDencodeEntities(this.ShortDescription);
                   $('section#page .container .page_' + row).append(
                       '<div class="col-xs-12 col-sm-6 col-md-3" style="z-index:1;">' +
                            '<div class="box-item">' +
                                '<a href="' + this.Url + '">' +
                                    '<img src="' + this.Photo + '" alt="" title="" class="" style="height:20%;width:100%;">' +
                                    '<div class="box-content">' +
                                        '<h3>' + this.TabName + '</h3>' +
                                        '<p>' + shortDesc.trunc(150, true) + '</p>' +
                                    '</div><!--/ .box-content -->' +
                                 '</a>' +
                                 '<div class="box-nav">' +
                                    '<a href="' + this.Url + '">' +
                                    '</a>' +
                                    '<a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-map-red.png" alt="" title="" class=""></a>' +
                                    (this.SourceUrl != "" ? '<a href="' + this.SourceUrl + '" target="_blank"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-tag.png" alt="" title="" class=""></a>' : '') +
                                    '<a href="' + this.Url + '">Find out more <i class="fa fa-angle-right"></i></a>' +
                                 '</div>' +
                             '</div>' +
                         '</div>'
                               );
                   //console.log(this.Title + ' : ' + this.ShortDesc);
                   counter++;
               });
               if (counter > 0) {
                   $('section#page .container').append(
                       '<div class="row"' + (paramIsMap == "yes" ? ' style="display:none;"' : '') + '>' +
                            '<div class="col-xs-12">' +
                                '<input type="hidden" name="search-by-grid" id="grid" value="" />' +
                                '<input type="hidden" name="page-nav-list" id="search-page" value="" />' +
                                '<ul id="nav-paging" class="paging">' +
                                '</ul>' +
                            '</div>' +
                        '</div>'
                       );
                   $('#result').html(total + ' Result');
                   var page = Math.floor(parseInt(total) / parseInt(paramLimit)) - (parseInt(total) % parseInt(paramLimit) == 0 ? 1 : 0);
                   if (page > 0) {
                       if (paramOffset > 1) {
                           $('#nav-paging').append(
                                '<li><a href="#">Prev</a></li>'
                           );
                       }
                       else {
                           $('#nav-paging').append(
                                '<li style="display:none"><a href="#">Prev</a></li>'
                           );
                       }
                       for (current = 0; current <= page; current++) {
                           $('#nav-paging').append(
                               '<li class="' + ((current + 1) == paramOffset ? "active" : "") + '"><a href="#">' + (current + 1) + '</a></li>'
                               );
                       }
                       if (paramOffset < (page + 1)) {
                           $('#nav-paging').append(
                                '<li><a href="#">Next</a></li>'
                           );
                       }
                       else {
                           if (paramOffset < (page + 1)) {
                               $('#nav-paging').append(
                                    '<li style="display:none"><a href="#">Next</a></li>'
                               );
                           }
                       }
                       $('#nav-paging li a').each(function (index, value) {
                           $(this).on('click', function () {
                               pagination(this); return false;
                           });
                       });
                   }
                   else {
                       $('#nav-paging').append(
                           '<li class="active"><a href="#" onclick="pagination(this); return false;">1</a></li>'
                           );
                   }
               }
           });
       }

       function listPlace(paramGroup, paramList) {
           $.getJSON(
               "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/Place/API/ModulePlace/ListPlace?groupname=" + paramGroup,
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
                                '<label><input type="checkbox" id="' + this.CommonId + '" onclick="searchByTag(this);"><span>' + this.TagName + '</span></label>' +
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

       function pagination(obj) {
           var page = $(obj).html();
           var current = $(obj).parent().parent().find('li.active a').html();
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
               if (page == "Prev") {
                   page = parseInt(current) - 1;
               }
               else if (page == "Next") {
                   page = parseInt(current) + 1;
               }
               $('#search-page').val(page);
               $('#grid').val('true');
               theForm.submit();
           }
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

       function searchByTrigger() {
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

       function showMap() {
           $('section#page .row').hide();
           $('section#page .page-nav').show();
           $('section#page .row .form-sort').hide();
           $('#result').show();
           $('section#map-bar').show();
           google.maps.event.trigger(map, 'resize');
       }
       function showGrid() {
           $('section#page .row').show();
           $('section#page .row .form-sort').show();
           $('section#map-bar').hide();
       }
</script>
  <section id="search-bar" style="margin-top:50px;">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-md-9">
                <a href="#" onclick="showGrid(); return false;" class="btn-listing"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-listing-grid.png"></a>
                <a href="#" onclick="showMap(); return false;" class="btn-listing"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-listing-map.png"></a>
            </div><!--/ .col-xs-12 -->
            <div class="col-xs-12 col-md-3">
                <div class="form-search">
                    <input type="search" name="keywords" id="keywords" class="form-control" onkeyup="search(event);" placeholder="Search within attractions">
                </div>
            </div><!--/ .col-xs-12 -->
        </div><!--/ .row -->
    </div><!--/ .container -->
</section>
  
<section id="filter-bar">
    <div class="container">
        <a href="#" class="filter-expand"><i class="fa fa-caret-down"></i></a>
        <div class="row">
            <div id="filter" class="col-xs-12">
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
    <section id="map-bar" style="display:none">
      <div id="map_canvas" style="width: 100%; min-height:511px; position: absolute; float:left;z-index:1;min-height:"></div>
    </section>
</section>
<script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
<script src="<%= Request.Url.GetLeftPart(UriPartial.Authority)%>/Portals/_default/Skins/HammerFlex/js/jquery.geocomplete.min.js">
</script>