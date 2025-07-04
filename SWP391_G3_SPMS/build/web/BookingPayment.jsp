<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="model.customer.*, java.util.*, java.math.BigDecimal" %>
<%
    BookingPageData pageData = (BookingPageData) request.getAttribute("pageData");
    if (pageData == null) {
        out.println("<h2>Lỗi: Không có dữ liệu trang Booking!</h2>");
        return;
    }
    User user = pageData.getUser();
    Pool pool = pageData.getPool();
    List<TicketSelection> selectedTickets = pageData.getSelectedTickets();
    List<PoolServiceSelection> selectedRents = pageData.getSelectedRents();
    Discounts selectedDiscount = pageData.getSelectedDiscount();
    String bookingDate = pageData.getBookingDate() != null ? pageData.getBookingDate().toString() : "";
    String startTime = pageData.getStartTime() != null ? pageData.getStartTime().toString().substring(0,5) : "";
    String endTime = pageData.getEndTime() != null ? pageData.getEndTime().toString().substring(0,5) : "";
    int slotCount = pageData.getSlotCount();

    BigDecimal total = pageData.getFinalAmount();
    BigDecimal discountAmount = pageData.getDiscountAmount();
    BigDecimal finalAmount = pageData.getFinalAmount();
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Thanh toán</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
        <style>body {
                font-family: "Inter", Arial, sans-serif;
            }</style>
    </head>
    <body class="bg-gray-50 min-h-screen font-['Inter'] antialiased">
        <%@include file="header.jsp" %>
        <div class="container mx-auto px-4 py-8 max-w-2xl">
            <!-- Header -->
            <div class="flex items-center mb-6">
                <a href="javascript:void(0);" onclick="history.back();" class="mr-3 text-gray-700 hover:text-blue-600 flex items-center">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M15 19l-7-7 7-7" />
                    </svg>
                    <span class="ml-2 text-xl md:text-2xl font-bold">Trở về Booking</span>
                </a>
            </div>

            <!-- Main box -->
            <div class="bg-white border border-gray-200 rounded-xl shadow p-6 md:p-8 flex flex-col gap-6">
                <!-- Thông tin đặt vé -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-2">
                    <div>
                        <div class="text-base font-semibold mb-2">Người đặt</div>
                        <div class="text-sm text-gray-500 mb-1">Họ và tên</div>
                        <div class="font-medium mb-2"><%= user.getFull_name() %></div>
                        <div class="text-sm text-gray-500 mb-1">Số điện thoại</div>
                        <div class="font-medium mb-2"><%= user.getPhone() != null ? user.getPhone() : "" %></div>
                        <div class="text-sm text-gray-500 mb-1">Địa điểm bể</div>
                        <div class="font-medium break-words">
                            <%= pool.getPool_road() + ", " + pool.getPool_address() %>
                        </div>
                    </div>
                    <div>
                        <div class="text-base font-semibold mb-2">Thông tin bể bơi</div>
                        <div class="text-sm text-gray-500 mb-1">Tên bể</div>
                        <div class="font-medium mb-2"><%= pool.getPool_name() %></div>
                        <div class="text-sm text-gray-500 mb-1">Thời gian</div>
                        <div style="background: #f5f6fa; padding: 10px 20px; border-radius: 8px; display: inline-block;">
                            <p><%= startTime %> – <%= endTime %></p>
                            <p><%= bookingDate %></p>
                        </div>
                    </div>
                </div>
                <div class="border-b"></div>

                <!-- Danh sách sản phẩm -->
                <div>
                    <div class="text-base font-semibold mb-3">Chi tiết đơn hàng</div>
                    <div class="w-full overflow-x-auto">
                        <table class="w-full text-sm text-left">
                            <thead>
                                <tr class="text-gray-500 border-b">
                                    <th class="py-2">Sản phẩm</th>
                                    <th class="py-2 text-center">Số lượng</th>
                                    <th class="py-2 text-right">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y">
                                <%-- Vé đã chọn --%>
                                <%
                                if (selectedTickets != null) {
                                    for (TicketSelection t : selectedTickets) {
                                %>
                                <tr>
                                    <td class="py-2"><%= t.getTypeName() %></td>
                                    <td class="py-2 text-center">x<%= t.getQuantity() %></td>
                                    <td class="py-2 text-right"><%= String.format("%,d", t.getPrice().intValue() * t.getQuantity()) %> đ</td>
                                </tr>
                                <%
                                    }
                                }
                                %>
                                <%-- Dịch vụ thuê đã chọn --%>
                                <%
                                if (selectedRents != null) {
                                    for (PoolServiceSelection r : selectedRents) {
                                %>
                                <tr>
                                    <td class="py-2"><%= r.getServiceName() %></td>
                                    <td class="py-2 text-center">x<%= r.getQuantity() %></td>
                                    <td class="py-2 text-right"><%= String.format("%,d", r.getPrice().intValue() * r.getQuantity()) %> đ</td>
                                </tr>
                                <%
                                    }
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Tổng tiền/Ưu đãi -->
                <div class="border-b"></div>
                <div class="flex flex-col gap-2">
                    <div class="flex justify-between items-center text-base">
                        <span class="font-medium">Tổng</span>
                        <span class="font-semibold text-gray-700"><%= String.format("%,.0f đ", total) %></span>
                    </div>
                    <div class="flex justify-between items-center text-base">
                        <span class="font-medium">Ưu đãi</span>
                        <% if (selectedDiscount!= null && discountAmount != null) { %>
                        <span class="text-green-700 font-semibold">(<%= selectedDiscount.getDiscountCode() %>) -<%= String.format("%,.0f đ", discountAmount) %> </span>
                        <% } else { %>
                        <span class="text-gray-500 text-sm">Không áp dụng ưu đãi</span>
                        <% } %>
                    </div>
                </div>
                <div class="border-b"></div>
                <!-- Tổng tiền cuối cùng -->
                <div class="flex justify-between items-center text-xl md:text-2xl font-bold mt-2 mb-1">
                    <span>Tổng tiền</span>
                    <span class="text-blue-700"><%= String.format("%,.0f đ", finalAmount) %></span>
                </div>
            </div>

            <!-- Nút thanh toán -->
            <div class="mt-8">
                <form action="payment" method="post">
                    <button class="w-full bg-blue-600 text-white text-lg font-bold py-4 rounded-2xl shadow hover:bg-blue-700 transition" type="submit">
                        THANH TOÁN
                    </button>
                </form>
            </div>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>