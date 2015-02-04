<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.FooterModule.View" %>
<section id="social-icons">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <ul>
                    <li><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/social-icons/email.png" alt="" title=""><span>Email</span></a></li>
                    <li><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/social-icons/facebook.png" alt="" title=""><span>Facebook</span></a></li>
                    <li><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/social-icons/twitter.png" alt="" title=""><span>Twitter</span></a></li>
                    <li><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/social-icons/instagram.png" alt="" title=""><span>Instagram</span></a></li>
                    <li><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/social-icons/youtube.png" alt="" title=""><span>Youtube</span></a></li>
                    <li><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/social-icons/linkedin.png" alt="" title=""><span>Linkedin</span></a></li>
                    <li><a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/social-icons/tripadvisor-logo.png" alt="" title=""><span>Reviews on Sentosa</span></a></li>
                </ul>
                <div class="clearfix"></div>
            </div><!--/ .col-xs-12 -->
        </div><!--/ .row -->
    </div><!--/ .container -->
</section>
<footer>
    
    <div class="container">
        
        <div class="row mid-footer">
        
            <div class="col-xs-4 col-md-2 col-md-offset-1">
                <h3 class="title">About Sentosa</h3>
                <ul>
                    <li><a href="#">About Sentosa</a></li>
                    <li><a href="#">Education Programee</a></li>
                    <li><a href="#">Awards</a></li>
                    <li><a href="?p=careers">Careers</a></li>
                </ul>
            </div>
        
            <div class="col-xs-4 col-md-2">
                <h3 class="title">Visitor Information</h3>
                <ul>
                    <li><a href="#">Frequently Asked Questions</a></li>
                    <li><a href="#">Getting Here</a></li>
                    <li><a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/contact-us">Contact Us</a></li>
                </ul>
            </div>
        
            <div class="col-xs-4 col-md-2">
                <h3 class="title">Useful Links</h3>
                <ul>
                    <li><a href="#">Meetings &amp; Events</a></li>
                    <li><a href="#">Sentosa Golf Club</a></li>
                    <li><a href="#">Sentosa Cove</a></li>
                    <li><a href="#">Faber Peak Singapore</a></li>
                </ul>
            </div>
            
            <div class="col-xs-12 col-md-5">
            
              <a href="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/subscribe"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/btn-subscribe.jpg"></a>
                <a href="#"><img src="<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/portals/_default/skins/hammerflex/img/btn-download.jpg"></a>
                
            </div><!--/ .col-xs-12 -->
            
        </div><!--/ .row -->
        
    </div><!--/ .container -->
        
    <section id="bottom-footer">
        
        <div class="container">
            <div class="row">
                <div class="col-xs-6 col-xs-offset-1">
                    <p>© Sentosa 2014. All rights reserved. <a href="#">Legal Notices</a> | <a href="#">Sitemap</a></p>
                </div><!--/ .col-xs-12 -->

                <div class="col-xs-5">
                    <a href="http://www.sentosa.gov.sg/" target="_blank">Visit Sentosa Development Corporation →</a>
                </div><!--/ .col-xs-12 -->
            </div><!--/ .row -->
        </div><!--/ .container -->

	</section>
</footer>