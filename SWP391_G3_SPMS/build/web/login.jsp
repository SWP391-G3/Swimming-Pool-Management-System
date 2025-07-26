<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Đăng nhập</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            body {
                background: linear-gradient(180deg, #a0e9ff 0%, #6dd5fa 100%);
                overflow: hidden;
                position: relative;
            }

            .wave {
                position: absolute;
                bottom: 0;
                width: 200%;
                height: 100px;
                background: rgba(255, 255, 255, 0.3);
                border-radius: 100% 100% 0 0;
                animation: wave 8s linear infinite;
                z-index: 0;
            }

            .wave:nth-child(2) {
                animation-delay: 2s;
                opacity: 0.5;
            }

            .wave:nth-child(3) {
                animation-delay: 4s;
                opacity: 0.3;
            }

            @keyframes wave {
                0% {
                    transform: translateX(0);
                }
                100% {
                    transform: translateX(-50%);
                }
            }

            .bubble {
                position: absolute;
                bottom: -50px;
                background-color: rgba(255, 255, 255, 0.3);
                border-radius: 50%;
                animation: rise 10s infinite ease-in;
                opacity: 0.7;
                z-index: 0;
            }

            @keyframes rise {
                0% {
                    transform: translateY(0) scale(1);
                    opacity: 0.5;
                }
                100% {
                    transform: translateY(-120vh) scale(0.8);
                    opacity: 0;
                }
            }
        </style>
    </head>
    <body class="min-h-screen flex items-center justify-center">
        <!-- Sóng -->
        <div class="wave"></div>
        <div class="wave"></div>
        <div class="wave"></div>

        <!-- Form đăng nhập -->
        <div class="relative z-10 bg-white/80 backdrop-blur-xl shadow-2xl rounded-2xl w-full max-w-md p-8 space-y-6">
            <h2 class="text-2xl font-bold text-center text-blue-600">Đăng nhập</h2>




            <!-- ❌ Thông báo lỗi -->
            <c:if test="${not empty error}">
                <p class="bg-red-100 text-red-700 p-3 rounded text-sm font-semibold text-center">${error}</p>
            </c:if>

            <form action="login" method="POST" class="space-y-4" autocomplete="off">
                <div>
                    <label for="usernameInput" class="block text-sm font-medium text-gray-700 mb-1">Tên đăng nhập</label>
                    <input
                        type="text"
                        id="usernameInput"
                        name="username"
                        placeholder="Nhập tên đăng nhập"
                        class="w-full px-4 py-2 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400"
                        required  />
                </div>
                <div class="relative">
                    <label for="passwordInput" class="block text-sm font-medium text-gray-700 mb-1">Mật khẩu</label>
                    <input
                        type="password"
                        id="passwordInput"
                        name="password"
                        placeholder="Nhập mật khẩu"
                        class="w-full px-4 py-2 pr-10 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400"
                        required />

                    <!-- Nút icon -->
                    <button type="button" id="togglePassword" class="absolute top-8 right-3 text-gray-600">
                        <!-- Mặc định là icon con mắt (mật khẩu đang ẩn) -->
                        <svg id="eyeIcon" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M2.458 12C3.732 7.943 7.523 5 12 5s8.268 2.943 9.542 7c-1.274 4.057-5.065 7-9.542 7S3.732 16.057 2.458 12z" />
                        </svg>
                    </button>
                </div>

                <script>
                    const passwordInput = document.getElementById("passwordInput");
                    const toggleButton = document.getElementById("togglePassword");
                    const eyeIcon = document.getElementById("eyeIcon");

                    let isPasswordVisible = false;

                    toggleButton.addEventListener("click", function () {
                        isPasswordVisible = !isPasswordVisible;
                        passwordInput.type = isPasswordVisible ? "text" : "password";

                        // Đổi icon SVG thành có gạch hoặc không
                        eyeIcon.innerHTML = isPasswordVisible
                                ? `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M13.875 18.825A10.05 10.05 0 0112 19c-4.477 0-8.268-2.943-9.542-7
                     a9.956 9.956 0 012.345-4.288M6.7 6.7
                     A9.966 9.966 0 0112 5c4.477 0 8.268 2.943 9.542 7
                     a9.954 9.954 0 01-4.293 5.144M15 12a3 3 0 01-3 3m0-6a3 3 0 013 3m0 0L4 4" />`
                                : `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
             <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M2.458 12C3.732 7.943 7.523 5 12 5
                     s8.268 2.943 9.542 7c-1.274 4.057-5.065 7-9.542 7
                     S3.732 16.057 2.458 12z" />`;
                    });
                </script>





                <a href="ResetPassword.jsp" class="text-blue-600 font-regular text-sm hover:underline">Quên mật khẩu?</a>
                <button
                    type="submit" id="btLogin"
                    class="w-full bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition duration-300"
                    >
                    Đăng nhập
                </button>
            </form>

            <div class="text-center text-sm text-gray-600">
                Bạn chưa có tài khoản?
                <a href="register.jsp" class="text-blue-600 font-medium hover:underline">Đăng ký ngay</a>
            </div>

            <!-- Divider -->
            <div class="flex items-center justify-center gap-4 my-4">
                <hr class="w-full border-gray-300" />
                <span class="text-gray-400 text-sm font-medium">hoặc</span>
                <hr class="w-full border-gray-300" />
            </div>

            <!-- Google login -->
            <a
                href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/SWP391_G3_SPMS/LoginGoogle&response_type=code&client_id=1011626607904-oroog9kq0dj2t481qcqkp39325sgcjvj.apps.googleusercontent.com&approval_prompt=force"
                class="flex items-center justify-center gap-2 border rounded-lg py-2 px-4 bg-white/90 text-gray-700 shadow hover:shadow-md transition"
                >
                <img src="https://www.svgrepo.com/show/355037/google.svg" class="w-5 h-5" />
                Đăng nhập với Google
            </a>

            <div class="text-center mt-4">
                <a href="LandingPage.jsp" class="text-sm text-gray-600 hover:underline">← Quay lại trang chủ</a>
            </div>
        </div>

        <!-- Bong bóng -->
        <script>
            const createBubbles = () => {
                for (let i = 0; i < 50; i++) {
                    const bubble = document.createElement("div");
                    const size = Math.random() * 20 + 10;
                    bubble.classList.add("bubble");
                    bubble.style.width = `${size}px`;
                    bubble.style.height = `${size}px`;
                    bubble.style.left = `${Math.random() * 100}%`;
                    bubble.style.animationDuration = `${5 + Math.random() * 5}s`;
                    bubble.style.animationDelay = `${Math.random() * 5}s`;
                    document.body.appendChild(bubble);
                }
            };
            window.onload = createBubbles;
        </script>
    </body>
</html>
