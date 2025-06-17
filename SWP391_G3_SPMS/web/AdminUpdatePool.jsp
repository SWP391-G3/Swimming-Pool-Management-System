<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List,model.Pool" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập nhật bể bơi</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
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
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-tie"></i> Quản lý nhân viên</a>
            <a href="adminViewCustomerList" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-check"></i> Quản lý khách hàng</a>
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo</a>
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-gear"></i> Cài đặt hệ thống</a>
            <a href="LogoutServlet" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 text-red-400"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
        </nav>

        <!-- Main content -->
        <main class="flex-1 ml-64 p-8">
            <div class="flex justify-between items-center bg-white shadow rounded p-4 mb-6">
                <h2 class="text-2xl font-bold text-blue-600">Cập nhật bể bơi</h2>
                <a href="#" class="text-gray-700 hover:text-blue-600"><i class="bi bi-person-circle text-2xl"></i></a>
            </div>

            <% 
                    String error = (String) request.getAttribute("error");
                        if (error == null) {
                            error = "";
                        }
                Pool p = (Pool) request.getAttribute("Pool"); if(p != null) { %>
            <form id="updatePoolForm" action="adminUpdatePool" method="POST" class="grid grid-cols-1 md:grid-cols-2 gap-6 bg-white shadow rounded p-6">
                <input type="hidden" name="pool_id" value="<%= p.getPool_id() %>">

                <div>
                    <label class="block text-sm font-medium text-gray-700">Tên bể bơi</label>
                    <input type="text" name="pool_name" value="<%= p.getPool_name() %>" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" required>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Hình Ảnh</label>
                    <input type="text" name="pool_image" value="<%= p.getPool_image() %>" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" required>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Mô tả</label>
                    <input type="text" name="pool_desctiprion" value="<%= p.getPool_description() %>" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" required>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Tên đường</label>
                    <input type="text" name="pool_road" value="<%= p.getPool_road() %>" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" required>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Khu vực</label>
                    <select id="branchId" name="pool_address" class="mt-1 w-full border border-gray-300 rounded px-3 py-2">
                        <option value="Hà Nội" <%= p.getPool_address().equals("Hà Nội") ? "selected" : "" %>>Hà Nội</option>
                        <option value="Hồ Chí Minh" <%= p.getPool_address().equals("Hồ Chí Minh") ? "selected" : "" %>>Hồ Chí Minh</option>
                        <option value="Đà Nẵng" <%= p.getPool_address().equals("Đà Nẵng") ? "selected" : "" %>>Đà Nẵng</option>
                        <option value="Quy Nhơn" <%= p.getPool_address().equals("Quy Nhơn") ? "selected" : "" %>>Quy Nhơn</option>
                        <option value="Cần Thơ" <%= p.getPool_address().equals("Cần Thơ") ? "selected" : "" %>>Cần Thơ</option>
                    </select>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Sức chứa</label>
                    <input type="number" name="max_slot" value="<%= p.getMax_slot() %>" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" required>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Giờ mở cửa</label>
                    <input type="time" name="open_time" value="<%= p.getOpen_time() %>" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" required>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Giờ đóng cửa</label>
                    <input type="time" name="close_time" value="<%= p.getClose_time() %>" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" required>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Trạng thái</label>
                    <select name="pool_status" class="mt-1 w-full border border-gray-300 rounded px-3 py-2">
                        <option value="true" <%= p.isPool_status() ? "selected" : "" %>>Đang hoạt động</option>
                        <option value="false" <%= !p.isPool_status() ? "selected" : "" %>>Hủy hoạt động</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">Mã khu vực</label>
                    <input type="number" id="branchId" name="branch_id" value="<%= p.getBranch_id() %>" class="mt-1 w-full border border-gray-300 rounded px-3 py-2" required>
                    <p class="text-sm text-gray-500 mt-1">1 - Hà Nội, 2 - HCM, 3 - Đà Nẵng, 4 - Cần thơ, 5 - Quy Nhơn</p>
                </div>

                <div class="md:col-span-2 flex gap-4">
                    <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 flex items-center gap-2">
                        <i class="bi bi-check-circle"></i> Cập nhật
                    </button>
                    <a href="adminPoolManagement" class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600 flex items-center gap-2">
                        <i class="bi bi-arrow-left-circle"></i> Quay lại
                    </a>
                </div>
            </form>
            <% } %>
        </main>
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
            <% if (error != null && !error.isEmpty()) { %>
                document.getElementById('errorMessage').textContent = "<%= error.replace("\"", "\\\"") %>";
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
            document.getElementById("updatePoolForm").addEventListener("submit", function (event) {
                const poolName = document.getElementsByName("pool_name")[0].value.trim();
                const poolImage = document.getElementsByName("pool_image")[0].value.trim();
                const poolDescription = document.getElementsByName("pool_desctiprion")[0].value.trim(); // Sai chính tả
                const poolRoad = document.getElementsByName("pool_road")[0].value.trim();
                const poolAddress = document.getElementsByName("pool_address")[0].value;
                const maxSlot = document.getElementsByName("max_slot")[0].value;
                const openTime = document.getElementsByName("open_time")[0].value;
                const closeTime = document.getElementsByName("close_time")[0].value;


                const nameRegex = /^[a-zA-ZÀ-ỹ\s0-9]+$/; // Cho phép chữ cái có dấu, khoảng trắng, số
                let errorMsg = "";

                if (poolName === "" || poolName.length < 3) {
                    errorMsg = "Tên bể bơi phải có ít nhất 3 ký tự.";
                } else if (!nameRegex.test(poolName)) {
                    errorMsg = "Tên bể bơi không được chứa ký tự đặc biệt.";
                } else if (!poolImage.startsWith("http")) {
                    errorMsg = "Link hình ảnh không hợp lệ.";
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
    </body>
</html>
