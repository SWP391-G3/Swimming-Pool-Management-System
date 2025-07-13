<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.admin.Branch,model.admin.StaffType,model.admin.Employee" %>
<%@ page import="model.customer.Pool" %>
<%@ page import="model.admin.EmployeeAccount" %>

<%
    List<Branch> branches = (List<Branch>) request.getAttribute("branches");
    List<StaffType> staffTypes = (List<StaffType>) request.getAttribute("staffTypes");
    List<Pool> pools = (List<Pool>) request.getAttribute("pools");
    EmployeeAccount employee = (EmployeeAccount) request.getAttribute("employee");
    Employee emp = (Employee) request.getAttribute("e");
    String userName = (String) session.getAttribute("userName"); // Lấy tên user từ session
    String error = (String) request.getAttribute("error"); 
    if(error == null) {
        error = "";
    }
    
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật nhân viên</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                <div class="flex justify-between items-center mb-8 p-6 border-2 border-gray-200 bg-white rounded-lg shadow-md">
                    <h2 class="text-3xl font-bold text-gray-800">Cập nhật nhân viên</h2>
                    <a href="adminViewEmployeeList"
                       class="text-gray-800 bg-gray-300 hover:bg-gray-400 px-5 py-2.5 rounded-md flex items-center gap-2 shadow">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại
                    </a>
                </div>

                <form action="adminEditEmployee" method="post"
                      class="bg-white p-6 rounded-lg shadow grid grid-cols-1 md:grid-cols-2 gap-4">
                    <input type="hidden" name="employeeId" value="<%= emp.getStaffId() %>"/>
                    <input type="hidden" name="username" value=""/>
                    <input type="hidden" name="password" value=""/>

                    <div>
                        <label class="font-medium">Họ tên:</label>
                        <input type="text" name="fullName" value="<%= employee.getFullName() %>" required
                               class="w-full mt-1 border rounded px-3 py-2"/>
                    </div>

                    <div>
                        <label class="font-medium">Email:</label>
                        <input type="email" name="email" value="<%= employee.getEmail() %>" required
                               class="w-full mt-1 border rounded px-3 py-2"/>
                    </div>

                    <div>
                        <label class="font-medium">SĐT:</label>
                        <input type="text" name="phone" value="<%= employee.getPhone() %>"
                               class="w-full mt-1 border rounded px-3 py-2"/>
                    </div>

                    <div>
                        <label class="font-medium">Ngày sinh:</label>
                        <input type="date" name="dob" value="<%= employee.getDob() %>" required
                               class="w-full mt-1 border rounded px-3 py-2"/>
                    </div>

                    <div>
                        <label class="font-medium">Giới tính:</label>
                        <select name="gender" required class="w-full mt-1 border rounded px-3 py-2">
                            <option value="">-- Chọn --</option>
                            <option value="Male" <%= "Male".equals(employee.getGender()) ? "selected" : "" %>>Nam</option>
                            <option value="Female" <%= "Female".equals(employee.getGender()) ? "selected" : "" %>>Nữ</option>
                            <option value="Other" <%= "Other".equals(employee.getGender()) ? "selected" : "" %>>Khác</option>
                        </select>
                    </div>

                    <div>
                        <label class="font-medium">Địa chỉ:</label>
                        <input type="text" name="address" value="<%= employee.getAddress() %>"
                               class="w-full mt-1 border rounded px-3 py-2"/>
                    </div>

                    <div>
                        <label class="font-medium">Chi nhánh:</label>
                        <select name="branchId" id="branchSelect" required class="w-full mt-1 border rounded px-3 py-2">
                            <option value="">-- Chọn chi nhánh --</option>
                            <% for (Branch b : branches) { %>
                            <option value="<%= b.getBranch_id() %>" <%= b.getBranch_id() == employee.getBranchId() ? "selected" : "" %>>
                                <%= b.getBranch_name() %>
                            </option>
                            <% } %>
                        </select>
                    </div>

                    <div>
                        <label class="font-medium">Bể bơi:</label>
                        <select name="poolId" id="poolSelect"
                                class="w-full mt-1 border rounded px-3 py-2"
                                <%= employee.getBranchId() == null ? "disabled" : "" %> required>
                            <option value="">-- Chọn bể bơi --</option>
                            <% if (pools != null) {
                        for (Pool p : pools) { %>
                            <option value="<%= p.getPool_id() %>" <%= p.getPool_id() == employee.getPoolId() ? "selected" : "" %>>
                                <%= p.getPool_name() %>
                            </option>
                            <% }} %>
                        </select>
                    </div>

                    <div class="md:col-span-2">
                        <label class="font-medium">Loại công việc:</label>
                        <select name="staffTypeId" required class="w-full mt-1 border rounded px-3 py-2">
                            <option value="">-- Chọn loại công việc --</option>
                            <% for (StaffType st : staffTypes) { %>
                            <option value="<%= st.getStaffTypeID() %>" <%= st.getStaffTypeID() == employee.getStaffTypeId() ? "selected" : "" %>>
                                <%= st.getType_name() %>
                            </option>
                            <% } %>
                        </select>
                    </div>

                    <div class="md:col-span-2 flex justify-end mt-4">
                        <button type="submit"
                                class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2.5 rounded-lg shadow-md flex items-center gap-2">
                            <i class="fa-solid fa-user-pen"></i> Cập nhật nhân viên
                        </button>
                    </div>
                </form>
            </main>
        </div>

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

        <!-- Modal lỗi -->
        <div id="errorModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
            <div class="bg-white rounded-xl shadow-2xl w-[90%] max-w-md p-6 relative">
                <!-- Nút đóng -->
                <button onclick="closeErrorModal()" class="absolute top-3 right-3 text-gray-400 hover:text-red-600 text-xl">
                    &times;
                </button>

                <!-- Header -->
                <div class="flex items-center gap-3 mb-4">
                    <div class="text-red-600 text-2xl">
                        <i class="fa-solid fa-circle-exclamation"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-red-600">Lỗi nhập liệu</h3>
                </div>

                <!-- Danh sách lỗi -->
                <ul id="errorList" class="text-sm text-red-500 space-y-1"></ul>


                <!-- Nút đóng -->
                <div class="mt-5 text-right">
                    <button onclick="closeErrorModal()" class="px-5 py-2 bg-blue-600 text-white rounded-lg shadow hover:bg-blue-700">
                        Đóng
                    </button>
                </div>
            </div>
        </div>


        <script>
            function closeErrorModal() {
                document.getElementById("errorModal").classList.add("hidden");
                document.getElementById("errorList").innerHTML = "";
            }

            document.querySelector('form').addEventListener('submit', function (e) {
                let isValid = true;
                let errors = [];

                const fullName = document.querySelector('[name="fullName"]').value.trim();
                const email = document.querySelector('[name="email"]').value.trim();
                const phone = document.querySelector('[name="phone"]').value.trim();
                const dob = document.querySelector('[name="dob"]').value;
                const address = document.querySelector('[name="address"]').value.trim();

                const fullNameRegex = /^[A-Za-zÀ-ỹ\s]+$/;
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                const phoneRegex = /^0\d{9}$/;
                const addressRegex = /^[\wÀ-ỹ\s,./-]{5,}$/;
                const today = new Date().toISOString().split("T")[0];

                if (!fullNameRegex.test(fullName) || fullName.length < 2) {
                    errors.push("Họ tên chỉ được chứa chữ cái và ít nhất 2 ký tự.");
                    isValid = false;
                }

                if (!emailRegex.test(email)) {
                    errors.push("Email không đúng định dạng.");
                    isValid = false;
                }

                if (!phoneRegex.test(phone)) {
                    errors.push("Số điện thoại phải bắt đầu bằng 0 và gồm 10 chữ số, không chứa ký tự.");
                    isValid = false;
                }

                if (dob === "" || dob > today) {
                    errors.push("Ngày sinh không hợp lệ.");
                    isValid = false;
                }

                if (!addressRegex.test(address)) {
                    errors.push("Địa chỉ phải từ 5 ký tự và không chứa ký tự đặc biệt lạ.");
                    isValid = false;
                }

                if (!isValid) {
                    e.preventDefault();
                    const list = document.getElementById("errorList");
                    list.innerHTML = "";
                    errors.forEach(msg => {
                        const li = document.createElement("li");
                        li.textContent = msg;
                        list.appendChild(li);
                    });
                    document.getElementById("errorModal").classList.remove("hidden");
                }
            });
        </script>

        <script>
            // Kiểm tra và hiển thị lỗi từ server khi trang load
            $(document).ready(function () {
                const serverError = '<%= error %>';

                if (serverError && serverError.trim() !== '') {
                    showServerError(serverError);
                }
            });

            // Hàm hiển thị lỗi từ server
            function showServerError(errorMessage) {
                const errorList = document.getElementById("errorList");
                errorList.innerHTML = "";

                // Tạo item lỗi
                const li = document.createElement("li");
                li.textContent = errorMessage;
                errorList.appendChild(li);

                // Hiển thị modal
                document.getElementById("errorModal").classList.remove("hidden");
            }

            // Cập nhật lại hàm validation để tích hợp với lỗi server
            document.querySelector('form').addEventListener('submit', function (e) {
                let isValid = true;
                let errors = [];

                const fullName = document.querySelector('[name="fullName"]').value.trim();
                const email = document.querySelector('[name="email"]').value.trim();
                const phone = document.querySelector('[name="phone"]').value.trim();
                const dob = document.querySelector('[name="dob"]').value;
                const address = document.querySelector('[name="address"]').value.trim();

                const fullNameRegex = /^[A-Za-zÀ-ỹ\s]+$/;
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                const phoneRegex = /^0\d{9}$/;
                const addressRegex = /^[\wÀ-ỹ\s,./-]{5,}$/;
                const today = new Date().toISOString().split("T")[0];

                // Validation logic (giữ nguyên như cũ)
                if (!fullNameRegex.test(fullName) || fullName.length < 2) {
                    errors.push("Họ tên chỉ được chứa chữ cái và ít nhất 2 ký tự.");
                    isValid = false;
                }

                if (!emailRegex.test(email)) {
                    errors.push("Email không đúng định dạng.");
                    isValid = false;
                }

                if (!phoneRegex.test(phone)) {
                    errors.push("Số điện thoại phải bắt đầu bằng 0 và gồm 10 chữ số, không chứa ký tự.");
                    isValid = false;
                }

                if (dob === "" || dob > today) {
                    errors.push("Ngày sinh không hợp lệ.");
                    isValid = false;
                }

                if (!addressRegex.test(address)) {
                    errors.push("Địa chỉ phải từ 5 ký tự và không chứa ký tự đặc biệt lạ.");
                    isValid = false;
                }

                // Nếu có lỗi validation, ngăn submit và hiển thị modal
                if (!isValid) {
                    e.preventDefault();
                    showValidationErrors(errors);
                }
            });

            // Hàm hiển thị lỗi validation
            function showValidationErrors(errors) {
                const list = document.getElementById("errorList");
                list.innerHTML = "";

                errors.forEach(msg => {
                    const li = document.createElement("li");
                    li.textContent = msg;
                    list.appendChild(li);
                });

                document.getElementById("errorModal").classList.remove("hidden");
            }

            // Hàm đóng modal (cập nhật để clear error)
            function closeErrorModal() {
                document.getElementById("errorModal").classList.add("hidden");
                document.getElementById("errorList").innerHTML = "";
            }
        </script>



    </body>
</html>
