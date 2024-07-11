<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SigninSignup.aspx.cs" Inherits="E_LearningWebsite.SigninSignup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="js/app.js"></script>
    <script src="https://kit.fontawesome.com/64d58efce2.js" crossorigin="anonymous"></script>
    <link href="styles/style.css" rel="stylesheet" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="container">
                <div class="forms-container">
                    <div class="signin-signup">
                        <div class="form sign-in-form">
                            <h2 class="title">Sign in</h2>
                            <div class="input-field">
                                <i class="fas fa-user"></i>
                                <asp:TextBox ID="txtUsername" runat="server" placeholder="Username"></asp:TextBox>
                            </div>
                            <div class="input-field">
                                <i class="fas fa-lock"></i>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
                            </div>
                            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn solid" OnClick="btnLogin_Click" />
                            <p class="social-text">Or Sign in with social platforms</p>
                            <div class="social-media">
                                <!-- Social media icons -->
                            </div>
                        </div>
                        <div class="form sign-up-form">
                            <h2 class="title">Sign up</h2>
                            <div class="input-field">
                                <i class="fas fa-user"></i>
                                <asp:TextBox ID="txtNewUsername" runat="server" placeholder="Username"></asp:TextBox>
                            </div>
                            <div class="input-field">
                                <i class="fas fa-envelope"></i>
                                <asp:TextBox ID="txtEmail" runat="server" placeholder="Email"></asp:TextBox>
                            </div>
                            <div class="input-field">
                                <i class="fas fa-lock"></i>
                                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
                            </div>
                            <asp:Button ID="btnSignup" runat="server" Text="Sign up" CssClass="btn" OnClick="btnSignup_Click" />
                            <p class="social-text">Or Sign up with social platforms</p>
                            <div class="social-media">
                                <!-- Social media icons -->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panels-container">
                    <div class="panel left-panel">
                        <div class="content">
                            <h3>New here ?</h3>
                            <p>
                                Lorem ipsum, dolor sit amet consectetur adipisicing elit. Debitis,
                                ex ratione. Aliquid!
                            </p>
                            <asp:Button ID="btnShowSignup" runat="server" Text="Sign up" CssClass="btn transparent" OnClientClick="showSignup(); return false;" />
                        </div>
                        <img src="img/log.svg" class="image" alt="" />
                    </div>
                    <div class="panel right-panel">
                        <div class="content">
                            <h3>One of us ?</h3>
                            <p>
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum
                                laboriosam ad deleniti.
                            </p>
                            <asp:Button ID="btnShowSignin" runat="server" Text="Sign in" CssClass="btn transparent" OnClientClick="showSignin(); return false;" />
                        </div>
                        <img src="img/register.svg" class="image" alt="" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
