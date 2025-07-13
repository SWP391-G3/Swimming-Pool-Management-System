<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.admin.Employee,model.admin.Branch" %>
<%@ page import="model.customer.User,model.admin.StaffType" %>

<%
    List<Employee> employees = (List<Employee>) request.getAttribute("employees");
    List<Branch> branchs = (List<Branch>) request.getAttribute("branchs");
    List<StaffType> staffTypes = (List<StaffType>) request.getAttribute("staffTypes");
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
    
    String keyword = request.getAttribute("keyword") != null ? request.getAttribute("keyword").toString() : "";
    String branch = request.getAttribute("branch") != null ? request.getAttribute("branch").toString() : "";
    String selectedStaffType = request.getAttribute("selectedStaffType") != null ? request.getAttribute("selectedStaffType").toString() : "";
    String selectedStatus = request.getAttribute("status") != null ? request.getAttribute("status").toString() : "";
%>



<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách nhân viên</title>
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

                <a href="adminViewEmployeeList"
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
                    <form action="adminFilterEmployee" method="get" class="bg-white p-6 rounded-lg shadow space-y-4">
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
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
                                        for (Branch b : branchs) {
                                            String branchName = b.getBranch_name();
                                    %>
                                    <option value="<%= branchName %>" <%= branchName.equals(branch) ? "selected" : "" %>>
                                        <%= branchName.replace("Chi nhánh ", "") %>
                                    </option>
                                    <% } %>
                                </select>
                            </div>

                            <!-- StaffTypes -->
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Lọc theo loại nhân viên</label>
                                <select name="staffType"
                                        class="w-full border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:outline-none">
                                    <option value="">-- Chọn loại nhân viên --</option>
                                    <%
                                        for (StaffType s : staffTypes) {
                                            String typeName = s.getType_name();
                                    %>
                                    <option value="<%= typeName %>" <%= typeName.equals(selectedStaffType) ? "selected" : "" %>>
                                        <%= typeName %>
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
                                            <a href="#" class="text-blue-600 hover:text-blue-800 btn-view-employee"
                                               data-id="<%= e.getStaffId() %>"
                                               data-branch-id="<%= e.getBranchId() %>"
                                               data-image="<%= e.getImages() %>"
                                               data-full-name="<%= e.getFullName() %>"
                                               data-email="<%= e.getEmail() %>"
                                               data-address="<%= e.getAddress() %>"
                                               data-dob="<%= e.getDob() %>"
                                               data-gender="<%= "Male".equals(e.getGender()) ? "Nam" : "Female".equals(e.getGender()) ? "Nữ" : "Khác" %>"
                                               data-status="<%= e.getStatus() ? "Đang hoạt động" : "Đã khóa" %>"
                                               data-area="<%= e.getBranchName() %>"
                                               data-pool="<%= e.getPoolName() %>"
                                               data-position="<%= e.getStaffTypeName() %>"
                                               data-description="<%= e.getStaffTypeDescription() %>">
                                                <i class="fa-solid fa-eye"></i>
                                            </a>
                                            <a href="adminEditEmployee?id=<%= e.getStaffId() %>&branchId=<%= e.getBranchId() %>" class="text-yellow-500 hover:text-yellow-700" title="Sửa"><i class="fa-solid fa-pen"></i></a>
                                            <a href="adminToggleEmployeeStatus?id=<%= e.getStaffId() %>" class="text-red-500 hover:text-red-700" title="Khóa/Mở"><i class="fa-solid fa-lock"></i></a>
                                        </div>
                                    </td>
                                </tr>
                                <% }} %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Overlay + Popup -->
                    <div id="employeeDetailModal" class="fixed inset-0 z-50 hidden bg-black bg-opacity-50 flex items-center justify-center px-4">
                        <div class="bg-white w-full max-w-2xl rounded-2xl shadow-xl p-8 relative animate-fade-in-up">

                            <!-- Close Button -->
                            <button onclick="closeModal()" class="absolute top-4 right-4 text-gray-400 hover:text-red-500 text-2xl">
                                <i class="fa-solid fa-xmark"></i>
                            </button>

                            <!-- Header: Avatar + Name + Status -->
                            <div class="flex items-center gap-6 mb-6">
                                <img id="empImage" src="" alt="Ảnh nhân viên"
                                     class="w-24 h-24 rounded-full object-cover border-4 border-blue-300 shadow">
                                <div>
                                    <h2 id="empFullName" class="text-2xl font-bold text-gray-800"></h2>
                                    <span id="empStatus"
                                          class="inline-block mt-1 text-sm font-semibold px-3 py-1 rounded-full">
                                    </span>
                                </div>
                            </div>

                            <!-- Details -->
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm text-gray-700 mb-6">
                                <p><span class="font-semibold text-gray-900">Email:</span> <span id="empEmail"></span></p>
                                <p><span class="font-semibold text-gray-900">Địa chỉ:</span> <span id="empAddress"></span></p>
                                <p><span class="font-semibold text-gray-900">Ngày sinh:</span> <span id="empDob"></span></p>
                                <p><span class="font-semibold text-gray-900">Giới tính:</span> <span id="empGender"></span></p>
                                <p><span class="font-semibold text-gray-900">Khu vực:</span> <span id="empArea"></span></p>
                                <p><span class="font-semibold text-gray-900">Bể bơi:</span> <span id="empPool"></span></p>
                                <p><span class="font-semibold text-gray-900">Vị trí:</span> <span id="empPosition"></span></p>
                                <p><span class="font-semibold text-gray-900">Mô tả:</span> <span id="empDescription"></span></p>
                            </div>

                            <!-- Action Buttons -->
                            <div class="flex justify-end gap-4">
                                <a href="#" id="updateLink"
                                   class="bg-blue-600 hover:bg-blue-700 text-white font-medium px-5 py-2 rounded-lg shadow">
                                    <i class="fa-solid fa-pen-to-square mr-1"></i> Cập nhật
                                </a>
                                <a href="#" id="toggleStatusLink"
                                   class="bg-red-600 hover:bg-red-700 text-white font-medium px-5 py-2 rounded-lg shadow">
                                    <i class="fa-solid fa-lock mr-1"></i> Khóa/Mở
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Pagination -->
                    <div class="flex flex-wrap justify-center mt-8 gap-2 text-sm">
                        <% if (currentPage > 1) { %>
                        <%-- Link trang trước --%>
                        <a class="px-3 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
                           href="adminFilterEmployee?page=<%= currentPage - 1 %>&keyword=<%= keyword %>&branch=<%= branch %>&staffType=<%= selectedStaffType %>&status=<%= selectedStatus %>">← Trước</a>

                        <% }
                            for (int i = startPage; i <= endPage; i++) {
                        %>
                        <a href="adminFilterEmployee?page=<%= i %>&keyword=<%= keyword %>&branch=<%= branch %>&staffType=<%= selectedStaffType %>&status=<%= selectedStatus %>"
                           class="px-3 py-2 rounded <%= i == currentPage ? "bg-green-600 text-white" : "bg-gray-200 text-gray-700 hover:bg-gray-300" %>"><%= i %></a>

                        <% }
                            if (currentPage < totalPages) {
                        %>
                        <a class="px-3 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
                           href="adminFilterEmployee?page=<%= currentPage + 1 %>&keyword=<%= keyword %>&branch=<%= branch %>&staffType=<%= selectedStaffType %>&status=<%= selectedStatus %>">Tiếp →</a>

                        <% } %>

                        <form action="adminFilterEmployee" method="get" class="flex items-center gap-2 ml-4">
                            <input type="hidden" name="keyword" value="<%= keyword %>">
                            <input type="hidden" name="branch" value="<%= branch %>">
                            <input type="hidden" name="staffType" value="<%= selectedStaffType %>">
                            <input type="hidden" name="status" value="<%= selectedStatus %>">

                            <input type="number" name="page" min="1" max="<%= totalPages %>" placeholder="Trang..."
                                   class="w-24 px-2 py-2 border rounded-lg text-center focus:ring-2 focus:ring-blue-500" required>
                            <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">Đến</button>
                        </form>

                    </div>


                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script>
                                // Thay thế đoạn JavaScript hiện tại bằng đoạn này:
                                $(document).ready(function () {
                                    $('.btn-view-employee').click(function (e) {
                                        e.preventDefault();

                                        const $this = $(this);
                                        const isActive = $this.data('status') === "Đang hoạt động";
                                        const staffId = $this.data('id');
                                        const branchId = $this.data('branch-id');

                                        // Gán dữ liệu vào modal
                                        $('#empImage').attr('src', $this.data('image'));
                                        $('#empFullName').text($this.data('full-name'));
                                        $('#empEmail').text($this.data('email'));
                                        $('#empAddress').text($this.data('address'));
                                        $('#empDob').text($this.data('dob'));
                                        $('#empGender').text($this.data('gender'));
                                        $('#empArea').text($this.data('area'));
                                        $('#empPool').text($this.data('pool'));
                                        $('#empPosition').text($this.data('position'));
                                        $('#empDescription').text($this.data('description'));

                                        // Gán trạng thái
                                        const $status = $('#empStatus');
                                        if (isActive) {
                                            $status
                                                    .text('Đang hoạt động')
                                                    .removeClass()
                                                    .addClass('inline-block mt-1 text-sm font-semibold px-3 py-1 rounded-full bg-green-100 text-green-700');
                                        } else {
                                            $status
                                                    .text('Đã khóa')
                                                    .removeClass()
                                                    .addClass('inline-block mt-1 text-sm font-semibold px-3 py-1 rounded-full bg-red-100 text-red-700');
                                        }

                                        // CÁCH 1: Sửa đoạn này - Set href trực tiếp thay vì dùng click handler
                                        $('#updateLink').attr('href', 'adminEditEmployee?id=' + staffId + '&branchId=' + branchId);
                                        $('#toggleStatusLink').attr('href', 'adminToggleEmployeeStatus?id=' + staffId);

                                        // Hiện modal
                                        $('#employeeDetailModal').removeClass('hidden');
                                    });
                                });

                                // Nút đóng modal
                                function closeModal() {
                                    document.getElementById("employeeDetailModal").classList.add("hidden");
                                }
                    </script>


                </div>
            </main>
        </div>

    </body>
</html>
