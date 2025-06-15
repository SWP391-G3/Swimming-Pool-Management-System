<%-- 
    Document   : landingpage
    Created on : Jun 4, 2025, 10:53:19 PM
    Author     : 84823
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Hệ Thống Bể Bơi PoolHub</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="./assets/css/main.css">
    </head>
    <body>
        <header id="header">
            <nav class="left">
                <a href="#menu"><span>Menu</span></a>
            </nav>
            <a href="index.html" class="logo">PoolHub</a>
            <nav class="right">
                <a href="login.jsp" class="button alt">Đăng nhập</a>
                <a href="register.jsp" class="button alt">Đăng ký</a>
            </nav>
        </header>


        <!-- Menu -->
        <nav id="menu">
            <ul class="links">
                <li><a href="index.html">Trang Chủ</a></li>
                <li><a href="#">Dịch Vụ</a></li>
                <li><a href="#">Ưu Đãi</a></li>
                <li><a href="#">Góp Ý</a></li>
            </ul>
            <ul class="actions vertical">
                <li><a href="login.jsp" class="button fit">Đăng nhập</a></li>
            </ul>

        </nav>




        <!-- Banner -->
        <section id="banner">
            <div class="content">
                <h1>Trải nghiệm bơi lý tưởng cùng PoolHub</h1>
                <p>Đặt vé dễ dàng, nhận thông báo nhanh chóng, tham gia ưu đãi hấp dẫn và quản lý lịch bơi của bạn mọi lúc mọi nơi.</p>
                <ul class="actions">
                    <li><a href="login.jsp" class="button scrolly">Khám phá ngay</a></li>
                </ul>
            </div>
        </section>

        <section id="features" class="wrapper">
            <div class="inner flex flex-3">
                <div class="flex-item left">
                    <div>
                        <h3>Đặt Vé Bơi</h3>
                        <p>Chọn khung giờ, loại vé và bể bơi yêu thích. Thanh toán dễ dàng, xác nhận nhanh chóng.</p>
                    </div>
                    <div>
                        <h3>Xem Lịch & Lịch Sử</h3>
                        <p>Theo dõi lịch đã đặt, xem lại vé cũ và quản lý thông tin cá nhân.</p>
                    </div>
                </div>
                <div class="flex-item image fit round">
                    <img src="images/banner5_2.jpg" alt="Dịch vụ bơi lội" style="border-radius: 50%" width="330" height="330">
                </div>
                <div class="flex-item right">
                    <div>
                        <h3>Ưu Đãi Cá Nhân</h3>
                        <p>Nhận mã giảm giá tự động theo mức độ sử dụng và dịp đặc biệt.</p>
                    </div>
                    <div>
                        <h3>Góp Ý & Hỗ Trợ</h3>
                        <p>Gửi đánh giá dịch vụ, yêu cầu hỗ trợ nhanh chóng từ hệ thống.</p>
                    </div>
                </div>
            </div>
        </section>

        <section id="two" class="wrapper style1 special">
            <div class="inner">
                <h2>Phản hồi từ khách hàng</h2>
                <figure>
                    <blockquote>
                        “Ứng dụng tiện lợi, bơi mỗi tuần mà không cần chờ đợi hay gọi điện. Ưu đãi mỗi tháng đều hấp dẫn!”
                    </blockquote>
                    <footer><cite class="author">Trần Minh</cite> <cite class="company">Khách hàng thường xuyên</cite></footer>
                </figure>
            </div>
        </section>
        <section id="three" class="wrapper">
            <div class="inner flex flex-3">
                <div class="flex-item box">
                    <div class="image fit">
                        <img src="images/banner4_1.jpg" alt="Vé bơi" width="418" height="200">
                    </div>
                    <div class="content">
                        <h3>Nhiều loại vé</h3>
                        <p>Vé theo lượt, theo giờ, hoặc vé tháng dành cho cá nhân và gia đình.</p>
                    </div>
                </div>
                <div class="flex-item box">
                    <div class="image fit">
                        <img src="images/pic09_1.jpg" alt="Thông báo" width="418" height="200">
                    </div>
                    <div class="content">
                        <h3>Thông báo tức thì</h3>
                        <p>Nhận cập nhật lịch bơi, thay đổi lịch, khuyến mãi và thông tin bể bơi ngay lập tức.</p>
                    </div>
                </div>
                <div class="flex-item box">
                    <div class="image fit">
                        <img src="images/pic06_1.jpg" alt="Chăm sóc khách hàng" width="418" height="200">
                    </div>
                    <div class="content">
                        <h3>Trải nghiệm tuyệt vời</h3>
                        <p>Bể bơi của chúng tôi luôn mới mẻ vè hấp dẫn, luôn mang đến cho khách hàng trải nghiệm tốt nhất.</p>
                    </div>
                </div>
            </div>
        </section>

        <footer id="footer">
            <div class="inner">
                <h2>Liên hệ</h2>
                <ul class="actions">
                    <li><span class="icon fa-phone"></span> <a href="#">(084) 123-4567</a></li>
                    <li><span class="icon fa-envelope"></span> <a href="#">hotro@poolhub.vn</a></li>
                    <li><span class="icon fa-map-marker"></span> 123 Đường Bơi Lội, TP. Bể Bơi</li>
                </ul>
            </div>
        </footer>

        <div class="copyright">
            © 2025 - Bản quyền thuộc <a href="#">PoolHub.vn</a>.
        </div>

        <!-- Scripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/jquery.scrolly.min.js"></script>
        <script src="assets/js/skel.min.js"></script>
        <script src="assets/js/util.js"></script>
        <script src="assets/js/main.js"></script>
    </body>
</html>
