<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
<% if (totalPages != null && totalPages > 1) { %>
<div class="flex justify-center items-center mt-8 gap-2">
    <% for (int i = 1; i <= totalPages; i++) { %>
    <button class="paging-btn px-3 py-1 rounded-md border font-medium
        <%= (i == currentPage) ? "bg-blue-600 text-white border-blue-600" : "bg-white text-blue-600 border-gray-300 hover:bg-blue-100" %>"
        data-page="<%= i %>"
        ><%= i %></button>
    <% } %>
</div>
<% } %>