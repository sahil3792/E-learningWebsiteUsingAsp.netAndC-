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
    public partial class ViewCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["CoursesID"] != null)
                {
                    int courseId = int.Parse(Request.QueryString["CoursesID"]);
                    
                    LoadCourseVideo(courseId);
                    LoadVideoTitles(courseId);
                }
            }
        }

        private void LoadCourseVideo(int courseId)
        {
            string cs = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = "SELECT TOP 1 VideoLink FROM CourseVideos WHERE CoursesID = @CourseID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CourseID", courseId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string videoUrl = GetEmbedUrl(reader["VideoLink"].ToString());
                    courseVideo.Attributes["src"] = videoUrl;
                }
                reader.Close();
            }
        }

        private void LoadVideoTitles(int courseId)
        {
            string cs = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = "SELECT VideoTitle, VideoLink FROM CourseVideos WHERE CoursesID = @CourseID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CourseID", courseId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                RepeaterVideoTitles.DataSource = reader;
                RepeaterVideoTitles.DataBind();
            }
        }

        public string GetEmbedUrl(string videoUrl)
        {
            Uri uri = new Uri(videoUrl);
            string videoId = string.Empty;

            if (uri.Host.Contains("youtu.be"))
            {
                videoId = uri.AbsolutePath.Trim('/');
            }
            else if (uri.Host.Contains("youtube.com"))
            {
                var query = HttpUtility.ParseQueryString(uri.Query);
                videoId = query["v"];
            }

            return $"https://www.youtube.com/embed/{videoId}";
        }

        public string GetThumbnailUrl(string videoUrl)
        {
            Uri uri = new Uri(videoUrl);
            string videoId = string.Empty;

            if (uri.Host.Contains("youtu.be"))
            {
                videoId = uri.AbsolutePath.Trim('/');
            }
            else if (uri.Host.Contains("youtube.com"))
            {
                var query = HttpUtility.ParseQueryString(uri.Query);
                videoId = query["v"];
            }

            return $"https://img.youtube.com/vi/{videoId}/hqdefault.jpg";
        }
    }
}
