<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.customer.User" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Contact Us</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
            rel="stylesheet"
            />
        <link rel="stylesheet" href="css/styles.css" />
    </head>
    <body class="bg-gray-50 min-h-screen font-['Inter'] antialiased">
        <!-- header -->
        <header class="bg-white shadow-md w-full">
            <div class="container mx-auto px-4">
                <div class="flex items-center justify-between py-4">
                    <%
                        User currentUser = (User) session.getAttribute("currentUser");
                        String userName = (currentUser != null) ? currentUser.getFull_name() : "";
                        String avatar = (currentUser != null && currentUser.getImages() != null && !currentUser.getImages().isEmpty())
                            ? currentUser.getImages() : "default-avatar.png";
                        String userEmail = (currentUser != null) ? currentUser.getEmail() : "";
                        String homeUrl = (currentUser != null) ? "customerHome" : "home";
                    %>
                    <!-- Logo -->
                    <div class="flex items-center space-x-3">
                        <div class="h-20 w-20">
                            <a href="<%= homeUrl %>">
                                <img src="images/logoPool.png" alt="Logo" class="h-full w-full object-contain" />
                            </a>
                        </div>
                        <a href="<%= homeUrl %>" class="text-3xl md:text-5xl font-bold text-[#33CCFF]">PoolHub</a>
                    </div>

                    <!-- Navigation -->
                    <nav class="hidden md:flex space-x-6 text-base font-medium items-center">
                        <a href="#" class="text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">Trang Chủ</a>
                        <a href="#" class="text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">Giới Thiệu</a>
                        <a href="booking" class="text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">Bể Bơi</a>
                        <a href="#" class="text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">Đánh Giá</a>
                        <a href="contact" class="text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">Liên Hệ</a>
                        <% if (currentUser != null) { %>
                        <!-- Nếu đã đăng nhập -->
                        <a href="my_account" class="flex items-center space-x-2 text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">
                            <span>Tài khoản <%= !userName.isEmpty() ? ("| " + userName) : "" %></span>
                            <img src="<%= avatar %>" alt="avatar" class="w-8 h-8 rounded-full object-cover border border-gray-300" />
                        </a>
                        <% } else { %>
                        <!-- Nếu chưa đăng nhập -->
                        <a href="login.jsp" class="flex items-center space-x-2 text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">
                            <span>Đăng nhập</span>
                        </a>
                        <% } %>
                    </nav>
                </div>
            </div>
        </header>
        <!-- end header -->
        <div class="w-full flex flex-col items-center py-8">
            <!-- Wrapper: max-w-5xl cho cả banner và form đều cân đối -->
            <div class="w-full max-w-5xl mx-auto px-2 sm:px-4">
                <!-- Banner -->
                <div class="w-full rounded-lg overflow-hidden shadow mb-10">
                    <div class="relative w-full h-48 md:h-60 flex items-center justify-center bg-gray-200">
                        <img
                            src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=compress&fit=crop&w=1200&q=80"
                            alt="Contact Banner"
                            class="w-full h-full object-cover"
                            />
                        <div class="absolute inset-0 bg-gradient-to-b from-black/30 to-black/10"></div>
                        <h1
                            class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-2xl md:text-3xl font-bold text-white text-center drop-shadow-lg px-4"
                            >
                            CONTACT US
                        </h1>
                    </div>
                </div>

                <!-- Contact Form -->
                <section class="w-full bg-white border border-gray-200 rounded-lg p-8 shadow flex flex-col gap-6">
                    <% String success = (String) request.getAttribute("success"); %>
                    <% if (success != null) { %>
                    <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded shadow text-center">
                        <%= success %>
                    </div>
                    <% } %>
                    <form id="contactForm" action="contact" method="POST" class="flex flex-col gap-6" novalidate>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div>
                                <label for="name" class="block mb-1 font-medium text-gray-700">Họ và tên<span class="text-red-500">*</span></label>
                                <input
                                    type="text"
                                    id="name"
                                    name="name"
                                    required
                                    minlength="2"
                                    maxlength="50"
                                    pattern="^[\p{L} ]+$"
                                    placeholder="Nhập họ và tên của bạn"
                                    value="<%= userName %>"
                                    class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-300 transition"
                                    />
                                <span class="text-red-500 text-sm hidden" id="errName"></span>
                            </div>
                            <div>
                                <label for="email" class="block mb-1 font-medium text-gray-700">Email<span class="text-red-500">*</span></label>
                                <input
                                    type="email"
                                    id="email"
                                    name="email"
                                    required
                                    maxlength="100"
                                    pattern="^[\\w.%+-]+@[\\w.-]+\\.[a-zA-Z]{2,}$"
                                    placeholder="Nhập email của bạn"
                                    value="<%= userEmail %>"
                                    class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-300 transition"
                                    />
                                <span class="text-red-500 text-sm hidden" id="errEmail"></span>
                            </div>
                            <div>
                                <label for="subject" class="block mb-1 font-medium text-gray-700">Chủ đề</label>
                                <select
                                    id="subject"
                                    name="subject"
                                    required
                                    class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-300 transition bg-white"
                                    >
                                    <option value="">-- Chọn chủ đề --</option>
                                    <option value="Chất lượng bể bơi">Chất lượng bể bơi</option>
                                    <option value="Thái độ phục vụ">Thái độ phục vụ</option>
                                    <option value="Cơ sở vật chất">Cơ sở vật chất</option>
                                    <option value="Góp ý khác">Góp ý khác</option>
                                </select>
                                <span class="text-red-500 text-sm hidden" id="errSubject"></span>
                            </div>
                        </div>
                        <div>
                            <label for="message" class="block mb-1 font-medium text-gray-700">Nội dung<span class="text-red-500">*</span></label>
                            <textarea
                                id="message"
                                name="message"
                                required
                                rows="5"
                                minlength="10"
                                maxlength="1000"
                                placeholder="Nhập nội dung liên hệ..."
                                class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-300 transition resize-none"
                                ></textarea>
                            <span class="text-red-500 text-sm hidden" id="errMessage"></span>
                        </div>
                        <div class="flex justify-end">
                            <button
                                type="submit"
                                class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-semibold px-8 py-2 rounded-lg shadow transition text-lg active:scale-95"
                                >
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Gửi
                            </button>
                        </div>
                    </form>
                </section>
            </div>
        </div>
        <!-- footer -->
        <footer class="bg-gray-900 text-white pt-12">
            <div class="container mx-auto px-4 grid grid-cols-1 md:grid-cols-3 gap-10 pb-10">
                <!-- Liên Hệ -->
                <div>
                    <h3 class="text-xl font-semibold mb-4 text-[#33CCFF]">Liên Hệ Chúng Tôi</h3>
                    <ul class="space-y-3 text-gray-300">
                        <li class="flex items-center gap-2">
                            <i class="fa fa-map-marker text-[#33CCFF]"></i> Địa chỉ
                        </li>
                        <li class="flex items-center gap-2">
                            <i class="fa fa-mobile text-[#33CCFF]"></i> +01 1234569540
                        </li>
                        <li class="flex items-center gap-2">
                            <i class="fa fa-envelope text-[#33CCFF]"></i>
                            <a href="mailto:poolhub@gmail.com" class="hover:underline">poolhub@gmail.com</a>
                        </li>
                    </ul>
                </div>

                <!-- Liên Kết Menu -->
                <div>
                    <h3 class="text-xl font-semibold mb-4 text-[#33CCFF]">Liên Kết Menu</h3>
                    <ul class="space-y-2 text-gray-300">
                        <li><a href="#" class="hover:text-[#33CCFF] transition">Trang Chủ</a></li>
                        <li><a href="#" class="hover:text-[#33CCFF] transition">Về Chúng Tôi</a></li>
                        <li><a href="#" class="hover:text-[#33CCFF] transition">Bể Bơi</a></li>
                        <li><a href="#" class="hover:text-[#33CCFF] transition">Thư Viện Hình Ảnh</a></li>
                        <li><a href="#" class="hover:text-[#33CCFF] transition">Đánh Giá</a></li>
                        <li><a href="#" class="hover:text-[#33CCFF] transition">Liên Hệ</a></li>
                    </ul>
                </div>

                <!-- Đăng ký bản tin -->
                <div>
                    <h3 class="text-xl font-semibold mb-4 text-[#33CCFF]">Bản Tin</h3>
                    <form class="flex flex-col gap-3 mb-4">
                        <input type="email" placeholder="Nhập email của bạn" 
                               class="w-full px-4 py-2 rounded-lg text-black focus:outline-none focus:ring-2 focus:ring-[#33CCFF]" />
                        <button type="submit" class="bg-[#33CCFF] text-white px-4 py-2 rounded-lg hover:bg-[#1BAFDA] transition">Đăng Ký</button>
                    </form>

                    <div class="flex space-x-4">
                        <a href="#"><i class="fa fa-facebook text-2xl hover:text-[#33CCFF] transition"></i></a>
                        <a href="#"><i class="fa fa-twitter text-2xl hover:text-[#33CCFF] transition"></i></a>
                        <a href="#"><i class="fa fa-linkedin text-2xl hover:text-[#33CCFF] transition"></i></a>
                        <a href="#"><i class="fa fa-youtube-play text-2xl hover:text-[#33CCFF] transition"></i></a>
                    </div>
                </div>
            </div>

            <!-- Copyright -->
            <div class="border-t border-gray-700 py-4 text-center text-gray-400 text-sm">
                © 2025 Tất cả quyền được bảo lưu. Thiết kế và phân phối bởi <span class="text-[#33CCFF] font-semibold">PoolHub</span>.
            </div>
        </footer>
        <!-- end footer -->
    </body>
    <script>
        document.getElementById('contactForm').addEventListener('submit', function (e) {
            let valid = true;

            // Validate name
            let name = document.getElementById('name').value.trim();
            let errName = document.getElementById('errName');
            if (!name) {
                errName.innerText = "Vui lòng nhập họ và tên";
                errName.classList.remove('hidden');
                valid = false;
            } else if (name.length < 2) {
                errName.innerText = "Họ và tên quá ngắn";
                errName.classList.remove('hidden');
                valid = false;
            } else if (name.length > 50) {
                errName.innerText = "Họ và tên quá dài";
                errName.classList.remove('hidden');
                valid = false;
            } else if (!/^[\p{L} ]+$/u.test(name)) {
                errName.innerText = "Họ và tên chỉ được chứa chữ cái";
                errName.classList.remove('hidden');
                valid = false;
            } else if (/ {2,}/.test(name)) { // Kiểm tra có nhiều hơn 1 khoảng trắng liên tiếp
                errName.innerText = "Không chứa hơn một khoảng trắng liên tiếp";
                errName.classList.remove('hidden');
                valid = false;
            } else {
                errName.classList.add('hidden');
            }

            // Validate email
            let email = document.getElementById('email').value.trim();
            let errEmail = document.getElementById('errEmail');
            let emailRegex = /^[\w.%+-]+@[\w.-]+\.[a-zA-Z]{2,}$/;
            if (!email) {
                errEmail.innerText = "Vui lòng nhập email";
                errEmail.classList.remove('hidden');
                valid = false;
            } else if (email.length > 100) {
                errEmail.innerText = "Email quá dài";
                errEmail.classList.remove('hidden');
                valid = false;
            } else if (!emailRegex.test(email)) {
                errEmail.innerText = "Email không đúng định dạng";
                errEmail.classList.remove('hidden');
                valid = false;
            } else {
                errEmail.classList.add('hidden');
            }

            // Validate subject
            let subject = document.getElementById('subject').value;
            let errSubject = document.getElementById('errSubject');
            if (!subject) {
                errSubject.innerText = "Vui lòng chọn chủ đề";
                errSubject.classList.remove('hidden');
                valid = false;
            } else {
                errSubject.classList.add('hidden');
            }

            // Validate message
            let message = document.getElementById('message').value;
            let errMessage = document.getElementById('errMessage');
            if (!message.trim()) {
                errMessage.innerText = "Vui lòng nhập nội dung";
                errMessage.classList.remove('hidden');
                valid = false;
            } else if (message.trim().length < 10) {
                errMessage.innerText = "Nội dung phải chứa ít nhất 10 ký tự";
                errMessage.classList.remove('hidden');
                valid = false;
            } else if (message.length > 1000) {
                errMessage.innerText = "Nội dung không được vượt quá 1000 ký tự";
                errMessage.classList.remove('hidden');
                valid = false;
            } else {
                errMessage.classList.add('hidden');
            }

            if (!valid) {
                e.preventDefault();
            }
        });
    </script>
</html>