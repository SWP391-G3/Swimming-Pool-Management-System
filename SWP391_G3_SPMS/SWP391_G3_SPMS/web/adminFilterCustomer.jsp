<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List,model.admin.Customer,model.customer.User" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>

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
<html>
    <head>
        <title>Quản lý khách hàng</title>
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
    <% 
    User currentUser = (User) session.getAttribute("currentUser");
    String userName = (currentUser != null) ? currentUser.getFull_name() : "";
    %>

    <% 
        String keyword = request.getAttribute("keyword") != null ? request.getAttribute("keyword").toString() : "";
        String status = request.getAttribute("status") != null ? request.getAttribute("status").toString() : "";
        String sortAmount = request.getAttribute("sortAmount") != null ? request.getAttribute("sortAmount").toString() : "";
        String user_id = request.getAttribute("userId") != null ? request.getAttribute("userId").toString() : "";
    %>
    <body class="bg-gray-100 font-sans leading-relaxed antialiased text-gray-800">
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

                    <a href="adminViewStaffCategory.jsp"
                       class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon">
                            <i class="fa-solid fa-user-tie text-sm"></i>
                        </div>
                        <span class="font-medium text-sm">Quản lý nhân viên</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>

                    <a href="adminViewCustomerList"
                       class="nav-item active-nav px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
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
                    <div class="bg-white p-4 rounded-2xl shadow-md mb-6 flex justify-between items-center">
                        <h2 class="text-xl font-bold text-blue-700">Danh sách khách hàng</h2>
                        <a href="adminViewCustomerList" class="bg-gray-800 hover:bg-gray-700 text-white font-semibold py-2 px-4 rounded transition">
                            <i class="fa-solid fa-rotate"></i> Đặt lại
                        </a>
                    </div>
                    <!-- Filters Form -->
                    <form action="adminFilterCustomer" method="GET" class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                        <input type="text" name="keyword" value="<%= keyword %>" placeholder="Tìm kiếm theo tên,email..." class="px-3 py-2 border rounded" />
                        <select name="status" class="border rounded px-3 py-2">
                            <option value="">-- Trạng thái tài khoản --</option>
                            <option value="active" <%= "active".equals(status) ? "selected" : "" %>>Đang hoạt động</option>
                            <option value="blocked" <%= "blocked".equals(status) ? "selected" : "" %>>Đã khóa</option>
                        </select>
                        <select name="sortAmount" class="border rounded px-3 py-2">
                            <option value="">-- Sắp xếp theo tổng chi tiêu --</option>
                            <option value="asc" <%= "asc".equals(sortAmount) ? "selected" : "" %>>Tăng dần</option>
                            <option value="desc" <%= "desc".equals(sortAmount) ? "selected" : "" %>>Giảm dần</option>
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
                                <a id="historyBtn" href="#" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded font-medium">
                                    <i class="fa-solid fa-clock-rotate-left"></i> Xem lịch sử
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Ban Reason Modal -->
                    <div id="banReasonModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
                        <div class="bg-white w-full max-w-md rounded-xl shadow-lg p-6 relative">
                            <button onclick="closeBanModal()" class="absolute top-2 right-2 text-gray-500 hover:text-red-500 text-xl">&times;</button>
                            <h3 class="text-xl font-bold mb-4 text-red-600 text-center">Nhập lý do khóa tài khoản</h3>

                            <form id="banForm" >
                                <input type="hidden" name="userId" id="banUserId" />
                                <textarea name="reason" id="banReason" rows="4" required
                                          class="w-full border rounded p-2 text-sm"
                                          placeholder="Nhập lý do khóa tài khoản..."></textarea>
                                <div class="flex justify-end gap-2 mt-4">
                                    <button type="button" onclick="closeBanModal()" class="bg-gray-400 hover:bg-gray-500 text-white px-4 py-2 rounded">Hủy</button>
                                    <button type="submit" class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded">Xác nhận khóa</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script>
                                        const currentPage = <%= currentPage %>;
                                        const keyword = "<%= keyword %>";
                                        const status = "<%= status %>";
                                        const sortAmount = "<%= sortAmount %>";
                                        $(document).ready(function () {
                                            $('.toggle-status-btn').click(function (e) {
                                                e.preventDefault();
                                                const $btn = $(this);
                                                const userId = $btn.data('user-id');
                                                const isActive = $btn.hasClass('bg-red-500'); // Nếu đang là nút Khóa → trạng thái hiện tại là Hoạt động

                                                if (isActive) {
                                                    // Đang hoạt động → hiện modal nhập lý do khóa
                                                    $('#banUserId').val(userId);
                                                    $('#banReason').val('');
                                                    $('#banReasonModal').removeClass('hidden');
                                                } else {
                                                    // Đang bị khóa → mở khóa luôn
                                                    $.ajax({
                                                        url: 'adminLockCustomer',
                                                        type: 'GET',
                                                        data: {
                                                            userId: userId,
                                                            userStatus: false // mở khóa
                                                        },
                                                        success: function () {
                                                            window.location.href = `adminFilterCustomer?page=${currentPage}&keyword=${keyword}&status=${status}&sortAmount=${sortAmount}`;
                                                        }
                                                        ,
                                                        error: function () {
                                                            alert('Có lỗi xảy ra, vui lòng thử lại!');
                                                        }
                                                    });
                                                }
                                            });


                                            // Xử lý modal xem chi tiết như cũ (GIỮ NGUYÊN):
                                            $('.view-btn').click(function (e) {
                                                e.preventDefault();
                                                const isActive = $(this).data('status');
                                                const $status = $('#modalStatus');
                                                const userId = $(this).data('user-id');
                                                $('#modalFullName').text($(this).data('full-name'));
                                                $('#modalEmail').text($(this).data('email'));
                                                $('#modalPhone').text($(this).data('phone'));
                                                $('#modalAddress').text($(this).data('address'));
                                                $('#modalDob').text($(this).data('dob'));
                                                $('#modalGender').text($(this).data('gender'));
                                                $('#modalImage').attr('src', $(this).data('image'));
                                                if (isActive) {
                                                    $status.text('Hoạt Động')
                                                            .removeClass()
                                                            .addClass('px-2 py-1 text-xs font-medium rounded-full bg-green-100 text-green-700');
                                                } else {
                                                    $status.text('Bị khóa')
                                                            .removeClass()
                                                            .addClass('px-2 py-1 text-xs font-medium rounded-full bg-red-100 text-red-700');
                                                }
                                                $('#historyBtn').attr('href', 'adminViewCustomerHistory?userId=' + userId);
                                                $('#updateBtn').attr('href', 'adminUpdateCustomer?userId=' + userId);
                                                $('#customerModal').removeClass('hidden');
                                            });
                                        });

                                        $('#banForm').submit(function (e) {
                                            e.preventDefault(); // chặn hành vi submit mặc định

                                            const userId = $('#banUserId').val();
                                            const reason = $('#banReason').val();

                                            $.ajax({
                                                url: 'adminLockCustomer',
                                                method: 'GET',
                                                data: {
                                                    userId: userId,
                                                    userStatus: true,
                                                    reason: reason
                                                },
                                                success: function (data) {
                                                    if (data.success) {
                                                        closeBanModal();
                                                         window.location.href = `adminFilterCustomer?page=${currentPage}&keyword=${keyword}&status=${status}&sortAmount=${sortAmount}`;
                                                    } else {
                                                        alert("Có lỗi khi khóa tài khoản.");
                                                    }
                                                },
                                                error: function () {
                                                    alert("Lỗi hệ thống, vui lòng thử lại!");
                                                }
                                            });
                                        });





                                        function closeBanModal() {
                                            $('#banReasonModal').addClass('hidden');
                                        }

                                        function closeModal() {
                                            $('#customerModal').addClass('hidden');
                                        }

                    </script>


                    <!-- Pagination -->
                    <div class="flex flex-wrap justify-center items-center gap-2 mt-6">
                        <!-- Nút Trước -->
                        <% if (currentPage > 1) { %>
                        <a href="adminFilterCustomer?page=<%= currentPage - 1 %>&keyword=<%= keyword %>&status=<%= status %>&sortAmount=<%= sortAmount %>"
                           class="px-3 py-1 bg-blue-500 text-white rounded">
                            Trước
                        </a>
                        <% } %>

                        <!-- Nút số trang -->
                        <% for (int i = startPage; i <= endPage; i++) { %>
                        <a href="adminFilterCustomer?page=<%= i %>&keyword=<%= keyword %>&status=<%= status %>&sortAmount=<%= sortAmount %>"
                           class="px-3 py-1 rounded <%= (i == currentPage ? "bg-green-600 text-white" : "bg-gray-300 text-gray-800") %>">
                            <%= i %>
                        </a>
                        <% } %>

                        <!-- Nút Tiếp -->
                        <% if (currentPage < totalPages) { %>
                        <a href="adminFilterCustomer?page=<%= currentPage + 1 %>&keyword=<%= keyword %>&status=<%= status %>&sortAmount=<%= sortAmount %>"
                           class="px-3 py-1 bg-blue-500 text-white rounded">
                            Tiếp
                        </a>
                        <% } %>

                        <!-- Input nhảy đến trang -->
                        <form action="adminFilterCustomer" method="GET" class="flex items-center gap-2">
                            <input type="hidden" name="keyword" value="<%= keyword %>">
                            <input type="hidden" name="status" value="<%= status %>">
                            <input type="hidden" name="sortAmount" value="<%= sortAmount %>">
                            <input type="number" name="page" min="1" max="<%= totalPages %>"
                                   placeholder="Trang..." class="w-20 px-2 py-1 border rounded text-center" required>
                            <button type="submit" class="bg-blue-600 text-white px-3 py-1 rounded hover:bg-blue-700">
                                Đến
                            </button>
                        </form>
                    </div>
                </main>
            </div>
    </body>
</html>