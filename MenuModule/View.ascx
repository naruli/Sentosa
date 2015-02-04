<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.MenuModule.View" %>
<style>
    .highlight { background-color: yellow }
</style>
<script type="text/javascript">
    $(document).ready(function () {
        $('header nav li').each(function (index, value) {
            $(this).removeClass('active');
        });
        var splitUrl = theForm.action.split('/');
        var startUrl = <%=(Request.ApplicationPath.Equals("/") ? 3 : 4)%> * 1;
        for(index=startUrl; index < splitUrl.length; index++) {
            $('#' + splitUrl[index].toLowerCase()).addClass('active');
        }
    });


    function doSearchTabs(e)
    {
        var key = $('#searchTabsID').val();
        if (e.keyCode == 13) {
            var _character = $('#searchTabsID').val();
           
           
            window.location.replace("<%=DotNetNuke.Common.Globals.NavigateURL(393, "value=tester")%>");
            
            return false;
        }
        //console.log(key);
        //$('li').highlight(key);
       
        //initial
        $('#result_suggested').html('');
        $('#result_suggested').append('<li class="header">Suggested Search Terms</li>');

        $('#result_top').html('');
        $('#result_top').append('<li class="header">Top Search</li>');


        $.getJSON(
            "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/MenuModule/API/ModuleMenu/searchTabs?key=" + key,
           function (result) {
               var parsedTaskJSONObject = jQuery.parseJSON(result);
              

               var counter = 0;
               $.each(parsedTaskJSONObject, function () {
                   if(this.TypeSearch == "top")
                   {
                       $('#result_top').append('<li><a href="'+this.Url+'"><i class="fa fa-star"></i>'+this.TabName+'</a></li>');
                   }
                   else{ //suggested
                     
                       $('#result_suggested').append('<li><a href="'+this.Url+'">'+this.TabName+'</a></li>');
                   }
                   //console.log(this.Title + ' : ' + this.ShortDesc);
                   counter++;
               });
               
           });


        //highlight key
        


    }  
</script>
<header>

    <div class="container">
        
        <div class="row">
            <div class="col-xs-12 col-md-3 logo">
                <a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/home"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/logo-sentosa.png" alt="Logo Sentosa" class=""></a>
            </div><!--/ .col-xs-12 -->
            
            <div class="col-xs-12 col-md-9 nopadding relativetome navigation">
                
                <div class="sub-nav">
                    <div class="left"><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-subscribe.png">Subscribe to eNewsletter</a></div><!--/ .left -->
                    <div class="right">
                        Language: &nbsp;
                        <div class="btn-group">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">English</a>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="#">English</a></li>
                                <li><a href="#">Bahasa Indonesia</a></li>
                            </ul>
                        </div><!--/ .btn-group -->
                    </div><!--/ .right -->
                    <div class="clearfix"></div>
                </div><!--/ .sub-nav -->
                
                <nav>
                    <ul>
                        <li><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/home"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-home.png"></a></li>
                        <li id="explore" class="active">
                            <a href="#">Explore</a>
                            <ul>
                                <li id="attractions"><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/explore/attractions"><i class="icon icon-attraction"></i><span>Attractions</span></a></li>
                                <li id="beaches"><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/explore/beaches"><i class="icon icon-beaches"></i><span>Beaches</span></a></li>
                                <li id="nature"><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/explore/nature"><i class="icon icon-nature"></i><span>Nature</span></a></li>
                                <li id="dining"><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/explore/dining"><i class="icon icon-dining"></i><span>Dining</span></a></li>
                                <li id="shops"><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/explore/shops"><i class="icon icon-shops"></i><span>Shops</span></a></li>
                                <li id="golf"><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/explore/golf"><i class="icon icon-golf"></i><span>Golf</span></a></li>
                                <li id="hotels-and-spas"><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/explore/hotels-and-spas"><i class="icon icon-hotels"></i><span>Hotels &amp; Spas</span></a></li>
                            </ul>
                        </li>
                        <li id="plan-your-visit">
                            <a href="#">Plan Your Visit</a>
                            <ul class="single-row wide">
                                <li id="find-fun"><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/plan-your-visit/find-fun"><i class="icon icon-map"></i><span>Find Fun</span></a></li>
                                <li id="getting-around"><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/plan-your-visit/getting-around"><i class="icon icon-getting-around"></i><span>Getting To / Around</span></a></li>
                                <li id="plan-your-itinerary"><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/plan-your-visit/plan-your-itinerary"><i class="icon icon-plan"></i><span>Plan Your Itinerary</span></a></li>
                            </ul>
                        </li>
                        <li id="state-specials">
                            <a href="#">State Specials</a>
                            <ul class="single-row">
                                <li id="events"><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/state-specials/events"><i class="icon icon-events"></i><span>Events</span></a></li>
                                <li id="promotions"><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/state-specials/promotions"><i class="icon icon-promo"></i><span>Promotions</span></a></li>
                            </ul>
                        </li>
                        <li id="islander"><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/islander">Islander</a></li>
                        <li class="search">
                            <a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/search"><i class="fa fa-search"></i></a>
                            <div class="search-box">
                                <input type="search" class="pull-left" placeholder="Search in sentosa" onkeyup="doSearchTabs(event)" id="searchTabsID" autocomplete="off">
                                <a href="#" class="search-box-close pull-right">
                                    <img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-close.png" alt="" title="">
                                </a>
                                <div class="clearfix"></div>
                                <ul class="search-lists" id="result_suggested">
                                   <li class="header">Suggested Search Terms</li>
                                    <li class="header">Top Search</li>
                                 </ul>
                              <ul class="search-lists" id="result_top">
                                   
                                </ul><!--/ .search-lists -->
                            </div><!--/ .search-box -->
                        </li>
                        <li><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/icon-tag.png"> Buy Tickets</a></li>
                    </ul>
                </nav>
            </div><!--/ .col-xs-12 -->
            
        </div><!--/ .row -->
        
    </div><!--/ .container -->
    
</header>


<script type="text/javascript">
    $(document).ready(function () {
        jQuery.fn.highlight = function(pat) {
            function innerHighlight(node, pat) {
                var skip = 0;
                if (node.nodeType == 3) {
                    var pos = node.data.toUpperCase().indexOf(pat);
                    pos -= (node.data.substr(0, pos).toUpperCase().length - node.data.substr(0, pos).length);
                    if (pos >= 0) {
                        var spannode = document.createElement('span');
                        spannode.className = 'highlight';
                        var middlebit = node.splitText(pos);
                        var endbit = middlebit.splitText(pat.length);
                        var middleclone = middlebit.cloneNode(true);
                        spannode.appendChild(middleclone);
                        middlebit.parentNode.replaceChild(spannode, middlebit);
                        skip = 1;
                    }
                }
                else if (node.nodeType == 1 && node.childNodes && !/(script|style)/i.test(node.tagName)) {
                    for (var i = 0; i < node.childNodes.length; ++i) {
                        i += innerHighlight(node.childNodes[i], pat);
                    }
                }
                return skip;
            }
            return this.length && pat && pat.length ? this.each(function() {
                innerHighlight(this, pat.toUpperCase());
            }) : this;
        };

        jQuery.fn.removeHighlight = function() {
            return this.find("span.highlight").each(function() {
                this.parentNode.firstChild.nodeName;
                with (this.parentNode) {
                    replaceChild(this.firstChild, this);
                    normalize();
                }
            }).end();
        };
    });

</script>




