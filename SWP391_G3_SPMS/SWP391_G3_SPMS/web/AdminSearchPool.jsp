<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.customer.Pool" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kết quả tìm kiếm bể bơi</title>
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
                width: 100%;
                max-width: 100%;
            }
            @media (min-width: 768px) {
                .main-content {
                    margin-left: 18rem; /* đúng với w-72 của sidebar */
                }
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
    <%
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
    <body class="bg-gradient-to-br from-blue-50 via-indigo-50 to-purple-50 text-gray-800 flex min-h-screen">


        <!-- Sidebar -->
        <nav id="sidebar"
             class="w-72 sidebar-gradient text-white p-4 flex flex-col h-screen fixed top-0 left-0 shadow-2xl overflow-y-auto z-50">
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
                        <div
                            class="w-12 h-12 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full flex items-center justify-center">
                            <i class="fas fa-user text-white text-lg"></i>
                        </div>
                        <div
                            class="absolute -bottom-1 -right-1 w-5 h-5 bg-green-400 rounded-full border-2 border-white pulse-animation">
                        </div>
                    </div>
                    <div class="flex-1">
                        <h4 class="text-sm font-semibold text-white">Nguyễn Văn A</h4>
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
                <p class="text-xs text-blue-200">© 2024 Pool Management</p>
                <p class="text-xs text-blue-300 mt-1">Version 2.1.0</p>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="main-content ml-0 md:ml-72 p-2 sm:p-4 md:p-6 w-full">
            <main class="w-full max-w-full">
                <div class="flex justify-between items-center bg-white p-4 rounded shadow">
                    <h2 class="text-2xl font-bold text-blue-600">Tìm kiếm bể bơi</h2>
                </div>

                <%
                  String search = (String) request.getAttribute("search");
                  String location = (String) request.getAttribute("location");
                  String status = (String) request.getAttribute("status");
                  String sort = (String) request.getAttribute("sort");
                  if(search != null || location != null || status != null || sort != null) {
                %>
                <p class="text-gray-700">Kết quả cho từ khóa: <strong>"<%= search %> - <%= location %> - <%= status %> - <%= sort %>"</strong></p>
                <%  }%>

                <form action="adminSearchPool" method="GET" class="grid grid-cols-1 md:grid-cols-4 gap-4 bg-white p-4 rounded shadow">
                    <input type="text" name="search" class="border rounded p-2" placeholder="Tìm theo tên bể bơi..." />
                    <select name="location" class="border rounded p-2">
                        <option value="">-- Lọc theo khu vực --</option>
                        <option value="Hà Nội">Hà Nội</option>
                        <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                        <option value="Đà Nẵng">Đà Nẵng</option>
                        <option value="Cần Thơ">Cần Thơ</option>
                        <option value="Quy Nhơn">Quy Nhơn</option>
                    </select>
                    <select name="status" class="border rounded p-2">
                        <option value="">-- Lọc theo trạng thái --</option>
                        <option value="true">Đang hoạt động</option>
                        <option value="false">Hủy hoạt động</option>
                    </select>
                    <select name="sort" class="border rounded p-2">
                        <option value="">-- Sắp xếp --</option>
                        <option value="capacity_asc">Sức chứa tăng dần</option>
                        <option value="capacity_desc">Sức chứa giảm dần</option>
                    </select>
                    <div class="md:col-span-2 flex gap-3">
                        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Tìm kiếm</button>
                        <a href="AdminAddPool.jsp" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">+ Thêm bể bơi mới</a>
                    </div>
                </form>

                <!-- Table -->
                <div class="overflow-x-auto bg-white rounded shadow">
                    <table class="min-w-full text-sm text-left">
                        <thead class="bg-gray-200 text-gray-700">
                            <tr>
                                <th class="p-3 border">ID</th>
                                <th class="p-3 border">Hình ảnh</th>
                                <th class="p-3 border">Tên bể bơi</th>
                                <th class="p-3 border">Địa chỉ</th>
                                <th class="p-3 border">Khu vực</th>
                                <th class="p-3 border">Sức chứa</th>
                                <th class="p-3 border">Giờ mở cửa</th>
                                <th class="p-3 border">Giờ đóng cửa</th>
                                <th class="p-3 border">Trạng thái</th>
                                <th class="p-3 border">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (listPool != null && !listPool.isEmpty()) {
                                    for (Pool p : listPool) {
                            %>
                            <tr class="hover:bg-gray-100">
                                <td class="p-3 border"><%= p.getPool_id() %></td>
                                <td class="p-3 border"><img src="<%= p.getPool_image() %>" class="w-24 h-16 object-cover rounded" /></td>
                                <td class="p-3 border"><%= p.getPool_name() %></td>
                                <td class="p-3 border"><%= p.getPool_road() %></td>
                                <td class="p-3 border"><%= p.getPool_address() %></td>
                                <td class="p-3 border"><%= p.getMax_slot() %></td>
                                <td class="p-3 border"><%= p.getOpen_time() %></td>
                                <td class="p-3 border"><%= p.getClose_time() %></td>
                                <td class="p-3 border">
                                    <span class="px-3 py-1 rounded-full text-xs font-medium <%= p.isPool_status() ? "bg-green-100 text-green-700" : "bg-red-100 text-red-700" %>">
                                        <%= p.isPool_status() ? "Đang hoạt động" : "Hủy hoạt động" %>
                                    </span>
                                </td>
                                <td class="p-3 border space-x-2">
                                    <a href="adminUpdatePool?id=<%= p.getPool_id() %>" class="bg-[#FFFF99] text-black px-2 py-1 rounded hover:bg-yellow-500"><i class="fa-solid fa-pen-to-square"></i> Sửa</a>
                                    <button 
                                        class="bg-[#FF3333] text-white px-2 py-1 rounded hover:bg-red-600"
                                        onclick="confirmDelete(<%= p.getPool_id() %>)"
                                        >
                                        <i class="fa-solid fa-trash"></i> Xóa
                                    </button>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="10" class="text-center p-4 text-red-500">Không có bể bơi nào phù hợp!</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <%
                    String rawStatus = request.getParameter("status");
                    if (rawStatus == null) rawStatus = "";
                    String rawSort = request.getParameter("sort");
                    if (rawSort == null) rawSort = "";
                %>
                <!-- Pagination -->
                <div class="flex justify-center items-center space-x-2 mt-4">
                    <% if (currentPage > 1) { %>
                    <a href="adminSearchPool?page=<%= currentPage - 1 %>&search=<%= search %>&location=<%= location %>&status=<%= rawStatus %>&sort=<%= rawSort %>" class="px-3 py-1 bg-blue-600 text-white rounded hover:bg-blue-700">Trước</a>
                    <% } for (int i = startPage; i <= endPage; i++) { %>
                    <a href="adminSearchPool?page=<%= i %>&search=<%= search %>&location=<%= location %>&status=<%= rawStatus %>&sort=<%= rawSort %>" class="px-3 py-1 rounded <%= i == currentPage ? "bg-green-600 text-white" : "bg-gray-200 text-gray-700" %> hover:opacity-75"><%= i %></a>
                    <% } if (currentPage < totalPages) { %>
                    <a href="adminSearchPool?page=<%= currentPage + 1 %>&search=<%= search %>&location=<%= location %>&status=<%= rawStatus %>&sort=<%= rawSort %>" class="px-3 py-1 bg-blue-600 text-white rounded hover:bg-blue-700">Tiếp</a>
                    <% } %>
                    <!-- Input nhảy trang -->
                    <form action="adminSearchPool" method="get" class="flex items-center gap-2 ml-4">
                        <input type="hidden" name="search" value="<%= search %>">
                        <input type="hidden" name="location" value="<%= location %>">
                        <input type="hidden" name="status" value="<%= rawStatus %>">
                        <input type="hidden" name="sort" value="<%= rawSort %>">

                        <input type="number" name="page" min="1" max="<%= totalPages %>" placeholder="Trang..." class="w-20 px-2 py-1 border rounded text-center" required>
                        <button type="submit" class="bg-blue-600 text-white px-3 py-1 rounded hover:bg-blue-700">Đến</button>
                    </form>

                </div>
            </main>
        </div>

        <!-- Popup xác nhận xóa -->
        <div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
            <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-sm">
                <h2 class="text-lg font-semibold text-red-600 mb-4">Xác nhận xóa</h2>
                <p class="text-gray-700 mb-6">Bạn có chắc chắn muốn xóa bể bơi này không?</p>
                <div class="flex justify-end gap-3">
                    <form id="deleteForm" action="adminDeletePool" method="GET">
                        <input type="hidden" name="id" id="deletePoolId" value="">
                        <div class="flex justify-end gap-3">
                            <button type="button" onclick="closeModal()" class="bg-gray-300 px-4 py-2 rounded hover:bg-gray-400">Hủy</button>
                            <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700">Xóa</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>

        <!-- code xử lý xóa bể bơi bằng Popup  -->
        <script>
            function confirmDelete(poolId) {
                document.getElementById("deletePoolId").value = poolId;
                document.getElementById("deleteModal").classList.remove("hidden");
            }


            function closeModal() {
                const modal = document.getElementById("deleteModal");
                modal.classList.add("hidden");
            }
        </script>
    </body>
</html>
