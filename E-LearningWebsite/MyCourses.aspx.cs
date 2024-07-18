using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_LearningWebsite
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int userId = int.Parse(Session["UserID"].ToString());
                BindCourses(userId);
            }
        }

        private void BindCourses(int userId)
        {
            string cs = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = @"
                    SELECT DISTINCT cd.Coursesid ,cd.CourseName, cd.CourseTeacherName, cd.CourseDesc, cd.CourseImage, cd.StudentCount, cd.rating, cd.CoursePrice
                    FROM Orders o
                    JOIN CoursesDetails cd ON o.CourseID = cd.CoursesID
                    WHERE o.UserID = @UserID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                RepeaterCourses.DataSource = rdr;
                RepeaterCourses.DataBind();
            }
        }
    }
}