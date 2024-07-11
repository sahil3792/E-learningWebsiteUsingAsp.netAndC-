<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="E_LearningWebsite.AdminHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />



    <div style="display: flex">
        <div style="border: 2px solid gray; width: 50%; height: 70%; margin: 10px; padding: 10px; border-radius: 10px">
            <asp:Label ID="Label1" runat="server" Text="Add Course" Style="align-items: center"></asp:Label>
            <div class="form-group">
                <asp:TextBox ID="TextBox1" runat="server" class="form-control" placeholder="Course name"></asp:TextBox>
            </div>
            <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click1" class="btn btn-primary" />
        </div>




        <div style="border: 2px solid gray; width: 50%; height: 80%; margin: 10px; padding: 10px; border-radius: 10px">


            <div class="form-group">
                <label for="exampleFormControlSelect1">Select Course</label>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="exampleFormControlSelect1">Select SubCourse</label>
                <asp:DropDownList ID="DropDownList2" runat="server"></asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="exampleFormControlTextarea1">Course Name</label>
                <asp:TextBox ID="txtCourseName" runat="server" class="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="exampleFormControlTextarea1">Course Description</label>
                <asp:TextBox ID="txtDesc" runat="server" class="form-control" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="exampleFormControlTextarea1">Teacher Name</label>
                <asp:TextBox ID="txtTeacherName" runat="server" class="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="exampleFormControlTextarea1">Course Price</label>
                <asp:TextBox ID="txtPrice" runat="server" class="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="exampleFormControlTextarea1">Course thumbnail</label>
                <asp:FileUpload ID="FileUpload1" class="form-control" runat="server" />
            </div>
            <asp:Button ID="Button2" runat="server" Text="submit" OnClick="Button2_Click" />

        </div>

    </div>


</asp:Content>
