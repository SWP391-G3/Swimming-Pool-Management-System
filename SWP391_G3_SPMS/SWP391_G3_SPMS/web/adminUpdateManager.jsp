<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.admin.Manager, model.customer.User, model.admin.Branch, java.util.List"%>

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
    <body class=bg-gray-100 font-sans leading-relaxed antialiased text-gray-800">


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
        </div>
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
                const branchId = document.getElementsByName("branch_id")[0].value;

                const nameRegex = /^[A-Za-zÀ-ỹà-ỹ\s']{2,}$/;
                const emailRegex = /^[\w\.-]+@[\w\.-]+\.\w{2,}$/;
                const phoneRegex = /^0\d{9}$/;
                const addressRegex = /^[A-Za-zÀ-ỹà-ỹ0-9\s']+$/;

                let errorMsg = "";

                if (!nameRegex.test(fullName)) {
                    errorMsg = "Họ tên phải có ít nhất 2 ký tự, chỉ chứa chữ và khoảng trắng.";
                } else if (!emailRegex.test(email)) {
                    errorMsg = "Email không hợp lệ.";
                } else if (!phoneRegex.test(phone)) {
                    errorMsg = "Số điện thoại phải bắt đầu bằng 0 và đủ 10 chữ số.";
                } else if (address.length < 5 || !addressRegex.test(address)) {
                    errorMsg = "Địa chỉ phải có ít nhất 5 ký tự và chỉ chứa chữ, số, khoảng trắng, hoặc dấu nháy đơn.";
                } else if (!branchId || parseInt(branchId) <= 0) {
                    errorMsg = "Vui lòng chọn chi nhánh hợp lệ.";
                }
                if (errorMsg !== "") {
                    event.preventDefault();
                    document.getElementById('errorMessage').textContent = errorMsg;
                    document.getElementById('errorModal').classList.remove('hidden');
                }
            });
        </script>


        <% 
            String error = (String) request.getAttribute("error");
            if (error != null && !error.isEmpty()) {
        %>
        <script>

            document.addEventListener("DOMContentLoaded", function () {
                document.getElementById('errorMessage').textContent = "<%= error.replace("\"", "\\\"") %>";
                document.getElementById('errorModal').classList.remove('hidden');
            });
        </script>
        <% } %>




    </div>
</body>
</html>
