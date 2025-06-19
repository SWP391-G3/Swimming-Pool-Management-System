<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List,model.admin.Customer,model.User" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý khách hàng</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="bg-gray-100 text-gray-800">

        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <nav class="w-64 bg-[#000033] text-white p-6 flex flex-col space-y-4 fixed h-full">
                <div class="mb-6 text-center"> 
                    <h1 class="text-2xl font-bold">Admin Panel</h1>
                    <p class="text-sm text-gray-300">Swimming Pool System</p>
                </div>
                <% 
                    User currentUser = (User) session.getAttribute("currentUser");
                    String userName = (currentUser != null) ? currentUser.getFull_name() : "";
                %>
                <div class="flex items-center gap-3 mb-6">
                    <img src="https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/465/avatar-trang-1.jpg" alt="Avatar" class="w-12 h-12 rounded-full border-2 border-white object-cover" />
                    <div>
                        <h4 class="text-base font-semibold"><%= userName %></h4>
                        <a href="#" class="text-sm text-blue-300 hover:underline">Xem chi tiết</a>
                    </div>
                </div>
                <a href="adminPoolManagement" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-water"></i> Quản lý bể bơi</a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-tie"></i> Quản lý nhân viên</a>
                <a href="adminViewCustomerList" class="bg-blue-900 ring-2 ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-check"></i> Quản lý khách hàng</a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo</a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-gear"></i> Cài đặt hệ thống</a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 text-red-400"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
            </nav>

            <% 
                List<Customer> listCustomer = (List<Customer>) request.getAttribute("listCustomer");
                int currentPage = (Integer) request.getAttribute("currentPage");
                int totalPages = (Integer) request.getAttribute("totalPages");

                int visiblePages = 5;
                int startPage = Math.max(1, currentPage - visiblePages / 2);
                int endPage = Math.min(totalPages, startPage + visiblePages - 1);
                if (endPage - startPage < visiblePages - 1) {
                    startPage = Math.max(1, endPage - visiblePages + 1);
                }
            %>
            <!-- Main Content -->
            <main class="ml-64 w-full p-8">
                <div class="bg-white p-4 rounded shadow mb-6 flex justify-between items-center">
                    <h2 class="text-xl font-bold text-blue-700">Danh sách khách hàng</h2>
                </div>
                <!-- Filters Form -->
                <form action="adminViewCustomerList" method="GET" class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                    <input type="text" name="keyword" placeholder="Tìm kiếm theo tên,email..." class="px-3 py-2 border rounded" />

                    <select name="status" class="border rounded px-3 py-2">
                        <option value="">-- Trạng thái tài khoản --</option>
                        <option value="active">Đang hoạt động</option>
                        <option value="blocked">Đã khóa</option>
                    </select>

                    <select name="sortAmount" class="border rounded px-3 py-2">
                        <option value="">-- Sắp xếp theo tổng chi tiêu --</option>
                        <option value="asc">Tăng dần</option>
                        <option value="desc">Giảm dần</option>
                    </select>

                    <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 flex items-center justify-center gap-2">
                        <i class="fa-solid fa-filter"></i> Tìm kiếm
                    </button>
                </form>

                <!-- Customer Table -->
                <div class="overflow-x-auto bg-white rounded shadow">
                    <table class="min-w-full text-sm text-left">
                        <thead class="bg-gray-200 text-gray-700">
                            <tr>
                                <th class="p-3 border">Mã khách hàng</th>
                                <th class="p-3 border">Họ tên</th>
                                <th class="p-3 border">Email</th>
                                <th class="p-3 border">Số điện thoại</th>
                                <th class="p-3 border">Tổng chi tiêu</th>
                                <th class="p-3 border">Trạng thái tài khoản</th>
                                <th class="p-3 border">Hành động</th>
                            </tr>
                        </thead>
                        <% 
                            if(listCustomer != null && !listCustomer.isEmpty()){
                                for(Customer c : listCustomer){
                                                         
                        %>
                        <tbody>
                            <!-- Hàng mẫu (sẽ được render động sau) -->
                            <tr class="hover:bg-gray-100">
                                <td class="p-3 border">KH00<%= c.getUser_id() %></td>
                                <td class="p-3 border"><%= c.getFull_name() %></td>
                                <td class="p-3 border"><%= c.getEmail() %></td>
                                <td class="p-3 border"><%= c.getPhone() %></td>
                                <td class="p-3 border">2000000 vnđ</td>
                                <td class="p-3 border">
                                    <span class=" <%= (c.getStatus() == true) ? "text-green-700 bg-green-100" : "text-red-700 bg-red-100" %> text-green-700 bg-green-100 px-3 py-1 rounded-full text-xs font-medium"><%= (c.getStatus() == true) ? "Hoạt Động" : "Bị khóa" %></span>
                                </td>
                                <td class="p-3 border space-x-2">
                                    <a href="#" class="bg-blue-500 text-white px-2 py-1 rounded hover:bg-blue-700"><i class="fa-solid fa-eye"></i> Xem</a>
                                    <a href="adminUpdateCustomer?userId=<%= c.getUser_id() %>" class="bg-yellow-400 text-black px-2 py-1 rounded hover:bg-yellow-500"><i class="fa-solid fa-pen"></i> Sửa</a>
                                    <a href="adminLockCustomer?userId=<%= c.getUser_id() %>&userStatus=<%= c.getStatus()%>"
                                       class="<%= (c.getStatus() == true) ? "bg-red-500 text-white hover:bg-red-700" : "bg-green-500 text-white hover:bg-green-700" %> px-2 py-1 rounded">
                                        <i class="fa-solid <%= (c.getStatus() == true) ? "fa-lock" : "fa-lock-open" %>"></i>
                                        <%= (c.getStatus() == true) ? "Khóa" : "Mở" %>
                                    </a>

                                </td>
                            </tr>
                            <!-- Thêm nhiều hàng tương tự -->
                        </tbody>
                        <%  }}%>
                    </table>
                </div>
                <!-- Pagination -->
                <div class="flex flex-wrap justify-center mt-6 gap-2">
                    <%
                        if (currentPage > 1) {
                    %>
                    <a class="px-3 py-1 bg-blue-500 text-white rounded" href="adminViewCustomerList?page=<%= currentPage - 1 %>">Trước</a>
                    <%
                        }
                        for (int i = startPage; i <= endPage; i++) {
                    %>
                    <a class="px-3 py-1 <%= (i == currentPage ? "bg-green-600 text-white" : "bg-gray-300 text-gray-800") %> rounded" href="adminViewCustomerList?page=<%= i %>"><%= i %></a>
                    <%
                        }
                        if (currentPage < totalPages) {
                    %>
                    <a class="px-3 py-1 bg-blue-500 text-white rounded" href="adminViewCustomerList?page=<%= currentPage + 1 %>">Tiếp</a>
                    <%
                        }
                    %>
                    <form action="adminViewCustomerList" method="get" class="flex items-center gap-2 ml-4">
                        <input type="number" name="page" min="1" max="<%= totalPages %>" placeholder="Trang..." class="w-20 px-2 py-1 border rounded text-center" required>
                        <button type="submit" class="bg-blue-600 text-white px-3 py-1 rounded hover:bg-blue-700">Đến</button>
                    </form>
                </div>
            </main>
        </div>

    </body>
</html>
