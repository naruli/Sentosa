<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="Sentosa.Modules.ExploreModule.Settings" %>


<!-- uncomment the code below to start using the DNN Form pattern to create and update settings -->

<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
<%@ Register TagName="FilePicker" TagPrefix="dnn" Src="~/controls/filepickeruploader.ascx" %>

	<h2 id="dnnSitePanel-AttractionsThumbnail" class="dnnFormSectionHead"><a href="" class="">Attraction Thumbnail</a></h2>
	<fieldset>
        <div class="dnnFormItem">
            <dnn:Label ID="lblImage1" runat="server" Text="Image Attractions" /> 
            <dnn:FilePicker ID="filepicker1" runat="server" />
        </div>
    </fieldset>

    <h2 id="dnnSitePanel-BeachesThumbnail" class="dnnFormSectionHead"><a href="" class="">Beaches Thumbnail</a></h2>
	<fieldset>
        <div class="dnnFormItem">
            <dnn:Label ID="lblImage2" runat="server" Text="Image Beaches" /> 
            <dnn:FilePicker ID="filepicker2" runat="server" />
        </div>
    </fieldset>

    <h2 id="dnnSitePanel-NatureThumbnail" class="dnnFormSectionHead"><a href="" class="">Nature Thumbnail</a></h2>
	<fieldset>
        <div class="dnnFormItem">
            <dnn:Label ID="lblImage3" runat="server" Text="Image Nature" /> 
            <dnn:FilePicker ID="filepicker3" runat="server" />
        </div>
    </fieldset>

    <h2 id="dnnSitePanel-DiningThumbnail" class="dnnFormSectionHead"><a href="" class="">Dining Thumbnail</a></h2>
	<fieldset>
        <div class="dnnFormItem">
            <dnn:Label ID="lblImage4" runat="server" Text="Image Dining" /> 
            <dnn:FilePicker ID="filepicker4" runat="server" />
        </div>
    </fieldset>

    <h2 id="dnnSitePanel-ShopsThumbnail" class="dnnFormSectionHead"><a href="" class="">Shops Thumbnail</a></h2>
	<fieldset>
        <div class="dnnFormItem">
            <dnn:Label ID="lblImage5" runat="server" Text="Image Shops" /> 
            <dnn:FilePicker ID="filepicker5" runat="server" />
        </div>
    </fieldset>

    <h2 id="dnnSitePanel-GolfThumbnail" class="dnnFormSectionHead"><a href="" class="">Golf Thumbnail</a></h2>
	<fieldset>
        <div class="dnnFormItem">
            <dnn:Label ID="lblImage6" runat="server" Text="Image Golf" /> 
            <dnn:FilePicker ID="filepicker6" runat="server" />
        </div>
    </fieldset>

    <h2 id="dnnSitePanel-HotelsAndSpasThumbnail" class="dnnFormSectionHead"><a href="" class="">Hotels & Spas Thumbnail</a></h2>
	<fieldset>
        <div class="dnnFormItem">
            <dnn:Label ID="lblImage7" runat="server" Text="Image Hotels And Spas" /> 
            <dnn:FilePicker ID="filepicker7" runat="server" />
        </div>
    </fieldset>