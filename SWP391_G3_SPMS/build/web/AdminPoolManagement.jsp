<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List,model.customer.Pool,model.customer.User"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Panel</title>
        <script src="https://cdn.tailwindcss.com"></script>
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
    <body class="bg-gray-100 text-gray-800 overflow-x-hidden">
        <%
            User currentUser = (User) session.getAttribute("currentUser");
            String userName = (currentUser != null) ? currentUser.getFull_name() : "";
            String nameWork = (String) request.getAttribute("nameWork");
            List<Pool> listPool = (List<Pool>) request.getAttribute("listPool");
            int currentPage = (Integer) request.getAttribute("currentPage");
            int totalPages = (Integer) request.getAttribute("totalPages");
            int visiblePages = 5;
            int startPage = Math.max(1, currentPage - visiblePages / 2);
            int endPage = Math.min(totalPages, startPage + visiblePages - 1);
            if (endPage - startPage < visiblePages - 1) {
                startPage = Math.max(1, endPage - visiblePages + 1);
            }
        %>

        <!-- Mobile menu button -->
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

                    <a href="adminPoolManagement" class="nav-item active-nav px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon">
                            <i class="fa-solid fa-water text-sm"></i>
                        </div>
                        <span class="font-medium text-sm">Quản lý bể bơi</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>

                    <a href="adminViewStaffCategory.jsp"
                       class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
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
                    <p class="text-xs text-blue-200">© 2025 Pool Management</p>
                    <p class="text-xs text-blue-300 mt-1">Version 2.1.0</p>
                </div>
            </nav>

            <!-- Main Content -->
            <div class="main-content ml-0 md:ml-72 p-2 sm:p-4 md:p-6 w-full">
                <main class="w-full max-w-full">
                    <div class="flex justify-between items-center bg-white p-4 rounded shadow mb-6">
                        <h2 class="text-lg md:text-xl font-bold text-blue-700"><%= nameWork %></h2>
                    </div>

                    <!-- Filter Form -->
                    <form action="adminSearchPool" method="GET" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-4 mb-6">
                        <input type="text" name="search" placeholder="Tìm theo tên bể bơi..." class="border rounded px-3 py-2">
                        <select name="location" class="border rounded px-3 py-2">
                            <option value="">-- Lọc theo khu vực --</option>
                            <option value="Hà Nội">Hà Nội</option>
                            <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                            <option value="Đà Nẵng">Đà Nẵng</option>
                            <option value="Quy Nhơn">Quy Nhơn</option>
                            <option value="Cần Thơ">Cần Thơ</option>
                        </select>
                        <select name="status" class="border rounded px-3 py-2">
                            <option value="">-- Lọc theo trạng thái --</option>
                            <option value="true">Đang hoạt động</option>
                            <option value="false">Hủy hoạt động</option>
                        </select>
                        <select name="sort" class="border rounded px-3 py-2">
                            <option value="">-- Sắp xếp theo sức chứa --</option>
                            <option value="capacity_asc">Sức chứa tăng dần</option>
                            <option value="capacity_desc">Sức chứa giảm dần</option>
                        </select>
                        <div class="sm:col-span-2 md:col-span-4 flex flex-col sm:flex-row gap-4">
                            <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                            <a href="AdminAddPool.jsp" class="bg-[#00BB00] text-white px-4 py-2 rounded flex items-center gap-2 hover:bg-green-700"><i class="fa-solid fa-plus"></i> Thêm bể bơi mới</a>
                            <a href="adminPoolManagement" class="bg-[#696969] text-white px-4 py-2 rounded flex items-center gap-2 hover:bg-green-700"><i class="fa-solid fa-rotate"></i> Làm mới</a>
                        </div>
                    </form>

                    <!-- Pool Table -->
                    <div class="table-container bg-white rounded shadow">
                        <table class="min-w-full text-sm text-left">
                            <thead class="bg-gray-200 text-gray-700">
                                <tr>
                                    <th class="p-2 md:p-3 border">ID</th>
                                    <th class="p-2 md:p-3 border">Hình ảnh</th>
                                    <th class="p-2 md:p-3 border">Tên</th>
                                    <th class="p-2 md:p-3 border">Địa chỉ</th>
                                    <th class="p-2 md:p-3 border">Khu vực</th>
                                    <th class="p-2 md:p-3 border">Sức chứa</th>
                                    <th class="p-2 md:p-3 border">Mở cửa</th>
                                    <th class="p-2 md:p-3 border">Đóng cửa</th>
                                    <th class="p-2 md:p-3 border">Trạng thái</th>
                                    <th class="p-2 md:p-3 border">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (listPool != null) {
                                        for (Pool p : listPool) {
                                %>
                                <tr class="hover:bg-gray-100">
                                    <td class="p-2 md:p-3 border"><%= p.getPool_id() %></td>
                                    <td class="p-2 md:p-3 border"><img src="<%= p.getPool_image() %>" class="w-16 md:w-24 h-12 md:h-16 object-cover rounded" /></td>
                                    <td class="p-2 md:p-3 border"><%= p.getPool_name() %></td>
                                    <td class="p-2 md:p-3 border"><%= p.getPool_road() %></td>
                                    <td class="p-2 md:p-3 border"><%= p.getPool_address() %></td>
                                    <td class="p-2 md:p-3 border"><%= p.getMax_slot() %></td>
                                    <td class="p-2 md:p-3 border"><%= p.getOpen_time() %></td>
                                    <td class="p-2 md:p-3 border"><%= p.getClose_time() %></td>
                                    <td class="p-2 md:p-3 border">
                                        <span class="px-2 md:px-3 py-1 rounded-full text-xs font-medium <%= p.isPool_status() ? "bg-green-100 text-green-700" : "bg-red-100 text-red-700" %>">
                                            <%= p.isPool_status() ? "Đang hoạt động" : "Hủy hoạt động" %>
                                        </span>
                                    </td>
                                    <td class="p-2 md:p-3 border space-x-2">
                                        <a href="adminUpdatePool?id=<%= p.getPool_id() %>&page=<%= currentPage %>" class="bg-[#FFFF99] text-black px-2 py-1 rounded hover:bg-yellow-500"><i class="fa-solid fa-pen-to-square"></i> Sửa</a>
                                        <button class="bg-[#FF3333] text-white px-2 py-1 rounded hover:bg-red-600" onclick="confirmDelete(<%= p.getPool_id() %>)">
                                            <i class="fa-solid fa-trash"></i> Xóa
                                        </button>
                                    </td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>


                    <!-- Pagination -->
                    <div class="flex flex-wrap justify-center mt-6 gap-2">
                        <div class="px-3 py-1 bg-blue-500 text-white rounded">
                            <a class="" href="adminPoolManagement">Đầu</a>
                        </div>
                        <%
                            if (currentPage > 1) {
                        %>
                        <a class="px-3 py-1 bg-blue-500 text-white rounded" href="adminPoolManagement?page=<%= currentPage - 1 %>">Trước</a>
                        <%
                            }
                            for (int i = startPage; i <= endPage; i++) {
                        %>
                        <a class="px-3 py-1 <%= (i == currentPage ? "bg-green-600 text-white" : "bg-gray-300 text-gray-800") %> rounded" href="adminPoolManagement?page=<%= i %>"><%= i %></a>
                        <%
                            }
                            if (currentPage < totalPages) {
                        %>
                        <a class="px-3 py-1 bg-blue-500 text-white rounded" href="adminPoolManagement?page=<%= currentPage + 1 %>">Tiếp</a>
                        <%
                            }
                        %>
                        <div class="px-3 py-1 bg-blue-500 text-white rounded">
                            <a class="" href="adminPoolManagement?page=<%= totalPages %>">Cuối</a>&nbsp;
                        </div>
                        <form action="adminPoolManagement" method="get" class="flex items-center gap-2 ml-4">
                            <input type="number" name="page" min="1" max="<%= totalPages %>" placeholder="Trang..." class="w-20 px-2 py-1 border rounded text-center" required>
                            <button type="submit" class="bg-blue-600 text-white px-3 py-1 rounded hover:bg-blue-700">Đến</button>
                        </form>
                    </div>
                </main>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
            <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-sm">
                <h2 class="text-lg font-semibold text-red-600 mb-4">Xác nhận xóa</h2>
                <p class="text-gray-700 mb-6">Bạn có chắc chắn muốn xóa bể bơi này không?</p>
                <form id="deleteForm" action="adminDeletePool" method="GET">
                    <input type="hidden" name="id" id="deletePoolId" value="">
                    <input type="hidden" name="page" id="deletePage" value="">
                    <div class="flex justify-end gap-3">
                        <button type="button" onclick="closeModal()" class="bg-gray-300 px-4 py-2 rounded hover:bg-gray-400">Hủy</button>
                        <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700">Xóa</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Error Modal -->
        <div id="errorModal" class="fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-50 hidden">
            <div class="bg-white rounded-xl shadow-2xl p-6 sm:p-8 w-full max-w-md animate-fade-in">
                <div class="flex items-center gap-3 mb-4">
                    <div class="text-red-600 text-2xl"><i class="fa-solid fa-circle-exclamation"></i></div>
                    <h2 class="text-xl font-bold text-red-600">Không thể xóa</h2>
                </div>
                <p class="text-gray-700 mb-6 leading-relaxed">
                    Chỉ có thể xóa bể bơi đang ở trạng thái <strong>"Hủy hoạt động"</strong>.
                </p>
                <div class="flex justify-end">
                    <button onclick="closeErrorModal()" class="bg-blue-600 hover:bg-blue-700 text-white font-medium px-5 py-2 rounded transition duration-200">Đóng</button>
                </div>
            </div>
        </div>

        <%
            String error = request.getParameter("error");
            if ("1".equals(error)) {
        %>
        <script>
            window.onload = function () {
                showCannotDeleteMessage();
            };
        </script>
        <%
            }
        %>

        <!-- JavaScript for modals and sidebar -->
        <script>
            function confirmDelete(poolId) {
                const currentPage = <%= currentPage %>;
                document.getElementById("deletePage").value = currentPage;
                document.getElementById("deletePoolId").value = poolId;
                document.getElementById("deleteModal").classList.remove("hidden");
            }

            function closeModal() {
                document.getElementById("deleteModal").classList.add("hidden");
            }

            function showCannotDeleteMessage() {
                document.getElementById("errorModal").classList.remove("hidden");
            }

            function closeErrorModal() {
                document.getElementById("errorModal").classList.add("hidden");
            }

            // Toggle sidebar on mobile
            const sidebar = document.getElementById("sidebar");
            const menuBtn = document.getElementById("mobileMenuBtn");
            menuBtn.addEventListener("click", () => {
                sidebar.classList.toggle("active");
            });
            document.addEventListener("click", (e) => {
                if (!sidebar.contains(e.target) && !menuBtn.contains(e.target) && window.innerWidth < 768) {
                    sidebar.classList.remove("active");
                }
            });
        </script>
    </body>
</html>