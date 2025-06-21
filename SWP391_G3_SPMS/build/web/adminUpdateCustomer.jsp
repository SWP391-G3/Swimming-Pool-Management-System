<%-- 
    Document   : adminUpdateCustomer
    Created on : Jun 17, 2025, 10:39:20 AM
    Author     : Lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.admin.Customer" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật khách hàng</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>

    <body class="bg-gray-100 text-gray-800">

        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <nav class="w-64 bg-[#000033] text-white p-6 flex flex-col space-y-4 fixed h-full">
                <div class="mb-6 text-center"> 
                    <h1 class="text-2xl font-bold">Admin Panel</h1>
                    <p class="text-sm text-gray-300">Swimming Pool System</p>
                </div>
                <div class="flex items-center gap-3 mb-6">
                    <img src="https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/465/avatar-trang-1.jpg" alt="Avatar" class="w-12 h-12 rounded-full border-2 border-white object-cover" />
                    <div>
                        <h4 class="text-base font-semibold">Admin</h4>
                        <a href="#" class="text-sm text-blue-300 hover:underline">Xem chi tiết</a>
                    </div>
                </div>
                <a href="adminPoolManagement" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-water"></i> Quản lý bể bơi</a>
                <a href="adminViewStaffCategory.jsp" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-tie"></i> Quản lý nhân viên</a>
                <a href="adminViewCustomerList" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-check"></i> Quản lý khách hàng</a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo</a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-gear"></i> Cài đặt hệ thống</a>
                <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 text-red-400"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
            </nav>

            <!-- Main content -->
            <main class="ml-64 w-full p-8">
                <% 
                    Customer c = (Customer) request.getAttribute("customer");
                    if(c != null){
                    
                %>
                <div class="bg-white p-6 rounded shadow mb-6">
                    <h2 class="text-2xl font-bold text-blue-700 mb-4">Cập nhật thông tin khách hàng</h2>
                    <form action="adminUpdateCustomer" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <input type="hidden" name="customer_id" value="<%= c.getUser_id() %>" />
                        <div>
                            <label class="block mb-1 font-semibold">Họ và tên</label>
                            <input type="text" name="full_name" value="<%= c.getFull_name() %>" class="w-full border px-3 py-2 rounded" required />
                        </div>

                        <div>
                            <label class="block mb-1 font-semibold">Email</label>
                            <input type="email" name="email" value="<%= c.getEmail() %>" class="w-full border px-3 py-2 rounded" required />
                        </div>

                        <div>
                            <label class="block mb-1 font-semibold">Số điện thoại</label>
                            <input type="text" name="phone" value="<%= c.getPhone() %>" class="w-full border px-3 py-2 rounded" required />
                        </div>

                        <div>
                            <label class="block mb-1 font-semibold">Ngày sinh</label>
                            <input type="date" name="dob" value="<%= c.getDob() %>" class="w-full border px-3 py-2 rounded" />
                        </div>

                        <div>
                            <label class="block mb-1 font-semibold">Giới tính</label>
                            <select name="gender" class="w-full border px-3 py-2 rounded">
                                <option value="Male" <%= c.getGender().equals("Male") ? "selected" : "" %>>Nam</option>
                                <option value="Female" <%= c.getGender().equals("Female") ? "selected" : "" %>>Nữ</option>
                                <option value="Other" <%= c.getGender().equals("Other") ? "selected" : "" %>>Khác</option>
                            </select>
                        </div>

                        <div>
                            <label class="block mb-1 font-semibold">Trạng thái tài khoản</label>
                            <select name="status" class="w-full border px-3 py-2 rounded">
                                <option value="true" <%= c.getStatus() ? "selected" : "" %>>Hoạt động</option>
                                <option value="false" <%= !c.getStatus() ? "selected" : "" %>>Bị khóa</option>
                            </select>
                        </div>
                        <% } %>

                        <div class="col-span-2 mt-4 flex justify-end gap-4">
                            <a href="adminViewCustomerList" class="bg-gray-300 text-black px-4 py-2 rounded hover:bg-gray-400">
                                <i class="fa-solid fa-arrow-left"></i> Quay lại
                            </a>
                            <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">
                                <i class="fa-solid fa-save"></i> Cập nhật
                            </button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
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
                const fullName = document.querySelector("input[name='full_name']").value.trim();
                const email = document.querySelector("input[name='email']").value.trim();
                const phone = document.querySelector("input[name='phone']").value.trim();
                const dob = document.querySelector("input[name='dob']").value;
                const gender = document.querySelector("select[name='gender']").value;
                const status = document.querySelector("select[name='status']").value;

                let errorMsg = "";

                if (fullName.length < 2) {
                    errorMsg += "Họ và tên phải có ít nhất 2 ký tự.<br/>";
                }

                const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                if (!emailRegex.test(email)) {
                    errorMsg += "Email không đúng định dạng. Định dạng hợp lệ như: tennguoidung@example.com.<br/>";
                }

                const phoneRegex = /^0\d{9}$/;
                if (!phoneRegex.test(phone)) {
                    errorMsg += "Số điện thoại phải bắt đầu bằng 0 và có 10 chữ số.<br/>";
                }

                if (dob) {
                    const today = new Date();
                    const inputDate = new Date(dob);
                    if (inputDate > today) {
                        errorMsg += "Ngày sinh không hợp lệ (sau hiện tại).<br/>";
                    }
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
