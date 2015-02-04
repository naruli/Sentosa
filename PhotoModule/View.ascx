<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.PhotoModule.View" %>

<section id="photo-list">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                
                <div class="title-box">
                    <h2 class="title" id="Header" runat="server"></h2>
                    <p class="desc" id="Description" runat="server"></p>
                </div><!--/ .title-box -->
                
                <ul class="photos" id="InstafeedList" runat="server">
                    
                </ul><!--/ .photos -->
                
                <div class="clearfix"></div>
                
            </div><!--/ .col-xs-12 -->
        </div><!--/ .row -->
    </div><!--/ .container -->
</section>
