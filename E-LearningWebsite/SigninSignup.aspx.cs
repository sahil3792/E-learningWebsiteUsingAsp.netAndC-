using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace E_LearningWebsite
{
    public partial class SigninSignup : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text, password = txtPassword.Text;
            string query = "exec fetchUser";
            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataReader rdr = cmd.ExecuteReader();
            if(rdr.HasRows)
            {
                while(rdr.Read())
                {
                    if (rdr["Username"].Equals(username)&& rdr["password"].Equals(password))
                    {
                        if (rdr["Urole"].Equals("User"))
                        {
                            Session["UserID"] = rdr["UserID"];
                            Response.Write("<script>alert('Successfully logged in')</script>");
                            Response.Redirect("/UserHome.aspx");
                        }
                        else
                        {
                            Session["UserID"] = rdr["UserID"];
                            Response.Write("<script>alert('Sucessfully logged in as admin')</script>");
                            Response.Redirect("/AdminHome.aspx");
                        }
                    }
                }
            }
            else
            {
                Response.Write("<script>alert('Couldnt find the user or invalid login credentials')</script>");
            }

        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string username= txtNewUsername.Text,email = txtEmail.Text,password = txtNewPassword.Text,Urole = "User";
            string query = $"Exec AddUser '{username}','{email}','{password}','{Urole}';";
            SqlCommand cmd = new SqlCommand(query,conn);
            cmd.ExecuteNonQuery();
            Response.Write("<script>alert('Successfully signed in please login now')</script>");
        }

    }
}