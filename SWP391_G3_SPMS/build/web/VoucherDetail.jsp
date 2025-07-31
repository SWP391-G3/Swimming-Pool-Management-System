<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="model.customer.DiscountDetail" %>
<%
    DiscountDetail voucher = (DiscountDetail) request.getAttribute("voucher");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Chi tiết voucher</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="css/styles.css" />
    </head>
    <body class="bg-gray-50 min-h-screen font-['Inter'] antialiased">
        <%@include file="header.jsp" %>
        <div class="container mx-auto px-4 py-8">
            <!-- Nút quay về -->
            <a href="voucher" class="inline-flex items-center text-blue-600 font-medium mb-6 hover:underline">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                </svg>
                Voucher
            </a>

            <!-- Banner image -->
            <div class="w-full rounded-lg overflow-hidden shadow mb-8">
                <div class="relative w-full h-48 md:h-60">
                    <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=compress&fit=crop&w=1200&q=80"
                         alt="Voucher Banner"
                         class="w-full h-full object-cover" />
                    <div class="absolute inset-0 bg-gradient-to-b from-black/30 to-black/10"></div>
                    <h1 class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-2xl md:text-3xl font-bold text-white text-center drop-shadow-lg px-4">
                        Chi tiết voucher
                    </h1>
                </div>
            </div>

            <% if (error != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <%= error %>
            </div>
            <% } else if (voucher != null) { %>
            <!-- Box chi tiết voucher -->
            <section class="w-full bg-white border border-gray-200 rounded-lg p-8 shadow flex flex-col gap-6">
                <h2 class="text-xl md:text-2xl font-bold text-blue-700 mb-2">
                    Thông tin voucher
                </h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-x-12 gap-y-4 mb-2">
                    <div>
                        <div class="mb-1 text-gray-500 font-medium">Mã voucher</div>
                        <div class="font-semibold text-gray-900 text-lg mb-3">
                            #<%= voucher.getDiscountCode() %>
                        </div>
                        <div class="mb-1 text-gray-500 font-medium">Ngày hết hạn</div>
                        <div class="mb-3 text-gray-800">
                            <%= voucher.getValidTo() != null ? voucher.getValidTo().toLocalDate().toString() : "" %>
                        </div>
                        <div class="mb-1 text-gray-500 font-medium">Mô tả</div>
                        <div class="text-gray-800"><%= voucher.getDescription() %></div>
                    </div>
                    <div>
                        <div class="mb-1 text-gray-500 font-medium">Tên voucher</div>
                        <div class="font-semibold text-gray-900 mb-3">
                            <%= voucher.getDescription() %>
                        </div>
                        <div class="mb-1 text-gray-500 font-medium">Ngày nhận</div>
                        <div class="mb-3 text-gray-800">
                            <%= voucher.getValidFrom() != null ? voucher.getValidFrom().toLocalDate().toString() : "" %>
                        </div>
                        <div class="mb-1 text-gray-500 font-medium">Giá trị</div>
                        <div class="mb-3 text-blue-700 font-bold text-lg">
                            <%= voucher.getDiscountPercent() != null ? voucher.getDiscountPercent().stripTrailingZeros().toPlainString() : "" %>%
                        </div>
                        <div class="mb-1 text-gray-500 font-medium">Trạng thái</div>
                        <%
                            boolean isExpired = voucher.getValidTo() != null && voucher.getValidTo().isBefore(java.time.LocalDateTime.now());
                            Boolean usedDiscount = voucher.getUsedDiscount();
                            if (isExpired) {
                        %>
                        <div class="font-semibold text-gray-500">Hết hạn</div>
                        <% } else if (usedDiscount != null && !usedDiscount) { %>
                        <div class="font-semibold text-red-600">Đã dùng</div>
                        <% } else { %>
                        <div class="font-semibold text-green-600">Còn hạn</div>
                        <% } %>
                    </div>
                </div>
                <div>
                    <form method="post" action="voucher_detail?code=<%= voucher.getDiscountCode() %>">
                        <button
                            class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-semibold px-8 py-2 rounded-lg shadow transition text-lg"
                            <%= (isExpired || (usedDiscount != null && !usedDiscount)) ? "disabled" : "" %>
                            >
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                            </svg>
                            Áp dụng
                        </button>
                    </form>
                </div>
            </section>
            <% } %>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>