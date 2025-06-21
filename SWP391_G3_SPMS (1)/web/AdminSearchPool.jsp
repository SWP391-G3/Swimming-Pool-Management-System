<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.Pool" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kết quả tìm kiếm bể bơi</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
    <body class="bg-gray-100 min-h-screen flex">

        <!-- Sidebar -->
        <nav class="w-64 bg-[#000033] text-white p-6 flex flex-col space-y-4 fixed h-full">
            <div class="mb-6 text-center"> 
                <h1 class="text-2xl font-bold">Admin Panel</h1>
                <p class="text-sm text-gray-300">Swimming Pool System</p>
            </div>
            <div class="flex items-center gap-3 mb-6">
                <img src="https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/465/avatar-trang-1.jpg" alt="Avatar" class="w-12 h-12 rounded-full border-2 border-white object-cover" />
                <div>
                    <h4 class="text-base font-semibold">Nguyễn Văn A</h4>
                    <a href="#" class="text-sm text-blue-300 hover:underline">Xem chi tiết</a>
                </div>
            </div>
            <a href="adminPoolManagement" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-water"></i> Quản lý bể bơi</a>
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-tie"></i> Quản lý nhân viên</a>
            <a href="adminViewCustomerList" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-check"></i> Quản lý khách hàng</a>
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo</a>
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-gear"></i> Cài đặt hệ thống</a>
            <a href="LogoutServlet" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 text-red-400"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
        </nav>

        <!-- Main -->
        <main class="flex-1 p-6 ml-64 space-y-6">
            <div class="flex justify-between items-center bg-white p-4 rounded shadow">
                <h2 class="text-2xl font-bold text-blue-600">Tìm kiếm bể bơi</h2>
                <div class="text-gray-800 text-2xl">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M5.121 17.804A13.937 13.937 0 0112 15c2.21 0 4.285.534 6.121 1.473M12 15V3" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>
                </div>
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
