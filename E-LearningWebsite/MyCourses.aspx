<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="MyCourses.aspx.cs" Inherits="E_LearningWebsite.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	    <script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/greensock/TweenMax.min.js"></script>
<script src="plugins/greensock/TimelineMax.min.js"></script>
<script src="plugins/scrollmagic/ScrollMagic.min.js"></script>
<script src="plugins/greensock/animation.gsap.min.js"></script>
<script src="plugins/greensock/ScrollToPlugin.min.js"></script>
<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/custom.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
    <!-- Popular Courses -->

<div class="courses">
	<div class="section_background parallax-window" data-parallax="scroll" data-image-src="images/courses_background.jpg" data-speed="0.8"></div>
	<div class="container">
		<div class="row">
			<div class="col">
				<div class="section_title_container text-center">
					<h2 class="section_title">My Courses</h2>
					<div class="section_subtitle"><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel gravida arcu. Vestibulum feugiat, sapien ultrices fermentum congue, quam velit venenatis sem</p></div>
				</div>
			</div>
		</div>
		<div class="row courses_row">
			
			<!-- Course -->
			<asp:Repeater ID="RepeaterCourses" runat="server">
    <ItemTemplate>
        <div class="col-lg-4 course_col">
            <div class="course">
                <div class="course_image"><img src='<%# Eval("CourseImage") %>' alt=""></div>
                <div class="course_body">
                    <h3 class="course_title"><a href='ViewCourse.aspx?Coursesid=<%# Eval("CoursesID") %>'><%# Eval("CourseName") %></a></h3>
                    <div class="course_teacher"><%# Eval("CourseTeacherName") %></div>
                    <div class="course_text">
                        <p><%# Eval("CourseDesc") %></p>
                    </div>
                </div>
                <div class="course_footer">
                    <div class="course_footer_content d-flex flex-row align-items-center justify-content-start">
                        <div class="course_info">
                            <i class="fa fa-graduation-cap" aria-hidden="true"></i>
                            <span><%# Eval("StudentCount") %> Students</span>
                        </div>
                        <div class="course_info">
                            <i class="fa fa-star" aria-hidden="true"></i>
                            <span><%# Eval("rating") %> Ratings</span>
                        </div>
                        <div class="course_price ml-auto">$<%# Eval("CoursePrice") %></div>
                    </div>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>

			<!-- Course -->
			

		</div>
		<div class="row">
			<div class="col">
				<div class="courses_button trans_200"><a href="#">view all courses</a></div>
			</div>
		</div>
	</div>
</div>
</asp:Content>
