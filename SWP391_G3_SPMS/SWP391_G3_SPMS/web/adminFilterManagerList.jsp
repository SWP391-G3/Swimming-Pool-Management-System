<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.admin.Manager, model.customer.User"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý người quản lý</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="./css/admin/adminPanel.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/global.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLndnUkP4OYlT6DkL4kSVV8Vsl5W0RXp2Pl3T/jCGX0gLexyO3J54+lZ7c2tXj4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            /* Ensure no horizontal scrollbar */
            body {
                overflow-x: hidden;
            }
            .main-content {
                width: calc(100% - 18rem); /* Adjust based on sidebar width */
                max-width: 100%;
            }
            .table-container {
                max-width: 100%;
                overflow-x: hidden;
            }
            table {
                width: 100%;
                table-layout: auto;
            }
            th, td {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            .main-content {
                margin-left: 18rem; /* tương ứng w-72 = 18rem */
                width: calc(100% - 18rem);
                max-width: 100%;
            }
            @media (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    width: 100%;
                }
            }

            @media (max-width: 768px) {
                .main-content {
                    width: 100%;
                    margin-left: 0;
                }
                th, td {
                    font-size: 0.875rem;
                    padding: 0.5rem;
                }
            }
            @keyframes fade-in {
                from {
                    opacity: 0;
                    transform: scale(0.95);
                }
                to {
                    opacity: 1;
                    transform: scale(1);
                }
            }
            .animate-fade-in {
                animation: fade-in 0.2s ease-out;
            }
        </style>
    </head>
    <body class="bg-gray-100 font-sans leading-relaxed antialiased text-gray-800">

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
            <nav id="sidebar" class="w-72 sidebar-gradient text-white p-4 flex flex-col h-screen fixed top-0 left-0 shadow-2xl overflow-y-auto z-50 md:translate-x-0">
                <!-- Logo Section -->
                <div class="logo-container mb-6 p-3 rounded-2xl text-center">
                    <div class="flex items-center justify-center mb-3">
                        <div class="w-12 h-12 bg-white rounded-full flex items-center justify-center">
                            <i class="fas fa-swimming-pool text-2xl text-blue-600"></i>
                        </div>
                    </div>
                    <h1 class="text-xl font-bold bg-gradient-to-r from-white to-blue-200 bg-clip-text text-transparent">
                        Admin Panel
                    </h1>
                    <p class="text-xs text-blue-100 mt-1">Swimming Pool System</p>
                </div>

                <!-- Profile Section -->
                <div class="profile-card p-3 rounded-2xl mb-4">
                    <div class="flex items-center gap-3">
                        <div class="relative">
                            <img src="https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/465/avatar-trang-1.jpg"
                                 alt="Avatar" class="w-12 h-12 rounded-full border-3 border-white object-cover shadow-lg" />
                            <div class="absolute -bottom-1 -right-1 w-5 h-5 bg-green-400 rounded-full border-2 border-white"></div>
                        </div>
                        <div class="flex-1">
                            <h4 class="text-sm font-semibold text-white"><%= userName %></h4>
                            <p class="text-xs text-blue-100">Administrator</p>
                            <a href="#" class="text-xs text-yellow-300 hover:text-yellow-200 hover:underline transition-colors">
                                <i class="fas fa-user-edit mr-1"></i>Xem chi tiết
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Navigation Menu -->
                <div class="flex-1 space-y-1">
                    <div class="text-xs font-semibold text-blue-200 uppercase tracking-wider mb-2 px-3">
                        <i class="fas fa-chart-bar mr-2"></i>Thống kê
                    </div>

                    <a href="adminDashBoard" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon">
                            <i class="fa-solid fa-chart-line text-sm"></i>
                        </div>
                        <span class="font-medium text-sm">Dashboard</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>

                    <div class="text-xs font-semibold text-blue-200 uppercase tracking-wider mb-2 px-3 mt-4">
                        <i class="fas fa-bars mr-2"></i>Quản lý
                    </div>

                    <a href="adminPoolManagement" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon">
                            <i class="fa-solid fa-water text-sm"></i>
                        </div>
                        <span class="font-medium text-sm">Quản lý bể bơi</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>

                    <a href="adminViewManagerList"
                       class="nav-item active-nav px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon">
                            <i class="fa-solid fa-user-tie text-sm"></i>
                        </div>
                        <span class="font-medium text-sm">Quản lý nhân viên</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>

                    <a href="adminViewCustomerList"
                       class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon">
                            <i class="fa-solid fa-user-check text-sm"></i>
                        </div>
                        <span class="font-medium text-sm">Quản lý khách hàng</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>

                    <div class="text-xs font-semibold text-blue-200 uppercase tracking-wider mb-2 px-3 mt-4">
                        <i class="fas fa-phone"></i> Liên hệ 
                    </div>

                    <a href="adminViewCustomerContact" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <span class="font-medium text-sm">Liên hệ khách hàng</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>

                    <div class="mt-3 pt-3 border-t border-white/20">
                        <a href="LogoutServlet"
                           class="logout-btn nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10 font-semibold">
                            <div class="nav-icon">
                                <i class="fa-solid fa-right-from-bracket text-sm"></i>
                            </div>
                            <span class="text-sm">Đăng xuất</span>
                            <i class="fas fa-sign-out-alt ml-auto text-sm"></i>
                        </a>
                    </div>
                </div>

                <!-- Footer -->
                <div class="mt-auto pt-4 border-t border-white/20 text-center">
                    <p class="text-xs text-blue-200">© 2024 Pool Management</p>
                    <p class="text-xs text-blue-300 mt-1">Version 2.1.0</p>
                </div>
            </nav>

            <div class="flex-1 main-content p-4">
                <!-- Main -->
                <main class="w-full max-w-full space-y-6 p-5">
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
                                    <option value="Chi nhánh Hà Nội" <%= "Chi nhánh Hà Nội".equals(request.getAttribute("branch")) ? "selected" : "" %>>Hà Nội</option>
                                    <option value="Chi nhánh Hồ Chí Minh" <%= "Chi nhánh Hồ Chí Minh".equals(request.getAttribute("branch")) ? "selected" : "" %>>Hồ Chí Minh</option>
                                    <option value="Chi nhánh Đà Nẵng" <%= "Chi nhánh Đà Nẵng".equals(request.getAttribute("branch")) ? "selected" : "" %>>Đà Nẵng</option>
                                    <option value="Chi nhánh Cần Thơ" <%= "Chi nhánh Cần Thơ".equals(request.getAttribute("branch")) ? "selected" : "" %>>Cần Thơ</option>
                                    <option value="Chi nhánh Quy Nhơn" <%= "Chi nhánh Quy Nhơn".equals(request.getAttribute("branch")) ? "selected" : "" %>>Quy Nhơn</option>
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
                            <a href="adminFilterManager"
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
                                    <td class="p-3 border">
                                        <% if (m.getBranch_name() != null) { %>
                                        <span class="px-3 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-700">
                                            <%= m.getBranch_name() %>
                                        </span>
                                        <% } else { %>
                                        <span class="px-3 py-1 rounded-full text-xs font-medium bg-yellow-100 text-yellow-700">
                                            Chưa phân công
                                        </span>
                                        <% } %>
                                    </td>
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

                    <!-- Modal nhập lý do khóa -->
                    <div id="banReasonModal" class="fixed inset-0 z-50 hidden bg-black bg-opacity-50 flex items-center justify-center px-4">
                        <div class="bg-white w-full max-w-md rounded-xl p-6 shadow-xl animate-fade-in relative">
                            <h2 class="text-xl font-bold mb-4">Nhập lý do khóa</h2>
                            <textarea id="banReasonInput" rows="4" class="w-full border rounded px-3 py-2 focus:ring-2 focus:ring-red-500"
                                      placeholder="Nhập lý do khóa quản lý này..."></textarea>
                            <div class="flex justify-end gap-3 mt-4">
                                <button onclick="closeBanModal()"
                                        class="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded">Hủy</button>
                                <button onclick="submitBanReason()"
                                        class="px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded">Xác nhận</button>
                            </div>
                        </div>
                    </div>

                    <!-- Pagination -->
                    <div class="flex flex-wrap justify-center mt-6 gap-2">
                        <% if (currentPage > 1) { %>
                        <a class="px-3 py-1 bg-blue-500 text-white rounded" href="adminFilterManager?page=<%= currentPage - 1 %>">Trước</a>
                        <% }
                        for (int i = startPage; i <= endPage; i++) { %>
                        <a class="px-3 py-1 <%= (i == currentPage ? "bg-green-600 text-white" : "bg-gray-300 text-gray-800") %> rounded" href="adminFilterManager?page=<%= i %>"><%= i %></a>
                        <% }
                            if (currentPage < totalPages) { %>
                        <a class="px-3 py-1 bg-blue-500 text-white rounded" href="adminFilterManager?page=<%= currentPage + 1 %>">Tiếp</a>
                        <% } %>

                        <form action="adminFilterManager" method="get" class="flex items-center gap-2 ml-4">

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
                let selectedManagerId = null;
                let isUnlocking = false;

                $(document).ready(function () {
                    $('.lock-btn').click(function () {
                        const button = $(this);
                        selectedManagerId = button.data('id');
                        const currentStatus = button.data('status');

                        if (currentStatus) {
                            // Nếu đang hoạt động => cần nhập lý do để khóa
                            isUnlocking = false;
                            $('#banReasonModal').removeClass('hidden');
                        } else {
                            // Nếu đang bị khóa => mở lại luôn
                            isUnlocking = true;
                            sendLockRequest(selectedManagerId, true, "", button);
                        }
                    });
                });

                function submitBanReason() {
                    const reason = $('#banReasonInput').val().trim();
                    if (reason === "") {
                        alert("Vui lòng nhập lý do khóa.");
                        return;
                    }

                    const button = $(`.lock-btn[data-id='${selectedManagerId}']`);
                    sendLockRequest(selectedManagerId, false, reason, button);
                    closeBanModal();
                }

                function closeBanModal() {
                    $('#banReasonModal').addClass('hidden');
                    $('#banReasonInput').val('');
                }

                function sendLockRequest(id, status, reason, button) {
                    $.ajax({
                        url: 'adminLockManager',
                        type: 'POST',
                        data: {
                            id: id,
                            status: status,
                            reason: reason
                        },
                        success: function (response) {
                            if (response.success) {
                                // Cập nhật lại trạng thái nút và hiển thị trong bảng
                                button.data('status', status);

                                if (status) {
                                    // Đang hoạt động
                                    button
                                            .removeClass('bg-green-600 hover:bg-green-700')
                                            .addClass('bg-red-600 hover:bg-red-700')
                                            .html('<i class="fa-solid fa-lock"></i> Khóa');

                                    button.closest('tr').find('td:eq(6) span')
                                            .removeClass('bg-red-100 text-red-700')
                                            .addClass('bg-green-100 text-green-700')
                                            .text('Đang hoạt động');
                                } else {
                                    // Đã khóa
                                    button
                                            .removeClass('bg-red-600 hover:bg-red-700')
                                            .addClass('bg-green-600 hover:bg-green-700')
                                            .html('<i class="fa-solid fa-unlock"></i> Mở');

                                    button.closest('tr').find('td:eq(6) span')
                                            .removeClass('bg-green-100 text-green-700')
                                            .addClass('bg-red-100 text-red-700')
                                            .text('Đã khóa');
                                }

                                alert('Cập nhật trạng thái thành công!');
                                location.reload();
                            } else {
                                alert('Cập nhật thất bại!');
                            }
                        },
                        error: function () {
                            alert('Đã xảy ra lỗi.');
                        }
                    });
                }
            </script>


    </body>
</html>
