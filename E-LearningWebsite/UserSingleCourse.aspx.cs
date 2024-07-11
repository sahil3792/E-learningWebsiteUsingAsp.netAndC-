using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Razorpay.Api;

namespace E_LearningWebsite
{
    public partial class UserSingleCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["CourseID"] != null)
                {
                    int courseId = int.Parse(Request.QueryString["CourseID"]);
                    // Use courseId as needed, e.g., to fetch course details from database
                    Response.Write($"<script>alert('{courseId}')</script>");
                    FetchCourseDetails(courseId);
                    List<Video> videoTitles = GetVideoTitles(courseId);
                    RepeaterVideoTitles.DataSource = videoTitles;
                    RepeaterVideoTitles.DataBind();
                }
            }
        }

        public class Video
        {
            public int LectureNumber { get; set; }
            public string VideoTitle { get; set; }
        }

        public List<Video> GetVideoTitles(int courseId)
        {
            List<Video> videoTitles = new List<Video>();
            string connectionString = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT VideoTitle FROM CourseVideos WHERE CoursesID = @CourseID";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CourseID", courseId);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                int lectureNumber = 1;
                while (reader.Read())
                {
                    Video video = new Video
                    {
                        LectureNumber = lectureNumber,
                        VideoTitle = reader["VideoTitle"].ToString()
                    };
                    videoTitles.Add(video);
                    lectureNumber++;
                }
            }

            return videoTitles;
        }

        private void FetchCourseDetails(int courseId)
        {
            // Replace with your connection string
            string connectionString = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // SQL query to fetch course details
                string query = "SELECT CourseName, CourseTeacherName, CourseDesc, CourseImage, StudentCount, rating, CoursePrice FROM CoursesDetails WHERE CoursesID = @CourseID";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CourseID", courseId);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        // Populate course details on the page
                        lblCourseTitle.Text = reader["CourseName"].ToString();
                        lblTeacherName.Text = reader["CourseTeacherName"].ToString();
                        lblCourseDescription.Text = reader["CourseDesc"].ToString();
                        imgCourseImage.ImageUrl = reader["CourseImage"].ToString(); // Adjust path as per your image location
                        price.Text = reader["CoursePrice"].ToString();

                        // Populate rating stars dynamically
                        int rating = Convert.ToInt32(reader["rating"]);
                        //divRating.InnerHtml = GetRatingStars(rating);

                        // Populate categories (can be fetched similarly from database)
                        //divCategories.InnerText = "Languages"; // Example

                        // You can also fetch and populate Curriculum and Reviews sections similarly
                        // For now, these are placeholders
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    // Handle exception
                    Console.WriteLine(ex.Message);
                }
            }
        }

        // Method to generate HTML for rating stars
        private string GetRatingStars(int rating)
        {
            string starsHtml = "";
            for (int i = 0; i < 5; i++)
            {
                if (i < rating)
                {
                    starsHtml += "<i class='fa fa-star' aria-hidden='true'></i>";
                }
                else
                {
                    starsHtml += "<i class='fa fa-star-o' aria-hidden='true'></i>";
                }
            }
            return starsHtml;
        }
        protected void btnExample_Click(object sender, EventArgs e)
        {
            Response.Write("<script>alert('button clicked')</script>");
            // Your server-side logic here
        }
        
    }
}