<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="model.customer.BookingDetails" %>
<%@ page import="model.customer.Feedback" %>
<%@ page import="model.customer.Ticket" %>
<%@ page import="java.text.NumberFormat,java.util.Locale" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.List" %> 
<%
    BookingDetails bookingDetail = (BookingDetails) request.getAttribute("bookingDetail");
    Feedback userFeedback = (Feedback) request.getAttribute("userFeedback");
    String successMsg = (String) request.getAttribute("successMsg");
    String errorMsg = (String) request.getAttribute("errorMsg");
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    boolean canCancel = (Boolean) request.getAttribute("canCancel");
    boolean canRefund = request.getAttribute("canRefund") != null ? (Boolean) request.getAttribute("canRefund") : false;
    long minutesSinceCancel = request.getAttribute("minutesSinceCancel") != null ? (Long) request.getAttribute("minutesSinceCancel") : Long.MAX_VALUE;
    if (bookingDetail == null) {
%>
<div class="text-red-600 font-bold">Không tìm thấy thông tin booking!</div>
<%
        return;
    }
    String statusRaw = bookingDetail.getBookingStatus();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Chi tiết lịch sử</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="css/styles.css" />
    </head>
    <body class="bg-gray-50 min-h-screen font-['Inter'] antialiased">
        <%@include file="header.jsp" %>
        <div class="container mx-auto px-4 py-8">
            <a href="booking_history" class="inline-flex items-center text-blue-600 font-medium mb-8 hover:underline">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" >
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
                </svg>
                Lịch sử đặt bể
            </a>
            <div class="relative w-full h-44 md:h-56 mb-8 rounded-lg overflow-hidden shadow-lg">
                <img src="https://images.pexels.com/photos/261185/pexels-photo-261185.jpeg?auto=compress&fit=crop&w=900&q=80" alt="Pool Banner" class="w-full h-full object-cover"/>
                <div class="absolute inset-0 bg-gradient-to-b from-black/30 to-black/10"></div>
                <h1 class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-2xl md:text-3xl font-bold text-white text-center drop-shadow-lg">
                    CHI TIẾT ĐẶT BỂ
                </h1>
            </div>
            <section class="bg-white border border-gray-200 rounded-lg p-8 shadow-sm w-full relative">
                <!-- Nút Huỷ đặt bể -->
                <% if (canCancel) {%>
                <form method="post" action="booking_detail"
                      onsubmit="return confirm('Bạn chắc chắn muốn huỷ đặt bể này?');"
                      class="absolute top-8 right-8">
                    <input type="hidden" name="bookingId" value="<%= bookingDetail.getBookingId()%>"/>
                    <input type="hidden" name="service" value="cancelBooking"/>
                    <button type="submit"
                            class="bg-red-600 hover:bg-red-700 text-white font-semibold px-5 py-2 rounded-md shadow transition-colors">
                        Huỷ đặt bể
                    </button>
                </form>
                <% } else if (canRefund) { %>
                <form method="post" action="booking_detail"
                      onsubmit="return confirm('Bạn chắc chắn muốn yêu cầu hoàn tiền cho đơn này?');"
                      class="absolute top-8 right-8">
                    <input type="hidden" name="bookingId" value="<%= bookingDetail.getBookingId()%>"/>
                    <input type="hidden" name="service" value="requestRefund"/>
                    <button type="submit"
                            class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-5 py-2 rounded-md shadow transition-colors">
                        Yêu cầu hoàn tiền
                    </button>
                </form>
                <% }%>
                <h2 class="text-xl font-bold mb-6 text-blue-700">Thông tin đặt bể</h2>
                <div class="mb-6 grid grid-cols-1 sm:grid-cols-3 md:grid-cols-2 gap-4">
                    <div>
                        <div class="text-gray-500 text-sm">Mã đặt</div>
                        <div class="font-medium text-gray-900">#B<%= bookingDetail.getBookingId()%></div>
                    </div>
                    <div>
                        <div class="text-gray-500 text-sm">Tên hồ bơi</div>
                        <div class="font-medium text-gray-900"><%= bookingDetail.getPoolName()%></div>
                    </div>
                    <div>
                        <div class="text-gray-500 text-sm">Thời gian đặt</div>
                        <div class="font-medium text-gray-900"><%= bookingDetail.getBookingDate()%></div>
                    </div>
                    <div>
                        <div class="text-gray-500 text-sm">Trạng thái</div>
                        <div>
                            <%
                                String statusLabel = "Chưa xác nhận";
                                String badgeClass = "bg-yellow-100 text-yellow-800";
                                if ("confirmed".equalsIgnoreCase(statusRaw) || "Đã xác nhận".equalsIgnoreCase(statusRaw)) {
                                    statusLabel = "Đã xác nhận";
                                    badgeClass = "bg-emerald-100 text-emerald-800";
                                } else if ("pending".equalsIgnoreCase(statusRaw) || "Chưa xác nhận".equalsIgnoreCase(statusRaw)) {
                                    statusLabel = "Chưa xác nhận";
                                    badgeClass = "bg-yellow-100 text-yellow-800";
                                } else if ("cancelled".equalsIgnoreCase(statusRaw) || "Đã huỷ".equalsIgnoreCase(statusRaw) || "Đã hủy".equalsIgnoreCase(statusRaw)) {
                                    statusLabel = "Đã huỷ";
                                    badgeClass = "bg-red-100 text-red-800";
                                }
                            %>
                            <span class="<%= badgeClass%> px-3 py-1 rounded-full text-sm font-medium">
                                <%= statusLabel%>
                            </span>
                        </div>
                    </div>
                    <div>
                        <div class="text-gray-500 text-sm">Địa chỉ</div>
                        <div class="font-medium text-gray-900">
                            <%= bookingDetail.getPoolAddressDetail()%>
                        </div>
                    </div>

                    <!-- Số lượng vé -->
                    <div>
                        <div class="text-gray-500 text-sm">Số lượng vé</div>
                        <div class="font-medium text-gray-900"><%= bookingDetail.getTicketCount()%></div>
                    </div>
                    <!-- Giờ bắt đầu -->
                    <div>
                        <div class="text-gray-500 text-sm">Giờ bắt đầu</div>
                        <div class="font-medium text-gray-900">
                            <%= bookingDetail.getStartTime() != null ? bookingDetail.getStartTime().toString() : ""%>
                        </div>
                    </div>
                    <!-- Mã giảm giá -->
                    <div>
                        <div class="text-gray-500 text-sm">Mã giảm giá</div>
                        <div class="font-medium text-gray-900">
                            <%= bookingDetail.getDiscountCode() != null ? bookingDetail.getDiscountCode() : "Không áp dụng"%>
                            <% if (bookingDetail.getDiscountPercent() != null && bookingDetail.getDiscountPercent().compareTo(java.math.BigDecimal.ZERO) > 0) {%>
                            (Giảm <%= bookingDetail.getDiscountPercent()%>%)
                            <% }%>
                        </div>
                    </div>
                    <!-- Giờ kết thúc -->
                    <div>
                        <div class="text-gray-500 text-sm">Giờ kết thúc</div>
                        <div class="font-medium text-gray-900">
                            <%= bookingDetail.getEndTime() != null ? bookingDetail.getEndTime().toString() : ""%>
                        </div>
                    </div>

                </div>
                <!-- Bảng danh sách vé -->
                <h2 class="text-lg font-bold mt-8 mb-4 text-blue-700">Danh sách vé đã đặt</h2>
                <%
                    List<Ticket> tickets = bookingDetail.getTickets();
                    if (tickets != null && !tickets.isEmpty()) {
                %>
                <table class="min-w-full border border-gray-200 rounded-lg mb-8">
                    <thead class="bg-gray-100">
                        <tr>
                            <th class="py-2 px-4 border-b text-center">Mã vé</th>
                            <th class="py-2 px-4 border-b text-center">Số người</th>
                            <th class="py-2 px-4 border-b text-center">Giá</th>
                            <th class="py-2 px-4 border-b text-center">Ngày xuất vé</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Ticket ticket : tickets) {%>
                        <tr>
                            <td class="py-2 px-4 border-b text-center font-mono"><%= ticket.getTicketCode()%></td>
                            <td class="py-2 px-4 border-b text-center"><%= ticket.getQuantity()%></td>        
                            <td class="py-2 px-4 border-b text-center"><%= currencyFormat.format(ticket.getTicketPrice())%></td>
                            <td class="py-2 px-4 border-b text-center"><%= ticket.getIssuedAt() != null ? ticket.getIssuedAt() : ""%></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <%
                } else {
                %>
                <div class="text-gray-500 italic mb-8">Không có vé nào trong booking này.</div>
                <%
                    }
                %>

                <!-- Tổng tiền -->
                <div class="flex justify-end mb-8">
                    <div class="text-right">
                        <div class="text-gray-500 text-base font-medium">Tổng tiền</div>
                        <div class="text-3xl md:text-4xl font-extrabold text-blue-700 mt-1 mb-2">
                            <%= bookingDetail.getAmount() != null ? currencyFormat.format(bookingDetail.getAmount()) : ""%>
                        </div>
                    </div>
                </div>
                <hr class="my-8" />
                <!-- Rate Pool Section (giữ nguyên như cũ) -->
                <div>
                    <h3 class="text-lg font-semibold mb-3 text-blue-700">Đánh giá hồ bơi</h3>
                    <% if (successMsg != null) { %>
                    <div class="text-green-600 font-medium mb-2">Gửi đánh giá thành công!</div>
                    <div class="mb-4 italic text-gray-700 text-center text-lg font-semibold">Cảm ơn quý khách đã đánh giá</div>
                    <% } else if (errorMsg != null) { %>
                    <div class="text-red-600 font-medium mb-2">Bạn đã gửi đánh giá cho hồ bơi này.</div>
                    <% } else if (userFeedback != null) { %>
                    <div class="mb-4 italic text-gray-700 text-center text-lg font-semibold">Cảm ơn quý khách đã đánh giá</div>
                    <% } else {%>
                    <form action="booking_detail" method="post" class="mb-4" id="rateForm">
                        <input type="hidden" name="bookingId" value="<%= bookingDetail.getBookingId()%>"/>
                        <input type="hidden" name="poolId" value="<%= bookingDetail.getPoolId()%>"/>
                        <div class="flex items-center gap-3 mb-4">
                            <div class="flex gap-1 text-2xl text-yellow-400 cursor-pointer">
                                <% for (int i = 1; i <= 5; i++) {%>
                                <input type="radio" id="star<%=i%>" name="rating" value="<%=i%>" style="display:none;" required>
                                <label for="star<%=i%>" style="cursor:pointer;font-size:2rem; color: #d1d5db;">&#9733;</label>
                                <% } %>
                            </div>
                        </div>
                        <textarea
                            name="comment"
                            rows="3"
                            class="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400 mb-4"
                            placeholder="Hãy chia sẻ trải nghiệm của bạn về hồ bơi này..."
                            required></textarea>
                        <button
                            type="submit"
                            class="bg-blue-600 text-white px-6 py-2 rounded-md font-semibold shadow hover:bg-blue-700 transition-colors"
                            >
                            Gửi đánh giá
                        </button>
                    </form>
                    <script>
                        // Đánh dấu sao khi click
                        document.querySelectorAll('label[for^="star"]').forEach(label => {
                            label.addEventListener('click', function () {
                                let n = parseInt(this.htmlFor.replace("star", ""));
                                for (let i = 1; i <= 5; i++) {
                                    document.querySelector('label[for="star' + i + '"]').style.color = (i <= n) ? "#facc15" : "#d1d5db";
                                }
                            });
                        });
                    </script>
                    <% }%>
                </div>
            </section>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>