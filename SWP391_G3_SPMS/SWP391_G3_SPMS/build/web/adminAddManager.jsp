<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.customer.User"%>
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
        <link rel="stylesheet" href="./css/admin/adminPanel.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/global.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLndnUkP4OYlT6DkL4kSVV8Vsl5W0RXp2Pl3T/jCGX0gLexyO3J54+lZ7c2tXj4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            /* Ensure no horizontal scrollbar */
            body {
                overflow-x: hidden;
            }
            .main-content {
                width: calc(100% - 18rem); /* Adjust based on sidebar width */
                max-width: 100%;
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
            .main-content {
                margin-left: 18rem; /* tương ứng w-72 = 18rem */
                width: calc(100% - 18rem);
                max-width: 100%;
            }
            @media (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    width: 100%;
                }
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
    <body class="bg-gray-100 font-sans leading-relaxed antialiased text-gray-800">

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
                        <h4 class="text-sm font-semibold text-white"><%= userName %></h4>
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

                <a href="adminPoolManagement" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                    <div class="nav-icon">
                        <i class="fa-solid fa-water text-sm"></i>
                    </div>
                    <span class="font-medium text-sm">Quản lý bể bơi</span>
                    <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                </a>

                <a href="adminViewManagerList"
                   class="nav-item active-nav px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
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

        <div class="flex-1 main-content p-4">
            <!-- Main -->
            <main class="w-full max-w-full space-y-6 p-5">
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
                            <input name="username" value="${param.username}" required type="text" class="w-full p-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold mb-1">Mật khẩu</label>
                            <input name="password" value="${param.password}" required type="password" class="w-full p-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold mb-1">Họ và tên</label>
                            <input name="full_name" value="${param.full_name}" required type="text" class="w-full p-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold mb-1">Email</label>
                            <input name="email"  value="${param.email}" required type="email" class="w-full p-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold mb-1">Điện thoại</label>
                            <input name="phone" value="${param.phone}" type="text" class="w-full p-3 rounded-xl border border-gray-300">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold mb-1">Địa chỉ</label>
                            <input name="address" value="${param.address}" type="text" class="w-full p-3 rounded-xl border border-gray-300">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold mb-1">Ngày sinh</label>
                            <input name="dob" value="${param.dob}" type="date" class="w-full p-3 rounded-xl border border-gray-300">
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

        <!-- Modal lỗi -->
        <div id="errorModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
            <div class="bg-white rounded-xl shadow-2xl w-[90%] max-w-md p-6 relative">
                <button onclick="closeErrorModal()" class="absolute top-3 right-3 text-gray-400 hover:text-red-600 text-xl">
                    &times;
                </button>

                <div class="flex items-center gap-3 mb-4">
                    <div class="text-red-600 text-2xl">
                        <i class="fa-solid fa-circle-exclamation"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-red-600">Lỗi</h3>
                </div>

                <p id="serverErrorText" class="text-red-500 text-sm"></p>

                <div class="mt-5 text-right">
                    <button onclick="closeErrorModal()" class="px-5 py-2 bg-blue-600 text-white rounded-lg shadow hover:bg-blue-700">
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
                const password = document.querySelector("input[name='password']").value;
                const fullName = document.querySelector("input[name='full_name']").value.trim();
                const email = document.querySelector("input[name='email']").value.trim();
                const phone = document.querySelector("input[name='phone']").value.trim();
                const address = document.querySelector("input[name='address']").value.trim();
                const dob = document.querySelector("input[name='dob']").value;
                const gender = document.querySelector("select[name='gender']").value;
                const branch = document.querySelector("select[name='branchId']").value;

                const usernameRegex = /^[a-zA-Z0-9_]{5,20}$/;
                const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,30}$/;
                const fullNameRegex = /^[A-Za-zÀ-ỹà-ỹ\s']{2,}$/;
                const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                const phoneRegex = /^0\d{9}$/;

                if (!usernameRegex.test(username)) {
                    errorMsg += "Tên đăng nhập phải từ 5-20 ký tự, chỉ gồm chữ, số hoặc dấu gạch dưới.<br/>";
                }

                if (!passwordRegex.test(password)) {
                    errorMsg += "Mật khẩu phải dài tối thiểu 8 ký tự, có ít nhất 1 chữ hoa, 1 chữ thường và 1 số.<br/>";
                }

                if (!fullNameRegex.test(fullName)) {
                    errorMsg += "Họ và tên phải có ít nhất 2 ký tự, chỉ chứa chữ và khoảng trắng.<br/>";
                }

                if (!emailRegex.test(email)) {
                    errorMsg += "Email không đúng định dạng. VD: ten@example.com<br/>";
                }

                if (!phoneRegex.test(phone)) {
                    errorMsg += "Số điện thoại phải bắt đầu bằng 0 và có 10 chữ số.<br/>";
                }

                if (address.length < 5) {
                    errorMsg += "Địa chỉ phải có ít nhất 5 ký tự.<br/>";
                }

                if (dob) {
                    const today = new Date();
                    const inputDate = new Date(dob);
                    let age = today.getFullYear() - inputDate.getFullYear();
                    const m = today.getMonth() - inputDate.getMonth();
                    if (m < 0 || (m === 0 && today.getDate() < inputDate.getDate())) {
                        age--;
                    }
                    if (age < 14) {
                        errorMsg += "Tuổi phải từ 14 tuổi trở lên.<br/>";
                    }
                    if (inputDate > today) {
                        errorMsg += "Ngày sinh không hợp lệ (trong tương lai).<br/>";
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


        <script>
            function closeErrorModal() {
                document.getElementById("errorModal").classList.add("hidden");
                document.getElementById("serverErrorText").innerHTML = "";
            }

            // Khi trang load, kiểm tra lỗi từ server
            document.addEventListener("DOMContentLoaded", function () {
                const serverError = '<%= request.getAttribute("error") != null ? request.getAttribute("error").toString().replace("'", "\\'") : "" %>';
                if (serverError.trim() !== "") {
                    document.getElementById("serverErrorText").innerText = serverError;
                    document.getElementById("errorModal").classList.remove("hidden");
                }
            });
        </script>



    </body>
</html>
