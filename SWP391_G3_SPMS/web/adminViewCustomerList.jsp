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
                <a href="adminViewStaffCategory.jsp" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-tie"></i> Quản lý nhân viên</a>
                <a href="adminViewCustomerList" class="bg-blue-900 ring-2 ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-check"></i> Quản lý khách hàng</a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo</a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-gear"></i> Cài đặt hệ thống</a>
                <a href="LogoutServlet" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 text-red-400"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
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
                <form action="adminFilterCustomer" method="GET" class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
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
                        <tbody>
                            <% 
                                if (listCustomer != null && !listCustomer.isEmpty()) {
                                    for (Customer c : listCustomer) {
                            %>
                            <tr class="hover:bg-gray-100">
                                <td class="p-3 border">KH00<%= c.getUser_id() %></td>
                                <td class="p-3 border"><%= c.getFull_name() %></td>
                                <td class="p-3 border"><%= c.getEmail() %></td>
                                <td class="p-3 border"><%= c.getPhone() %></td>
                                <td class="p-3 border"><%= c.getTotal_spent() %> vnđ</td>
                                <td class="p-3 border">
                                    <span class="<%= (c.getStatus() ? "text-green-700 bg-green-100" : "text-red-700 bg-red-100") %> px-3 py-1 rounded-full text-xs font-medium">
                                        <%= (c.getStatus() ? "Hoạt Động" : "Bị khóa") %>
                                    </span>
                                </td>
                                <td class="p-3 border space-x-2">
                                    <a href="#" 
                                       class="bg-blue-500 text-white px-2 py-1 rounded hover:bg-blue-700 view-btn"
                                       data-user-id ="<%= c.getUser_id() %>"
                                       data-full-name="<%= c.getFull_name() %>"
                                       data-email="<%= c.getEmail() %>"
                                       data-phone="<%= c.getPhone() %>"
                                       data-address="<%= c.getAddress() %>"
                                       data-dob="<%= c.getDob() %>"
                                       data-gender="<%= c.getGender().equalsIgnoreCase("male") ? "Nam" : c.getGender().equalsIgnoreCase("female") ? "Nữ" : "Khác" %>"
                                       data-image="<%= c.getImages() %>"
                                       data-status="<%= c.getStatus() %>">
                                        <i class="fa-solid fa-eye"></i> Xem
                                    </a>

                                    <a href="adminUpdateCustomer?userId=<%= c.getUser_id() %>" class="bg-yellow-400 text-black px-2 py-1 rounded hover:bg-yellow-500"><i class="fa-solid fa-pen"></i> Sửa</a>
                                    <a href="adminLockCustomer?userId=<%= c.getUser_id() %>&userStatus=<%= c.getStatus()%>" 
                                       class="toggle-status-btn <%= (c.getStatus() ? "bg-red-500" : "bg-green-500") %> text-white px-2 py-1 rounded"
                                       data-user-id="<%= c.getUser_id() %>"
                                       data-user-status="<%= c.getStatus() %>">
                                        <i class="fa-solid <%= (c.getStatus() ? "fa-lock" : "fa-lock-open") %>"></i>
                                        <%= (c.getStatus() ? "Khóa" : "Mở") %>
                                    </a>
                                </td>
                            </tr>
                            <% 
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="7" class="p-3 text-center">Không có khách hàng nào được tìm thấy.</td>
                            </tr>
                            <% 
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <!-- Customer Detail Modal -->
                <div id="customerModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
                    <div class="bg-white w-full max-w-xl rounded-xl shadow-lg p-6 relative">
                        <button onclick="closeModal()" class="absolute top-2 right-2 text-gray-500 hover:text-red-500 text-xl">&times;</button>
                        <h3 class="text-2xl font-bold mb-4 text-blue-700 text-center">Chi tiết khách hàng</h3>

                        <!-- Thông tin chính -->
                        <div class="flex items-center gap-6 mb-6">
                            <img id="modalImage" src="" alt="Ảnh đại diện" class="w-24 h-24 rounded-full object-cover border shadow" />
                            <div>
                                <p class="text-xl font-semibold text-gray-800" id="modalFullName"></p>
                                <p class="text-sm mt-1">
                                    <span id="modalStatus" class="px-2 py-1 text-white text-xs font-medium rounded-full"></span>
                                </p>
                            </div>
                        </div>

                        <!-- Thông tin phụ -->
                        <div class="grid grid-cols-1 gap-3 text-sm text-gray-700 mb-6">
                            <p><strong>Email:</strong> <span id="modalEmail"></span></p>
                            <p><strong>Số điện thoại:</strong> <span id="modalPhone"></span></p>
                            <p><strong>Địa chỉ:</strong> <span id="modalAddress"></span></p>
                            <p><strong>Ngày sinh:</strong> <span id="modalDob"></span></p>
                            <p><strong>Giới tính:</strong> <span id="modalGender"></span></p>
                        </div>

                        <!-- Nút hành động -->
                        <div class="flex justify-end gap-3">
                            <button onclick="closeModal()" class="bg-gray-400 hover:bg-gray-500 text-white px-4 py-2 rounded">Đóng</button>
                            <a id="updateBtn" href="#" class="bg-yellow-400 hover:bg-yellow-500 text-black px-4 py-2 rounded font-medium">
                                <i class="fa-solid fa-pen"></i> Cập nhật
                            </a>
                            <a id="historyBtn" type="button" href="#" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded font-medium">
                                <i class="fa-solid fa-clock-rotate-left"></i> Xem lịch sử
                            </a>
                        </div>  
                    </div>
                </div>



                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script>
                                $(document).ready(function () {
                                    $('.toggle-status-btn').click(function (e) {
                                        e.preventDefault();
                                        var $btn = $(this);
                                        var userId = $btn.data('user-id');
                                        var userStatus = $btn.data('user-status');
                                        $.ajax({
                                            url: 'adminLockCustomer',
                                            type: 'GET',
                                            data: {
                                                userId: userId,
                                                userStatus: userStatus
                                            },
                                            success: function (response) {
                                                // Cập nhật lại trạng thái trên giao diện
                                                // Đảo trạng thái
                                                var newStatus = !userStatus;
                                                $btn.data('user-status', newStatus);
                                                // Đổi màu nút và icon, text
                                                if (newStatus) {
                                                    $btn.removeClass('bg-green-500').addClass('bg-red-500');
                                                    $btn.find('i').removeClass('fa-lock-open').addClass('fa-lock');
                                                    $btn.html('<i class="fa-solid fa-lock"></i> Khóa');
                                                    // Đổi trạng thái text
                                                    $btn.closest('tr').find('td:nth-child(6) span')
                                                            .removeClass('text-red-700 bg-red-100')
                                                            .addClass('text-green-700 bg-green-100')
                                                            .text('Hoạt Động');
                                                } else {
                                                    $btn.removeClass('bg-red-500').addClass('bg-green-500');
                                                    $btn.find('i').removeClass('fa-lock').addClass('fa-lock-open');
                                                    $btn.html('<i class="fa-solid fa-lock-open"></i> Mở');
                                                    $btn.closest('tr').find('td:nth-child(6) span')
                                                            .removeClass('text-green-700 bg-green-100')
                                                            .addClass('text-red-700 bg-red-100')
                                                            .text('Bị khóa');
                                                }
                                            },
                                            error: function () {
                                                alert('Có lỗi xảy ra, vui lòng thử lại!');
                                            }
                                        });
                                    });
                                });
                                $('.view-btn').click(function (e) {
                                    e.preventDefault();

                                    const isActive = $(this).data('status'); // true hoặc false
                                    const $status = $('#modalStatus');
                                    const userId = $(this).data('user-id');

                                    // Gán dữ liệu
                                    $('#modalFullName').text($(this).data('full-name'));
                                    $('#modalEmail').text($(this).data('email'));
                                    $('#modalPhone').text($(this).data('phone'));
                                    $('#modalAddress').text($(this).data('address'));
                                    $('#modalDob').text($(this).data('dob'));
                                    $('#modalGender').text($(this).data('gender'));
                                    $('#modalImage').attr('src', $(this).data('image'));

                                    // Gán trạng thái và màu
                                    if (isActive) {
                                        $status
                                                .text('Hoạt Động')
                                                .removeClass()
                                                .addClass('px-2 py-1 text-xs font-medium rounded-full bg-green-100 text-green-700');
                                    } else {
                                        $status
                                                .text('Bị khóa')
                                                .removeClass()
                                                .addClass('px-2 py-1 text-xs font-medium rounded-full bg-red-100 text-red-700');
                                    }

                                    // Gán link cho lịch sử và cập nhật
                                    $('#historyBtn').attr('href', 'adminViewCustomerHistory?userId=' + userId);
                                    $('#updateBtn').attr('href', 'adminUpdateCustomer?userId=' + userId);

                                    // Hiện modal
                                    $('#customerModal').removeClass('hidden');
                                });



                                function closeModal() {
                                    $('#customerModal').addClass('hidden');
                                }

                </script>

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