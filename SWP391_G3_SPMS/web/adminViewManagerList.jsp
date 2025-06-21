<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.admin.Manager, model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý người quản lý</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="bg-gray-100 text-gray-800">

        <%
            User currentUser = (User) session.getAttribute("currentUser");
            String userName = currentUser != null ? currentUser.getFull_name() : "";

            List<Manager> managers = (List<Manager>) request.getAttribute("managers");
            int currentPage = (Integer) request.getAttribute("currentPage");
            int totalPages = (Integer) request.getAttribute("totalPages");

            int visiblePages = 5;
            int startPage = Math.max(1, currentPage - visiblePages / 2);
            int endPage = Math.min(totalPages, startPage + visiblePages - 1);
            if (endPage - startPage < visiblePages - 1) {
                startPage = Math.max(1, endPage - visiblePages + 1);
            }
        %>

        <!-- Nút mở sidebar mobile -->
        <button id="mobileMenuBtn" class="fixed top-4 left-4 z-50 bg-blue-600 text-white p-2 rounded md:hidden">
            <i class="fa-solid fa-bars"></i>
        </button>

        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <nav id="sidebar" class="w-64 bg-[#000033] text-white p-6 flex flex-col space-y-4 fixed h-full transform -translate-x-full md:translate-x-0 transition-transform duration-300 z-40">
                <div class="mb-6 text-center"> 
                    <h1 class="text-2xl font-bold">Admin Panel</h1>
                    <p class="text-sm text-gray-300">Swimming Pool System</p>
                </div>
                <div class="flex items-center gap-3 mb-6">
                    <img src="https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/465/avatar-trang-1.jpg" alt="Avatar" class="w-12 h-12 rounded-full border-2 border-white object-cover" />
                    <div>
                        <h4 class="text-base font-semibold"><%= userName %></h4>
                        <a href="#" class="text-sm text-blue-300 hover:underline">Xem chi tiết</a>
                    </div>
                </div>
                <a href="adminPoolManagement" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-water"></i> Quản lý bể bơi</a>
                <a href="managers" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 bg-blue-900 ring-2 ring-white"><i class="fa-solid fa-user-tie"></i> Quản lý quản lý</a>
                <a href="adminViewCustomerList" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-check"></i> Quản lý khách hàng</a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo</a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-gear"></i> Cài đặt hệ thống</a>
                <a href="LogoutServlet" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 text-red-400"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
            </nav>

            <!-- Main Content -->
            <main class="md:ml-64 w-full p-4 sm:p-6 md:p-8">
                <div class="flex justify-between items-center bg-white p-4 rounded shadow mb-6">
                    <h2 class="text-xl font-bold text-blue-700"><i class="fa-solid fa-user-tie mr-2"></i> Danh sách người quản lý</h2>
                    <a href="AdminAddManager.jsp" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">
                        <i class="fa-solid fa-square-plus"></i> Thêm mới
                    </a>
                </div>

                <div class="overflow-x-auto bg-white rounded shadow">
                    <table class="min-w-full text-sm text-left">
                        <thead class="bg-gray-200 text-gray-700">
                            <tr>
                                <th class="p-3 border">ID</th>
                                <th class="p-3 border">Họ tên</th>
                                <th class="p-3 border">Email</th>
                                <th class="p-3 border">Số điện thoại</th>
                                <th class="p-3 border">Địa chỉ</th>
                                <th class="p-3 border">Chi nhánh</th>
                                <th class="p-3 border">Trạng thái</th>
                                <th class="p-3 border">Ngày tạo</th>
                                <th class="p-3 border">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (managers != null && !managers.isEmpty()) {
                                    for (Manager m : managers) {
                            %>
                            <tr class="hover:bg-gray-100">
                                <td class="p-3 border"><%= m.getManager_id() %></td>
                                <td class="p-3 border"><%= m.getFull_name() %></td>
                                <td class="p-3 border"><%= m.getEmail() %></td>
                                <td class="p-3 border"><%= m.getPhone() %></td>
                                <td class="p-3 border"><%= m.getAddress() %></td>
                                <td class="p-3 border"><%= m.getBranch_name() != null ? m.getBranch_name() : "Chưa phân công" %></td>
                                <td class="p-3 border">
                                    <span class="px-3 py-1 rounded-full text-xs font-medium <%= m.getStatus() ? "bg-green-100 text-green-700" : "bg-red-100 text-red-700" %>">
                                        <%= m.getStatus() ? "Đang hoạt động" : "Đã khóa" %>
                                    </span>
                                </td>
                                <td class="p-3 border"><%= m.getCreate_at() %></td>
                                <td class="p-3 border space-x-2">
                                    <a href="adminUpdateManager?id=<%= m.getManager_id() %>" class="bg-yellow-400 text-black px-2 py-1 rounded hover:bg-yellow-500">
                                        <i class="fa-solid fa-pen-to-square"></i> Sửa
                                    </a>
                                    <a href="adminDeleteManager?id=<%= m.getManager_id() %>" class="bg-red-600 text-white px-2 py-1 rounded hover:bg-red-700">
                                        <i class="fa-solid fa-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="9" class="text-center py-6 text-gray-500 italic">Không tìm thấy người quản lý nào.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div class="flex flex-wrap justify-center mt-6 gap-2">
                    <%
                        if (currentPage > 1) {
                    %>
                    <a class="px-3 py-1 bg-blue-500 text-white rounded" href="managers?page=<%= currentPage - 1 %>">Trước</a>
                    <%
                        }
                        for (int i = startPage; i <= endPage; i++) {
                    %>
                    <a class="px-3 py-1 <%= (i == currentPage ? "bg-green-600 text-white" : "bg-gray-300 text-gray-800") %> rounded" href="managers?page=<%= i %>"><%= i %></a>
                    <%
                        }
                        if (currentPage < totalPages) {
                    %>
                    <a class="px-3 py-1 bg-blue-500 text-white rounded" href="managers?page=<%= currentPage + 1 %>">Tiếp</a>
                    <%
                        }
                    %>

                    <form action="managers" method="get" class="flex items-center gap-2 ml-4">
                        <input type="number" name="page" min="1" max="<%= totalPages %>" placeholder="Trang..." class="w-20 px-2 py-1 border rounded text-center" required>
                        <button type="submit" class="bg-blue-600 text-white px-3 py-1 rounded hover:bg-blue-700">Đến</button>
                    </form>
                </div>
            </main>
        </div>


    </body>
</html>
