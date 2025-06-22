<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="java.util.List, model.admin.Branch"%>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    String userName = currentUser != null ? currentUser.getFull_name() : "Admin";
    List<Branch> availableBranchs = (List<Branch>) request.getAttribute("availableBranchs");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Quản Lý Mới</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="bg-gray-50 text-gray-800 font-sans">

        <!-- Sidebar -->
        <nav id="sidebar" class="w-64 bg-[#000033] text-white p-6 flex flex-col space-y-4 fixed h-full transform -translate-x-full md:translate-x-0 transition-transform duration-300 z-40">
            <div class="mb-6 text-center"> 
                <h1 class="text-2xl font-bold">Admin Panel</h1>
                <p class="text-sm text-gray-300">Swimming Pool System</p>
            </div>
            <div class="flex items-center gap-3 mb-6">
                <img src="https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/465/avatar-trang-1.jpg" alt="Avatar" class="w-12 h-12 rounded-full border-2 border-white object-cover" />
                <div>
                    <h4 class="text-base font-semibold"><%= userName %></h4>
                    <a href="#" class="text-sm text-blue-300 hover:underline">Xem chi tiết</a>
                </div>
            </div>
            <a href="adminPoolManagement" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-water"></i> Quản lý bể bơi</a>
            <a href="adminViewManagerList" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 bg-blue-900 ring-2 ring-white"><i class="fa-solid fa-user-tie"></i> Quản lý nhân viên</a>
            <a href="adminViewCustomerList" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-check"></i> Quản lý khách hàng</a>
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo</a>
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-gear"></i> Cài đặt hệ thống</a>
            <a href="LogoutServlet" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 text-red-400"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
        </nav>

        <!-- Form content -->
        <main class="ml-0 md:ml-64 p-8">
            <div class="flex flex-col md:flex-row justify-between items-start md:items-center bg-white p-6 rounded-2xl shadow mb-6 border border-blue-100">
                <h2 class="text-3xl font-extrabold text-blue-800 tracking-wide flex items-center gap-3">
                    <i class="fa-solid fa-user-tie text-blue-600 text-2xl"></i> Thêm người quản lý
                </h2>
                <a href="adminViewManagerList"
                   class="mt-4 md:mt-0 inline-flex items-center gap-2 bg-gray-700 hover:bg-gray-800 text-white text-sm font-semibold px-5 py-2.5 rounded-xl shadow transition duration-300">
                    <i class="fa-solid fa-arrow-left"></i> Quay lại
                </a>
            </div>

            <div class="max-w-4xl mx-auto bg-white p-10 rounded-3xl shadow-xl space-y-6">
                <h2 class="text-3xl font-bold text-blue-700 text-center">Tạo tài khoản Quản Lý</h2>

                <form action="adminAddManager" method="post"  class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-semibold mb-1">Tên đăng nhập</label>
                        <input name="username" required type="text" class="w-full p-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Mật khẩu</label>
                        <input name="password" required type="password" class="w-full p-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Họ và tên</label>
                        <input name="full_name" required type="text" class="w-full p-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Email</label>
                        <input name="email" required type="email" class="w-full p-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Điện thoại</label>
                        <input name="phone" type="text" class="w-full p-3 rounded-xl border border-gray-300">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Địa chỉ</label>
                        <input name="address" type="text" class="w-full p-3 rounded-xl border border-gray-300">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Ngày sinh</label>
                        <input name="dob" type="date" class="w-full p-3 rounded-xl border border-gray-300">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-1">Giới tính</label>
                        <select name="gender" class="w-full p-3 rounded-xl border border-gray-300">
                            <option value="">-- Chọn --</option>
                            <option value="Nam">Nam</option>
                            <option value="Nữ">Nữ</option>
                            <option value="Khác">Khác</option>
                        </select>
                    </div>

                    <div class="md:col-span-2">
                        <label class="block text-sm font-semibold mb-1">Ảnh đại diện</label>
                        <input type="file" name="imageFile" accept="image/*"
                               class="w-full p-2 rounded-xl border border-gray-300 file:bg-blue-700 file:text-white file:px-4 file:py-2 file:rounded-lg file:border-0 file:font-semibold">
                    </div>

                    <div class="md:col-span-2">
                        <label class="block text-sm font-semibold mb-1">Chi nhánh quản lý</label>
                        <select name="branchId" required>
                            <option value="">-- Chọn chi nhánh --</option>
                            <% for (Branch b : availableBranchs) { %>
                            <option value="<%= b.getBranch_id() %>"><%= b.getBranch_name() %></option>
                            <% } %>
                        </select>

                    </div>

                    <div class="md:col-span-2 text-center pt-4">
                        <button type="submit" class="bg-blue-700 hover:bg-blue-800 text-white text-lg font-bold py-3 px-8 rounded-2xl shadow transition duration-300">
                            <i class="fa-solid fa-plus mr-2"></i> Thêm Quản Lý
                        </button>
                    </div>
                </form>
            </div>
        </main>
        <!-- Popup thông báo lỗi -->
        <div id="errorPopup" class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50 hidden">
            <div class="relative bg-white border border-red-400 text-red-700 px-6 py-5 rounded-lg shadow-xl max-w-md w-full">
                <!-- Nút X đóng -->
                <button onclick="closeErrorPopup()" class="absolute top-2 right-2 text-red-500 hover:text-red-700 text-lg">
                    <i class="fa-solid fa-xmark"></i>
                </button>

                <h3 class="text-xl font-bold text-red-600 mb-3 text-left">Lỗi dữ liệu!</h3>
                <div id="errorMessage" class="text-sm text-red-700 leading-relaxed"></div>

                <div class="text-center mt-5">
                    <button onclick="closeErrorPopup()" class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded shadow">
                        Đóng
                    </button>
                </div>
            </div>
        </div>

        <script>
            function closeErrorPopup() {
                document.getElementById("errorPopup").classList.add("hidden");
            }

            document.querySelector("form").addEventListener("submit", function (e) {
                let errorMsg = "";

                const username = document.querySelector("input[name='username']").value.trim();
                const password = document.querySelector("input[name='password']").value.trim();
                const fullName = document.querySelector("input[name='full_name']").value.trim();
                const email = document.querySelector("input[name='email']").value.trim();
                const phone = document.querySelector("input[name='phone']").value.trim();
                const address = document.querySelector("input[name='address']").value.trim();
                const dob = document.querySelector("input[name='dob']").value;
                const gender = document.querySelector("select[name='gender']").value;
                const branch = document.querySelector("select[name='branchId']").value;

                if (username.length < 4) {
                    errorMsg += "Tên đăng nhập phải có ít nhất 4 ký tự.<br/>";
                }
                if (password.length < 6) {
                    errorMsg += "Mật khẩu phải có ít nhất 9 ký tự.<br/>";
                }
                if (fullName.length < 2) {
                    errorMsg += "Họ và tên phải có ít nhất 2 ký tự.<br/>";
                }
                const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                if (!emailRegex.test(email)) {
                    errorMsg += "Email không đúng định dạng. Định dạng hợp lệ như: ten@example.com<br/>";
                }
                const phoneRegex = /^0\d{9}$/;
                if (!phoneRegex.test(phone)) {
                    errorMsg += "Số điện thoại phải bắt đầu bằng 0 và có 10 chữ số.<br/>";
                }
                if (dob) {
                    const today = new Date();
                    const inputDate = new Date(dob);

                    // Tính tuổi
                    let age = today.getFullYear() - inputDate.getFullYear();
                    const m = today.getMonth() - inputDate.getMonth();
                    if (m < 0 || (m === 0 && today.getDate() < inputDate.getDate())) {
                        age--; // Chưa tới sinh nhật trong năm nay
                    }

                    if (age < 14) {
                        errorMsg += "Tuổi phải từ 14 tuổi trở lên.<br/>";
                    }

                    if (inputDate > today) {
                        errorMsg += "Ngày sinh không hợp lệ (sau ngày hiện tại).<br/>";
                    }
                }

                if (gender === "") {
                    errorMsg += "Vui lòng chọn giới tính.<br/>";
                }
                if (branch === "") {
                    errorMsg += "Vui lòng chọn chi nhánh quản lý.<br/>";
                }

                if (errorMsg !== "") {
                    e.preventDefault();
                    document.getElementById("errorMessage").innerHTML = errorMsg;
                    document.getElementById("errorPopup").classList.remove("hidden");
                }
            });
        </script>

    </body>
</html>
