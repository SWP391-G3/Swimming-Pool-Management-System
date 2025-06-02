<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.User,model.BookingDetails,model.DiscountDetail,java.util.List,java.text.SimpleDateFormat,java.text.NumberFormat,java.util.Locale" %>
<%
    User user = (User) request.getAttribute("user");
    List<BookingDetails> recentBookings = (List<BookingDetails>) request.getAttribute("recentBookings");
    List<DiscountDetail> voucherActive = (List<DiscountDetail>) request.getAttribute("voucherActive");
    List<DiscountDetail> voucherUsed = (List<DiscountDetail>) request.getAttribute("voucherUsed");
    int voucherActiveCount = request.getAttribute("voucherActiveCount") != null ? (Integer)request.getAttribute("voucherActiveCount") : 0;
    int voucherUsedCount = request.getAttribute("voucherUsedCount") != null ? (Integer)request.getAttribute("voucherUsedCount") : 0;
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Account</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/styles.css">
    </head>
    <body class="bg-white min-h-screen font-['Inter'] antialiased">
        <div class="container mx-auto px-4 py-8">

            <!-- Back homepage -->
            <a href="index.jsp"
               class="absolute top-4 left-4 z-50 bg-white/70 px-4 py-2 rounded-full shadow flex items-center gap-2 hover:bg-blue-100 transition">
                <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                </svg>
                <span class="font-medium text-blue-700">Trang chủ</span>
            </a>

            <!-- Hero Image Section -->
            <div class="relative w-full h-64 mb-8 rounded-lg overflow-hidden shadow-lg">
                <img src="https://www.saharapoolbuilder.com/wp-content/uploads/2019/07/swimming-pool-depth-recommendations.jpg"
                     alt="Account Dashboard"
                     class="w-full h-full object-cover">
                <div class="absolute inset-0 bg-gradient-to-b from-black/30 to-black/10"></div>
                <h1 class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-4xl font-bold text-white text-center drop-shadow-lg">
                    TÀI KHOẢN CỦA TÔI
                </h1>
            </div>

            <!-- Navigation Cards -->
            <div class="grid grid-cols-2 sm:grid-cols-2 md:grid-cols-4 gap-4 mb-8">
                <a href="booking_history" class="bg-blue-500 rounded-lg p-6 text-center cursor-pointer hover:shadow-lg transition-all duration-300 transform hover:-translate-y-1 block">
                    <div class="flex flex-col items-center">
                        <svg class="w-8 h-8 mb-3 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
                        </svg>
                        <span class="text-white font-medium">LỊCH SỬ ĐẶT BỂ</span>
                    </div>
                </a>
                <a href="#" class="bg-blue-500 rounded-lg p-6 text-center cursor-pointer hover:shadow-lg transition-all duration-300 transform hover:-translate-y-1 block">
                    <div class="flex flex-col items-center">
                        <svg class="w-8 h-8 mb-3 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"/>
                        </svg>
                        <span class="text-white font-medium">VOUCHER</span>
                    </div>
                </a>
                <a href="profile" class="bg-blue-500 rounded-lg p-6 text-center cursor-pointer hover:shadow-lg transition-all duration-300 transform hover:-translate-y-1 block">
                    <div class="flex flex-col items-center">
                        <svg class="w-8 h-8 mb-3 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                        </svg>
                        <span class="text-white font-medium">CHỈNH SỬA THÔNG TIN</span>
                    </div>
                </a>
                <a href="logout" class="bg-blue-500 rounded-lg p-6 text-center cursor-pointer hover:shadow-lg transition-all duration-300 transform hover:-translate-y-1 block">
                    <div class="flex flex-col items-center">
                        <svg class="w-8 h-8 mb-3 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                        </svg>
                        <span class="text-white font-medium">ĐĂNG XUẤT</span>
                    </div>
                </a>
            </div>

            <!-- My Information Section-->
            <div class="bg-gray-100 rounded-lg p-6 shadow-sm mb-8 w-full border border-gray-200">
                <h2 class="text-xl font-semibold mb-4">Thông tin của tôi</h2>
                <div class="grid grid-cols-1 md:grid-cols-3 xl:grid-cols-2 gap-4">
                    <div>
                        <div class="text-gray-500 text-sm">Họ và tên</div>
                        <div class="font-medium text-gray-900"><%= user != null ? user.getFullName() : "" %></div>
                    </div>
                    <div>
                        <div class="text-gray-500 text-sm">Ngày sinh</div>
                        <div class="font-medium text-gray-900"><%= user != null && user.getDob() != null ? dateFormat.format(user.getDob()) : "" %></div>
                    </div>
                    <div>
                        <div class="text-gray-500 text-sm">Gmail</div>
                        <div class="font-medium text-gray-900"><%= user != null ? user.getEmail() : "" %></div>
                    </div>
                    <div>
                        <div class="text-gray-500 text-sm">Số điện thoại</div>
                        <div class="font-medium text-gray-900"><%= user != null ? user.getPhone() : "" %></div>
                    </div>
                    <div>
                        <div class="text-gray-500 text-sm">Giới tính</div>
                        <div class="font-medium text-gray-900"><%= user != null ? user.getGender() : "" %></div>
                    </div>
                    <div class="md:col-span-2 xl:col-span-1">
                        <div class="text-gray-500 text-sm">Địa chỉ</div>
                        <div class="font-medium text-gray-900"><%= user != null ? user.getAddress() : "" %></div>
                    </div>
                </div>
            </div>
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
                <!-- Your Orders Section -->
                <div class="bg-gray-100 rounded-lg p-6 shadow-sm mb-8 w-full border border-gray-200 lg:col-span-8">
                    <h2 class="text-xl font-semibold mb-4">Gần đây</h2>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead>
                                <tr class="text-left text-gray-500">
                                    <th class="pb-4">Mã</th>
                                    <th class="pb-4">Tên bể</th>
                                    <th class="pb-4">Địa chỉ</th>
                                    <th class="pb-4">Thời gian đặt</th>
                                    <th class="pb-4">Trạng thái</th>
                                    <th class="pb-4">Tổng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (recentBookings != null && !recentBookings.isEmpty()) {
                                        for (BookingDetails b : recentBookings) {
                                %>
                                <tr class="border-t hover:bg-gray-50">
                                    <td class="py-4 text-blue-600 font-medium">#<%= b.getBookingId() %></td>
                                    <td class="text-gray-700"><%= b.getPoolName() %></td>
                                    <td class="text-gray-700"><%= b.getPoolAddressDetail() %></td>
                                    <td class="text-gray-600"><%= b.getBookingDate() != null ? dateFormat.format(b.getBookingDate()) : "" %></td>
                                    <td>
                                        <%
                                            String status = b.getBookingStatus();
                                            String badgeClass = "bg-gray-100 text-gray-800";
                                            if ("confirmed".equalsIgnoreCase(status) || "Đã xác nhận".equalsIgnoreCase(status)) {
                                                badgeClass = "bg-emerald-100 text-emerald-800";
                                                status = "Đã xác nhận";
                                            } else if ("pending".equalsIgnoreCase(status) || "Chờ xác nhận".equalsIgnoreCase(status)) {
                                                badgeClass = "bg-yellow-100 text-yellow-800";
                                                status = "Chờ xác nhận";
                                            } else if ("cancelled".equalsIgnoreCase(status) || "Đã hủy".equalsIgnoreCase(status)) {
                                                badgeClass = "bg-red-100 text-red-800";
                                                status = "Đã hủy";
                                            }
                                        %>
                                        <span class="<%= badgeClass %> px-3 py-1 rounded-full text-sm font-medium">
                                            <%= status %>
                                        </span>
                                    </td>
                                    <td class="font-medium"><%= b.getAmount() != null ? currencyFormat.format(b.getAmount()) : "" %></td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="8" class="py-4 text-center text-gray-500">Không có lịch sử đặt bể.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- Voucher section -->
                <div class="bg-gray-100 rounded-lg p-6 shadow-sm mb-8 w-full border border-gray-200 lg:col-span-4">
                    <h2 class="text-xl font-semibold mb-4">Voucher</h2>
                    <div class="mb-6">
                        <div class="flex justify-between items-center mb-3">
                            <div class="flex items-center">
                                <svg class="w-5 h-5 text-gray-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"/>
                                </svg>
                                <span>Voucher đang có</span>
                            </div>
                            <span class="text-gray-600 font-semibold"><%= voucherActiveCount %></span>
                        </div>
                        <div class="flex justify-between items-center">
                            <div class="flex items-center">
                                <svg class="w-5 h-5 text-gray-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"/>
                                </svg>
                                <span>Voucher đã dùng</span>
                            </div>
                            <span><%= voucherUsedCount %></span>
                        </div>
                    </div>
                    <div>
                        <h3 class="text-sm font-medium mb-3 flex items-center">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            Voucher đang có gần đây
                        </h3>
                        <div class="space-y-3 mt-4">
                            <%
                                if (voucherActive != null && !voucherActive.isEmpty()) {
                                    for (DiscountDetail d : voucherActive) {
                            %>
                            <div class="flex justify-between items-center p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors">
                                <div>
                                    <div class="font-medium"><%= d.getDiscountCode() %></div>
                                    <div class="text-sm text-gray-500">Hiệu lực: <%= d.getValidTo() != null ? d.getValidTo().toLocalDate() : "" %></div>
                                </div>
                                <span class="bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm font-medium">
                                    <%= d.getDiscountPercent() != null ? d.getDiscountPercent() + "%" : "" %>
                                </span>
                            </div>
                            <%
                                    }
                                } else {
                            %>
                            <div class="text-center text-gray-500 p-4">Chưa có voucher nào.</div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>