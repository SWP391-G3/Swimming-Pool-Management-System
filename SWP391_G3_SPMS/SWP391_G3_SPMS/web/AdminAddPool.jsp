<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm Bể Bơi Mới</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="./css/admin/adminPanel.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/global.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLndnUkP4OYlT6DkL4kSVV8Vsl5W0RXp2Pl3T/jCGX0gLexyO3J54+lZ7c2tXj4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            /* Ensure no horizontal scrollbar */
            body {
                overflow-x: hidden;
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
    <body class="bg-gray-100 min-h-screen flex">
        <!-- Sidebar -->
        <nav id="sidebar" class="w-72 sidebar-gradient text-white p-4 flex flex-col h-screen fixed top-0 left-0 shadow-2xl overflow-y-auto z-50 md:translate-x-0">
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
                        <img src="https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/465/avatar-trang-1.jpg"
                             alt="Avatar" class="w-12 h-12 rounded-full border-3 border-white object-cover shadow-lg" />
                        <div class="absolute -bottom-1 -right-1 w-5 h-5 bg-green-400 rounded-full border-2 border-white"></div>
                    </div>
                    <div class="flex-1">
                        <h4 class="text-sm font-semibold text-white"></h4>
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
                <p class="text-xs text-blue-200">© 2025 Pool Management</p>
                <p class="text-xs text-blue-300 mt-1">Version 2.1.0</p>
            </div>
        </nav>

        <div class="main-content ml-0 md:ml-72 p-2 sm:p-4 md:p-6 w-full">
            <!-- Main content -->
            <main class="w-full max-w-full space-y-6">


                <!-- Header -->
                <div class="flex justify-between items-center bg-white shadow rounded p-4 mb-6">
                    <h2 class="text-2xl font-bold text-blue-600">Thêm bể bơi mới</h2>
                </div>

                <% String error = (String) request.getAttribute("error"); %>
                <!-- Form -->
                <form id="addPoolForm" action="adminAddPool" enctype="multipart/form-data" method="POST" class="grid grid-cols-1 md:grid-cols-2 gap-6 bg-white shadow rounded p-6">

                    <div>
                        <label class="block text-sm font-medium text-gray-700">Tên bể bơi</label>
                        <input type="text" name="poolName" value="${param.poolName}" class="mt-1 w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Nhập tên bể bơi" required>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">Hình ảnh</label>
                        <input type="file" name="poolImage" value="${param.poolImage}" class="mt-1 w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Nhập link hình ảnh" required >
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">Mô tả</label>
                        <input type="text" name="poolDescription" value="${param.poolDescription}" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" placeholder="Nhập mô tả" required>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">Tên đường</label>
                        <input type="text" name="poolRoad" value="${param.poolRoad}" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" placeholder="Nhập địa chỉ" >
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">Khu vực</label>
                        <select id="poolAddress" name="poolAddress" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" >
                            <option value="">-- Chọn khu vực --</option>
                            <option value="Hà Nội">Hà Nội</option>
                            <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                            <option value="Đà Nẵng">Đà Nẵng</option>
                            <option value="Cần Thơ">Cần Thơ</option>
                            <option value="Quy Nhơn">Quy Nhơn</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">Sức chứa</label>
                        <input type="number" name="maxSlot" value="${param.maxSlot}" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" placeholder="Nhập sức chứa" required>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">Giờ mở cửa</label>
                        <input type="time" name="openTime" value="${param.openTime}" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" required>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">Giờ đóng cửa</label>
                        <input type="time" name="closeTime" value="${param.closeTime}" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" required>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">Trạng thái</label>
                        <select name="poolStatus" class="mt-1 w-full border border-gray-300 rounded px-3 py-2">
                            <option value="true" selected>Đang hoạt động</option>
                            <option value="false">Hủy hoạt động</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">Mã Khu vực</label>
                        <input type="number" id="branchId" name="branch_id" value="${param.branch_id}" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" placeholder="Nhập mã khu vực" readonly>
                        <p class="text-sm text-gray-500 mt-1">1 - Hà Nội, 2 - HCM, 3 - Đà Nẵng, 4 - Cần thơ, 5 - Quy Nhơn</p>
                    </div>

                    <!-- Button -->
                    <div class="col-span-1 md:col-span-2 flex gap-4">
                        <button id="addPool" type="submit" class="flex items-center gap-2 bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded font-medium">
                            <i class="bi bi-plus-circle"></i> Thêm bể bơi
                        </button>
                        <a href="adminPoolManagement" class="flex items-center gap-2 bg-gray-500 hover:bg-gray-600 text-white px-4 py-2 rounded font-medium">
                            <i class="bi bi-arrow-left-circle"></i> Quay lại
                        </a>
                    </div>
                </form>
            </main>
        </div>

        <!-- Error Modal (Tailwind version) -->
        <div id="errorModal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden flex items-center justify-center">
            <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6 animate-fade-in-down">
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


        <script>
            function closeErrorModal() {
                document.getElementById('errorModal').classList.add('hidden');
            }

            window.onload = function () {
            <% if (error != null) { %>
                const message = `<%= error.replaceAll("\"", "\\\\\"").replaceAll("\n", "\\n") %>`;
                document.getElementById('errorMessage').textContent = message;
                document.getElementById('errorModal').classList.remove('hidden');
            <% } %>
            };
        </script>

        <script>
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
                if (areaCodeMap[selected]) {
                    branchIdInput.value = areaCodeMap[selected];
                } else {
                    branchIdInput.value = "";
                }
            });
        </script>

        <script>
            document.getElementById("addPoolForm").addEventListener("submit", function (event) {
                const poolName = document.getElementsByName("poolName")[0].value.trim();
                const fileInput = document.querySelector('input[name="poolImage"]');
                const poolImageFile = fileInput.files[0];
                const allowedTypes = ["image/jpeg", "image/png", "image/webp"];
                const poolDescription = document.getElementsByName("poolDescription")[0].value.trim();
                const poolRoad = document.getElementsByName("poolRoad")[0].value.trim();
                const poolAddress = document.getElementsByName("poolAddress")[0].value;
                const maxSlot = document.getElementsByName("maxSlot")[0].value;
                const openTime = document.getElementsByName("openTime")[0].value;
                const closeTime = document.getElementsByName("closeTime")[0].value;

                // Regex chỉ cho phép chữ cái (có dấu), số và khoảng trắng (không ký tự đặc biệt)
                const textRegex = /^[a-zA-ZÀ-ỹ0-9\s]+$/;

                let errorMsg = "";

                if (poolName === "" || poolName.length < 3) {
                    errorMsg = "Tên bể bơi phải có ít nhất 3 ký tự.";
                } else if (!textRegex.test(poolName)) {
                    errorMsg = "Tên bể bơi không được chứa ký tự đặc biệt.";
                } else if (poolImageFile && !allowedTypes.includes(poolImageFile.type)) {
                    errorMsg = "Chỉ chấp nhận file ảnh JPG, PNG hoặc WEBP.";
                } else if (poolDescription === "" || poolDescription.length < 10) {
                    errorMsg = "Mô tả phải có ít nhất 10 ký tự.";
                } else if (!textRegex.test(poolDescription)) {
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
