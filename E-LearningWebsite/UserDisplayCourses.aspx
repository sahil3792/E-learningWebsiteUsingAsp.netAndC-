﻿<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="UserDisplayCourses.aspx.cs" Inherits="E_LearningWebsite.UserDisplayCourses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="MasterStyle/bootstrap4/bootstrap.min.css" rel="stylesheet" />
    <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="plugins/colorbox/colorbox.css" rel="stylesheet" />
    <link href="plugins/OwlCarousel2-2.2.1/animate.css" rel="stylesheet" />
    <link href="plugins/OwlCarousel2-2.2.1/owl.carousel.css" rel="stylesheet" />
    <link href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css" rel="stylesheet" />
    <link href="MasterStyle/courses.css" rel="stylesheet" />
    <link href="MasterStyle/courses_responsive.css" rel="stylesheet" />



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Home -->

    <div class="home">
        <div class="breadcrumbs_container">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="breadcrumbs">
                            <ul>
                                <li><a href="index.html">Home</a></li>
                                <li>Courses</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Courses -->

    <div class="courses">
        <div class="container">
            <div class="row">

                <!-- Courses Main Content -->
                <div class="col-lg-8">
                    <div class="courses_search_container">
                        <div action="#" id="courses_search_form" class="courses_search_form d-flex flex-row align-items-center justify-content-start">
                            <input type="search" class="courses_search_input" placeholder="Search Courses" >
                            <select id="courses_search_select" class="courses_search_select courses_search_input">
                                <option>All Categories</option>
                                <option>Category</option>
                                <option>Category</option>
                                <option>Category</option>
                            </select>
                            <button action="submit" class="courses_search_button ml-auto">search now</button>
                        </div>
                    </div>
                    <div class="courses_container">
                        <div class="row courses_row">

                            <!-- Course -->
                            <asp:Repeater ID="Repeater1" runat="server">
                                <ItemTemplate>
                                    <div class="col-lg-6 course_col">
                                        <div class="course">
                                            <div class="course_image">
                                                <img src='<%# Eval("CourseImage") %>' alt="">
                                            </div>
                                            <div class="course_body">
                                                <h3 class="course_title">
                                                    <a href="UserSingleCourse.aspx?CourseID=<%# Eval("CoursesID") %>"><%# Eval("CourseName") %></a>
                                                </h3>
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
                                                    <div class="course_price ml-auto">&#8377 <%# Eval("CoursePrice") %> </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                            
                        </div>
                        <div class="row pagination_row">
                            <div class="col">
                                <div class="pagination_container d-flex flex-row align-items-center justify-content-start">
                                    <ul class="pagination_list">
                                        <li class="active"><a href="#">1</a></li>
                                        <li><a href="#">2</a></li>
                                        <li><a href="#">3</a></li>
                                        <li><a href="#"><i class="fa fa-angle-right" aria-hidden="true"></i></a></li>
                                    </ul>
                                    <div class="courses_show_container ml-auto clearfix">
                                        <div class="courses_show_text">Showing <span class="courses_showing">1-6</span> of <span class="courses_total">26</span> results:</div>
                                        <div class="courses_show_content">
                                            <span>Show: </span>
                                            <select id="courses_show_select" class="courses_show_select">
                                                <option>06</option>
                                                <option>12</option>
                                                <option>24</option>
                                                <option>36</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Courses Sidebar -->
                <div class="col-lg-4">
                    <div class="sidebar">

                        <!-- Categories -->
                        <div class="sidebar_section">
                            <div class="sidebar_section_title">Categories</div>
                            <div class="sidebar_categories">
                                <ul>
                                    <li><a href="#">Art & Design</a></li>
                                    <li><a href="#">Business</a></li>
                                    <li><a href="#">IT & Software</a></li>
                                    <li><a href="#">Languages</a></li>
                                    <li><a href="#">Programming</a></li>
                                </ul>
                            </div>
                        </div>

                        <!-- Latest Course -->
                        <div class="sidebar_section">
                            <div class="sidebar_section_title">Latest Courses</div>
                            <div class="sidebar_latest">

                                <!-- Latest Course -->
                                <div class="latest d-flex flex-row align-items-start justify-content-start">
                                    <div class="latest_image">
                                        <div>
                                            <img src="images/latest_1.jpg" alt=""></div>
                                    </div>
                                    <div class="latest_content">
                                        <div class="latest_title"><a href="course.html">How to Design a Logo a Beginners Course</a></div>
                                        <div class="latest_price">Free</div>
                                    </div>
                                </div>

                                <!-- Latest Course -->
                                <div class="latest d-flex flex-row align-items-start justify-content-start">
                                    <div class="latest_image">
                                        <div>
                                            <img src="images/latest_2.jpg" alt=""></div>
                                    </div>
                                    <div class="latest_content">
                                        <div class="latest_title"><a href="course.html">Photography for Beginners Masterclass</a></div>
                                        <div class="latest_price">$170</div>
                                    </div>
                                </div>

                                <!-- Latest Course -->
                                <div class="latest d-flex flex-row align-items-start justify-content-start">
                                    <div class="latest_image">
                                        <div>
                                            <img src="images/latest_3.jpg" alt=""></div>
                                    </div>
                                    <div class="latest_content">
                                        <div class="latest_title"><a href="course.html">The Secrets of Body Language</a></div>
                                        <div class="latest_price">$220</div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <!-- Gallery -->
                        <div class="sidebar_section">
                            <div class="sidebar_section_title">Instagram</div>
                            <div class="sidebar_gallery">
                                <ul class="gallery_items d-flex flex-row align-items-start justify-content-between flex-wrap">
                                    <li class="gallery_item">
                                        <div class="gallery_item_overlay d-flex flex-column align-items-center justify-content-center">+</div>
                                        <a class="colorbox" href="images/gallery_1_large.jpg">
                                            <img src="images/gallery_1.jpg" alt="">
                                        </a>
                                    </li>
                                    <li class="gallery_item">
                                        <div class="gallery_item_overlay d-flex flex-column align-items-center justify-content-center">+</div>
                                        <a class="colorbox" href="images/gallery_2_large.jpg">
                                            <img src="images/gallery_2.jpg" alt="">
                                        </a>
                                    </li>
                                    <li class="gallery_item">
                                        <div class="gallery_item_overlay d-flex flex-column align-items-center justify-content-center">+</div>
                                        <a class="colorbox" href="images/gallery_3_large.jpg">
                                            <img src="images/gallery_3.jpg" alt="">
                                        </a>
                                    </li>
                                    <li class="gallery_item">
                                        <div class="gallery_item_overlay d-flex flex-column align-items-center justify-content-center">+</div>
                                        <a class="colorbox" href="images/gallery_4_large.jpg">
                                            <img src="images/gallery_4.jpg" alt="">
                                        </a>
                                    </li>
                                    <li class="gallery_item">
                                        <div class="gallery_item_overlay d-flex flex-column align-items-center justify-content-center">+</div>
                                        <a class="colorbox" href="images/gallery_5_large.jpg">
                                            <img src="images/gallery_5.jpg" alt="">
                                        </a>
                                    </li>
                                    <li class="gallery_item">
                                        <div class="gallery_item_overlay d-flex flex-column align-items-center justify-content-center">+</div>
                                        <a class="colorbox" href="images/gallery_6_large.jpg">
                                            <img src="images/gallery_6.jpg" alt="">
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <!-- Tags -->
                        <div class="sidebar_section">
                            <div class="sidebar_section_title">Tags</div>
                            <div class="sidebar_tags">
                                <ul class="tags_list">
                                    <li><a href="#">creative</a></li>
                                    <li><a href="#">unique</a></li>
                                    <li><a href="#">photography</a></li>
                                    <li><a href="#">ideas</a></li>
                                    <li><a href="#">wordpress</a></li>
                                    <li><a href="#">startup</a></li>
                                </ul>
                            </div>
                        </div>

                        <!-- Banner -->
                        <div class="sidebar_section">
                            <div class="sidebar_banner d-flex flex-column align-items-center justify-content-center text-center">
                                <div class="sidebar_banner_background" style="background-image: url(images/banner_1.jpg)"></div>
                                <div class="sidebar_banner_overlay"></div>
                                <div class="sidebar_banner_content">
                                    <div class="banner_title">Free Book</div>
                                    <div class="banner_button"><a href="#">download now</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Newsletter -->

    <div class="newsletter">
        <div class="newsletter_background parallax-window" data-parallax="scroll" data-image-src="images/newsletter.jpg" data-speed="0.8"></div>
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="newsletter_container d-flex flex-lg-row flex-column align-items-center justify-content-start">

                        <!-- Newsletter Content -->
                        <div class="newsletter_content text-lg-left text-center">
                            <div class="newsletter_title">sign up for news and offers</div>
                            <div class="newsletter_subtitle">Subcribe to lastest smartphones news & great deals we offer</div>
                        </div>

                        <!-- Newsletter Form -->
                        <div class="newsletter_form_container ml-lg-auto">
                            <form action="#" id="newsletter_form" class="newsletter_form d-flex flex-row align-items-center justify-content-center">
                                <input type="email" class="newsletter_input" placeholder="Your Email" >
                                <button type="submit" class="newsletter_button">subscribe</button>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
