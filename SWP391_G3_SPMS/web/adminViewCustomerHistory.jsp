<%-- 
    Document   : adminViewCustomerHIstory
    Created on : Jun 20, 2025, 10:26:58 PM
    Author     : Lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.admin.CustomerBooking,model.admin.CustomerService,model.admin.CustomerFeedback,model.admin.Customer" %>
<%@page import="model.admin.CustomerVoucher,model.admin.CustomerTicket" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Lịch sử khách hàng</title>
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
                            <h4 class="text-sm font-semibold text-white"></h4>
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
                        <i class="fas fa-bars mr-2"></i>Menu Chính
                    </div>
                    <a href="adminPoolManagement" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon"><i class="fa-solid fa-water text-sm"></i></div>
                        <span class="font-medium text-sm">Quản lý bể bơi</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>
                    <a href="adminViewStaffCategory.jsp" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon"><i class="fa-solid fa-user-tie text-sm"></i></div>
                        <span class="font-medium text-sm">Quản lý nhân viên</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>
                    <a href="adminViewCustomerList" class="nav-item active-nav px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon"><i class="fa-solid fa-user-check text-sm"></i></div>
                        <span class="font-medium text-sm">Quản lý khách hàng</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>
                    <a href="#" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon"><i class="fa-solid fa-chart-line text-sm"></i></div>
                        <span class="font-medium text-sm">Thống kê & Báo cáo</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>
                    <div class="text-xs font-semibold text-blue-200 uppercase tracking-wider mb-2 px-3 mt-4">
                        <i class="fas fa-cog mr-2"></i>Hệ thống
                    </div>
                    <a href="#" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon"><i class="fa-solid fa-gear text-sm"></i></div>
                        <span class="font-medium text-sm">Cài đặt hệ thống</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>
                    <div class="mt-3 pt-3 border-t border-white/20">
                        <a href="LogoutServlet" class="logout-btn nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 Światowy z-10 font-semibold">
                            <div class="nav-icon"><i class="fa-solid fa-right-from-bracket text-sm"></i></div>
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
                    <div class="max-w-5xl mx-auto bg-white p-6 rounded-xl shadow">
                        <div class="flex items-center justify-between mb-6">
                            <h1 class="text-2xl font-bold text-blue-800">Thông tin chi tiết về lịch sử sử dụng của khách hàng</h1>
                            <a href="adminViewCustomerList" class="px-4 py-2 bg-gray-700 text-white rounded hover:bg-gray-800 text-sm">
                                <i class="fa-solid fa-arrow-left mr-1"></i> Quay lại
                            </a>
                        </div>
                        <% 
                            Customer cus = (Customer) request.getAttribute("customer");
                        %>
                        <!-- Thông tin khách hàng -->
                        <div class="mb-10 bg-white p-6 rounded-xl shadow border border-gray-200">
                            <h2 class="text-xl font-semibold text-blue-800 mb-6">Thông tin khách hàng</h2>

                            <!-- Avatar + Tên + Trạng thái -->
                            <div class="flex flex-wrap items-center gap-6 mb-6">
                                <img src="https://via.placeholder.com/100" alt="Avatar"
                                     class="w-24 h-24 rounded-full border-4 border-blue-300 object-cover shadow-sm" />

                                <div class="flex-1">
                                    <h3 class="text-xl font-semibold text-gray-800"><%= cus.getFull_name() %></h3>
                                    <span class="inline-block mt-2 px-3 py-1 text-sm font-medium rounded-full
                                          <%= cus.getStatus() ? "bg-green-100 text-green-700" : "bg-red-100 text-red-700"%>
                                          border border-green-300">
                                        <%= cus.getStatus() ? "Đang hoạt động" : "Bị khóa" %>
                                    </span>
                                </div>
                            </div>

                            <!-- Thông tin khác -->
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-x-12 gap-y-4 mb-6">
                                <div>
                                    <p class="text-sm font-medium text-gray-500">Email</p>
                                    <p class="text-base font-semibold text-gray-800"><%= cus.getEmail() %></p>
                                </div>
                                <div>
                                    <p class="text-sm font-medium text-gray-500">Số điện thoại</p>
                                    <p class="text-base font-semibold text-gray-800"><%= cus.getPhone() %></p>
                                </div>
                                <div>
                                    <p class="text-sm font-medium text-gray-500">Địa chỉ</p>
                                    <p class="text-base font-semibold text-gray-800"><%= cus.getAddress() %></p>
                                </div>
                                <div>
                                    <p class="text-sm font-medium text-gray-500">Giới tính</p>
                                    <p class="text-base font-semibold text-gray-800"><%= "male".equals(cus.getGender()) ? "Nam" : "female".equals(cus.getGender()) ? "Nữ" : "Khác"%></p>
                                </div>
                                <div>
                                    <p class="text-sm font-medium text-gray-500">Ngày sinh</p>
                                    <p class="text-base font-semibold text-gray-800"><%= cus.getDob() %></p>
                                </div>
                            </div>

                            <!-- Button -->
                            <div class="flex flex-wrap gap-4">

                                <button id="voucherBtn"
                                        class="bg-indigo-500 hover:bg-indigo-600 text-white px-5 py-2 rounded-md text-sm font-medium flex items-center gap-2 shadow">
                                    <i class="fa-solid fa-ticket"></i> Voucher
                                </button>

                                <a href="adminUpdateCustomer?userId=<%= cus.getUser_id() %>"
                                   class="bg-yellow-500 hover:bg-yellow-600 text-white px-5 py-2 rounded-md text-sm font-medium flex items-center gap-2 shadow">
                                    <i class="fa-solid fa-pen-to-square"></i> Cập nhật
                                </a>

                                <a href="adminLockCustomer?userId=<%= cus.getUser_id() %>&userStatus=<%= cus.getStatus() %>"
                                   class="toggle-status-btn <%= cus.getStatus() ? "bg-red-500" : "bg-green-500" %> text-white px-5 py-2 rounded-md text-sm font-medium flex items-center gap-2 shadow"
                                   data-user-id="<%= cus.getUser_id() %>"
                                   data-user-status="<%= cus.getStatus() %>">
                                    <i class="fa-solid <%= cus.getStatus() ? "fa-lock" : "fa-lock-open" %>"></i>
                                    <%= cus.getStatus() ? "Khóa" : "Mở" %>
                                </a>

                            </div>
                        </div>
                        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                        <script>
                            $(document).ready(function () {
                                $('.toggle-status-btn').click(function (e) {
                                    e.preventDefault();
                                    const $btn = $(this);
                                    const userId = $btn.data('user-id');
                                    const userStatus = $btn.data('user-status');
                                    $.ajax({
                                        url: 'adminLockCustomer',
                                        type: 'GET',
                                        data: {
                                            userId: userId,
                                            userStatus: userStatus
                                        },
                                        success: function () {
                                            const newStatus = !userStatus;
                                            $btn.data('user-status', newStatus);
                                            if (newStatus) {
                                                $btn.removeClass('bg-green-500').addClass('bg-red-500');
                                                $btn.find('i').removeClass('fa-lock-open').addClass('fa-lock');
                                                $btn.html('<i class="fa-solid fa-lock"></i> Khóa');
                                                $btn.closest('.mb-10').find('span')
                                                        .removeClass('bg-red-100 text-red-700')
                                                        .addClass('bg-green-100 text-green-700')
                                                        .text('Đang hoạt động');
                                            } else {
                                                $btn.removeClass('bg-red-500').addClass('bg-green-500');
                                                $btn.find('i').removeClass('fa-lock').addClass('fa-lock-open');
                                                $btn.html('<i class="fa-solid fa-lock-open"></i> Mở');
                                                $btn.closest('.mb-10').find('span')
                                                        .removeClass('bg-green-100 text-green-700')
                                                        .addClass('bg-red-100 text-red-700')
                                                        .text('Bị khóa');
                                            }
                                        },
                                        error: function () {
                                            alert('Có lỗi xảy ra, vui lòng thử lại!');
                                        }
                                    });
                                });
                            });
                        </script>



                        <!-- Popup Overlay -->
                        <div id="voucherPopup" class="fixed inset-0 bg-black bg-opacity-50 hidden justify-center items-center z-50">
                            <div class="bg-white p-6 rounded-xl shadow-lg w-full max-w-3xl relative">
                                <button id="closePopup" class="absolute top-3 right-4 text-gray-500 hover:text-red-500 text-xl font-bold">&times;</button>
                                <h2 class="text-xl font-semibold text-indigo-700 mb-4"><i class="fa-solid fa-ticket"></i> Voucher & Ticket đã sử dụng</h2>

                                <!-- VOUCHER -->
                                <div class="mb-6">
                                    <h3 class="font-semibold text-gray-700 mb-2">Voucher</h3>
                                    <table class="w-full table-auto border text-sm bg-indigo-50 border-indigo-200 rounded shadow">
                                        <thead class="bg-indigo-100 text-indigo-900">
                                            <tr>
                                                <th class="px-3 py-2 border">Tên Voucher</th>
                                                <th class="px-3 py-2 border">Giảm giá</th>
                                                <th class="px-3 py-2 border">Ngày áp dụng</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%-- Giả sử bạn có List<CustomerVoucher> vouchers --%>
                                            <%
                                                CustomerVoucher v = (CustomerVoucher) request.getAttribute("customerVoucher");
                                                if(v != null){
                                            %>
                                            <tr>
                                                <td class="px-3 py-2 border"><%= v.getVoucher_name() %></td>
                                                <td class="px-3 py-2 border"><%= v.getDescription() %> %</td>
                                                <td class="px-3 py-2 border"><%= v.getApplied_date() %></td>
                                            </tr>
                                            <% } else { %>
                                            <tr><td colspan="3" class="px-3 py-2 text-center">Chưa có voucher nào được sử dụng</td></tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- TICKET -->
                                <div>
                                    <h3 class="font-semibold text-gray-700 mb-2">Ticket</h3>
                                    <table class="w-full table-auto border text-sm bg-yellow-50 border-yellow-200 rounded shadow">
                                        <thead class="bg-yellow-100 text-yellow-900">
                                            <tr>
                                                <th class="px-3 py-2 border">Loại vé</th>
                                                <th class="px-3 py-2 border">Mã vé</th>
                                                <th class="px-3 py-2 border">Tổng tiền</th>
                                                <th class="px-3 py-2 border">Ngày sử dụng</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%-- Giả sử bạn có List<CustomerTicket> tickets --%>
                                            <%
                                                CustomerTicket t = (CustomerTicket) request.getAttribute("customerTicket");
                                                if(t != null){
                                            %>
                                            <tr>
                                                <td class="px-3 py-2 border"><%= t.getType_name() %></td>
                                                <td class="px-3 py-2 border"><%= t.getType_code() %></td>
                                                <td class="px-3 py-2 border"><%= t.getAverage_price() %></td>
                                                <td class="px-3 py-2 border"><%= t.getUse_date() %> vnđ</td>
                                            </tr>
                                            <% } else { %>
                                            <tr><td colspan="3" class="px-3 py-2 text-center">Chưa có vé nào được sử dụng</td></tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                const voucherBtn = document.getElementById("voucherBtn");
                                const voucherPopup = document.getElementById("voucherPopup");
                                const closePopup = document.getElementById("closePopup");

                                voucherBtn.addEventListener("click", function () {
                                    voucherPopup.classList.remove("hidden");
                                    voucherPopup.classList.add("flex"); // Hiển thị theo flex để căn giữa
                                });

                                closePopup.addEventListener("click", function () {
                                    voucherPopup.classList.add("hidden");
                                    voucherPopup.classList.remove("flex");
                                });

                                // Click outside to close
                                voucherPopup.addEventListener("click", function (e) {
                                    if (e.target === voucherPopup) {
                                        voucherPopup.classList.add("hidden");
                                        voucherPopup.classList.remove("flex");
                                    }
                                });
                            });
                        </script>




                        <!-- Booking Details -->
                        <div class="mb-10">
                            <h2 class="text-xl font-semibold text-green-700 mb-4">Lịch sử đặt bể bơi mới nhất</h2>
                            <div class="overflow-x-auto">
                                <table class="w-full table-auto text-left border border-green-200 bg-green-50 rounded-xl shadow">
                                    <thead class="bg-green-100 text-green-900">
                                        <tr>
                                            <th class="px-4 py-2 border">Bể bơi</th>
                                            <th class="px-4 py-2 border">Ngày đặt</th>
                                            <th class="px-4 py-2 border">Thời gian</th>
                                            <th class="px-4 py-2 border">Slot</th>
                                            <th class="px-4 py-2 border">Thanh toán</th>
                                            <th class="px-4 py-2 border">TT Thanh toán</th>
                                            <th class="px-4 py-2 border">Ngày tạo</th>
                                        </tr>
                                    </thead>
                                    <% 
                                        CustomerBooking cusBooking = (CustomerBooking) request.getAttribute("customerBooking");
                                        if(cusBooking != null){
                                    %>
                                    <tbody class="text-sm text-gray-700">
                                        <tr>
                                            <td class="px-4 py-2 border"><%= cusBooking.getPool_name() %></td>
                                            <td class="px-4 py-2 border"><%= cusBooking.getBooking_date() %></td>
                                            <td class="px-4 py-2 border"><%= cusBooking.getStart_time().format(java.time.format.DateTimeFormatter.ofPattern("HH:mm"))  %> - 
                                                <%= cusBooking.getEnd_time().format(java.time.format.DateTimeFormatter.ofPattern("HH:mm"))  %></td>
                                            <td class="px-4 py-2 border"><%= cusBooking.getSlot_count() %></td>
                                            <td class="px-4 py-2 border"><%= cusBooking.getTotal_spent() %> vnđ</td>
                                            <td class="px-4 py-2 border text-green-600 font-semibold"><%= cusBooking.getPayment_status() %></td>
                                            <td class="px-4 py-2 border"><%= cusBooking.getCreate_at() %></td>
                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>
                            </div>
                        </div> 

                        <!-- Service Details -->
                        <div class="mb-10">
                            <h2 class="text-xl font-semibold text-purple-700 mb-4">Lịch sử sử dụng dịch vụ mới nhất</h2>
                            <div class="overflow-x-auto">
                                <table class="w-full table-auto text-left border border-purple-200 bg-purple-50 rounded-xl shadow">
                                    <thead class="bg-purple-100 text-purple-900">
                                        <tr>
                                            <th class="px-4 py-2 border">Dịch vụ</th>
                                            <th class="px-4 py-2 border">Số lượng</th>
                                            <th class="px-4 py-2 border">Tổng tiền</th>
                                            <th class="px-4 py-2 border">Bể bơi</th>
                                            <th class="px-4 py-2 border">Ngày sử dụng</th>
                                            <th class="px-4 py-2 border">Khung giờ</th>
                                        </tr>
                                    </thead>
                                    <% 
                                        List<CustomerService> cs = (List<CustomerService>) request.getAttribute("customerService");
                                        if(cs != null) {
                                        for(CustomerService c : cs){
                                    %>
                                    <tbody class="text-sm text-gray-700">
                                        <tr>
                                            <td class="px-4 py-2 border"><%= c.getService_name()  %></td>
                                            <td class="px-4 py-2 border"><%= c.getQuantity() %></td>
                                            <td class="px-4 py-2 border"><%= c.getTotal_service_price() %> vnđ</td>
                                            <td class="px-4 py-2 border"><%= c.getPool_name()  %></td>
                                            <td class="px-4 py-2 border"><%= c.getBooking_date() %></td>
                                            <td class="px-4 py-2 border"><%= cusBooking.getStart_time().format(java.time.format.DateTimeFormatter.ofPattern("HH:mm"))  %> - 
                                                <%= cusBooking.getEnd_time().format(java.time.format.DateTimeFormatter.ofPattern("HH:mm"))  %></td>
                                        </tr>
                                        <% }}%>      
                                    </tbody>
                                </table>
                            </div>
                        </div>


                        <!-- Feedback Details -->
                        <% 
                            CustomerFeedback cf = (CustomerFeedback) request.getAttribute("customerFeedback");
                            if(cf != null){
                        %>
                        <div class="mt-12">
                            <h3 class="text-lg font-semibold text-blue-700 mb-4"><i class="fa-solid fa-comments"></i> Đánh giá mới nhất của khách hàng</h3>
                            <div class="space-y-4">
                                <div class="bg-gray-50 p-4 rounded shadow border-l-4 border-blue-400">
                                    <div class="flex justify-between items-center mb-2">
                                        <h4 class="font-semibold text-gray-800"><%= cf.getPool_name() %></h4>
                                        <span class="text-sm text-gray-500"><%= cf.getCreate_at() %></span>
                                    </div>
                                    <p class="text-gray-700 italic">"<%= cf.getComment() %>!"</p>
                                    <div class="text-yellow-400 mt-2">    
                                        <% 
                                            int stars = cf.getRating(); 
                                            for(int i = 0; i < stars; i++) { 
                                        %>
                                        <i class="fa-solid fa-star"></i>
                                        <% } %>
                                    </div>
                                </div>
                                <%  }%>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
    </body>
</html>
