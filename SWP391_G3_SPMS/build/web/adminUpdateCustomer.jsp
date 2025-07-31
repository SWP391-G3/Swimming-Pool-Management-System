<%-- 
    Document   : adminUpdateCustomer
    Created on : Jun 17, 2025, 10:39:20 AM
    Author     : Lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.admin.Customer,model.customer.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật khách hàng</title>
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

    <body class="bg-gray-100 text-gray-800">

        <div class="flex min-h-screen">

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
                        <%
                             User admin = (User) session.getAttribute("adminAccount");                        
                        %>
                        <div class="flex-1">
                            <h4 class="text-sm font-semibold text-white"><%= admin != null ? admin.getFull_name() : "" %></h4>
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

                    <a href="adminViewStaffCategory.jsp"
                       class="nav-item active-nav px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon">
                            <i class="fa-solid fa-user-tie text-sm"></i>
                        </div>
                        <span class="font-medium text-sm">Quản lý nhân viên</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>

                    <a href="adminViewCustomerList"
                       class="nav-item active-nav px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
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
                                <input type="date" required name="dob" value="<%= c.getDob() %>" class="w-full border px-3 py-2 rounded" />
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

                    const fullNameRegex = /^[A-Za-zÀ-Ỹà-ỹ\s]+$/;
                    if (fullName.length < 2 || !fullNameRegex.test(fullName)) {
                        errorMsg += "Họ và tên phải có ít nhất 2 ký tự và không chứa số hoặc ký tự đặc biệt.<br/>";
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
