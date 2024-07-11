using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_LearningWebsite
{
    public partial class AdminAddVideo : System.Web.UI.Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;
            conn = new SqlConnection(cs);

            if (!IsPostBack)
            {
                BindCategoryDropDownList();
            }
        }

        private void BindCategoryDropDownList()
        {
            string query = "SELECT CourseID, CourseName FROM Course";
            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CourseName";
            ddlCategory.DataValueField = "CourseID";
            ddlCategory.DataBind();

            ddlCategory.Items.Insert(0, new ListItem("Select a category", "0"));
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selectedCategoryId = Convert.ToInt32(ddlCategory.SelectedValue);
            BindSubCategoryDropDownList(selectedCategoryId);
        }

        private void BindSubCategoryDropDownList(int categoryId)
        {
            string query = "SELECT SubCourseID, SubCourseName FROM SubCourse WHERE CourseID = @CourseID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@CourseID", categoryId);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlSubCategory.DataSource = dt;
            ddlSubCategory.DataTextField = "SubCourseName";
            ddlSubCategory.DataValueField = "SubCourseID";
            ddlSubCategory.DataBind();

            ddlSubCategory.Items.Insert(0, new ListItem("Select a sub-category", "0"));
        }

        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selectedSubCategoryId = Convert.ToInt32(ddlSubCategory.SelectedValue);
            BindCourseDropDownList(selectedSubCategoryId);
        }
        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Handle course selection change event
            int selectedCourseId = Convert.ToInt32(ddlCourse.SelectedValue);

            // You can optionally fetch and display additional details based on the selected course
            // For example, fetch videos related to the selected course or perform other operations
        }
        private void BindCourseDropDownList(int subCategoryId)
        {
            string query = "SELECT CoursesID, CourseName FROM CoursesDetails WHERE SubCourseID = @SubCourseID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@SubCourseID", subCategoryId);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlCourse.DataSource = dt;
            ddlCourse.DataTextField = "CourseName";
            ddlCourse.DataValueField = "CoursesID";
            ddlCourse.DataBind();

            ddlCourse.Items.Insert(0, new ListItem("Select a course", "0"));
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            int selectedCourseId = Convert.ToInt32(ddlCourse.SelectedValue);
            string videoTitle = txtVideoTitle.Text.Trim();
            string videoLink = txtVideoLink.Text.Trim();

            if (selectedCourseId == 0)
            {
                Response.Write("<script>alert('Please select a course.')</script>");
                return;
            }

            if (string.IsNullOrEmpty(videoTitle) || string.IsNullOrEmpty(videoLink))
            {
                Response.Write("<script>alert('Please enter both video title and link.')</script>");
                return;
            }

            // Insert into database
            string query = "INSERT INTO CourseVideos (CoursesID, VideoTitle, VideoLink) VALUES (@CoursesID, @VideoTitle, @VideoLink)";
            SqlCommand cmd = new SqlCommand(query, conn);

            cmd.Parameters.AddWithValue("@CoursesID", selectedCourseId);
            cmd.Parameters.AddWithValue("@VideoTitle", videoTitle);
            cmd.Parameters.AddWithValue("@VideoLink", videoLink);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Video saved successfully.')</script>");

                // Clear input fields after saving
                txtVideoTitle.Text = "";
                txtVideoLink.Text = "";
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "')</script>");
            }
            finally
            {
                conn.Close();
            }
        }
    }
}
