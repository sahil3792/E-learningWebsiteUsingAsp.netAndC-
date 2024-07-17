using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using Razorpay.Api;

namespace E_LearningWebsite
{
    public partial class UserSingleCourse : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();
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

            string query = "SELECT VideoTitle FROM CourseVideos WHERE CoursesID = @CourseID";
            SqlCommand command = new SqlCommand(query, conn);
            command.Parameters.AddWithValue("@CourseID", courseId);

            
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
            return videoTitles;
        }

        private void FetchCourseDetails(int courseId)
        {
            // Replace with your connection string
            string connectionString = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;
            decimal coursePrice = GetCoursePrice(courseId);
            price.Text = coursePrice.ToString();
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

        private decimal GetCoursePrice(int courseId)
        {
            // Replace with your actual database fetching logic
            decimal price = 0;
            string connectionString = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString; ;
            string query = "SELECT CoursePrice FROM CoursesDetails WHERE CoursesID = @CourseID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CourseID", courseId);
                conn.Open();
                price = Convert.ToDecimal(cmd.ExecuteScalar());
            }

            return price;
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            int UserID = int.Parse(Session["UserID"].ToString());
            Response.Write("<script>alert('button clicked')</script>");
            decimal totalAmount = Convert.ToDecimal(price.Text);
            string query = $"exec StoreInOrders '{UserID}','{totalAmount}'; SELECT SCOPE_IDENTITY();";
            SqlCommand cmd = new SqlCommand(query, conn);
            int orderid = Convert.ToInt32(cmd.ExecuteScalar());

            string selectuser = $"exec selectuser '{UserID}'";
            SqlCommand command = new SqlCommand(selectuser, conn);
            SqlDataReader rdr = command.ExecuteReader();
            string name = "", email = "";

            if (rdr.Read())
            {
                name = rdr["Username"].ToString();
                
                email = rdr["Email"].ToString();
            }
            rdr.Close();

            // Retrieve Razorpay API keys from web.config
            string keyId = "rzp_test_J24VTErrWDMd0g";
            string keySecret = "VoRvJOlFc1hv9kNBS6xwWl2G";

            // Initialize Razorpay client
            RazorpayClient client = new RazorpayClient(keyId, keySecret);

            // Create Razorpay order
            Dictionary<string, object> options = new Dictionary<string, object>
            {
                { "amount", (totalAmount * 100) }, // Amount is in currency subunits. Hence, 50000 refers to 50000 paise or ₹500.
                { "currency", "INR" },
                { "receipt", orderid.ToString() },
                { "payment_capture", 1 }
            };

            try
            {
                Order order = client.Order.Create(options);

                // Build HTML for Razorpay checkout
                StringBuilder outputHTML = new StringBuilder();
                outputHTML.Append("<html>");
                outputHTML.Append("<head>");
                outputHTML.Append("<title>Merchant Check Out Page</title>");
                outputHTML.Append("</head>");
                outputHTML.Append("<body>");
                outputHTML.Append("<center>Please do not refresh this page...</center>");
                outputHTML.Append("<form id='redirectForm' action='InvoiceGeneration.aspx' method='post'>");
                outputHTML.AppendFormat("<input type='hidden' name='razorpay_payment_id' value='{0}'/>", "");
                outputHTML.AppendFormat("<input type='hidden' name='razorpay_order_id' value='{0}'/>", order["id"]);
                outputHTML.AppendFormat("<input type='hidden' name='razorpay_signature' value='{0}'/>", "");
                outputHTML.AppendFormat("<input type='hidden' name='order_id' value='{0}'/>", orderid);
                outputHTML.AppendFormat("<input type='hidden' name='amount' value='{0}'/>", totalAmount);
                outputHTML.AppendFormat("<input type='hidden' name='currency' value='INR'/>");
                outputHTML.AppendFormat("<input type='hidden' name='name' value='{0}'/>", name);
                outputHTML.AppendFormat("<input type='hidden' name='email' value='{0}'/>", email);
                outputHTML.Append("</form>");
                outputHTML.Append("<script src='https://checkout.razorpay.com/v1/checkout.js'></script>");
                outputHTML.Append("<script>");
                outputHTML.Append("var options = {");
                outputHTML.AppendFormat("key: '{0}',", keyId);
                outputHTML.AppendFormat("amount: '{0}',", (totalAmount * 100).ToString());
                outputHTML.AppendFormat("currency: 'INR',");
                outputHTML.AppendFormat("name: 'Fruitables',");
                outputHTML.AppendFormat("description: 'Fruits',");
                outputHTML.AppendFormat("image: 'https://your_logo_url',");
                outputHTML.AppendFormat("order_id: '{0}',", order["id"]);
                outputHTML.Append("handler: function (response) {");
                outputHTML.Append("document.getElementById('redirectForm').razorpay_payment_id.value = response.razorpay_payment_id;");
                outputHTML.Append("document.getElementById('redirectForm').razorpay_signature.value = response.razorpay_signature;");
                outputHTML.Append("document.getElementById('redirectForm').submit();");
                outputHTML.Append("},");
                outputHTML.Append("prefill: {");
                outputHTML.AppendFormat("name: '{0}',", name);
                outputHTML.AppendFormat("email: '{0}',", email);
                outputHTML.Append("},");
                outputHTML.Append("notes: {");
                outputHTML.Append("address: 'Note value'");
                outputHTML.Append("},");
                outputHTML.Append("theme: {");
                outputHTML.Append("color: '#3399cc'");
                outputHTML.Append("}");
                outputHTML.Append("};");
                outputHTML.Append("var rzp1 = new Razorpay(options);");
                outputHTML.Append("rzp1.open();");
                outputHTML.Append("</script>");
                outputHTML.Append("</body>");
                outputHTML.Append("</html>");

                Response.Write(outputHTML.ToString());
            }
            catch (Razorpay.Api.Errors.BadRequestError ex)
            {
                // Log and handle the BadRequestError specifically
                Response.Write($"BadRequestError: {ex.Message}");
            }
            catch (Exception ex)
            {
                // Log and handle other exceptions
                Response.Write($"Error: {ex.Message}");
            }
        }
    }
}