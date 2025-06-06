<%-- 
    Document   : HomePage
    Created on : May 31, 2025, 12:38:21 AM
    Author     : Lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List,model.Pool,model.FeedBack" %>
<!DOCTYPE html>
<html>
    <head>
        <!-- basic -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <!-- mobile metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <!-- site metas -->
        <title>PoolHub</title>
        <meta name="keywords" content="bể bơi, PoolHub, đặt phòng">
        <meta name="description" content="Hệ thống bể bơi PoolHub - Nơi trải nghiệm tuyệt vời">
        <meta name="author" content="PoolHub Team">
        <!-- bootstrap css -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <!-- style css -->
        <link rel="stylesheet" href="css/style.css">
        <!-- Responsive-->
        <link rel="stylesheet" href="css/responsive.css">
        <!-- fevicon -->
        <link rel="icon" href="images/fevicon.png" type="image/gif" />
        <!-- Scrollbar Custom CSS -->
        <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
        <!-- Tweaks for older IEs-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css"
              media="screen">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <!--[if lt IE 9]>
           <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
           <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
    </head>

    <body class="main-layout">
        <!-- loader  -->
<!--        <div class="loader_bg">
            <div class="loader"><img src="images/loading.gif" alt="#" /></div>
        </div>-->
        <!-- end loader -->
        <!-- header -->
        <header>
            <div class="header">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col logo_section">
                            <div class="full">
                                <div class="center-desk">
                                    <div class="titlePool">
                                        <a href="home">PoolHub</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-9 col-lg-9 col-md-9 col-sm-9">
                            <nav class="navigation navbar navbar-expand-md navbar-dark ">
                                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample04"
                                        aria-controls="navbarsExample04" aria-expanded="false" aria-label="Toggle navigation">
                                    <span class="navbar-toggler-icon"></span>
                                </button>
                                <div class="collapse navbar-collapse" id="navbarsExample04">
                                    <ul class="navbar-nav mr-auto">
                                        <li class="nav-item active">
                                            <a class="nav-link" href="#">Trang Chủ</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#">Giới Thiệu</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#">Bể Bơi</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#">Đánh Giá</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#">Liên Hệ</a>
                                        </li>
                                    </ul>
                                </div>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- end header -->

        <!-- banner -->
        <section class="banner_main">
            <div id="myCarousel" class="carousel slide banner" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img class="first-slide" src="images/banner2.jpg" alt="Trải nghiệm tuyệt vời">
                    </div>
                    <div class="carousel-item">
                        <img class="second-slide" src="images/banner3.jpg" alt="Thư giãn bên bể bơi">
                    </div>
                </div>
                <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </section> 
        <!-- end banner -->

        <!-- about -->
        <div class="about">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-5">
                        <div class="titlepage">
                            <h2>Về Chúng Tôi</h2>
                            <p>PoolHub là hệ thống bể bơi hàng đầu, nơi bạn có thể tận hưởng những giây phút thư giãn tuyệt vời. Chúng tôi cam kết mang đến cho bạn trải nghiệm tốt nhất với dịch vụ chuyên nghiệp và cơ sở vật chất hiện đại.</p>
                            <a class="read_more" href="#"> Đọc Thêm</a>
                        </div>
                    </div>
                    <div class="col-md-7">
                        <div class="about_img">
                            <figure><img src="images/about.png" alt="Về chúng tôi" /></figure>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end about -->

        <!-- our_room -->
        <div class="our_room">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="titlepage">
                            <h2>Bể Bơi Của Chúng Tôi</h2>
                            <p>Khám phá các bể bơi tuyệt đẹp của chúng tôi.</p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <% 
                        List<Pool> listPool = (List<Pool>) request.getAttribute("listPool");
                        int count = 0;
                        if(listPool != null){
                        for(Pool p : listPool){
                        
                        
                    %>
                    <div class="col-md-4 col-sm-6">
                        <div id="serv_hover" class="room">
                            <div class="room_img">
                                <figure><img src="<%= p.getPool_image() %>" alt="" /></figure>
                            </div>
                            <div class="bed_room">
                                <h3>Bể Bơi <%= ++count%></h3>
                                <p><%= p.getPool_description() %></p>
                            </div>
                        </div>
                    </div>
                    <% }}%>
                </div>
            </div>
        </div>
        <!-- end our_room -->

        <!-- gallery -->
        <div class="gallery">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="titlepage">
                            <h2>Thư Viện Hình Ảnh</h2>
                        </div>
                    </div>
                </div>

                <!-- BẮT ĐẦU MỘT ROW DUY NHẤT CHỨA TOÀN BỘ ẢNH -->
                <div class="row">
                    <% 
                        List<Pool> listPool2 = (List<Pool>) request.getAttribute("listPool2");
                        if(listPool2 != null){
                            for(Pool p : listPool2){
                    %>
                    <div class="col-md-3 col-sm-6 mb-4">
                        <div class="gallery_img">
                            <figure><img src="<%= p.getPool_image() %>" alt="" class="img-fluid" /></figure>
                        </div>
                    </div>
                    <% }} %>
                </div>
                <!-- KẾT THÚC ROW -->
            </div>
        </div>

        <!-- end gallery -->

        <!-- blog -->
        <div class="blog">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="titlepage">
                            <h2>Đánh Giá</h2>
                            <p>Dưới đây là những đánh giá và trải nghiệm của khách hàng tại PoolHub.</p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <% 
                        List<FeedBack> listPool3 = (List<FeedBack>) request.getAttribute("listPool3");
                        if(listPool3 != null){
                            for(FeedBack f : listPool3){
                    %>
                    <div class="col-md-4 h-100 d-flex mb-4">
                        <div class="blog_box w-100">
                            <div class="blog_img">
                                <figure><img src="<%= f.getPool_image()%>" alt="Đánh giá 1" /></figure>
                            </div>
                            <div class="blog_room">
                                <h3><%= f.getPool_name() %></h3>
                                <span><%= f.getRating() %> sao</span>
                                <p><%= f.getComment() %></p>
                            </div>
                        </div>
                    </div>
                            <%  }}%>
                </div>
            </div>
        </div>
        <!-- end blog -->

        <!-- contact -->

        <!-- end contact -->

        <!-- footer -->
        <footer>
            <div class="footer">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4">
                            <h3>Liên Hệ Chúng Tôi</h3>
                            <ul class="conta">
                                <li><i class="fa fa-map-marker" aria-hidden="true"></i> Địa Chỉ</li>
                                <li><i class="fa fa-mobile" aria-hidden="true"></i> +01 1234569540</li>
                                <li><i class="fa fa-envelope" aria-hidden="true"></i><a href="#"> poolhub@gmail.com</a></li>
                            </ul>
                        </div>
                        <div class="col-md-4">
                            <h3>Liên Kết Menu</h3>
                            <ul class="link_menu">
                                <li class="active"><a href="#">Trang Chủ</a></li>
                                <li><a href="#">Về Chúng Tôi</a></li>
                                <li><a href="#">Bể Bơi</a></li>
                                <li><a href="#">Thư Viện Hình Ảnh</a></li>
                                <li><a href="#">Đánh Giá</a></li>
                                <li><a href="#">Liên Hệ</a></li>
                            </ul>
                        </div>
                        <div class="col-md-4">
                            <h3>Bản Tin</h3>
                            <form class="bottom_form">
                                <input class="enter" placeholder="Nhập email của bạn" type="text" name="Enter your email">
                                <button class="sub_btn">Đăng Ký</button>
                            </form>
                            <ul class="social_icon">
                                <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-youtube-play" aria-hidden="true"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="copyright">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-10 offset-md-1">
                                <p>
                                    © 2025 Tất cả quyền được bảo lưu. Thiết kế bởi Hệ thống bể bơi PoolHub</a>
                                    <br><br>
                                    Phân phối bởi PoolHub</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- end footer -->

        <!-- Javascript files-->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/jquery-3.0.0.min.js"></script>
        <!-- sidebar -->
        <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>
