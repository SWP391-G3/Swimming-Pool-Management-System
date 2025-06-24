<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý nhân viên</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="bg-gray-100 text-gray-800">
        <%
            User currentUser = (User) session.getAttribute("currentUser");
            String userName = currentUser != null ? currentUser.getFull_name() : "";
        %>

        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <nav id="sidebar" class="w-64 bg-[#000033] text-white p-6 flex flex-col space-y-4 fixed h-full">
                <div class="mb-6 text-center">
                    <h1 class="text-2xl font-bold">Admin Panel</h1>
                    <p class="text-sm text-gray-300">Swimming Pool System</p>
                </div>

                <div class="flex items-center gap-3 mb-6">
                    <img src="https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/465/avatar-trang-1.jpg"
                         alt="Avatar"
                         class="w-12 h-12 rounded-full border-2 border-white object-cover"/>
                    <div>
                        <h4 class="text-base font-semibold"><%= userName %></h4>
                        <a href="#" class="text-sm text-blue-300 hover:underline">Xem chi tiết</a>
                    </div>
                </div>

                <a href="adminPoolManagement"
                   class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2">
                    <i class="fa-solid fa-water"></i> Quản lý bể bơi
                </a>

                <a href="#" class="bg-blue-900 ring-2 ring-white px-3 py-2 rounded flex items-center gap-2">
                    <i class="fa-solid fa-user-tie"></i> Quản lý nhân viên
                </a>

                <a href="adminViewCustomerList"
                   class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2">
                    <i class="fa-solid fa-user-check"></i> Quản lý khách hàng
                </a>

                <a href="#"
                   class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2">
                    <i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo
                </a>

                <a href="#"
                   class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2">
                    <i class="fa-solid fa-gear"></i> Cài đặt hệ thống
                </a>

                <a href="LogoutServlet"
                   class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 text-red-400">
                    <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                </a>
            </nav>

            <!-- Main content -->
            <main class="ml-64 w-full p-8">
                <div class="bg-white shadow rounded-xl p-8">
                    <h2 class="text-2xl font-bold text-blue-700 mb-6">
                        Chào mừng <%= userName %>, chọn một chức năng để quản lý:
                    </h2>

                    <div class="grid grid-cols-2 gap-6">
                        <!-- Nhân viên bể bơi -->
                        <a href="adminViewEmployeeList"
                           class="bg-white border border-blue-500 rounded-xl p-6 text-center hover:shadow-lg transition">
                            <i class="fa-solid fa-users-gear text-4xl text-blue-600 mb-4"></i>
                            <h3 class="text-lg font-semibold text-blue-700">Nhân viên bể bơi</h3>
                            <p class="text-sm text-gray-600 mt-2">
                                Xem và phân công nhân viên vận hành theo từng bể bơi, khu vực
                            </p>
                        </a>

                        <!-- Quản lý bể bơi -->
                        <a href="adminViewManagerList"
                           class="bg-white border border-green-500 rounded-xl p-6 text-center hover:shadow-lg transition">
                            <i class="fa-solid fa-user-shield text-4xl text-green-600 mb-4"></i>
                            <h3 class="text-lg font-semibold text-green-700">Quản lý bể bơi</h3>
                            <p class="text-sm text-gray-600 mt-2">
                                Theo dõi và bổ nhiệm người quản lý chịu trách nhiệm cho từng bể bơi, khu vực
                            </p>
                        </a>
                    </div>
                </div>
            </main>
        </div>
    </body>
</html>
