<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.BookingDetails" %>
<%@ page import="java.text.SimpleDateFormat,java.text.NumberFormat,java.util.Locale" %>
<%
    List<BookingDetails> bookingList = (List<BookingDetails>) request.getAttribute("bookingList");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Lịch sử đặt bể</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
            rel="stylesheet"
            />
        <link rel="stylesheet" href="css/styles.css" />
    </head>
    <body class="bg-gray-50 min-h-screen font-['Inter'] antialiased">
        <div class="container mx-auto px-4 py-8">
            <a
                href="my_account"
                class="inline-flex items-center text-blue-600 font-medium mb-8 hover:underline"
                >
                <svg
                    class="w-5 h-5 mr-2"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    >
                <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M15 19l-7-7 7-7"
                    />
                </svg>
                Tài khoản của tôi
            </a>
            <div
                class="relative w-full h-52 md:h-64 mb-8 rounded-lg overflow-hidden shadow-lg"
                >
                <img
                    src="https://images.pexels.com/photos/3584965/pexels-photo-3584965.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
                    alt="Booking History Banner"
                    class="w-full h-full object-cover"
                    />
                <div
                    class="absolute inset-0 bg-gradient-to-b from-black/30 to-black/10"
                    ></div>
                <h1
                    class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-3xl md:text-4xl font-bold text-white text-center drop-shadow-lg"
                    >
                    LỊCH SỬ ĐẶT BỂ
                </h1>
            </div>
            <section class="bg-white border border-gray-200 rounded-lg p-8 shadow-sm">
                <h2 class="text-2xl font-bold mb-8 text-blue-700">Lịch sử đặt bể</h2>
                <form class="w-full mb-8" method="get">
                    <div class="flex flex-col md:flex-row md:items-end gap-4">
                        <!--Search bằng tên -->
                        <div class="flex-1">
                            <label class="block text-gray-600 mb-1 font-medium"
                                   >Tên hồ bơi</label>
                            <input
                                type="text"
                                name="poolName"
                                value="<%= request.getParameter("poolName") != null ? request.getParameter("poolName") : "" %>"
                                placeholder="Nhập tên hồ bơi"
                                class="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                />
                        </div>
                        <!--Search bằng Status -->
                        <div class="flex-1 min-w-[110px]">
                            <label class="block text-gray-600 mb-1 font-medium">Trạng thái</label>
                            <select name="status" class="w-full border border-gray-300 rounded-md px-2 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400">
                                <option value="">Tất cả</option>
                                <option value="confirmed" <%= "confirmed".equals(request.getParameter("status")) ? "selected" : "" %>>Đã xác nhận</option>
                                <option value="pending" <%= "pending".equals(request.getParameter("status")) ? "selected" : "" %>>Chờ xác nhận</option>
                                <option value="cancelled" <%= "cancelled".equals(request.getParameter("status")) ? "selected" : "" %>>Đã hủy</option>
                            </select>
                        </div>
                        <!--Search theo Ngày -->
                        <div class="flex-1 flex gap-2">
                            <div class="flex-1">
                                <label class="block text-gray-600 mb-1 font-medium"
                                       >Từ ngày</label>
                                <input
                                    type="date"
                                    name="fromDate"
                                    value="<%= request.getParameter("fromDate") != null ? request.getParameter("fromDate") : "" %>"
                                    class="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                    />
                            </div>
                        </div>
                        <!--Sắp xếp -->
                        <div class="flex-1 min-w-[110px]">
                            <label class="block text-gray-600 mb-1 font-medium"
                                   >Sắp xếp</label>
                            <select
                                name="sortOrder"
                                class="w-full border border-gray-300 rounded-md px-2 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                >
                                <option value="date_desc" <%= "date_desc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>Mới nhất</option>
                                <option value="date_asc" <%= "date_asc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>Cũ nhất</option>
                                <option value="price_asc" <%= "price_asc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>Giá tăng</option>
                                <option value="price_desc" <%= "price_desc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>Giá giảm</option>
                            </select>
                        </div>
                        <!--Gửi tìm kiếm -->
                        <div class="flex-shrink-0 md:ml-2">
                            <button
                                type="submit"
                                class="bg-blue-600 text-white px-6 py-2 rounded-md font-semibold shadow hover:bg-blue-700 transition-colors w-full mt-6 md:mt-0"
                                >
                                Tìm kiếm
                            </button>
                        </div>
                    </div>
                </form>
                <!--Danh sách Booking  -->
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead>
                            <tr class="text-left text-gray-500">
                                <th class="pb-4">Mã đặt</th>
                                <th class="pb-4">Tên hồ bơi</th>
                                <th class="pb-4">Địa chỉ</th>
                                <th class="pb-4">Thời gian đặt</th>
                                <th class="pb-4">Số slot</th>
                                <th class="pb-4">Trạng thái</th>
                                <th class="pb-4">Tổng tiền</th>
                                <th class="pb-4">Chi tiết</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (bookingList != null && !bookingList.isEmpty()) {
                                    for (BookingDetails booking : bookingList) {
                            %>
                            <tr class="border-t hover:bg-gray-50">
                                <td class="py-4 text-blue-600 font-medium">#B<%= booking.getBookingId() %></td>
                                <td class="text-gray-900"><%= booking.getPoolName() %></td>
                                <td class="text-gray-700"><%= booking.getPoolAddressDetail() %></td>
                                <td class="text-gray-600"><%= booking.getBookingDate() != null ? dateFormat.format(booking.getBookingDate()) : "" %></td>
                                <td class="text-gray-600"><%= booking.getSlotCount() %></td>
                                <td>
                                    <%
                                        String status = booking.getBookingStatus();
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
                                <td class="font-medium"><%= booking.getAmount() != null ? currencyFormat.format(booking.getAmount()) : "" %></td>
                                <td>
                                    <a href="booking_detail?bookingId=<%= booking.getBookingId() %>"
                                       class="bg-gray-900 text-white px-4 py-1.5 rounded-md text-sm hover:bg-gray-800 transition-colors">
                                        Chi tiết
                                    </a>
                                </td>
                            </tr>
                            <% }} else {%>
                            <tr>
                                <td colspan="9" class="text-center text-gray-500 py-8">Không có lịch sử đặt bể nào.</td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </body>
</html>