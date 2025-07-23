<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, model.customer.DiscountDetail" %>
<%
    // ==== KHAI BÁO BIẾN ĐẦU FILE ====
    List<DiscountDetail> vouchers = (List<DiscountDetail>) request.getAttribute("vouchers");
    String error = (String) request.getAttribute("error");
    String search = (String) request.getAttribute("search");
    String expiryStatus = (String) request.getAttribute("expiryStatus");
    String expiryFrom = (String) request.getAttribute("expiryFrom");
    String expiryTo = (String) request.getAttribute("expiryTo");
    String sort = (String) request.getAttribute("sort");
    Integer currentPage = (Integer) request.getAttribute("page");
    Integer totalPages = (Integer) request.getAttribute("totalPage");
    String voucherMsg = (String) request.getAttribute("voucherMsg");

    if (search == null) {
        search = "";
    }
    if (expiryStatus == null) {
        expiryStatus = "all";
    }
    if (expiryFrom == null) {
        expiryFrom = "";
    }
    if (expiryTo == null) {
        expiryTo = "";
    }
    if (sort == null) {
        sort = "newest";
    }
    if (currentPage == null) {
        currentPage = 1;
    }
    if (totalPages == null)
        totalPages = 1;
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Danh sách Voucher</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="css/styles.css" />
        <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-30px) translateX(-50%);}
            to   { opacity: 1; transform: translateY(0) translateX(-50%);}
        }
        @keyframes fadeOut {
            from { opacity: 1; transform: translateY(0) translateX(-50%);}
            to   { opacity: 0; transform: translateY(-30px) translateX(-50%);}
        }
        .animate-fadeIn {
            animation: fadeIn 0.6s;
        }
        .animate-fadeOut {
            animation: fadeOut 0.6s;
        }
        </style>
    </head>
    <body class="bg-gray-50 min-h-screen font-['Inter'] antialiased">
        <%@include file="header.jsp" %>
        <% if (voucherMsg != null && !voucherMsg.isEmpty()) { %>
            <div id="toastMsg"
                 class="fixed top-6 left-1/2 transform -translate-x-1/2 z-50 px-6 py-3 rounded shadow-lg bg-green-600 text-white text-lg font-semibold animate-fadeIn"
                 style="min-width:280px; text-align:center;">
                <%= voucherMsg %>
            </div>
        <% } %>
        <div class="container mx-auto px-4 py-8">
            <!-- Nút quay về -->
            <a href="my_account" class="inline-flex items-center text-blue-600 font-medium mb-8 hover:underline">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                </svg>
                Tài khoản của tôi
            </a>
            <!-- Hero Image Section -->
            <div class="relative w-full h-52 md:h-64 mb-8 rounded-lg overflow-hidden shadow-lg">
                <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=compress&fit=crop&w=1200&q=80"
                     alt="Voucher Banner"
                     class="w-full h-full object-cover"/>
                <div class="absolute inset-0 bg-gradient-to-b from-black/30 to-black/10"></div>
                <h1 class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-3xl md:text-4xl font-bold text-white text-center drop-shadow-lg">
                    DANH SÁCH VOUCHER
                </h1>
            </div>
            <!-- Main Content with Sidebar -->
            <div class="flex flex-col lg:flex-row gap-8">
                <!-- Sidebar: Bộ lọc tìm kiếm -->
                <aside class="bg-white border border-gray-200 rounded-lg p-6 w-full lg:w-1/4 mb-6 lg:mb-0 shadow-sm">
                    <h3 class="font-semibold text-lg text-blue-700 mb-4">Tìm kiếm & bộ lọc</h3>
                    <form id="voucherFilterForm" method="get" action="voucher">
                        <input type="hidden" name="service" value="showVoucher"/>
                        <div class="mb-4">
                            <label class="block text-gray-600 mb-1 font-medium" for="search">Tìm kiếm / Nhận mã voucher</label>
                            <div class="relative">
                                <input
                                    type="text"
                                    id="search"
                                    name="search"
                                    value="<%= search%>"
                                    maxlength="100"
                                    class="w-full border border-gray-300 rounded-md px-4 py-2 pr-10 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                    placeholder="Nhập mã voucher để tìm kiếm hoặc nhận voucher mới"
                                    />
                                <span class="text-red-500 text-sm hidden" id="errSearch"></span>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-600 mb-1 font-medium" for="expiryStatus">Hạn sử dụng</label>
                            <select id="expiryStatus" name="expiryStatus"
                                    class="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400">
                                <option value="all" <%= "all".equals(expiryStatus) ? "selected" : ""%>>Tất cả</option>
                                <option value="active" <%= "active".equals(expiryStatus) ? "selected" : ""%>>Còn hạn</option>
                                <option value="expiring" <%= "expiring".equals(expiryStatus) ? "selected" : ""%>>Sắp hết hạn (7 ngày)</option>
                                <option value="expired" <%= "expired".equals(expiryStatus) ? "selected" : ""%>>Đã hết hạn</option>
                                <option value="range" <%= "range".equals(expiryStatus) ? "selected" : ""%>>Chọn khoảng ngày</option>
                            </select>
                            <div id="expiryRangeFields" style="<%= "range".equals(expiryStatus) ? "" : "display:none;"%>" class="mt-2 flex gap-2">
                                <input type="date" name="expiryFrom" id="expiryFrom" value="<%= expiryFrom%>"
                                       class="border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" placeholder="Từ ngày" />
                                <input type="date" name="expiryTo" id="expiryTo" value="<%= expiryTo%>"
                                       class="border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" placeholder="Đến ngày" />
                            </div>
                            <span class="text-red-500 text-sm hidden" id="errExpiry"></span>
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-600 mb-1 font-medium" for="sort">Sắp xếp</label>
                            <select
                                id="sort"
                                name="sort"
                                class="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                >
                                <option value="newest" <%= "newest".equals(sort) ? "selected" : ""%>>Mới nhất</option>
                                <option value="expiry" <%= "expiry".equals(sort) ? "selected" : ""%>>Sắp hết hạn</option>
                                <option value="value" <%= "value".equals(sort) ? "selected" : ""%>>Giá trị giảm giá cao</option>
                            </select>
                            <span class="text-red-500 text-sm hidden" id="errSort"></span>
                        </div>
                        <button
                            type="submit"
                            class="w-full bg-blue-600 text-white px-4 py-2 rounded-md font-semibold shadow hover:bg-blue-700 transition-colors"
                            >
                            Lọc / Nhận voucher
                        </button>
                    </form>
                </aside>

                <!-- Main voucher list -->
                <section class="flex-1 bg-white border border-gray-200 rounded-lg p-8 shadow-sm">
                    <h2 class="text-2xl font-bold mb-6 text-blue-700">Danh sách voucher</h2>
                    <% if (error != null) {%>
                    <div class="text-red-600"><%= error%></div>
                    <% } %>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <%
                            if (vouchers != null && vouchers.size() > 0) {
                                for (DiscountDetail voucher : vouchers) {
                                    Boolean usedDiscount = voucher.getUsedDiscount();
                        %>
                        <div class="border border-yellow-300 bg-yellow-50 rounded-lg p-5 flex flex-col gap-3 shadow hover:shadow-md transition relative">
                            <div class="flex items-center justify-between">
                                <span class="font-semibold text-yellow-700 text-lg">#<%= voucher.getDiscountCode()%></span>
                                <a href="voucher_detail?code=<%= voucher.getDiscountCode()%>"
                                   class="text-blue-600 text-sm font-medium hover:underline">Chi tiết</a>
                            </div>
                            <div class="text-gray-800 text-base"><%= voucher.getDescription()%></div>
                            <div class="flex flex-wrap items-center gap-4 text-sm text-gray-500">
                                <span>Hết hạn: <span class="font-medium text-gray-700">
                                        <%= voucher.getValidTo().toLocalDate().toString()%>
                                    </span></span>
                                <span>Đã dùng: <span class="font-semibold text-blue-700">
                                        <%= String.format("%.1f", voucher.getUsedPercent())%>%
                                    </span></span>
                                    <% if (usedDiscount != null && usedDiscount) { %>
                                <span class="px-2 py-1 bg-green-200 text-green-700 rounded">Chưa dùng</span>
                                <% } %>
                            </div>
                            <!-- Nút nhỏ và nằm góc phải dưới trong thẻ -->
                            <a href="customerViewPoolList"
                               class="absolute right-4 bottom-4 bg-blue-600 text-white px-4 py-2 rounded font-bold text-sm shadow hover:bg-blue-700 transition-colors">
                                Áp dụng
                            </a>
                        </div>
                        <%
                            }
                        } else {
                        %>
                        <div class="text-gray-500 col-span-2 text-center">Không có voucher nào phù hợp.</div>
                        <% }%>
                    </div>
                    <!-- Pagination -->
                    <div class="flex flex-col md:flex-row md:justify-between items-center mt-8 gap-3">
                        <div class="flex flex-wrap gap-1">
                            <form id="pageGoForm" method="get" action="voucher" class="flex items-center gap-2">
                                <input type="hidden" name="service" value="showVoucher"/>
                                <input type="hidden" name="search" value="<%= search%>"/>
                                <input type="hidden" name="expiryStatus" value="<%= expiryStatus%>"/>
                                <input type="hidden" name="expiryFrom" value="<%= expiryFrom%>"/>
                                <input type="hidden" name="expiryTo" value="<%= expiryTo%>"/>
                                <input type="hidden" name="sort" value="<%= sort%>"/>
                                <span>Đi đến trang:</span>
                                <input type="number" id="pageInput" name="page" min="1" max="<%= totalPages%>" value="<%= currentPage%>"
                                       class="border border-gray-300 rounded px-2 py-1 w-16" />
                                <span class="text-red-500 text-sm hidden" id="errPage"></span>
                                <span>/ <%= totalPages%></span>
                                <button style="display:none"></button>
                            </form>
                            <%
                                int startPage = Math.max(1, currentPage - 2);
                                int endPage = Math.min(totalPages, currentPage + 2);
                                if (startPage > 1) {
                            %>
                            <form method="get" action="voucher" style="display:inline;">
                                <input type="hidden" name="service" value="showVoucher"/>
                                <input type="hidden" name="search" value="<%= search%>"/>
                                <input type="hidden" name="expiryStatus" value="<%= expiryStatus%>"/>
                                <input type="hidden" name="expiryFrom" value="<%= expiryFrom%>"/>
                                <input type="hidden" name="expiryTo" value="<%= expiryTo%>"/>
                                <input type="hidden" name="sort" value="<%= sort%>"/>
                                <input type="hidden" name="page" value="1"/>
                                <button class="px-3 py-1 rounded border border-gray-300 bg-white text-gray-600 hover:bg-gray-100 transition">1</button>
                            </form>
                            <% if (startPage > 2) { %>
                            <span class="px-2">...</span>
                            <% } %>
                            <%
                                }
                                for (int i = startPage; i <= endPage; i++) {
                            %>
                            <form method="get" action="voucher" style="display:inline;">
                                <input type="hidden" name="service" value="showVoucher"/>
                                <input type="hidden" name="search" value="<%= search%>"/>
                                <input type="hidden" name="expiryStatus" value="<%= expiryStatus%>"/>
                                <input type="hidden" name="expiryFrom" value="<%= expiryFrom%>"/>
                                <input type="hidden" name="expiryTo" value="<%= expiryTo%>"/>
                                <input type="hidden" name="sort" value="<%= sort%>"/>
                                <input type="hidden" name="page" value="<%= i%>"/>
                                <button class="px-3 py-1 rounded border border-gray-300 <% if (i == currentPage) { %>bg-blue-600 text-white font-semibold<% } else { %>bg-white text-gray-600 hover:bg-gray-100<% }%> transition">
                                    <%= i%>
                                </button>
                            </form>
                            <%
                                }
                                if (endPage < totalPages) {
                                    if (endPage < totalPages - 1) { %>
                            <span class="px-2">...</span>
                            <% }
                            %>
                            <form method="get" action="voucher" style="display:inline;">
                                <input type="hidden" name="service" value="showVoucher"/>
                                <input type="hidden" name="search" value="<%= search%>"/>
                                <input type="hidden" name="expiryStatus" value="<%= expiryStatus%>"/>
                                <input type="hidden" name="expiryFrom" value="<%= expiryFrom%>"/>
                                <input type="hidden" name="expiryTo" value="<%= expiryTo%>"/>
                                <input type="hidden" name="sort" value="<%= sort%>"/>
                                <input type="hidden" name="page" value="<%= totalPages%>"/>
                                <button class="px-3 py-1 rounded border border-gray-300 bg-white text-gray-600 hover:bg-gray-100 transition"><%= totalPages%></button>
                            </form>
                            <%
                                }
                            %>
                            <form method="get" action="voucher" style="display:inline;">
                                <input type="hidden" name="service" value="showVoucher"/>
                                <input type="hidden" name="search" value="<%= search%>"/>
                                <input type="hidden" name="expiryStatus" value="<%= expiryStatus%>"/>
                                <input type="hidden" name="expiryFrom" value="<%= expiryFrom%>"/>
                                <input type="hidden" name="expiryTo" value="<%= expiryTo%>"/>
                                <input type="hidden" name="sort" value="<%= sort%>"/>
                                <input type="hidden" name="page" value="<%= (currentPage < totalPages) ? (currentPage + 1) : totalPages%>"/>
                                <button class="px-3 py-1 rounded border border-gray-300 bg-gray-100 text-gray-500 hover:bg-gray-200 transition"
                                        <%= (currentPage >= totalPages) ? "disabled" : ""%>>Next</button>
                            </form>
                        </div>
                        <!-- Ô nhập số trang -->
                        <form method="get" action="voucher" class="flex items-center gap-2">
                            <input type="hidden" name="service" value="showVoucher"/>
                            <input type="hidden" name="search" value="<%= search%>"/>
                            <input type="hidden" name="expiryStatus" value="<%= expiryStatus%>"/>
                            <input type="hidden" name="expiryFrom" value="<%= expiryFrom%>"/>
                            <input type="hidden" name="expiryTo" value="<%= expiryTo%>"/>
                            <input type="hidden" name="sort" value="<%= sort%>"/>
                            <span>Đi đến trang:</span>
                            <input type="number" name="page" min="1" max="<%= totalPages%>" value="<%= currentPage%>"
                                   class="border border-gray-300 rounded px-2 py-1 w-16" onchange="this.form.submit()"/>
                            <span>/ <%= totalPages%></span>
                        </form>
                    </div>
                </section>
            </div>
        </div>
        <%@include file="footer.jsp" %>
    </body>
    <script>
        // Toast popup auto close
        window.addEventListener('DOMContentLoaded', function() {
            var toast = document.getElementById('toastMsg');
            if (toast) {
                setTimeout(function() {
                    toast.classList.remove('animate-fadeIn');
                    toast.classList.add('animate-fadeOut');
                    setTimeout(function() {
                        toast.style.display = "none";
                    }, 600);
                }, 3000);
            }
        });
        // Ẩn/hiện trường nhập khoảng ngày khi chọn "Chọn khoảng ngày"
        document.getElementById('expiryStatus').addEventListener('change', function () {
            let fields = document.getElementById('expiryRangeFields');
            fields.style.display = (this.value === 'range') ? 'flex' : 'none';
        });

        document.getElementById('voucherFilterForm').addEventListener('submit', function (e) {
            let valid = true;

            // Validate search
            let search = document.getElementById('search').value;
            let errSearch = document.getElementById('errSearch');
            if (search.trim() && search.trim().length > 100) {
                errSearch.innerText = "Từ khóa tìm kiếm quá dài";
                errSearch.classList.remove('hidden');
                valid = false;
            } else if (search && search.trim().length === 0) {
                errSearch.innerText = "Từ khóa tìm kiếm không hợp lệ";
                errSearch.classList.remove('hidden');
                valid = false;
            } else if (search.trim() && !/^[^<>]*$/.test(search)) {
                errSearch.innerText = "Từ khóa tìm kiếm chứa ký tự không hợp lệ";
                errSearch.classList.remove('hidden');
                valid = false;
            } else {
                errSearch.classList.add('hidden');
            }

            // Validate expiry filter
            let expiryStatus = document.getElementById('expiryStatus').value;
            let errExpiry = document.getElementById('errExpiry');
            if (["all", "active", "expiring", "expired", "range"].indexOf(expiryStatus) === -1) {
                errExpiry.innerText = "Kiểu bộ lọc hạn sử dụng không hợp lệ";
                errExpiry.classList.remove('hidden');
                valid = false;
            } else if (expiryStatus === 'range') {
                let expiryFrom = document.getElementById('expiryFrom').value;
                let expiryTo = document.getElementById('expiryTo').value;
                let dateRegex = /^\d{4}-\d{2}-\d{2}$/;
                if (!expiryFrom || !expiryTo) {
                    errExpiry.innerText = "Vui lòng chọn cả hai ngày";
                    errExpiry.classList.remove('hidden');
                    valid = false;
                } else if (!dateRegex.test(expiryFrom) || !dateRegex.test(expiryTo)) {
                    errExpiry.innerText = "Ngày không hợp lệ";
                    errExpiry.classList.remove('hidden');
                    valid = false;
                } else if (new Date(expiryFrom) > new Date(expiryTo)) {
                    errExpiry.innerText = "Ngày bắt đầu phải nhỏ hơn hoặc bằng ngày kết thúc";
                    errExpiry.classList.remove('hidden');
                    valid = false;
                } else {
                    errExpiry.classList.add('hidden');
                }
            } else {
                errExpiry.classList.add('hidden');
            }

            // Validate sort
            let sort = document.getElementById('sort').value;
            let errSort = document.getElementById('errSort');
            if (["newest", "expiry", "value"].indexOf(sort) === -1) {
                errSort.innerText = "Kiểu sắp xếp không hợp lệ";
                errSort.classList.remove('hidden');
                valid = false;
            } else {
                errSort.classList.add('hidden');
            }

            if (!valid)
                e.preventDefault();
        });

        // Validate trang khi nhập số trang
        document.getElementById('pageGoForm').addEventListener('submit', function (e) {
            let valid = true;
            let page = document.getElementById('pageInput').value;
            let errPage = document.getElementById('errPage');
            let maxPage = parseInt(document.getElementById('pageInput').max);
            if (!page || isNaN(page) || page < 1 || page > maxPage) {
                errPage.innerText = "Số trang không hợp lệ";
                errPage.classList.remove('hidden');
                valid = false;
            } else {
                errPage.classList.add('hidden');
            }
            if (!valid)
                e.preventDefault();
        });
    </script>
</html>