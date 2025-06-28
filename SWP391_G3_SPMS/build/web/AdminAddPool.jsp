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
        <style>
            .animate-fade-in-down {
                animation: fadeInDown 0.3s ease-out;
            }

            @keyframes fadeInDown {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>

    </head>
    <body class="bg-gray-100 min-h-screen flex">
        <!-- Sidebar -->
        <nav class="w-64 bg-[#000033] text-white p-6 flex flex-col space-y-4 fixed h-full">
            <div class="mb-6 text-center"> 
                <h1 class="text-2xl font-bold">Admin Panel</h1>
                <p class="text-sm text-gray-300">Swimming Pool System</p>
            </div>
            <div class="flex items-center gap-3 mb-6">
                <img src="https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/465/avatar-trang-1.jpg" alt="Avatar" class="w-12 h-12 rounded-full border-2 border-white object-cover" />
                <div>
                    <h4 class="text-base font-semibold">Nguyễn Văn A</h4>
                    <a href="#" class="text-sm text-blue-300 hover:underline">Xem chi tiết</a>
                </div>
            </div>
            <a href="adminPoolManagement" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-water"></i> Quản lý bể bơi</a>
            <a href="adminViewStaffCategory.jsp" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-tie"></i> Quản lý nhân viên</a>
            <a href="adminViewCustomerList" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-check"></i> Quản lý khách hàng</a>
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo</a>
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-gear"></i> Cài đặt hệ thống</a>
            <a href="LogoutServlet" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 text-red-400"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
        </nav>

        <!-- Main content -->
        <main class="flex-1 ml-64 p-8">


            <!-- Header -->
            <div class="flex justify-between items-center bg-white shadow rounded p-4 mb-6">
                <h2 class="text-2xl font-bold text-blue-600">Thêm bể bơi mới</h2>
                <a href="#" class="text-gray-700 hover:text-blue-600"><i class="bi bi-person-circle text-2xl"></i></a>
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
                    <input type="file" name="poolImage" value="${param.poolImage}" class="mt-1 w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Nhập link hình ảnh" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">Mô tả</label>
                    <input type="text" name="poolDescription" value="${param.poolDescription}" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" placeholder="Nhập mô tả" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">Tên đường</label>
                    <input type="text" name="poolRoad" value="${param.poolRoad}" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" placeholder="Nhập địa chỉ" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">Khu vực</label>
                    <select id="poolAddress" name="poolAddress" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" required>
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
                    <button type="submit" class="flex items-center gap-2 bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded font-medium">
                        <i class="bi bi-plus-circle"></i> Thêm bể bơi
                    </button>
                    <a href="adminPoolManagement" class="flex items-center gap-2 bg-gray-500 hover:bg-gray-600 text-white px-4 py-2 rounded font-medium">
                        <i class="bi bi-arrow-left-circle"></i> Quay lại
                    </a>
                </div>
            </form>

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
                const nameRegex = /^[a-zA-ZÀ-ỹ\s0-9]+$/; // Cho phép chữ cái có dấu, khoảng trắng, số
                let errorMsg = "";
                if (poolName === "" || poolName.length < 3) {
                    errorMsg = "Tên bể bơi phải có ít nhất 3 ký tự.";
                } else if (!nameRegex.test(poolName)) {
                    errorMsg = "Tên bể bơi không được chứa ký tự đặc biệt.";
                } else if (poolImageFile && !allowedTypes.includes(poolImageFile.type)) {
                    errorMsg = "Chỉ chấp nhận file ảnh JPG, PNG hoặc WEBP.";
                } else if (poolDescription.length < 10) {
                    errorMsg = "Mô tả phải có ít nhất 10 ký tự.";
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



        </main>
    </body>
</html>
