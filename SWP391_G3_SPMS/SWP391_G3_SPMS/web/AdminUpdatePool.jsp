<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List,model.customer.Pool" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập nhật bể bơi</title>
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
            label{
                text-align: start;
            }
            .main-content {
                width: 100%;
                max-width: 100%;
            }
            @media (min-width: 768px) {
                .main-content {
                    margin-left: 18rem; /* đúng với w-72 của sidebar */
                }
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
    <body class="bg-gray-100 min-h-screen flex overflow-x-hidden">
        <!-- Sidebar -->
        <nav id="sidebar"
             class="w-72 sidebar-gradient text-white p-4 flex flex-col h-screen fixed top-0 left-0 shadow-2xl overflow-y-auto z-50">
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
                        <div
                            class="w-12 h-12 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full flex items-center justify-center">
                            <i class="fas fa-user text-white text-lg"></i>
                        </div>
                        <div
                            class="absolute -bottom-1 -right-1 w-5 h-5 bg-green-400 rounded-full border-2 border-white pulse-animation">
                        </div>
                    </div>
                    <div class="flex-1">
                        <h4 class="text-sm font-semibold text-white">Nguyễn Văn A</h4>
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
                    <i class="fas fa-chart-bar mr-2"></i>Thống kê
                </div>

                <a href="adminDashBoard" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                    <div class="nav-icon">
                        <i class="fa-solid fa-chart-line text-sm"></i>
                    </div>
                    <span class="font-medium text-sm">Dashboard</span>
                    <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                </a>

                <div class="text-xs font-semibold text-blue-200 uppercase tracking-wider mb-2 px-3 mt-4">
                    <i class="fas fa-bars mr-2"></i>Quản lý
                </div>

                <a href="adminPoolManagement" class="nav-item active-nav px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                    <div class="nav-icon">
                        <i class="fa-solid fa-water text-sm"></i>
                    </div>
                    <span class="font-medium text-sm">Quản lý bể bơi</span>
                    <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                </a>

                <a href="adminViewStaffCategory.jsp"
                   class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                    <div class="nav-icon">
                        <i class="fa-solid fa-user-tie text-sm"></i>
                    </div>
                    <span class="font-medium text-sm">Quản lý nhân viên</span>
                    <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                </a>

                <a href="adminViewCustomerList"
                   class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                    <div class="nav-icon">
                        <i class="fa-solid fa-user-check text-sm"></i>
                    </div>
                    <span class="font-medium text-sm">Quản lý khách hàng</span>
                    <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                </a>

                <div class="text-xs font-semibold text-blue-200 uppercase tracking-wider mb-2 px-3 mt-4">
                    <i class="fas fa-phone"></i> Liên hệ 
                </div>

                <a href="adminViewCustomerContact" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                    <div class="nav-icon">
                        <i class="fas fa-phone"></i>
                    </div>
                    <span class="font-medium text-sm">Liên hệ khách hàng</span>
                    <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                </a>

                <div class="mt-3 pt-3 border-t border-white/20">
                    <a href="LogoutServlet"
                       class="logout-btn nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10 font-semibold">
                        <div class="nav-icon">
                            <i class="fa-solid fa-right-from-bracket text-sm"></i>
                        </div>
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

        <!-- Main Content -->
        <div class="flex-1 ml-72 p-6 space-y-8 overflow-y-auto">
            <main>
                <!-- Header -->
                <div class="text-center mb-8">
                    <div class="bg-white shadow rounded-2xl p-6 mb-6 flex justify-between items-center">
                        <h2 class="text-3xl font-semibold text-blue-700 tracking-tight">Cập nhật bể bơi</h2>
                        <i class="bi bi-person-circle text-3xl text-gray-600"></i>
                    </div>

                    <% 
                        String error = (String) request.getAttribute("error");
                        String currentPage = (String) request.getAttribute("page");
                        if (error == null) error = "";
                        Pool p = (Pool) request.getAttribute("Pool"); 
                        if (p != null) { 
                    %>
                    <form id="updatePoolForm" action="adminUpdatePool" method="POST" enctype="multipart/form-data"
                          class="grid grid-cols-1 lg:grid-cols-2 gap-6 bg-white shadow-md rounded-2xl p-8">

                        <input type="hidden" name="pool_id" value="<%= p.getPool_id() %>">
                        <input type="hidden" name="page" value="<%= currentPage %>">

                        <div class="md:col-span-2 flex gap-6">
                            <div class="w-full md:w-1/2 space-y-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700">Tên bể bơi</label>
                                    <input type="text" name="pool_name" value="<%= p.getPool_name() %>"
                                           class="mt-1 w-full border border-gray-300 rounded px-3 py-2" required>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700">Chọn ảnh mới</label>
                                    <input type="file" name="pool_image" class="w-full border border-gray-300 rounded px-3 py-2" accept="image/*">
                                    <p class="text-xs text-left text-gray-500 mt-1">Để trống nếu không muốn thay đổi ảnh</p>
                                </div>
                            </div>

                            <div class="w-full md:w-1/2">
                                <label class="block text-sm font-medium text-gray-700">Hình ảnh hiện tại</label>
                                <img src="<%= p.getPool_image() %>" alt="Ảnh bể bơi" class="w-44 h-32 object-cover border rounded-lg shadow-sm mt-2 mb-3">
                            </div>
                        </div>


                        <div>
                            <label class="block text-sm font-medium text-gray-700">Mô tả</label>
                            <input type="text" name="pool_description" value="<%= p.getPool_description() %>"
                                   class="mt-1 w-full border border-gray-300 rounded-xl px-4 py-2 shadow-sm" required>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Tên đường</label>
                            <input type="text" name="pool_road" value="<%= p.getPool_road() %>"
                                   class="mt-1 w-full border border-gray-300 rounded-xl px-4 py-2 shadow-sm" required>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Khu vực</label>
                            <select id="poolAddress" name="pool_address"
                                    class="mt-1 w-full border border-gray-300 rounded-xl px-4 py-2 shadow-sm">
                                <option value="Hà Nội" <%= p.getPool_address().equals("Hà Nội") ? "selected" : "" %>>Hà Nội</option>
                                <option value="Hồ Chí Minh" <%= p.getPool_address().equals("Hồ Chí Minh") ? "selected" : "" %>>Hồ Chí Minh</option>
                                <option value="Đà Nẵng" <%= p.getPool_address().equals("Đà Nẵng") ? "selected" : "" %>>Đà Nẵng</option>
                                <option value="Quy Nhơn" <%= p.getPool_address().equals("Quy Nhơn") ? "selected" : "" %>>Quy Nhơn</option>
                                <option value="Cần Thơ" <%= p.getPool_address().equals("Cần Thơ") ? "selected" : "" %>>Cần Thơ</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Sức chứa</label>
                            <input type="number" name="max_slot" value="<%= p.getMax_slot() %>"
                                   class="mt-1 w-full border border-gray-300 rounded-xl px-4 py-2 shadow-sm" required>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Giờ mở cửa</label>
                            <input type="time" name="open_time" value="<%= p.getOpen_time() %>"
                                   class="mt-1 w-full border border-gray-300 rounded-xl px-4 py-2 shadow-sm" required>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Giờ đóng cửa</label>
                            <input type="time" name="close_time" value="<%= p.getClose_time() %>"
                                   class="mt-1 w-full border border-gray-300 rounded-xl px-4 py-2 shadow-sm" required>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Trạng thái</label>
                            <select name="pool_status"
                                    class="mt-1 w-full border border-gray-300 rounded-xl px-4 py-2 shadow-sm">
                                <option value="true" <%= p.isPool_status() ? "selected" : "" %>>Đang hoạt động</option>
                                <option value="false" <%= !p.isPool_status() ? "selected" : "" %>>Hủy hoạt động</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Mã khu vực</label>
                            <input type="number" id="branchId" name="branch_id" value="<%= p.getBranch_id() %>"
                                   class="mt-1 w-full border border-gray-300 rounded-xl px-4 py-2 shadow-sm" required>
                            <p class="text-sm text-gray-500 mt-1">1 - Hà Nội, 2 - HCM, 3 - Đà Nẵng, 4 - Cần Thơ, 5 - Quy Nhơn</p>
                        </div>

                        <div class="lg:col-span-2 flex gap-4 mt-4">
                            <button type="submit"
                                    class="bg-green-600 text-white px-6 py-2 rounded-xl shadow-md hover:bg-green-700 transition-all duration-200 flex items-center gap-2">
                                <i class="bi bi-check-circle"></i> Cập nhật
                            </button>
                            <a href="adminPoolManagement"
                               class="bg-gray-500 text-white px-6 py-2 rounded-xl hover:bg-gray-600 shadow-md transition-all duration-200 flex items-center gap-2">
                                <i class="bi bi-arrow-left-circle"></i> Quay lại
                            </a>
                        </div>
                    </form>
                    <% } %>
                </div>
            </main>
        </div>

        <!-- Error Modal -->
        <div id="errorModal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden flex items-center justify-center">
            <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-semibold text-red-600">Lỗi</h2>
                    <button onclick="closeErrorModal()" class="text-gray-500 hover:text-gray-700 text-2xl">&times;</button>
                </div>
                <div class="mb-4">
                    <p id="errorMessage" class="text-gray-700"></p>
                </div>
                <div class="text-right">
                    <button onclick="closeErrorModal()" class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded">
                        Đóng
                    </button>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script>
            function closeErrorModal() {
                document.getElementById('errorModal').classList.add('hidden');
            }
            window.onload = function () {
            <% if (error != null && !error.isEmpty()) { %>
                document.getElementById('errorMessage').textContent = "<%= error.replace("\"", "\\\"") %>";
                document.getElementById('errorModal').classList.remove('hidden');
            <% } %>
            };

            const areaCodeMap = {
                "Hà Nội": 1,
                "Hồ Chí Minh": 2,
                "Đà Nẵng": 3,
                "Cần Thơ": 4,
                "Quy Nhơn": 5
            };
            document.getElementById("poolAddress").addEventListener("change", function () {
                const selected = this.value;
                const branchIdInput = document.getElementById("branchId");
                branchIdInput.value = areaCodeMap[selected] || "";
            });

            document.getElementById("updatePoolForm").addEventListener("submit", function (event) {
                const poolName = document.getElementsByName("pool_name")[0].value.trim();
                const fileInput = document.querySelector('input[name="pool_image"]');
                const poolImageFile = fileInput.files[0];
                const allowedTypes = ["image/jpeg", "image/png", "image/webp"];
                const poolDescription = document.getElementsByName("pool_description")[0].value.trim();
                const poolRoad = document.getElementsByName("pool_road")[0].value.trim();
                const poolAddress = document.getElementsByName("pool_address")[0].value;
                const maxSlot = document.getElementsByName("max_slot")[0].value;
                const openTime = document.getElementsByName("open_time")[0].value;
                const closeTime = document.getElementsByName("close_time")[0].value;

                let errorMsg = "";

                const nameRegex = /^[a-zA-ZÀ-ỹ\s0-9]+$/; // Dùng cho tên
                const descriptionRegex = /^[a-zA-ZÀ-ỹ\s0-9.,:;()\-'"!?%&]+(\s[a-zA-ZÀ-ỹ\s0-9.,:;()\-'"!?%&]+)*$/; // Dùng cho mô tả

                if (poolName.length < 3) {
                    errorMsg = "Tên bể bơi phải có ít nhất 3 ký tự.";
                } else if (!nameRegex.test(poolName)) {
                    errorMsg = "Tên bể bơi không được chứa ký tự đặc biệt.";
                } else if (poolImageFile && !allowedTypes.includes(poolImageFile.type)) {
                    errorMsg = "Chỉ chấp nhận file ảnh JPG, PNG hoặc WEBP.";
                } else if (poolDescription.length < 10) {
                    errorMsg = "Mô tả phải có ít nhất 10 ký tự.";
                } else if (!descriptionRegex.test(poolDescription)) {
                    errorMsg = "Mô tả không được chứa ký tự đặc biệt.";
                } else if (poolRoad === "") {
                    errorMsg = "Vui lòng nhập tên đường.";
                } else if (poolAddress === "") {
                    errorMsg = "Vui lòng chọn khu vực.";
                } else if (maxSlot <= 0 || isNaN(maxSlot)) {
                    errorMsg = "Sức chứa phải lớn hơn 0.";
                } else if (openTime >= closeTime) {
                    errorMsg = "Giờ mở cửa phải trước giờ đóng cửa.";
                }

                if (errorMsg !== "") {
                    event.preventDefault();
                    document.getElementById('errorMessage').textContent = errorMsg;
                    document.getElementById('errorModal').classList.remove('hidden');
                }
            });
        </script>
    </body>
</html>
