<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Thiết lập bảo mật</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="css/styles.css" />
    </head>
    <body class="bg-gray-50 min-h-screen font-['Inter'] antialiased">
        <%@include file="header.jsp" %>
        <div class="container mx-auto px-4 py-8">
            <a href="my_account" class="inline-flex items-center text-blue-600 font-medium mb-8 hover:underline">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                </svg>
                Tài khoản của tôi
            </a>

            <div class="relative w-full h-52 md:h-64 mb-8 rounded-lg overflow-hidden shadow-lg">
                <img src="https://images.pexels.com/photos/3184291/pexels-photo-3184291.jpeg" alt="Security Settings Banner"
                     class="w-full h-full object-cover" />
                <div class="absolute inset-0 bg-gradient-to-b from-black/30 to-black/10"></div>
                <h1 class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-3xl md:text-4xl font-bold text-white text-center drop-shadow-lg">
                    THIẾT LẬP BẢO MẬT
                </h1>
            </div>

            <div class="flex flex-col lg:flex-row gap-8">
                <!-- Sidebar -->
                <aside class="bg-white border border-gray-200 rounded-lg p-6 w-full lg:w-1/4 mb-6 lg:mb-0 shadow-sm">
                    <nav class="space-y-2">
                        <a href="profile" class="flex items-center gap-2 px-3 py-2 rounded-lg hover:bg-blue-50 text-gray-700 font-medium">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M5.121 17.804A13.937 13.937 0 0112 15c2.589 0 5.017.735 7.121 2.004M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                            </svg>
                            Thông tin cá nhân
                        </a>
                        <a href="change_password"
                           class="flex items-center gap-2 px-3 py-2 rounded-lg bg-blue-100 text-blue-700 font-semibold">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M12 11c0-1.054.816-2 2-2s2 .946 2 2a2 2 0 01-2 2c-1.184 0-2-.946-2-2zm0 0V7m0 4v4m0-4h4m-4 0H8"/>
                            </svg>
                            Thiết lập bảo mật
                        </a>
                        <a href="payment-methods.jsp"
                           class="flex items-center gap-2 px-3 py-2 rounded-lg hover:bg-blue-50 text-gray-700 font-medium">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M17 9V7a5 5 0 00-10 0v2a2 2 0 00-2 2v6a2 2 0 002 2h10a2 2 0 002-2v-6a2 2 0 00-2-2z"/>
                            </svg>
                            Phương thức thanh toán
                        </a>
                    </nav>
                </aside>

                <!-- Form -->
                <section class="flex-1 bg-white border border-gray-200 rounded-lg p-8 shadow-sm">
                    <h2 class="text-2xl font-bold mb-8 text-blue-700">Đổi mật khẩu</h2>

                    <!-- Hiển thị lỗi -->
                    <div id="errorMessage" class="hidden mb-6 p-4 rounded bg-red-100 text-red-800"></div>

                    <% String message = (String) request.getAttribute("message");
               if (message != null && !message.isEmpty()) { %>
                    <div class="mb-6 p-4 rounded <%= message.contains("thành công") ? "bg-green-100 text-green-800" : "bg-red-100 text-red-800" %>">
                        <%= message %>
                    </div>
                    <% } %>

                    <form action="change_password" method="post" onsubmit="return validateForm()">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="md:col-span-2">
                                <label class="block text-gray-600 mb-1 font-medium">Mật khẩu hiện tại</label>
                                <div class="relative">
                                    <input type="password" id="current_password" name="current_password"
                                           class="w-full border border-gray-300 rounded-md px-4 py-2 pr-12 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                           placeholder="Nhập mật khẩu hiện tại" required />
                                    <button type="button" onclick="togglePassword('current_password', this)"
                                            class="absolute right-2 top-2 text-gray-500 hover:text-blue-600" tabindex="-1">Hiện</button>
                                </div>
                            </div>
                            <div>
                                <label class="block text-gray-600 mb-1 font-medium">Mật khẩu mới</label>
                                <div class="relative">
                                    <input type="password" id="new_password" name="new_password"
                                           class="w-full border border-gray-300 rounded-md px-4 py-2 pr-12 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                           placeholder="Nhập mật khẩu mới" required />
                                    <button type="button" onclick="togglePassword('new_password', this)"
                                            class="absolute right-2 top-2 text-gray-500 hover:text-blue-600" tabindex="-1">Hiện</button>
                                </div>
                            </div>
                            <div>
                                <label class="block text-gray-600 mb-1 font-medium">Xác nhận mật khẩu mới</label>
                                <div class="relative">
                                    <input type="password" id="confirm_password" name="confirm_password"
                                           class="w-full border border-gray-300 rounded-md px-4 py-2 pr-12 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                           placeholder="Nhập lại mật khẩu mới" required />
                                    <button type="button" onclick="togglePassword('confirm_password', this)"
                                            class="absolute right-2 top-2 text-gray-500 hover:text-blue-600" tabindex="-1">Hiện</button>
                                </div>
                            </div>
                            <div class="mt-8 flex justify-end">
                                <button type="submit"
                                        class="bg-blue-600 text-white px-6 py-2 rounded-md font-semibold shadow hover:bg-blue-700 transition-colors">
                                    Đổi mật khẩu
                                </button>
                            </div>
                        </div>
                    </form>
                </section>
            </div>
        </div>

        <script>
            function togglePassword(inputId, btn) {
                const input = document.getElementById(inputId);
                const isPassword = input.type === 'password';
                input.type = isPassword ? 'text' : 'password';
                btn.innerText = isPassword ? 'Ẩn' : 'Hiện';
            }

            function validateForm() {
                const oldPass = document.getElementById("current_password").value;
                const newPass = document.getElementById("new_password").value;
                const confirm = document.getElementById("confirm_password").value;
                const errorBox = document.getElementById("errorMessage");

                // Logic giống Java
                if (!newPass || newPass.length < 8) {
                    showError("Mật khẩu mới phải có ít nhất 8 ký tự!");
                    return false;
                }
                if (/\s/.test(newPass)) {
                    showError("Mật khẩu mới không được chứa khoảng trắng!");
                    return false;
                }

                let groups = 0;
                if (/[a-z]/.test(newPass))
                    groups++;
                if (/[A-Z]/.test(newPass))
                    groups++;
                if (/\d/.test(newPass))
                    groups++;
                if (/[^a-zA-Z0-9]/.test(newPass))
                    groups++;
                if (groups < 3) {
                    showError("Mật khẩu mới phải có ít nhất 3 trong 4 nhóm: chữ thường, chữ hoa, số, ký tự đặc biệt!");
                    return false;
                }

                if (newPass === oldPass) {
                    showError("Mật khẩu mới không được trùng với mật khẩu hiện tại!");
                    return false;
                }

                if (newPass !== confirm) {
                    showError("Mật khẩu mới và xác nhận không khớp!");
                    return false;
                }

                errorBox.classList.add("hidden");
                return true;
            }

            function showError(msg) {
                const errorBox = document.getElementById("errorMessage");
                errorBox.innerText = msg;
                errorBox.classList.remove("hidden");
                window.scrollTo({top: 0, behavior: "smooth"});
            }
        </script>
    </body>
</html>
