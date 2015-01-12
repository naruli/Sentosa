<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.AttractionsModule.View" %>
<script type="text/javascript">
    $(document).ready(function () {
        var idList = "2";
        var limit = "16";
        var offset = "<%=(Request.QueryString["Page"] != null ? Request.QueryString["Page"].ToString() : "1")%>";
        var searchValue = "<%=(Request.Params["keywords"] != null ? Request.Params["keywords"].ToString() : "")%>";
        var sortBy = "<%=(Request.Params["sort-by"] != null ? Request.Params["sort-by"].ToString() : "name")%>";
        var list = "<%=(Request.Params["list"] != null ? Request.Params["list"].ToString() : "1")%>";
        $('#sorting').val(sortBy);
        $('#keywords').val(searchValue);
        listAttractions(idList, list);
        searchAttractions(searchValue, sortBy, list, offset, limit);
        //console.log('Parameter : ' + searchValue + ', ' + sortBy + ', ' + list);
    });

    function searchAttractions(paramSearch, paramOrder, paramList, paramOffset, paramLimit) {
        $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/AttractionsModule/API/ModuleAttractions/SearchAttractions?searchValue=" + paramSearch + "&order=" + paramOrder + "&list=" + paramList + "&offset=" + paramOffset + "&limit=" + paramLimit,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $('#resultTable').html('');
               var counter = 0;
               var total = 0;
               $.each(parsedTaskJSONObject, function () {
                   if (counter == 0) {
                       total = this.Total;
                   }
                   $('#resultTable').append(
                       '<div class="col-xs-12 col-sm-6 col-md-3">' +
                            '<div class="box-item">' +
                                '<a href="Attractions/Details?Id=' + this.Id + '">' +
                                    '<img src="' + this.PathImage + '" alt="" title="" class="">' +
                                    '<div class="box-content">' +
                                        '<h3>' + this.Title + '</h3>' +
                                        '<p>' + this.ShortDesc + '</p>' +
                                    '</div><!--/ .box-content -->' +
                                 '</a>' +
                                 '<div class="box-nav">' +
                                    '<a href="Attractions/Details?Id=' + this.Id + '">' +
                                    '</a>' +
                                    '<a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-map-red.png" alt="" title="" class=""></a>' +
                                    (this.UrlPurchase != "" ? '<a href="http://' + this.UrlPurchase + '" target="_blank"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-tag.png" alt="" title="" class=""></a>' : '') +
                                    '<a href="Attractions/Details?Id=' + this.Id + '">Find out more <i class="fa fa-angle-right"></i></a>' +
                                 '</div><!--/ .box-nav -->' +
                            '</div><!--/ .box-item -->' +
                        '</div><!--/ .col-xs-12 -->'
                       );
                   //console.log(this.Title + ' : ' + this.ShortDesc);
                   counter++;
               });
               if (counter > 0) {
                   $('#result').html(total + ' Result');
                   var page = Math.floor(parseInt(total) / parseInt(paramLimit)) - (parseInt(total) % parseInt(paramLimit) == 0 ? 1 : 0);
                   if (page > 0) {
                       if (paramOffset > 1) {
                           $('#nav-paging').append(
                                '<li><a href="#">Prev</a></li>'
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
                       $('#nav-paging li a').each(function (index, value) {
                           $(this).on('click', function () {
                               pagination(this); return false;
                           });
                       });
                   }
                   else {
                       $('#nav-paging').append(
                           '<li class="active"><a href="#" onclick="pagination(this);return false;">1</a></li>'
                           );
                   }
               }
           });
       }

       function listAttractions(Id, paramList) {
           $.getJSON(
               "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/AttractionsModule/API/ModuleAttractions/ListAttractions?id=" + Id,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               var counter = 0;
               $('.form-filter').html('');
               $('.form-filter').append(
                    '<div class="col-xs-2 col-md-1">' +
                        '<div class="checkbox-wrapper">' +
                            '<label><input type="checkbox" id="1"><span>All</span></label>' +
                        '</div>' +
                    '</div>' +
                    '<div id="interestList" class="col-xs-10 col-md-11">' +
                    '</div>'
                   );
               $.each(parsedTaskJSONObject, function () {
                   if (counter > 0) {
                       $('#interestList').append(
                            '<div class="checkbox-wrapper">' +
                                '<label><input type="checkbox" id="' + this.Id + '"><span>' + this.Value + '</span></label>' +
                            '</div>'
                       );
                   }
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
        var tempUrl = theForm.action.split('?');
        if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
            var listParam = "";
            $('section#filter-bar .tag-lists .item').each(function (index, value) {
                listParam += $(this).attr('data-id') + ",";
            });
            listParam = listParam.substring(0, listParam.length - 1);
            if (listParam == "") {
                listParam = "1";
            }
            $('#list').val(listParam);
            if (page == "Prev") {
                page = parseInt(current) - 1;
            }
            else if (page == "Next") {
                page = parseInt(current) + 1;
            }
            theForm.action = tempUrl[0] + '?Page=' + page;
            theForm.submit();
        }
    }

    function search(e) {
        var enterKey = 13;
        if (e.which == enterKey) {
            var tempUrl = theForm.action.split('?');
            if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
                var listParam = "";
                $('section#filter-bar .tag-lists .item').each(function (index, value) {
                    listParam += $(this).attr('data-id') + ",";
                });
                listParam = listParam.substring(0, listParam.length - 1);
                if (listParam == "") {
                    listParam = "1";
                }
                $('#list').val(listParam);
                theForm.action = tempUrl[0];
                theForm.submit();
            }
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
                var itemCount = $('section#filter-bar .tag-lists > .item[data-id="1"]').length;
                if (this.checked) {
                    if (dataId == "1") {
                        $('section#filter-bar .tag-lists .item').each(function (index, value) {
                            $(this).stop().fadeOut('fast');
                            $(this).remove();
                        });
                        $('section#filter-bar .filter-expanded input[type="checkbox"]').each(function (index, value) {
                            if ($(this).attr('id') != "1") {
                                $(this).prop('checked', '');
                            }
                        });
                    }
                    if (!itemCount > 0) {
                        $('.tag-lists').html($('.tag-lists').html() + '<div class="item" data-id="' + dataId + '">' + dataText + '<a href="#" class="remove-tag">&times;</a></div>');
                        setRemoval();
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
<section id="search-bar">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-md-9">
                <a href="#" class="btn-listing"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-listing-grid.png"></a>
                <a href="#" class="btn-listing"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-listing-map.png"></a>
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
        <div class="row page-nav">
            <div class="col-xs-4 col-md-9">
                <span id="result" class="nav-title"></span>
            </div><!--/ .col-xs-6 -->
            <div class="col-xs-8 col-md-3 nopadding padding-xs">
                <div class="form-sort">
                    <label>Sort by:</label>
                    <div class="select-wrapper">
                        <select id="sorting" name="sort-by" class="form-control">
                            <option value="name">Name</option>
                            <option value="description">Description</option>
                            <option value="date">Date</option>
                        </select>
                    </div><!--/ .select-wrapper -->
                </div>
            </div><!--/ .col-xs-6 -->
        </div><!--/ .row.page-nav -->
        <div id="resultTable" class="row">           
        </div>
        <div class="row">
            <div class="col-xs-12">
                <ul id="nav-paging" class="paging">
                </ul><!--/ .paging -->
            </div><!--/ .col-xs-12 -->
        </div><!--/ .row -->
    </div><!--/ .container -->
</section>