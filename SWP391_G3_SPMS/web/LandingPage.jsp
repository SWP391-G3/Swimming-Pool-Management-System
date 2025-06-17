<%-- 
    Document   : LandingPage
    Created on : May 31, 2025, 12:36:09 AM
    Author     : Lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Hệ Thống Bể Bơi PoolHub</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: '#33CCFF',
                            secondary: '#0F172A'
                        },
                        animation: {
                            fadeIn: "fadeIn 1.5s ease-in-out",
                            slideUp: "slideUp 1s ease-out"
                        },
                        keyframes: {
                            fadeIn: {
                                '0%': {opacity: '0'},
                                '100%': {opacity: '1'}
                            },
                            slideUp: {
                                '0%': {transform: 'translateY(20px)', opacity: '0'},
                                '100%': {transform: 'translateY(0)', opacity: '1'}
                            }
                        }
                    }
                }
            };
        </script>
    </head>

    <body class="bg-white text-gray-800 font-sans">
        <!-- Header -->
        <header class="bg-white shadow sticky top-0 z-50">
            <div class="container mx-auto flex justify-between items-center py-4 px-6 animate-fadeIn">
                <a href="LandingPage.jsp" class="text-3xl font-bold text-primary transition-transform hover:scale-105">PoolHub</a>
                <nav class="space-x-4">
                    <a href="login.jsp" class="bg-primary text-white px-4 py-2 rounded-lg hover:bg-cyan-400 transition-all duration-300">Đăng nhập</a>
                </nav>
            </div>
        </header>

        <!-- Banner -->
        <section class="bg-gradient-to-r from-primary to-blue-400 text-white text-center py-24 animate-slideUp">
            <div class="max-w-2xl mx-auto px-4">
                <h1 class="text-4xl md:text-5xl font-extrabold mb-4 leading-tight animate-fadeIn">Trải nghiệm bơi lý tưởng cùng PoolHub</h1>
                <p class="text-lg md:text-xl mb-6 animate-fadeIn delay-200">Đặt vé dễ dàng, nhận thông báo nhanh chóng, tham gia ưu đãi hấp dẫn và quản lý lịch bơi của bạn mọi lúc mọi nơi.</p>
                <a href="login.jsp" class="inline-block bg-white text-primary font-semibold px-6 py-3 rounded-lg hover:bg-gray-100 transition duration-300 transform hover:scale-105">Khám phá ngay</a>
            </div>
        </section>

        <!-- Tính năng -->
        <section class="py-20 bg-gray-50">
            <div class="max-w-6xl mx-auto px-6 grid md:grid-cols-3 gap-12 items-center">
                <div class="space-y-10 animate-slideUp">
                    <div>
                        <h3 class="text-xl font-semibold text-secondary mb-2">Đặt Vé Bơi</h3>
                        <p class="text-gray-600">Chọn khung giờ, loại vé và bể bơi yêu thích. Thanh toán dễ dàng, xác nhận nhanh chóng.</p>
                    </div>
                    <div>
                        <h3 class="text-xl font-semibold text-secondary mb-2">Xem Lịch & Lịch Sử</h3>
                        <p class="text-gray-600">Theo dõi lịch đã đặt, xem lại vé cũ và quản lý thông tin cá nhân.</p>
                    </div>
                </div>
                <div class="flex justify-center animate-fadeIn">
                    <img src="images/banner5_2.jpg" alt="Dịch vụ bơi lội" class="rounded-full w-72 h-72 object-cover shadow-lg hover:scale-105 transition duration-300" />
                </div>
                <div class="space-y-10 animate-slideUp">
                    <div>
                        <h3 class="text-xl font-semibold text-secondary mb-2">Ưu Đãi Cá Nhân</h3>
                        <p class="text-gray-600">Nhận mã giảm giá tự động theo mức độ sử dụng và dịp đặc biệt.</p>
                    </div>
                    <div>
                        <h3 class="text-xl font-semibold text-secondary mb-2">Góp Ý & Hỗ Trợ</h3>
                        <p class="text-gray-600">Gửi đánh giá dịch vụ, yêu cầu hỗ trợ nhanh chóng từ hệ thống.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Feedback -->
        <section class="bg-white py-16 text-center border-t">
            <div class="max-w-3xl mx-auto px-4 animate-fadeIn">
                <h2 class="text-2xl font-bold text-secondary mb-6">Phản hồi từ khách hàng</h2>
                <blockquote class="italic text-lg text-gray-700">“Ứng dụng tiện lợi, bơi mỗi tuần mà không cần chờ đợi hay gọi điện. Ưu đãi mỗi tháng đều hấp dẫn!”</blockquote>
                <p class="mt-4 text-gray-600 font-medium">- Trần Minh, Khách hàng thường xuyên</p>
            </div>
        </section>

        <!-- Dịch vụ nổi bật -->
        <section class="py-20 bg-gray-100">
            <div class="max-w-6xl mx-auto grid md:grid-cols-3 gap-8 px-6">
                <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-xl transition duration-300 animate-fadeIn">
                    <img src="images/banner4_1.jpg" alt="Vé bơi" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <h3 class="text-lg font-semibold mb-2 text-secondary">Nhiều loại vé</h3>
                        <p class="text-gray-600">Vé theo lượt, theo giờ, hoặc vé tháng dành cho cá nhân và gia đình.</p>
                    </div>
                </div>
                <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-xl transition duration-300 animate-fadeIn delay-200">
                    <img src="images/pic09_1.jpg" alt="Thông báo" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <h3 class="text-lg font-semibold mb-2 text-secondary">Thông báo tức thì</h3>
                        <p class="text-gray-600">Nhận cập nhật lịch bơi, thay đổi lịch, khuyến mãi và thông tin bể bơi ngay lập tức.</p>
                    </div>
                </div>
                <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-xl transition duration-300 animate-fadeIn delay-300">
                    <img src="images/pic06_1.jpg" alt="Chăm sóc khách hàng" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <h3 class="text-lg font-semibold mb-2 text-secondary">Trải nghiệm tuyệt vời</h3>
                        <p class="text-gray-600">Bể bơi của chúng tôi luôn mới mẻ và hấp dẫn, luôn mang đến cho khách hàng trải nghiệm tốt nhất.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-gradient-to-r from-primary to-blue-400 border-t py-12">
            <div class="max-w-4xl mx-auto text-center space-y-4 animate-fadeIn">
                <h2 class="text-xl font-bold text-secondary">Liên hệ</h2>
                <ul class="space-y-2 text-gray-600">
                    <li>(084) 123-4567</li>
                    <li>hotro@poolhub.vn</li>
                    <li>123 Đường Bơi Lội, TP. Bể Bơi</li>
                </ul>
            </div>
        </footer>

        <div class="bg-gray-100 text-center py-4 text-sm text-gray-500 animate-fadeIn">
            © 2025 - Bản quyền thuộc <a href="#" class="text-primary hover:underline">PoolHub.vn</a>
        </div>
    </body>

</html>
