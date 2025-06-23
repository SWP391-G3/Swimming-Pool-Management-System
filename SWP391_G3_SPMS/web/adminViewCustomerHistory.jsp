<%-- 
    Document   : adminViewCustomerHIstory
    Created on : Jun 20, 2025, 10:26:58 PM
    Author     : Lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.admin.CustomerBooking,model.admin.CustomerService,model.admin.CustomerFeedback,model.admin.Customer" %>
<%@page import="model.admin.CustomerVoucher" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Lịch sử khách hàng</title>
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
                <div class="flex items-center gap-3 mb-6">
                    <img src="https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/465/avatar-trang-1.jpg" alt="Avatar" class="w-12 h-12 rounded-full border-2 border-white object-cover" />
                    <div>
                        <h4 class="text-base font-semibold">Admin Name</h4>
                        <a href="#" class="text-sm text-blue-300 hover:underline">Xem chi tiết</a>
                    </div>
                </div>
                <a href="adminPoolManagement" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2">
                    <i class="fa-solid fa-water"></i> Quản lý bể bơi
                </a>
                <a href="adminViewStaffCategory.jsp" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2">
                    <i class="fa-solid fa-user-tie"></i> Quản lý nhân viên
                </a>
                <a href="adminViewCustomerList" class="bg-blue-900 ring-2 ring-white px-3 py-2 rounded flex items-center gap-2">
                    <i class="fa-solid fa-user-check"></i> Quản lý khách hàng
                </a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2">
                    <i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo
                </a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2">
                    <i class="fa-solid fa-gear"></i> Cài đặt hệ thống
                </a>
                <a href="LogoutServlet" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 text-red-400">
                    <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                </a>
            </nav>

            <!-- Main content -->
            <main class="ml-64 w-full p-8">
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
                            <h2 class="text-xl font-semibold text-indigo-700 mb-4"><i class="fa-solid fa-ticket"></i> Danh sách Voucher & Ticket đã sử dụng</h2>

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
                                            CustomerVoucher vouchers = (CustomerVoucher) request.getAttribute("customerVoucher");
                                            if(vouchers != null){
                                                for(CustomerVoucher v : vouchers)
                                        %>
                                        <tr>
                                            <td class="px-3 py-2 border"><%= v.getVoucher_name() %></td>
                                            <td class="px-3 py-2 border"><%= v.getDesciption() %> %</td>
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
                                            <th class="px-3 py-2 border">Số lượng</th>
                                            <th class="px-3 py-2 border">Tổng tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%-- Giả sử bạn có List<CustomerTicket> tickets --%>
                                        <%
                                            List<CustomerTicket> tickets = (List<CustomerTicket>) request.getAttribute("customerTickets");
                                            if(tickets != null){
                                                for(CustomerTicket t : tickets){
                                        %>
                                        <tr>
                                            <td class="px-3 py-2 border"><%= t.getTicket_type() %></td>
                                            <td class="px-3 py-2 border"><%= t.getQuantity() %></td>
                                            <td class="px-3 py-2 border"><%= t.getTotal_amount() %> vnđ</td>
                                        </tr>
                                        <% }} else { %>
                                        <tr><td colspan="3" class="px-3 py-2 text-center">Chưa có vé nào được sử dụng</td></tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>



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
