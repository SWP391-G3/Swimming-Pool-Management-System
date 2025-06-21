<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.admin.Manager, model.User, model.admin.Branch, java.util.List"%>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    String userName = currentUser != null ? currentUser.getFull_name() : "";

    Manager manager = (Manager) request.getAttribute("manager");
    List<Branch> branches = (List<Branch>) request.getAttribute("branchList");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Cập nhật người quản lý</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="bg-gray-100 text-gray-800">

        <!-- Nút mở sidebar mobile -->
        <button id="mobileMenuBtn" class="fixed top-4 left-4 z-50 bg-blue-600 text-white p-2 rounded md:hidden">
            <i class="fa-solid fa-bars"></i>
        </button>

        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <nav id="sidebar" class="w-64 bg-[#000033] text-white p-6 flex flex-col space-y-4 fixed h-full transform -translate-x-full md:translate-x-0 transition-transform duration-300 z-40">
                <div class="mb-6 text-center"> 
                    <h1 class="text-2xl font-bold">Admin Panel</h1>
                    <p class="text-sm text-gray-300">Swimming Pool System</p>
                </div>
                <div class="flex items-center gap-3 mb-6">
                    <img src="https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/465/avatar-trang-1.jpg" class="w-12 h-12 rounded-full border-2 border-white object-cover" />
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

            <!-- Main Content -->
            <main class="md:ml-64 w-full p-6 space-y-6">
                <div class="bg-white rounded-lg shadow p-6">
                    <h2 class="text-2xl font-bold text-blue-700 mb-4"><i class="fa-solid fa-pen-to-square mr-2"></i> Cập nhật người quản lý</h2>

                    <form id="adminUpdateManager" action="adminUpdateManager" method="post" class="space-y-4">
                        <input type="hidden" name="manager_id" value="<%= manager.getManager_id() %>">

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Họ tên</label>
                                <input type="text" name="full_name" value="<%= manager.getFull_name() %>" required
                                       class="w-full border border-gray-300 px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                                <input type="email" name="email" value="<%= manager.getEmail() %>" required
                                       class="w-full border border-gray-300 px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Số điện thoại</label>
                                <input type="text" name="phone" value="<%= manager.getPhone() %>"
                                       class="w-full border border-gray-300 px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Địa chỉ</label>
                                <input type="text" name="address" value="<%= manager.getAddress() %>"
                                       class="w-full border border-gray-300 px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Trạng thái</label>
                                <select name="status" class="w-full border border-gray-300 px-3 py-2 rounded focus:ring-2 focus:ring-blue-500">
                                    <option value="true" <%= manager.getStatus() ? "selected" : "" %>>Đang hoạt động</option>
                                    <option value="false" <%= !manager.getStatus() ? "selected" : "" %>>Đã khóa</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Chi nhánh</label>
                                <select name="branch_id" class="w-full border border-gray-300 px-3 py-2 rounded focus:ring-2 focus:ring-blue-500">
                                    <% for (Branch branch : branches) { %>
                                    <option value="<%= branch.getBranch_id() %>" <%= branch.getBranch_id() == manager.getBranch_id() ? "selected" : "" %>>
                                        <%= branch.getBranch_name() %>
                                    </option>
                                    <% } %>
                                </select>

                            </div>
                        </div>

                        <div class="flex justify-end mt-6 gap-3">
                            <a href="adminViewManagerList" class="bg-gray-300 hover:bg-gray-400 text-gray-800 px-4 py-2 rounded">Hủy</a>
                            <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </main>
            <!-- Modal thông báo lỗi -->
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
                    document.getElementById("errorModal").classList.add("hidden");
                    document.getElementById("errorMessage").textContent = "";
                }

                document.getElementById("adminUpdateManager").addEventListener("submit", function (event) {
                    const fullName = document.getElementsByName("full_name")[0].value.trim();
                    const email = document.getElementsByName("email")[0].value.trim();
                    const phone = document.getElementsByName("phone")[0].value.trim();
                    const address = document.getElementsByName("address")[0].value.trim();

                    let errorMsg = "";

                    const nameRegex = /^[a-zA-ZÀ-ỹ\s]+$/;
                    const emailRegex = /^[\w\.-]+@[\w\.-]+\.\w{2,}$/;
                    const phoneRegex = /^0\d{9}$/;

                    if (fullName.length < 2 || !nameRegex.test(fullName)) {
                        errorMsg = "Họ tên không hợp lệ. Phải ít nhất 2 ký tự và chỉ chứa chữ.";
                    } else if (!emailRegex.test(email)) {
                        errorMsg = "Email không hợp lệ.";
                    } else if (!phoneRegex.test(phone)) {
                        errorMsg = "Số điện thoại phải bắt đầu bằng 0 và có 10 chữ số.";
                    } else if (address.length < 5) {
                        errorMsg = "Địa chỉ phải có ít nhất 5 ký tự.";
                    }

                    if (errorMsg !== "") {
                        event.preventDefault();
                        document.getElementById('errorMessage').textContent = errorMsg;
                        document.getElementById('errorModal').classList.remove('hidden');
                    }
                });
            </script>




        </div>
    </body>
</html>
