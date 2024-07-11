<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminAddVideo.aspx.cs" Inherits="E_LearningWebsite.AdminAddVideo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <br /><br /><br /><br /><br /><br /><br />
   <div class="form-group">
        <label for="ddlCategory">Select Category:</label>
        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
        </asp:DropDownList>
    </div>
    <div class="form-group">
        <label for="ddlSubCategory">Select SubCategory:</label>
        <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSubCategory_SelectedIndexChanged">
        </asp:DropDownList>
    </div>
    <div class="form-group">
        <label for="ddlCategory">Select Course:</label>
        <asp:DropDownList ID="ddlCourse" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
        </asp:DropDownList>
    </div>
    <div class="form-group">
        <label for="txtVideoTitle">Video Title:</label>
        <asp:TextBox ID="txtVideoTitle" runat="server" CssClass="form-control"></asp:TextBox>
    </div>
    <div class="form-group">
        <label for="txtVideoLink">YouTube Video Link:</label>
        <asp:TextBox ID="txtVideoLink" runat="server" CssClass="form-control"></asp:TextBox>
    </div>
    <div class="form-group">
        <asp:Button ID="btnSave" runat="server" Text="Save Video" OnClick="btnSave_Click" CssClass="btn btn-success" />
    </div>
</asp:Content>
