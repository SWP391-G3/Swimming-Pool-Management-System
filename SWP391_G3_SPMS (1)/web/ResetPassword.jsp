<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Đặt lại mật khẩu</title>
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

        <!-- Waves -->
        <div class="wave"></div>
        <div class="wave"></div>
        <div class="wave"></div>

        <!-- Form container -->
        <div class="relative z-10 bg-white/80 backdrop-blur-xl shadow-2xl rounded-2xl w-full max-w-md p-8 space-y-6">
            <h2 class="text-2xl font-bold text-center text-blue-600">Khôi phục mật khẩu</h2>



            <c:if test="${not empty sessionScope.message}">
                <p class="bg-green-100 text-green-700 p-3 rounded text-sm text-center">${sessionScope.message}</p>
                <c:remove var="message" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <p class="bg-red-100 text-red-700 p-3 rounded text-sm text-center">${sessionScope.error}</p>
                <c:remove var="error" scope="session"/>
            </c:if>

            <!-- STEP 1: Nhập Email -->
            <c:if test="${empty param.step || param.step == 'email'}">
                <form method="post" action="reset-password" class="space-y-4">
                    <input type="hidden" name="step" value="email" />
                    <label class="block text-sm font-medium text-gray-700">Email đã đăng ký</label>
                    <input type="email" name="email" placeholder="Nhập email"
                           class="w-full px-4 py-2 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400" required />
                    <button type="submit"
                            class="w-full bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition duration-300">
                        Gửi mã OTP
                    </button>
                </form>
            </c:if>

            <!-- STEP 2: Nhập OTP -->
            <c:if test="${param.step == 'otp'}">
                <form method="post" action="reset-password" class="space-y-4">
                    <input type="hidden" name="step" value="otp" />
                    <label class="block text-sm font-medium text-gray-700">Nhập mã OTP bạn nhận được</label>
                    <input type="text" name="otp" placeholder="Mã OTP"
                           class="w-full px-4 py-2 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400" required />
                    <button type="submit"
                            class="w-full bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition duration-300">
                        Xác nhận OTP
                    </button>
                </form>
            </c:if>

            <!-- STEP 3: Nhập mật khẩu mới -->
            <c:if test="${param.step == 'newpass'}">
                <form method="post" action="reset-password" class="space-y-4">
                    <input type="hidden" name="step" value="newpass" />
                    <label class="block text-sm font-medium text-gray-700">Mật khẩu mới</label>
                    <input type="password" name="newPassword" placeholder="Nhập mật khẩu mới"
                           class="w-full px-4 py-2 border rounded-lg bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400" required />
                    <button type="submit"
                            class="w-full bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition duration-300">
                        Đặt lại mật khẩu
                    </button>
                </form>
            </c:if>

            <div class="text-center mt-4">
                <a href="login.jsp" class="text-sm text-gray-600 hover:underline">← Quay lại đăng nhập</a>
            </div>
        </div>

        <!-- Bubble animation -->
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
