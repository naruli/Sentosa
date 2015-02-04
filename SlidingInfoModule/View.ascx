<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.SlidingInfoModule.View" %>
<section id="sliding-wrapper">
    <div id="WeatherPane">
        <section id="info-weather">
            <a href="#" class="info-weather-trigger">Weather</a>
            <div class="container">
                <a href="#" class="info-weather-close">×</a>
                <div class="row">
                    <div class="col-xs-12 col-md-6 col-md-offset-1">
                        <h2 class="temp">The weather today is:<br>Temperature at: <span>28°C</span></h2>
                        <img src="/portals/_default/skins/hammerflex/img/weather-icons/mendung.png" alt="" title="" class="weather-icon">
                        <p>Fluffy clouds are invading The State of Fun. Enjoy the cool breeze at Sentosa as you dine, shop or just do nothing at all.</p>
                        <p><small>Source of information: Meteorological Service Singapore</small></p>
                    </div><!--/ .col-xs-12 -->
                    <div class="col-xs-12 col-md-5">
                        <table>
                            <thead>
                                <tr>
                                    <th>SUN</th>
                                    <th>MON</th>
                                    <th>TUE</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <img src="/portals/_default/skins/hammerflex/img/weather-icons/mendung.png" alt="" class="">
                                        20°C
                                    </td>
                                    <td>
                                        <img src="/portals/_default/skins/hammerflex/img/weather-icons/cloudy.png" alt="" class="">
                                        30°C
                                    </td>
                                    <td>
                                        <img src="/portals/_default/skins/hammerflex/img/weather-icons/sunny.png" alt="" class="">
                                        35°C
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div><!--/ .col-xs-12 -->
                </div><!--/ .row -->
            </div><!--/ .container -->
        </section><!--/ .info-weather -->
    </div>

    <div id="AnnouncementPane" runat="server">
        <section id="info-announcement">
            <a href="#" class="info-announcement-trigger">Announcements</a>
            <div class="container">
                <a href="#" class="info-announcement-close" style="z-index:1">×</a>
                <div class="row">
                    <div class="col-xs-11 col-xs-offset-1">
                        <h2 class="title" style="color:white" id="Header" runat="server"></h2>
                        <ul class="announcement-list" id="tabs" runat="server">
                        </ul>
                        <div class="announcement-controls">
                            <a href="#" class="left"><i class="fa fa-angle-left"></i></a>
                            <a href="#" class="right"><i class="fa fa-angle-right"></i></a>
                        </div><!--/ .anouncement-controls -->
                    </div><!--/ .col-xs-12 -->
                </div><!--/ .row -->
            </div><!--/ .container -->
        </section><!--/ .info-weather -->
    </div>
    

</section>