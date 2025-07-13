<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.admin.Branch" %>
<%@ page import="model.admin.StaffType" %>
<%@ page import="model.customer.User" %>

<%
    List<Branch> branches = (List<Branch>) request.getAttribute("branches");
    List<StaffType> staffTypes = (List<StaffType>) request.getAttribute("staffTypes");
    User currentUser = (User) session.getAttribute("currentUser");
    String userName = currentUser != null ? currentUser.getFull_name() : "";
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm nhân viên</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://cdn.tailwindcss.com"></script>
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

                <a href="adminViewEmployeeList"
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
                <!-- Tiêu đề và nút quay lại -->
                <div class="flex justify-between items-center mb-8 p-6 border-2 border-gray-200 bg-gradient-to-r from-gray-100 via-white to-white rounded-lg shadow-md hover:shadow-lg transition-all duration-300">
                    <h2 class="text-3xl font-extrabold text-gray-800 tracking-wide">Thêm nhân viên</h2>
                    <a href="adminViewEmployeeList"
                       class="text-gray-800 bg-gray-300 hover:bg-gray-400 px-5 py-2.5 rounded-md flex items-center gap-2 shadow hover:shadow-lg transform hover:scale-105 transition-all duration-300 ease-in-out">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại
                    </a>
                </div>


                <!-- Form -->
                <form action="adminAddNewEmployee" method="post" class="bg-white p-6 rounded-lg shadow grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div><label class="font-medium">Tên đăng nhập:</label><input type="text" name="username" required class="w-full mt-1 border rounded px-3 py-2" /></div>
                    <div><label class="font-medium">Mật khẩu:</label><input type="password" name="password" required class="w-full mt-1 border rounded px-3 py-2" /></div>
                    <div><label class="font-medium">Họ tên:</label><input type="text" name="fullName" required class="w-full mt-1 border rounded px-3 py-2" /></div>
                    <div><label class="font-medium">Email:</label><input type="email" name="email" required class="w-full mt-1 border rounded px-3 py-2" /></div>
                    <div><label class="font-medium">SĐT:</label><input type="text" name="phone" class="w-full mt-1 border rounded px-3 py-2" /></div>
                    <div><label class="font-medium">Ngày sinh:</label><input type="date" name="dob" required class="w-full mt-1 border rounded px-3 py-2" /></div>
                    <div>
                        <label class="font-medium">Giới tính:</label>
                        <select name="gender" required class="w-full mt-1 border rounded px-3 py-2">
                            <option value="">-- Chọn --</option>
                            <option value="Male">Nam</option>
                            <option value="Female">Nữ</option>
                            <option value="Other">Khác</option>
                        </select>
                    </div>
                    <div><label class="font-medium">Địa chỉ:</label><input type="text" name="address" class="w-full mt-1 border rounded px-3 py-2" /></div>

                    <!-- Chi nhánh -->
                    <div>
                        <label class="font-medium">Chi nhánh:</label>
                        <select name="branchId" id="branchSelect" required class="w-full mt-1 border rounded px-3 py-2">
                            <option value="">-- Chọn chi nhánh --</option>
                            <% for (Branch b : branches) { %>
                            <option value="<%= b.getBranch_id() %>"><%= b.getBranch_name() %></option>
                            <% } %>
                        </select>
                    </div>

                    <!-- Bể bơi -->
                    <div>
                        <label class="font-medium">Bể bơi:</label>
                        <select name="poolId" id="poolSelect" required disabled class="w-full mt-1 border rounded px-3 py-2">
                            <option value="">-- Chọn chi nhánh trước --</option>
                        </select>
                    </div>

                    <!-- Loại công việc -->
                    <div class="md:col-span-2">
                        <label class="font-medium">Loại công việc:</label>
                        <select name="staffTypeId" required class="w-full mt-1 border rounded px-3 py-2">
                            <option value="">-- Chọn loại công việc --</option>
                            <% for (StaffType st : staffTypes) { %>
                            <option value="<%= st.getStaffTypeID() %>"><%= st.getType_name() %></option>
                            <% } %>
                        </select>
                    </div>

                    <!-- Submit -->
                    <div class="md:col-span-2 flex justify-end mt-4">
                        <button type="submit"
                                class="bg-green-600 hover:bg-green-700 text-white px-6 py-2.5 rounded-lg shadow-md hover:shadow-lg transform hover:scale-105 transition-all duration-300 ease-in-out flex items-center gap-2">
                            <i class="fa-solid fa-user-plus"></i>
                            Thêm nhân viên
                        </button>
                    </div>

                </form>
            </main>
        </div>

        <!-- AJAX load pool -->
        <script>
            $(document).ready(function () {
                $('#branchSelect').on('change', function () {
                    const branchId = $(this).val();
                    const $poolSelect = $('#poolSelect');

                    $poolSelect.empty();

                    if (!branchId) {
                        $poolSelect.prop('disabled', true).append("<option value=''>-- Chọn chi nhánh trước --</option>");
                        return;
                    }

                    $.ajax({
                        url: 'adminAddNewEmployee',
                        method: 'GET',
                        data: {branchId: branchId},
                        dataType: 'json',
                        success: function (data) {
                            $poolSelect.prop('disabled', false).append("<option value=''>-- Chọn bể bơi --</option>");
                            if (Array.isArray(data)) {
                                $.each(data, function (index, pool) {
                                    $poolSelect.append($('<option>', {
                                        value: pool.pool_id,
                                        text: pool.pool_name
                                    }));
                                });
                            } else {
                                $poolSelect.append("<option value=''>-- Không có bể bơi --</option>");
                            }
                        },
                        error: function () {
                            $poolSelect.prop('disabled', true).append("<option value=''>-- Lỗi khi tải bể bơi --</option>");
                        }
                    });
                });
            });
        </script>

        <script>
            document.querySelector('form').addEventListener('submit', function (e) {
                let isValid = true;
                let errorMsg = "";

                const username = document.querySelector('[name="username"]').value.trim();
                const password = document.querySelector('[name="password"]').value.trim();
                const fullName = document.querySelector('[name="fullName"]').value.trim();
                const address = document.querySelector('[name="address"]').value.trim();
                const dob = document.querySelector('[name="dob"]').value;

                // Validate Tên đăng nhập: ít nhất 2 ký tự, không chứa ký tự đặc biệt
                const usernameRegex = /^[a-zA-Z0-9]{2,}$/;
                if (!usernameRegex.test(username)) {
                    errorMsg += "- Tên đăng nhập phải từ 2 ký tự trở lên và không chứa ký tự đặc biệt.\n";
                    isValid = false;
                }

                const addressRegex = /^[a-zA-Z0-9]{5,}$/;
                if (!addressRegex.test(address)) {
                    errorMsg += "- Địa chỉ phải từ 5 ký tự trở lên và không chứa ký tự đặc biệt.\n";
                    isValid = false;
                }

                // Validate Mật khẩu: đúng 9 chữ số
                const passwordRegex = /^\d{9}$/;
                if (!passwordRegex.test(password)) {
                    errorMsg += "- Mật khẩu phải đúng 9 chữ số.\n";
                    isValid = false;
                }

                // Validate Họ và tên: chỉ chứa chữ cái (kể cả tiếng Việt, có dấu)
                const fullNameRegex = /^[A-Za-zÀ-ỹ\s]+$/;
                if (!fullNameRegex.test(fullName) || fullName.length < 2) {
                    errorMsg += "- Họ và tên chỉ được chứa chữ cái và phải từ 2 ký tự trở lên.\n";
                    isValid = false;
                }

                // Validate Ngày sinh: không được lớn hơn ngày hiện tại
                const today = new Date().toISOString().split("T")[0];
                if (dob === "" || dob > today) {
                    errorMsg += "- Ngày sinh không được lớn hơn ngày hiện tại.\n";
                    isValid = false;
                }

                // Nếu có lỗi
                if (!isValid) {
                    alert("Lỗi nhập liệu:\n" + errorMsg);
                    e.preventDefault(); // Ngăn form submit
                }
            });
        </script>

    </body>
</html>
