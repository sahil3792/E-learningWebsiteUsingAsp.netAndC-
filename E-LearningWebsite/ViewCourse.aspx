<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="ViewCourse.aspx.cs" Inherits="E_LearningWebsite.ViewCourse" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="styles/ViewCourse.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />

    <div class="main-container">
        <div class="iframe-container">
            <iframe id="courseVideo" runat="server" width="850" height="480" frameborder="0" allowfullscreen></iframe>
        </div>
        <div class="video-list-container">
            <asp:Repeater ID="RepeaterVideoTitles" runat="server">
                <ItemTemplate>
                    <div class="video-title" onclick="loadVideo('<%# GetEmbedUrl(Eval("VideoLink").ToString()) %>')">
                        <img src="<%# GetThumbnailUrl(Eval("VideoLink").ToString()) %>" width="150" height="100" alt="Video Thumbnail" style="border-radius: 5px;" />
                        <h5><%# Eval("VideoTitle") %></h5>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <script type="text/javascript">
        function loadVideo(videoUrl) {
            console.log("loadVideo called with URL: ", videoUrl); // Log the video URL
            var iframe = document.getElementById('<%= courseVideo.ClientID %>');
            if (iframe) {
                console.log("Iframe found. Setting src to: ", videoUrl); // Log iframe update
                iframe.src = videoUrl;
            } else {
                console.error("Iframe not found."); // Log error if iframe not found
            }
        }

        function GetEmbedUrl(videoUrl) {
            var videoId = videoUrl.includes("v=") ? videoUrl.split('v=')[1] : videoUrl.split('/').pop();
            return "https://www.youtube.com/embed/" + videoId.split('&')[0];
        }

        function GetThumbnailUrl(videoUrl) {
            var videoId = videoUrl.includes("v=") ? videoUrl.split('v=')[1] : videoUrl.split('/').pop();
            return "https://img.youtube.com/vi/" + videoId.split('&')[0] + "/0.jpg";
        }
    </script>
</asp:Content>