using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_LearningWebsite
{
    public partial class AdminHome : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
           
            
                string cs = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;
                conn = new SqlConnection(cs);
                conn.Open();

            if (!IsPostBack)
            {
                BindCourseDropDownList();
                
            }

        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            string coursename = TextBox1.Text;
            string query = $"exec AddCourse '{coursename}';";
            SqlCommand cmd = new SqlCommand(query, conn);

            cmd.ExecuteNonQuery();
            Response.Write("<script>alert('Inserted')</script>");
            
            
        }

        private void BindCourseDropDownList()
        {
            string query = "SELECT CourseID, CourseName FROM Course"; // Adjust the table and column names as per your database schema
            SqlCommand cmd = new SqlCommand(query, conn);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            DropDownList1.DataSource = dt;
            DropDownList1.DataTextField = "CourseName"; // The column name that contains the display text
            DropDownList1.DataValueField = "CourseID"; // The column name that contains the value
            DropDownList1.DataBind();

            DropDownList1.Items.Insert(0, new ListItem("Select a course", "0")); // Optional: Add a default item at the top
        }
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selectedCourseId = Convert.ToInt32(DropDownList1.SelectedValue);
            BindSubCourseDropDownList(selectedCourseId);
        }

        private void BindSubCourseDropDownList(int courseId)
        {
            string cs = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                try
                {
                    string query = "SELECT SubCourseID, SubCourseName FROM SubCourse WHERE CourseID = @CourseID"; // Adjust the table and column names as per your database schema
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    DropDownList2.DataSource = dt;
                    DropDownList2.DataTextField = "SubCourseName"; // The column name that contains the display text
                    DropDownList2.DataValueField = "SubCourseID"; // The column name that contains the value
                    DropDownList2.DataBind();

                    DropDownList2.Items.Insert(0, new ListItem("Select a sub-course", "0")); // Optional: Add a default item at the top
                }
                catch (Exception ex)
                {
                    // Handle exceptions
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            int selectedCourseId = Convert.ToInt32(DropDownList1.SelectedValue);
            int selectedSubCourseId = Convert.ToInt32(DropDownList2.SelectedValue);

            string courseName = txtCourseName.Text;
            string courseDesc = txtDesc.Text;
            string teacherName = txtTeacherName.Text;
            decimal coursePrice = decimal.Parse(txtPrice.Text);
            string thumbnailPath = "";

            // Handle file upload
            if (FileUpload1.HasFile)
            {
                string filename = Path.GetFileName(FileUpload1.FileName);
                string folderPath = Server.MapPath("Uploads/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }
                thumbnailPath = "Uploads/" + filename;
                FileUpload1.SaveAs(folderPath + filename);
            }

            // Insert course details into database
            string query = "INSERT INTO CoursesDetails (CourseID, SubCourseID, CourseName, CourseDesc, CourseTeacherName, CoursePrice, CourseImage) " +
                           "VALUES (@CourseID, @SubCourseID, @CourseName, @CourseDesc, @CourseTeacherName, @CoursePrice, @CourseImage)";
            SqlCommand cmd = new SqlCommand(query, conn);

            cmd.Parameters.AddWithValue("@CourseID", selectedCourseId);
            cmd.Parameters.AddWithValue("@SubCourseID", selectedSubCourseId);
            cmd.Parameters.AddWithValue("@CourseName", courseName);
            cmd.Parameters.AddWithValue("@CourseDesc", courseDesc);
            cmd.Parameters.AddWithValue("@CourseTeacherName", teacherName);
            cmd.Parameters.AddWithValue("@CoursePrice", coursePrice);
            cmd.Parameters.AddWithValue("@CourseImage", thumbnailPath);

            try
            {
                
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Course details inserted successfully.')</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "')</script>");
            }
        }
        }
}
