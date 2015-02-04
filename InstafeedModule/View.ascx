<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.InstafeedModule.View" %>
<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>

<script type="text/javascript" src="<%=Request.Url.GetLeftPart(UriPartial.Authority)%>/Portals/_default/Skins/HammerFlex/js/instafeed.min.js"></script>

<script type="text/javascript">
    function addImage() {
        $.dnnConfirm({
            text: 'You sure you want to add this image to list',
            yesText: 'Yep,add',
            noText: 'Cancel',
            title: 'Add Confirmation',
            callbackTrue: function () {
                var images = $('input[name="instafeed[]"]:checked');
                if (images.length > 0) {
                    var sf = $.ServicesFramework(<%:ModuleContext.ModuleId%>);
                    $.ajax({
                        url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/InstafeedModule/API/ModuleInstafeed/DeleteInstafeed',
                        type: "POST",
                        contentType: "application/json",
                        beforeSend: sf.setModuleHeaders,
                        data: "",
                        success: function (data) {
                            $(images).each(function (i) {
                                alert(this.value);
                                var instafeedToAdd = {
                                    Url: $(this).value
                                };

                                $.ajax({
                                    url: '<%=(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath)%>/DesktopModules/InstafeedModule/API/ModuleInstafeed/AddInstafeed',
                                    type: "POST",
                                    contentType: "application/json",
                                    beforeSend: sf.setModuleHeaders,
                                    data: JSON.stringify(instafeedToAdd),
                                    success: function (data) {
                                    }
                                });
                            });
                            alert('Successfully Added!');
                        }
                    });
                }
                else {
                    alert('Please Select 1 or more images');
                }
            }
        });
    }
    var feed = new Instafeed({
        get: 'tagged',
        tagName: '<%= !String.IsNullOrEmpty(Hastag.Text) ? Hastag.Text : "TheStateofFun"%>',
        clientId: 'c8ff29be776d4bdfa183e15da1c6c95a',
        limit: 10,
        sortBy: 'random',
        resolution: 'low_resolution',
        template: '<div style="margin:5px;"><input type="checkbox" name="instafeed[]" value="{{image}}" /><img src="{{image}}" alt="" title="" style="width:100px;height:100px;"/></div>',
        error: function (data) {
            alert(data);
            return false;
        }
    });
    feed.run();
</script>


<div class="dnnFormItem">
    <dnn:label ID="Label1" runat="server" Text="Hastag" />
    <asp:TextBox ID="Hastag" runat="server" />
</div>

<div class="dnnFormItem">
    <dnn:label ID="Label2" runat="server" Text="" />
    <asp:Button ID="ChangeHastag" CssClass="dnnPrimaryAction" Text="Change" runat="server" />
</div>

<div class="dnnFormItem">
	<dnn:label ID="Label3" runat="server" Text="Instafeed List" />	
    <div id="instafeed"></div>
</div>
<div class="dnnFormItem">
	<dnn:label ID="Label4" runat="server" Text="" />
    <input type="button" class="dnnPrimaryAction" value="Add to List" onclick="addImage();" />
</div>