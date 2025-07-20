<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% 
    java.time.LocalDate now = java.time.LocalDate.now();
    java.time.LocalDate minDob = now.minusYears(14);
    pageContext.setAttribute("maxDob", minDob.toString());
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Đăng ký tài khoản</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            body {
                background: linear-gradient(180deg, #a0e9ff 0%, #6dd5fa 100%);
                overflow: hidden;
                position: relative;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
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
    <body>
        <div class="wave"></div>
        <div class="wave"></div>
        <div class="wave"></div>

        <div class="relative z-10 bg-white/80 backdrop-blur-xl shadow-2xl rounded-2xl w-full max-w-3xl p-10 space-y-8">
            <h2 class="text-2xl font-bold text-center text-blue-600">Đăng ký tài khoản</h2>

            <c:if test="${not empty requestScope.error}">
                <p class="bg-red-100 text-red-700 p-3 rounded text-sm text-center">${requestScope.error}</p>
            </c:if>
            <c:if test="${not empty sessionScope.message}">
                <p class="bg-green-200 text-green-800 p-3 rounded text-sm text-center">${sessionScope.message}</p>
                <c:remove var="message" scope="session" />
            </c:if>

            <!-- STEP 1: Form đăng ký -->
            <c:if test="${empty param.step || param.step == 'info'}">
                <form action="register" method="POST" class="space-y-6" autocomplete="off">
                    <input type="hidden" name="step" value="info" />

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Cột trái -->
                        <div class="space-y-4">
                            <input type="text" name="full_name" placeholder="Họ và tên"
                                   value="${param.full_name != null ? param.full_name : ''}"
                                   class="w-full px-4 py-2 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400" required />

                            <input type="tel" name="phone" placeholder="Số điện thoại"
                                   pattern="0[0-9]{9}"
                                   title="Số điện thoại phải bắt đầu bằng 0 và có đúng 10 chữ số"
                                   value="${param.phone != null ? param.phone : ''}"
                                   class="w-full px-4 py-2 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                   required />

                            <input type="date" name="dob" max="${maxDob}"
                                   class="w-full px-4 py-2 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                   required
                                   title="Bạn phải từ 14 tuổi trở lên" />

                            <div class="relative">
                                <input type="password" id="passwordInput" name="password" placeholder="Mật khẩu"
                                       class="w-full px-4 py-2 pr-10 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400" required />
                                <button type="button" id="togglePassword" class="absolute top-2.5 right-3 text-gray-600">
                                    <svg id="eyeIcon1" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M2.458 12C3.732 7.943 7.523 5 12 5
                                          s8.268 2.943 9.542 7c-1.274 4.057-5.065 7-9.542 7
                                          S3.732 16.057 2.458 12z" />
                                    </svg>
                                </button>
                            </div>
                        </div>

                        <!-- Cột phải -->
                        <div class="space-y-4">
                            <input type="email" name="email" placeholder="Email"
                                   value="${param.email != null ? param.email : ''}"
                                   class="w-full px-4 py-2 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400" required />

                            <input type="text" name="username" placeholder="Tên đăng nhập"
                                   value="${param.username != null ? param.username : ''}"
                                   class="w-full px-4 py-2 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400" required />

                            <input type="text" name="address" placeholder="Địa chỉ (tùy chọn)"
                                   value="${param.address != null ? param.address : ''}"
                                   class="w-full px-4 py-2 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400" />

                            <div class="relative">
                                <input type="password" id="confirmPasswordInput" name="confirm_password" placeholder="Nhập lại mật khẩu"
                                       class="w-full px-4 py-2 pr-10 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400" required />
                                <button type="button" id="toggleConfirmPassword" class="absolute top-2.5 right-3 text-gray-600">
                                    <svg id="eyeIcon2" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M2.458 12C3.732 7.943 7.523 5 12 5
                                          s8.268 2.943 9.542 7c-1.274 4.057-5.065 7-9.542 7
                                          S3.732 16.057 2.458 12z" />
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </div>

                    <button type="submit"
                            class="w-full bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition duration-300">
                        Đăng ký & gửi OTP
                    </button>
                </form>
            </c:if>

            <!-- STEP 2: Xác nhận OTP -->
            <c:if test="${param.step == 'otp'}">
                <form method="post" action="register" class="space-y-4">
                    <input type="hidden" name="step" value="otp" />
                    <label class="block text-sm font-medium text-gray-700">Nhập mã OTP bạn nhận được</label>
                    <input type="text" name="otp" placeholder="Mã OTP"
                           class="w-full px-4 py-2 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400" required />

                    <button type="submit"
                            class="w-full bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition duration-300">
                        Xác nhận OTP
                    </button>
                </form>

                <div class="text-center mt-2">
                    <a href="register?step=resend"
                       class="text-yellow-600 font-medium hover:underline">
                        Gửi lại mã OTP
                    </a>
                </div>

            </c:if>

            <div class="text-center mt-4">
                <a href="login.jsp" class="text-sm text-gray-600 hover:underline">← Quay lại đăng nhập</a>
            </div>
        </div>

        <script>
            function togglePasswordVisibility(inputId, iconId) {
                const input = document.getElementById(inputId);
                const icon = document.getElementById(iconId);
                const isHidden = input.type === "password";

                input.type = isHidden ? "text" : "password";
                icon.innerHTML = isHidden
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
            }

            document.getElementById("togglePassword").addEventListener("click", () => {
                togglePasswordVisibility("passwordInput", "eyeIcon1");
            });

            document.getElementById("toggleConfirmPassword").addEventListener("click", () => {
                togglePasswordVisibility("confirmPasswordInput", "eyeIcon2");
            });
        </script>

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