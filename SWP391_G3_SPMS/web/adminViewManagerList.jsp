<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.admin.Manager, model.User,model.admin.Branch"%>
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
            List<Branch> branchs = (List<Branch>) request.getAttribute("branchs");
            List<Branch> availableBranchs = (List<Branch>) request.getAttribute("availableBranchs");

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
                <a href="adminViewManagerList" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 bg-blue-900 ring-2 ring-white"><i class="fa-solid fa-user-tie"></i> Quản lý nhân viên</a>
                <a href="adminViewCustomerList" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-check"></i> Quản lý khách hàng</a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo</a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-gear"></i> Cài đặt hệ thống</a>
                <a href="LogoutServlet" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 text-red-400"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
            </nav>

            <!-- Main Content -->
            <main class="md:ml-64 w-full p-4 sm:p-6 md:p-8 space-y-6">
                <!-- Header -->
                <div class="flex flex-col md:flex-row justify-between items-start md:items-center bg-white p-6 rounded-lg shadow">
                    <h2 class="text-2xl font-bold text-blue-700 mb-4 md:mb-0"><i class="fa-solid fa-user-tie mr-2"></i> Danh sách người quản lý</h2>
                    <a href="adminAddManager"
                       class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded shadow transition duration-200">
                        <i class="fa-solid fa-square-plus"></i> Thêm mới
                    </a>
                </div>

                <!-- Search & Filter Form -->
                <form action="adminFilterManager" method="get" class="bg-white p-6 rounded-lg shadow space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <!-- Keyword -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Tìm theo tên hoặc email</label>
                            <input type="text" name="keyword" placeholder="Nhập tên hoặc email"
                                   value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : "" %>"
                                   class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:outline-none">

                        </div>

                        <!-- Branch -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Lọc theo chi nhánh</label>
                            <select name="branch"
                                    class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:outline-none">
                                <option value="">-- Chọn chi nhánh --</option>
                                <% 
                                    String selectedBranch = (String) request.getAttribute("branch");
                                    for (Branch b : branchs) {
                                        String branchName = b.getBranch_name();
                                %>
                                <option value="<%= branchName %>" <%= branchName.equals(selectedBranch) ? "selected" : "" %>>
                                    <%= branchName.replace("Chi nhánh ", "") %>
                                </option>
                                <% } %>
                            </select>


                        </div>

                        <!-- Status -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Lọc theo trạng thái</label>
                            <select name="status"
                                    class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:outline-none">
                                <option value="">-- Trạng thái --</option>
                                <option value="true" <%= "true".equals(request.getAttribute("status")) ? "selected" : "" %>>Đang hoạt động</option>
                                <option value="false" <%= "false".equals(request.getAttribute("status")) ? "selected" : "" %>>Đã khóa</option>
                            </select>

                        </div>
                    </div>

                    <!-- Buttons -->
                    <div class="flex flex-wrap gap-3 pt-2">
                        <button type="submit"
                                class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-4 py-2 rounded shadow">
                            <i class="fa-solid fa-magnifying-glass mr-1"></i> Tìm kiếm
                        </button>
                        <a href="#" type="reset"
                           class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-semibold px-4 py-2 rounded shadow">
                            <i class="fa-solid fa-rotate-left mr-1"></i> Đặt lại
                        </a>
                    </div>
                </form>

                <!-- Table -->
                <div class="overflow-x-auto bg-white rounded-lg shadow">
                    <table class="min-w-full text-sm text-left table-auto border">
                        <thead class="bg-gray-200 text-gray-700">
                            <tr>
                                <th class="p-3 border">ID</th>
                                <th class="p-3 border">Họ tên</th>
                                <th class="p-3 border">Email</th>
                                <th class="p-3 border">Số điện thoại</th>
                                <th class="p-3 border">Địa chỉ</th>
                                <th class="p-3 border">Chi nhánh</th>
                                <th class="p-3 border">Trạng thái</th>
                                <th class="p-3 border">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (managers != null && !managers.isEmpty()) {
                                        for (Manager m : managers) { %>
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
                                <td class="p-3 border space-x-2">
                                    <a href="adminUpdateManager?id=<%= m.getManager_id() %>" class="bg-yellow-400 text-black px-2 py-1 rounded hover:bg-yellow-500"><i class="fa-solid fa-pen-to-square"></i> Sửa</a>
                                    <button 
                                        class="lock-btn <%= m.getStatus() ? "bg-red-600 text-white" : "bg-green-600 text-white" %> px-2 py-1 rounded hover:bg-red-700" 
                                        data-id="<%= m.getManager_id() %>" 
                                        data-status="<%= m.getStatus() %>">
                                        <i class="fa-solid <%= m.getStatus() ? "fa-lock" : "fa-unlock" %>"></i> <%= m.getStatus() ? "Khóa" : "Mở" %>
                                    </button>

                                </td>
                            </tr>
                            <% } } else { %>
                            <tr>
                                <td colspan="9" class="text-center py-6 text-gray-500 italic">Không tìm thấy người quản lý nào.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>


                <!-- Pagination -->
                <div class="flex flex-wrap justify-center mt-6 gap-2">
                    <% if (currentPage > 1) { %>
                    <a class="px-3 py-1 bg-blue-500 text-white rounded" href="adminViewManagerList?page=<%= currentPage - 1 %>">Trước</a>
                    <% }
                        for (int i = startPage; i <= endPage; i++) { %>
                    <a class="px-3 py-1 <%= (i == currentPage ? "bg-green-600 text-white" : "bg-gray-300 text-gray-800") %> rounded" href="adminViewManagerList?page=<%= i %>"><%= i %></a>
                    <% }
                            if (currentPage < totalPages) { %>
                    <a class="px-3 py-1 bg-blue-500 text-white rounded" href="adminViewManagerList?page=<%= currentPage + 1 %>">Tiếp</a>
                    <% } %>

                    <form action="adminViewManagerList" method="get" class="flex items-center gap-2 ml-4">
                        <input type="number" name="page" min="1" max="<%= totalPages %>" placeholder="Trang..."
                               class="w-20 px-2 py-1 border rounded text-center focus:ring-2 focus:ring-blue-500 focus:outline-none" required>
                        <button type="submit"
                                class="bg-blue-600 text-white px-3 py-1 rounded hover:bg-blue-700 transition">Đến</button>
                    </form>
                </div>
            </main>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                $('.lock-btn').click(function () {
                    var button = $(this);
                    var id = button.data('id');
                    var currentStatus = button.data('status'); // true: đang hoạt động, false: đã khóa
                    var newStatus = !currentStatus; // Đảo trạng thái

                    $.ajax({
                        url: 'adminLockManager',
                        type: 'POST',
                        data: {
                            id: id,
                            status: newStatus // Gửi trạng thái mới muốn set
                        },
                        success: function (response) {
                            if (response.success) {
                                // Cập nhật lại data-status
                                button.data('status', newStatus);

                                // Đổi text, màu, icon
                                if (newStatus) {
                                    // Đang hoạt động => hiện nút "Khóa"
                                    button
                                            .removeClass('bg-green-600 hover:bg-green-700')
                                            .addClass('bg-red-600 hover:bg-red-700')
                                            .html('<i class="fa-solid fa-lock"></i> Khóa');
                                    // Đổi màu trạng thái trong bảng (nếu muốn)
                                    button.closest('tr').find('td:eq(6) span')
                                            .removeClass('bg-red-100 text-red-700')
                                            .addClass('bg-green-100 text-green-700')
                                            .text('Đang hoạt động');
                                } else {
                                    // Đã khóa => hiện nút "Mở"
                                    button
                                            .removeClass('bg-red-600 hover:bg-red-700')
                                            .addClass('bg-green-600 hover:bg-green-700')
                                            .html('<i class="fa-solid fa-unlock"></i> Mở');
                                    button.closest('tr').find('td:eq(6) span')
                                            .removeClass('bg-green-100 text-green-700')
                                            .addClass('bg-red-100 text-red-700')
                                            .text('Đã khóa');
                                }
                            } else {
                                alert('Thao tác thất bại!');
                            }
                        },
                        error: function () {
                            alert('Có lỗi xảy ra!');
                        }
                    });
                });
            });
        </script>


    </body>
</html>
