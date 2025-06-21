<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Danh sách Voucher</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="css/styles.css" />
    </head>
    <body class="bg-gray-50 min-h-screen font-['Inter'] antialiased">
        <div class="container mx-auto px-4 py-8">
            <!-- Nút quay về -->
            <a href="myaccount.jsp" class="inline-flex items-center text-blue-600 font-medium mb-8 hover:underline">
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

            <!-- Hero Image Section -->
            <div class="relative w-full h-52 md:h-64 mb-8 rounded-lg overflow-hidden shadow-lg">
                <img
                    src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=compress&fit=crop&w=1200&q=80"
                    alt="Voucher Banner"
                    class="w-full h-full object-cover"
                    />
                <div class="absolute inset-0 bg-gradient-to-b from-black/30 to-black/10"></div>
                <!-- Tiêu đề nằm giữa ảnh -->
                <h1 class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-3xl md:text-4xl font-bold text-white text-center drop-shadow-lg">
                    DANH SÁCH VOUCHER
                </h1>
            </div>

            <!-- Main Content with Sidebar -->
            <div class="flex flex-col lg:flex-row gap-8">
                <!-- Sidebar: Bộ lọc tìm kiếm -->
                <aside class="bg-white border border-gray-200 rounded-lg p-6 w-full lg:w-1/4 mb-6 lg:mb-0 shadow-sm">
                    <h3 class="font-semibold text-lg text-blue-700 mb-4">Tìm kiếm & bộ lọc</h3>
                    <form>
                        <div class="mb-4">
                            <label class="block text-gray-600 mb-1 font-medium" for="search">Tìm kiếm</label>
                            <div class="relative">
                                <input
                                    type="text"
                                    id="search"
                                    name="search"
                                    class="w-full border border-gray-300 rounded-md px-4 py-2 pr-10 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                    placeholder="Nhập mã hoặc nội dung voucher"
                                    />
                                <span class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400">
                                    <svg
                                        class="w-5 h-5"
                                        fill="none"
                                        stroke="currentColor"
                                        viewBox="0 0 24 24"
                                        >
                                    <circle cx="11" cy="11" r="8" stroke-width="2" />
                                    <path
                                        stroke-linecap="round"
                                        stroke-width="2"
                                        d="M21 21l-2-2"
                                        />
                                    </svg>
                                </span>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-600 mb-1 font-medium" for="expiry">Ngày hết hạn</label>
                            <input
                                type="date"
                                id="expiry"
                                name="expiry"
                                class="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                />
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-600 mb-1 font-medium" for="sort">Sắp xếp</label>
                            <select
                                id="sort"
                                name="sort"
                                class="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                >
                                <option value="newest">Mới nhất</option>
                                <option value="expiry">Sắp hết hạn</option>
                                <option value="used">Tỷ lệ sử dụng cao</option>
                            </select>
                        </div>
                        <button
                            type="submit"
                            class="w-full bg-blue-600 text-white px-4 py-2 rounded-md font-semibold shadow hover:bg-blue-700 transition-colors"
                            >
                            Lọc
                        </button>
                    </form>
                </aside>

                <!-- Main voucher list -->
                <section class="flex-1 bg-white border border-gray-200 rounded-lg p-8 shadow-sm">
                    <h2 class="text-2xl font-bold mb-6 text-blue-700">Danh sách voucher</h2>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Mỗi voucher là 1 card, có thể lặp động bằng JSP forEach -->
                        <div class="border border-yellow-300 bg-yellow-50 rounded-lg p-5 flex flex-col gap-3 shadow hover:shadow-md transition">
                            <div class="flex items-center justify-between">
                                <span class="font-semibold text-yellow-700 text-lg">#VOUCHER20</span>
                                <a href="#" class="text-blue-600 text-sm font-medium hover:underline">Chi tiết</a>
                            </div>
                            <div class="text-gray-800 text-base">Giảm 20% toàn bộ đơn</div>
                            <div class="flex flex-wrap items-center gap-4 text-sm text-gray-500">
                                <span>Hết hạn:<span class="font-medium text-gray-700">2025-05-01</span></span>
                                <span>Đã dùng:<span class="font-semibold text-blue-700">51%</span></span>
                            </div>
                        </div>
                        <div class="border border-yellow-300 bg-yellow-50 rounded-lg p-5 flex flex-col gap-3 shadow hover:shadow-md transition">
                            <div class="flex items-center justify-between">
                                <span class="font-semibold text-yellow-700 text-lg">#VOUCHER21</span>
                                <a
                                    href="#"
                                    class="text-blue-600 text-sm font-medium hover:underline"
                                    >Chi tiết</a>
                            </div>
                            <div class="text-gray-800 text-base">Giảm 20% toàn bộ đơn</div>
                            <div class="flex flex-wrap items-center gap-4 text-sm text-gray-500">
                                <span>Hết hạn:<span class="font-medium text-gray-700">2025-05-01</span></span>
                                <span>Đã dùng:<span class="font-semibold text-blue-700">51%</span></span>
                            </div>
                        </div>
                        <div class="border border-yellow-300 bg-yellow-50 rounded-lg p-5 flex flex-col gap-3 shadow hover:shadow-md transition">
                            <div class="flex items-center justify-between">
                                <span class="font-semibold text-yellow-700 text-lg">#FREESHIP</span>
                                <a
                                    href="#"
                                    class="text-blue-600 text-sm font-medium hover:underline"
                                    >Chi tiết</a>
                            </div>
                            <div class="text-gray-800 text-base">Giảm 20% toàn bộ đơn</div>
                            <div class="flex flex-wrap items-center gap-4 text-sm text-gray-500">
                                <span>Hết hạn:<span class="font-medium text-gray-700">2025-05-01</span></span>
                                <span>Đã dùng:<span class="font-semibold text-blue-700">51%</span></span>
                            </div>
                        </div>
                        <div class="border border-yellow-300 bg-yellow-50 rounded-lg p-5 flex flex-col gap-3 shadow hover:shadow-md transition">
                            <div class="flex items-center justify-between">
                                <span class="font-semibold text-yellow-700 text-lg">#VOUCHERV</span>
                                <a
                                    href="#"
                                    class="text-blue-600 text-sm font-medium hover:underline"
                                    >Chi tiết</a>
                            </div>
                            <div class="text-gray-800 text-base">Giảm 20% toàn bộ đơn</div>
                            <div class="flex flex-wrap items-center gap-4 text-sm text-gray-500">
                                <span>Hết hạn:<span class="font-medium text-gray-700">2025-05-01</span></span>
                                <span>Đã dùng:<span class="font-semibold text-blue-700">51%</span></span>
                            </div>
                        </div>
                        <div class="border border-yellow-300 bg-yellow-50 rounded-lg p-5 flex flex-col gap-3 shadow hover:shadow-md transition">
                            <div class="flex items-center justify-between">
                                <span class="font-semibold text-yellow-700 text-lg">#WELCOME</span>
                                <a
                                    href="#"
                                    class="text-blue-600 text-sm font-medium hover:underline"
                                    >Chi tiết</a>
                            </div>
                            <div class="text-gray-800 text-base">Giảm 10% toàn bộ đơn</div>
                            <div class="flex flex-wrap items-center gap-4 text-sm text-gray-500">
                                <span>Hết hạn:<span class="font-medium text-gray-700">2025-05-01</span></span>
                                <span>Đã dùng:<span class="font-semibold text-blue-700">51%</span></span>
                            </div>
                        </div>
                        <div class="border border-yellow-300 bg-yellow-50 rounded-lg p-5 flex flex-col gap-3 shadow hover:shadow-md transition">
                            <div class="flex items-center justify-between">
                                <span class="font-semibold text-yellow-700 text-lg">#SUMMER25</span>
                                <a href="#"
                                    class="text-blue-600 text-sm font-medium hover:underline"
                                    >Chi tiết</a>
                            </div>
                            <div class="text-gray-800 text-base">Giảm 10% toàn bộ đơn</div>
                            <div class="flex flex-wrap items-center gap-4 text-sm text-gray-500">
                                <span>Hết hạn:<span class="font-medium text-gray-700">2025-05-01</span></span>
                                <span>Đã dùng:<span class="font-semibold text-blue-700">51%</span></span>
                            </div>
                        </div>
                    </div>

                    <!-- Pagination -->
                    <div class="flex justify-end mt-8">
                        <nav class="inline-flex items-center gap-1 text-sm">
                            <button class="px-3 py-1 rounded border border-gray-300 bg-gray-100 text-gray-500 hover:bg-gray-200 transition"disabled>Previous</button>
                            <button class="px-3 py-1 rounded border border-blue-600 bg-blue-50 text-blue-700 font-semibold">1</button>
                            <button class="px-3 py-1 rounded border border-gray-300 bg-white text-gray-600 hover:bg-gray-100 transition">2</button>
                            <span class="px-2">...</span>
                            <button class="px-3 py-1 rounded border border-gray-300 bg-white text-gray-600 hover:bg-gray-100 transition">5</button>
                            <button class="px-3 py-1 rounded border border-gray-300 bg-gray-100 text-gray-500 hover:bg-gray-200 transition">Next</button>
                        </nav>
                    </div>
                </section>
            </div>
        </div>
    </body>
</html>
