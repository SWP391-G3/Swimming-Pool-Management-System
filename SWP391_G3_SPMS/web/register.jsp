<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Đăng ký</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: "#0072ff",
                        },
                    },
                },
            };
        </script>
        <style>
            body {
                background: linear-gradient(180deg, #87e0fd 0%, #53cbf1 40%, #05abe0 100%);
                background-size: 300% 300%;
                animation: backgroundMotion 30s ease-in-out infinite;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                overflow: hidden;
                position: relative;
            }

            @keyframes backgroundMotion {
                0% {
                    background-position: 0% 50%;
                }
                50% {
                    background-position: 100% 50%;
                }
                100% {
                    background-position: 0% 50%;
                }
            }

            .wave-layer {
                position: absolute;
                bottom: 0;
                left: 0;
                width: 200%;
                height: 200px;
                background: url("data:image/svg+xml;utf8,<svg viewBox='0 0 1440 320' xmlns='http://www.w3.org/2000/svg'><path fill='%23ffffff' fill-opacity='0.3' d='M0,160L80,149.3C160,139,320,117,480,106.7C640,96,800,96,960,122.7C1120,149,1280,203,1360,229.3L1440,256L1440,320L1360,320C1280,320,1120,320,960,320C800,320,640,320,480,320C320,320,160,320,80,320L0,320Z'></path></svg>") repeat-x;
                animation: waveMove 20s linear infinite;
                z-index: -1;
                background-size: cover;
            }

            @keyframes waveMove {
                0% {
                    transform: translateX(0);
                }
                100% {
                    transform: translateX(-25%);
                }
            }
        </style>
    </head>
    <body>
        <div class="wave-layer"></div>

        <div class="bg-white/90 backdrop-blur-xl shadow-2xl rounded-2xl w-full max-w-4xl p-10">
            <h2 class="text-3xl font-bold text-center text-primary mb-6">Đăng ký</h2>

            <c:if test="${not empty error}">
                <p class="bg-red-100 text-red-700 p-3 rounded text-sm font-semibold text-center mb-4">${error}</p>
            </c:if>
            <c:if test="${not empty mess}">
                <p class="bg-green-200 text-green-800 p-3 rounded text-sm font-semibold text-center mb-4">${mess}</p>
            </c:if>

            <form action="register" method="POST" autocomplete="off">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label class="block mb-1 text-sm font-medium text-gray-700">Họ và tên</label>
                        <input
                            type="text"
                            name="full_name"
                            placeholder="Nhập họ và tên"
                            value="${param.full_name != null ? param.full_name : ''}"
                            pattern="^(?=.{4,50}$)[A-Za-zÀ-ỹĐđ'\\-]+( [A-Za-zÀ-ỹĐđ'\\-]+)*$"
                            title="Họ tên phải dài từ 4 đến 50 ký tự, chỉ bao gồm chữ cái và 1 khoảng trắng"
                            required
                            class="w-full px-4 py-2 border rounded-lg bg-white focus:outline-none focus:ring-2 focus:ring-primary"
                            />
                    </div>

                    <div>
                        <label class="block mb-1 text-sm font-medium text-gray-700">Email</label>
                        <input
                            type="email"
                            name="email"
                            placeholder="email@gmail.com"
                            value="${param.email != null ? param.email : ''}"
                            required
                            class="w-full px-4 py-2 border rounded-lg bg-white focus:outline-none focus:ring-2 focus:ring-primary"
                            />
                    </div>

                    <div>
                        <label class="block mb-1 text-sm font-medium text-gray-700">Số điện thoại</label>
                        <input
                            type="tel"
                            name="phone"
                            placeholder="Nhập số điện thoại"
                            value="${param.phone != null ? param.phone : ''}"
                            pattern="^0\\d{9}$"
                            required
                            class="w-full px-4 py-2 border rounded-lg bg-white focus:outline-none focus:ring-2 focus:ring-primary"
                            />
                    </div>

                    <div>
                        <label class="block mb-1 text-sm font-medium text-gray-700">Tên đăng nhập</label>
                        <input
                            type="text"
                            name="username"
                            placeholder="Tên đăng nhập"
                            value="${param.username != null ? param.username : ''}"
                            pattern="^[A-Za-z0-9]{4,50}$"
                            required
                            class="w-full px-4 py-2 border rounded-lg bg-white focus:outline-none focus:ring-2 focus:ring-primary"
                            />
                    </div>

                    <div>
                        <label class="block mb-1 text-sm font-medium text-gray-700">Mật khẩu</label>
                        <input
                            type="password"
                            name="password"
                            placeholder="Nhập mật khẩu"
                            required
                            class="w-full px-4 py-2 border rounded-lg bg-white focus:outline-none focus:ring-2 focus:ring-primary"
                            />
                    </div>

                    <div>
                        <label class="block mb-1 text-sm font-medium text-gray-700">Nhập lại mật khẩu</label>
                        <input
                            type="password"
                            name="confirm_password"
                            placeholder="Nhập lại mật khẩu"
                            required
                            class="w-full px-4 py-2 border rounded-lg bg-white focus:outline-none focus:ring-2 focus:ring-primary"
                            />
                    </div>
                </div>

                <div class="mt-6">
                    <button
                        type="submit"
                        class="w-full bg-primary text-white font-semibold py-3 rounded-lg hover:bg-blue-600 transition duration-300"
                        >
                        Đăng ký
                    </button>
                </div>
            </form>

            <div class="text-center mt-6 text-sm text-gray-700">
                <a href="LandingPage.jsp" class="hover:underline">← Quay lại trang chủ</a>
            </div>
            <div class="text-center text-sm mt-1 text-gray-700">
                Đã có tài khoản? <a href="login.jsp" class="text-primary hover:underline font-medium">Đăng nhập</a>
            </div>
        </div>
    </body>
</html>
