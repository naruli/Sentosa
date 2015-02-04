<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.ExploreModule.View" %>
<script type="text/javascript">
    function loadExplore(url) {
         console.log(url);
         $.getJSON(
             url,
             function (result) {
                 var parsedTaskJSONObject = jQuery.parseJSON(result);
                 var counter = 0;
                 $('.explore-lists').html('');
                 $.each(parsedTaskJSONObject, function () {
                     $('.explore-lists').append(
                         '<li>' +
                            '<a href="<%=Request.Url.GetLeftPart(UriPartial.Authority)%>' + this.Url + '">' +
                                '<img src="'+this.PathImage+'" alt="" title="" class="">' +
                                '<div class="caption"><span>'+this.Title+'</span></div><!--/ .caption -->' +
                            '</a>' +
                        '</li>'
                         );
                     counter++;
                 });
             });
    }
    loadExplore('<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath.ToString())%>/DesktopModules/ExploreModule/API/ModuleExplore/GetExplore');
</script>
<section id="explore">
    
    <div class="container">
        
        <div class="circle"></div>
    
        <div class="row">
        
            <div class="col-xs-12">
            
                <h2 class="title" id="Header" runat="server"></h2>
                <p class="desc" id="Description" runat="server"></p>
                
                <ul class="explore-lists">
                </ul>
                
            </div><!--/ .col-xs-12 -->
            
        </div><!--/ .row -->
        
    </div><!--/ .container -->
    
</section>