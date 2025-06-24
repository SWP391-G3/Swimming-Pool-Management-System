<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.admin.Employee,model.admin.Branch" %>
<%@ page import="model.User" %>

<%
    List<Employee> employees = (List<Employee>) request.getAttribute("employees");
    List<Branch> branchs = (List<Branch>) request.getAttribute("branchs");
    int currentPage = (int) request.getAttribute("currentPage");
    int totalPages = (int) request.getAttribute("totalPages");

    int visiblePages = 5;
    int startPage = Math.max(1, currentPage - visiblePages / 2);
    int endPage = Math.min(totalPages, startPage + visiblePages - 1);
    if (endPage - startPage < visiblePages - 1) {
        startPage = Math.max(1, endPage - visiblePages + 1);
    }

    User currentUser = (User) session.getAttribute("currentUser");
    String userName = currentUser != null ? currentUser.getFull_name() : "";
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách nhân viên</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="bg-gray-100 font-sans leading-relaxed antialiased text-gray-800">

        <!-- Sidebar -->
        <nav class="w-64 bg-[#000033] text-white p-6 flex flex-col space-y-4 fixed h-full md:translate-x-0 transition-transform z-40">
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
            <a href="adminViewEmployeeList" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-tie"></i> Quản lý nhân viên</a>
            <a href="adminViewCustomerList" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-check"></i> Quản lý khách hàng</a>
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo</a>
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-gear"></i> Cài đặt hệ thống</a>
            <a href="LogoutServlet" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 text-red-400"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
        </nav>

        <!-- Main content -->
        <div class="md:ml-64 p-6">
            <div class="bg-white p-8 rounded-xl shadow-lg">

                <!-- Tiêu đề + Quay lại -->
                <div class="flex justify-between items-center mb-6">
                    <div>
                        <h1 class="text-3xl font-bold tracking-tight">Quản lý nhân viên</h1>
                        <p class="text-gray-500 text-sm">Xem và quản lý danh sách nhân viên toàn hệ thống</p>
                    </div>
                    <a href="adminViewStaffCategory.jsp" class="bg-gray-200 hover:bg-gray-300 text-gray-800 px-4 py-2 rounded-lg text-sm font-medium flex items-center gap-2">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại
                    </a>
                </div>

                <!-- Search & Filter Form -->
                <form action="adminFilterManager" method="get" class="bg-white p-6 rounded-lg shadow space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <!-- Keyword -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Tìm theo tên hoặc email</label>
                            <input type="text" name="keyword" placeholder="Nhập tên hoặc email"
                                   value=""
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
                        <a href="adminViewEmployeeList" type="reset"
                           class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-semibold px-4 py-2 rounded shadow">
                            <i class="fa-solid fa-rotate-left mr-1"></i> Đặt lại
                        </a>
                        <a href="adminAddEmployee"
                           class="flex items-center gap-2 bg-green-600 hover:bg-green-700 text-white font-semibold px-5 py-2.5 rounded-lg shadow transition">
                            <i class="fa-solid fa-user-plus"></i> Thêm nhân viên
                        </a>
                    </div>
                </form> </br>

                <!-- Bảng nhân viên -->
                <div class="overflow-x-auto">
                    <table class="w-full bg-white border border-gray-200 rounded-lg shadow overflow-hidden text-sm text-left">
                        <thead class="bg-gray-50 text-gray-600 uppercase text-xs">
                            <tr>
                                <th class="px-6 py-3">ID</th>
                                <th class="px-6 py-3">Họ tên</th>
                                <th class="px-6 py-3">Chi nhánh</th>
                                <th class="px-6 py-3">Bể bơi</th>
                                <th class="px-6 py-3">Loại nhân viên</th>
                                <th class="px-6 py-3">Trạng thái</th>
                                <th class="px-6 py-3 text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <% if (employees != null) {
                        for (Employee e : employees) { %>
                            <tr class="hover:bg-gray-50">
                                <td class="px-6 py-4"><%= e.getStaffId() %></td>
                                <td class="px-6 py-4"><%= e.getFullName() %></td>
                                <td class="px-6 py-4"><%= e.getBranchName() != null ? e.getBranchName() : "N/A" %></td>
                                <td class="px-6 py-4"><%= e.getPoolName() != null ? e.getPoolName() : "N/A" %></td>
                                <td class="px-6 py-4"><%= e.getStaffTypeName() != null ? e.getStaffTypeName() : "N/A" %></td>
                                <td class="px-6 py-4">
                                    <span class="px-3 py-1 rounded-full text-xs font-medium <%= e.getStatus() ? "bg-green-100 text-green-700" : "bg-red-100 text-red-700" %>">
                                        <%= e.getStatus() ? "Đang hoạt động" : "Đã khóa" %>
                                    </span>
                                </td>                               
                                <td class="px-6 py-4 text-center">
                                    <div class="flex justify-center gap-4 text-lg">
                                        <a href="adminViewEmployeeDetail?id=<%= e.getStaffId() %>" class="text-blue-600 hover:text-blue-800" title="Xem"><i class="fa-solid fa-eye"></i></a>
                                        <a href="adminEditEmployee?id=<%= e.getStaffId() %>" class="text-yellow-500 hover:text-yellow-700" title="Sửa"><i class="fa-solid fa-pen"></i></a>
                                        <a href="adminToggleEmployeeStatus?id=<%= e.getStaffId() %>" class="text-red-500 hover:text-red-700" title="Khóa/Mở"><i class="fa-solid fa-lock"></i></a>
                                    </div>
                                </td>
                            </tr>
                            <% }} %>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div class="flex flex-wrap justify-center mt-8 gap-2 text-sm">
                    <% if (currentPage > 1) { %>
                    <a class="px-3 py-2 bg-blue-600 text-white rounded hover:bg-blue-700" href="adminViewEmployeeList?page=<%= currentPage - 1 %>">← Trước</a>
                    <% }
                        for (int i = startPage; i <= endPage; i++) {
                    %>
                    <a href="adminViewEmployeeList?page=<%= i %>" class="px-3 py-2 rounded <%= i == currentPage ? "bg-green-600 text-white" : "bg-gray-200 text-gray-700 hover:bg-gray-300" %>"><%= i %></a>
                    <% }
                        if (currentPage < totalPages) {
                    %>
                    <a class="px-3 py-2 bg-blue-600 text-white rounded hover:bg-blue-700" href="adminViewEmployeeList?page=<%= currentPage + 1 %>">Tiếp →</a>
                    <% } %>

                    <form action="adminViewEmployeeList" method="get" class="flex items-center gap-2 ml-4">
                        <input type="number" name="page" min="1" max="<%= totalPages %>" placeholder="Trang..."
                               class="w-24 px-2 py-2 border rounded-lg text-center focus:ring-2 focus:ring-blue-500" required>
                        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">Đến</button>
                    </form>
                </div>
            </div>
        </div>

    </body>
</html>
