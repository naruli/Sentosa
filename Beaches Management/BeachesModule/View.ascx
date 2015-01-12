<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.BeachesModule.View" %>
<script type="text/javascript">
    $(document).ready(function () {
        var limit = "4";
        var offset = "<%=(Request.QueryString["Page"] != null ? Request.QueryString["Page"].ToString() : "1")%>";
        var searchValue = "<%=(Request.Params["keywords"] != null ? Request.Params["keywords"].ToString() : "")%>";
        var sortBy = "<%=(Request.Params["sort-by"] != null ? Request.Params["sort-by"].ToString() : "name")%>";
        $('#sorting').val(sortBy);
        $('#keywords').val(searchValue);
        searchBeaches(searchValue, sortBy, offset, limit);
        //console.log('Parameter : ' + searchValue + ', ' + sortBy + ', ' + list);
    });

    function searchBeaches(paramSearch, paramOrder, paramOffset, paramLimit) {
        $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/BeachesModule/API/ModuleBeaches/SearchBeaches?searchValue=" + paramSearch + "&order=" + paramOrder + "&offset=" + paramOffset + "&limit=" + paramLimit,
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
                                '<a href="Beaches/Details?Id=' + this.Id + '">' +
                                    '<img src="' + this.PathImage + '" alt="" title="" class="">' +
                                    '<div class="box-content">' +
                                        '<h3>' + this.Title + '</h3>' +
                                        '<p>' + this.ShortDesc + '</p>' +
                                    '</div><!--/ .box-content -->' +
                                 '</a>' +
                                 '<div class="box-nav">' +
                                    '<a href="Beaches/Details?Id=' + this.Id + '">' +
                                    '</a>' +
                                    '<a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-map-red.png" alt="" title="" class=""></a>' +
                                    (this.UrlBrochure != "" ? '<a href="http://' + this.UrlBrochure + '" target="_blank"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-tag.png" alt="" title="" class=""></a>' : '') +
                                    '<a href="Beaches/Details?Id=' + this.Id + '">Find out more <i class="fa fa-angle-right"></i></a>' +
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

       function pagination(obj) {
           var page = $(obj).html();
           var current = $(obj).parent().parent().find('li.active a').html();
           var tempUrl = theForm.action.split('?');
           if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
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
                   theForm.action = tempUrl[0];
                   theForm.submit();
               }
           }
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
                    <input type="search" name="keywords" id="keywords" class="form-control" onkeyup="search(event);" placeholder="Search within beaches">
                </div>
            </div><!--/ .col-xs-12 -->
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