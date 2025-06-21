<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    String userName = currentUser != null ? currentUser.getFull_name() : "Admin";
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Quản Lý Mới</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="bg-gray-50 text-gray-800 font-sans">

        <!-- Sidebar -->
        <nav id="sidebar" class="w-64 bg-[#001F3F] text-white p-6 flex flex-col space-y-5 fixed h-full z-40">
            <div class="text-center mb-4">
                <h1 class="text-2xl font-bold tracking-wide">Admin Panel</h1>
                <p class="text-sm text-gray-300">Swimming Pool System</p>
            </div>

            <div class="flex items-center gap-4 mb-6">
                <img src="https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/465/avatar-trang-1.jpg" class="w-12 h-12 rounded-full border-2 border-white object-cover">
                <div>
                    <p class="font-semibold text-lg"><%= userName %></p>
                    <a href="#" class="text-sm text-blue-300 hover:underline">Xem chi tiết</a>
                </div>
            </div>

            <a href="adminPoolManagement" class="flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-blue-800 transition">
                <i class="fa-solid fa-water"></i> Quản lý bể bơi
            </a>
            <a href="adminViewStaffCategory.jsp" class="flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-blue-800 transition">
                <i class="fa-solid fa-user-tie"></i> Quản lý nhân viên
            </a>
            <a href="adminViewCustomerList" class="flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-blue-800 transition">
                <i class="fa-solid fa-user-check"></i> Quản lý khách hàng
            </a>
            <a href="#" class="flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-blue-800 transition">
                <i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo
            </a>
            <a href="#" class="flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-blue-800 transition">
                <i class="fa-solid fa-gear"></i> Cài đặt hệ thống
            </a>
            <a href="LogoutServlet" class="flex items-center gap-3 px-4 py-2 rounded-lg text-red-400 hover:bg-blue-800 transition">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </nav>

        <!-- Form content -->
        <main class="ml-0 md:ml-64 p-8">
            <div class="max-w-4xl mx-auto bg-white p-10 rounded-3xl shadow-xl space-y-6">
                <h2 class="text-3xl font-bold text-blue-700 text-center">Tạo tài khoản Quản Lý</h2>

                <form action="adminAddManager" method="post" enctype="multipart/form-data" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-semibold mb-1">Tên đăng nhập</label>
                        <input name="username" required type="text" class="w-full p-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Mật khẩu</label>
                        <input name="password" required type="password" class="w-full p-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Họ và tên</label>
                        <input name="full_name" required type="text" class="w-full p-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Email</label>
                        <input name="email" required type="email" class="w-full p-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Điện thoại</label>
                        <input name="phone" type="text" class="w-full p-3 rounded-xl border border-gray-300">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Địa chỉ</label>
                        <input name="address" type="text" class="w-full p-3 rounded-xl border border-gray-300">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Ngày sinh</label>
                        <input name="dob" type="date" class="w-full p-3 rounded-xl border border-gray-300">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Giới tính</label>
                        <select name="gender" class="w-full p-3 rounded-xl border border-gray-300">
                            <option value="">-- Chọn --</option>
                            <option value="Nam">Nam</option>
                            <option value="Nữ">Nữ</option>
                            <option value="Khác">Khác</option>
                        </select>
                    </div>

                    <div class="md:col-span-2">
                        <label class="block text-sm font-semibold mb-1">Ảnh đại diện</label>
                        <input type="file" name="imageFile" accept="image/*"
                               class="w-full p-2 rounded-xl border border-gray-300 file:bg-blue-700 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:font-semibold">
                    </div>

                    <div class="md:col-span-2">
                        <label class="block text-sm font-semibold mb-1">Chi nhánh quản lý</label>
                        <select name="branch_name" required class="w-full p-3 rounded-xl border border-gray-300">
                            <option value="">-- Chọn chi nhánh --</option>
                            <option value="Chi nhánh Hà Nội">Chi nhánh Hà Nội</option>
                            <option value="Chi nhánh Hồ Chí Minh">Chi nhánh Hồ Chí Minh</option>
                            <option value="Chi nhánh Đà Nẵng">Chi nhánh Đà Nẵng</option>
                            <option value="Chi nhánh Cần Thơ">Chi nhánh Cần Thơ</option>
                            <option value="Chi nhánh Quy Nhơn">Chi nhánh Quy Nhơn</option>
                        </select>
                    </div>

                    <div class="md:col-span-2 text-center pt-4">
                        <button type="submit" class="bg-blue-700 hover:bg-blue-800 text-white text-lg font-bold py-3 px-8 rounded-2xl shadow transition duration-300">
                            <i class="fa-solid fa-plus mr-2"></i> Tạo Quản Lý
                        </button>
                    </div>
                </form>
            </div>
        </main>
    </body>
</html>
