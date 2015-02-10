<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.SlidingInfoModule.View" %>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">google.load("feeds", "1");</script>
<script>
    $(document).ready(function () {
        var feed = new google.feeds.Feed('http://www.weather.gov.sg/wip/pp/rndops/web/rss/rssNcast_NEW.xml');
        var pre_url = "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img";
        feed.load(function (data) {
            // Parse data depending on the specified response format, default is JSON.
            var contex = data.feed.entries[0].content; //summary
            var result = contex.split("<br>"); //<br>
            for (var count = 0; count < result.length ; count++) {
                //console.log(result[count]);
                var result1 = result[count];
                var result1Split = result1.split("-");
                if (result1Split[0].trim() == "SENTOSA") {
                    console.log("found : " + result1Split[1].trim());
                    if (result1Split[1].trim() == "Passing showers") {
                        //$(".temp").append(result1Split[1].trim());
                        $('<img src="' + pre_url + '/weather-icons/mendung.png" alt="" title="" class="weather-icon">').insertAfter(".temp");
                    }
                    if (result1Split[1].trim() == "Fair (Day)") {
                        //$(".temp").append(result1Split[1].trim());
                        $('<img src="' + pre_url + '/weather-icons/mendung.png" alt="" title="" class="weather-icon">').insertAfter(".temp");
                    }
                    if (result1Split[1].trim() == "Fair (Night)") {
                        //$(".temp").append(result1Split[1].trim());
                        $('<img src="' + pre_url + '/weather-icons/mendung.png" alt="" title="" class="weather-icon">').insertAfter(".temp");
                    }
                    if (result1Split[1].trim() == "Partly cloudy") {
                        //$(".temp").append(result1Split[1].trim());
                        $('<img src="' + pre_url + '/weather-icons/mendung.png" alt="" title="" class="weather-icon">').insertAfter(".temp");
                    }
                    if (result1Split[1].trim() == "Cloudy") {
                        //$(".temp").append(result1Split[1].trim());
                        $('<img src="' + pre_url + '/weather-icons/mendung.png" alt="" title="" class="weather-icon">').insertAfter(".temp");
                    }
                    if (result1Split[1].trim() == "Hazy") {
                        //$(".temp").append(result1Split[1].trim());
                        $('<img src="' + pre_url + '/weather-icons/mendung.png" alt="" title="" class="weather-icon">').insertAfter(".temp");
                    }
                    if (result1Split[1].trim() == "Windy") {
                        //$(".temp").append(result1Split[1].trim());
                        $('<img src="' + pre_url + '/weather-icons/mendung.png" alt="" title="" class="weather-icon">').insertAfter(".temp");
                    }
                    if (result1Split[1].trim() == "Rain") {
                        //$(".temp").append(result1Split[1].trim());
                        $('<img src="' + pre_url + '/weather-icons/mendung.png" alt="" title="" class="weather-icon">').insertAfter(".temp");
                    }
                    if (result1Split[1].trim() == "Showers") {
                        //$(".temp").append(result1Split[1].trim());
                        $('<img src="' + pre_url + '/weather-icons/mendung.png" alt="" title="" class="weather-icon">').insertAfter(".temp");
                    }
                    if (result1Split[1].trim() == "Thundery showers") {
                        //$(".temp").append(result1Split[1].trim());
                        $('<img src="' + pre_url + '/weather-icons/mendung.png" alt="" title="" class="weather-icon">').insertAfter(".temp");
                    }
                }
            }
        });
    });
</script>
<script>
    $(document).ready(function () {
        var feed = new google.feeds.Feed('http://www.weather.gov.sg/wip/pp/rndops/web/rss/3Day_RSS.xml');
        var pre_url = "<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img";
        var feed2 = new google.feeds.Feed('http://www.weather.gov.sg/wip/pp/rndops/web/rss/rssForecast_new.xml');
        feed2.load(function (data) {
            // Parse data depending on the specified response format, default is JSON.
            console.log(data);
            var contex = data.feed.entries[0].content; //summary
            var result = contex.split("<br>"); //<br>
            for (var count = 0; count < result.length ; count++) {
                //console.log(result[count]);
                var result1 = result[count];
                var result1Split = result1.split("-");
                console.log(result1Split);
                if (result1Split[0].trim() == "Max/Min Temperature(<sup>o</sup>C )") {
                    console.log("found : " + result1Split[1].trim());
                    $("#temp2").append(result1Split[1].trim());
                }
            }

            //var gettext = contex.indexOf("SENTOSA");
            //alert(contex);

            //console.dir(data);
        });
        feed.load(function (data) {
            // Parse data depending on the specified response format, default is JSON.
            var contex = data.feed.entries[0].content; //summary
            var result = contex.split("<br>"); //<br>
            for (var count = 0; count < result.length ; count++) {
                //console.log(result[count]);
                var result1 = result[count].split("<b>");
                for (var count2 = 0; count2 < result1.length; count2++) {
                    var result2 = result1[count2].split(":</b>");
                    if (result2[0].trim() == "Day") {
                        console.log("Day : " + result2[1]);

                        $("#3day").append("<th>" + result2[1].trim() + "</th>");
                    }
                    if (result2[0].trim() == "Forecast") {
                        console.log("Forecast : " + result2[1]);
                        if (result2[1].search("Fair (Day)") != "-1") {
                            $("#3dayforecast").append('<td id="forecast' + count + '"><img src="' + pre_url + '/weather-icons/mendung.png" alt=""></td>');
                        }
                        if (result2[1].search("Fair (Night)") != "-1") {
                            $("#3dayforecast").append('<td id="forecast' + count + '"><img src="' + pre_url + '/weather-icons/mendung.png" alt=""></td>');
                        }
                        if (result2[1].search("Partly cloudy") != "-1") {
                            $("#3dayforecast").append('<td id="forecast' + count + '"><img src="' + pre_url + '/weather-icons/mendung.png" alt=""></td>');
                        }
                        if (result2[1].search("Cloudy") != "-1") {
                            $("#3dayforecast").append('<td id="forecast' + count + '"><img src="' + pre_url + '/weather-icons/mendung.png" alt=""></td>');
                        }
                        if (result2[1].search("Hazy") != "-1") {
                            $("#3dayforecast").append('<td id="forecast' + count + '"><img src="' + pre_url + '/weather-icons/mendung.png" alt=""></td>');
                        }
                        if (result2[1].search("Windy") != "-1") {
                            $("#3dayforecast").append('<td id="forecast' + count + '"><img src="' + pre_url + '/weather-icons/mendung.png" alt=""></td>');
                        }
                        if (result2[1].search("Rain") != "-1") {
                            $("#3dayforecast").append('<td id="forecast' + count + '"><img src="' + pre_url + '/weather-icons/mendung.png" alt=""></td>');
                        }
                        if (result2[1].search("passing showers") != "-1") {
                            $("#3dayforecast").append('<td id="forecast' + count + '"><img src="' + pre_url + '/weather-icons/mendung.png" alt=""></td>');
                        }
                        if (result2[1].search("Showers") != "-1") {
                            $("#3dayforecast").append('<td id="forecast' + count + '"><img src="' + pre_url + '/weather-icons/mendung.png" alt=""></td>');
                        }
                        if (result2[1].search("Thundery showers") != "-1") {
                            $("#3dayforecast").append('<td id="forecast' + count + '"><img src="' + pre_url + '/weather-icons/mendung.png" alt=""></td>');
                        }
                    }
                    if (result2[0].trim() == "Temperature") {
                        console.log("Temperature : " + (count - 1) + result2[1]);
                        $("#forecast" + (count - 1)).append(result2[1] + "°C");
                    }
                }


            }
        });
    });
</script>
  
  
<section id="sliding-wrapper">
    <div id="WeatherPane">
        <section id="info-weather">
            <a href="#" class="info-weather-trigger">Weather</a>
            <div class="container">
                <a href="#" class="info-weather-close">×</a>
                <div class="row">
                    <div class="col-xs-12 col-md-6 col-md-offset-1">
                        <h2 class="temp">The weather today is:<br>Temperature(°C) at: <span id="temp2"></span></h2>
                        
                        <p>Fluffy clouds are invading The State of Fun. Enjoy the cool breeze at Sentosa as you dine, shop or just do nothing at all.</p>
                        <p><small>Source of information: Meteorological Service Singapore</small></p>
                    </div><!--/ .col-xs-12 -->
                    <div class="col-xs-12 col-md-5">
                        <table>
                            <thead>
                                <tr id="3day">
                                </tr>
                            </thead>
                            <tbody>
                                <tr id="3dayforecast">
                                    
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