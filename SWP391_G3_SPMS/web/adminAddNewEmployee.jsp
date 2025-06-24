<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.admin.Branch" %>
<%@ page import="model.admin.StaffType" %>
<%@ page import="model.User" %>

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
    </head>
    <body class="bg-gray-100">

        <!-- Sidebar -->
        <nav class="w-64 bg-[#000033] text-white p-6 flex flex-col space-y-4 fixed h-full z-40">
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
            <a href="adminViewEmployeeList" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-tie"></i> Quản lý nhân viên</a>
            <a href="adminViewCustomerList" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-user-check"></i> Quản lý khách hàng</a>
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-chart-line"></i> Thống kê & Báo cáo</a>
            <a href="#" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2"><i class="fa-solid fa-gear"></i> Cài đặt hệ thống</a>
            <a href="LogoutServlet" class="hover:bg-blue-900 hover:ring-2 hover:ring-white px-3 py-2 rounded flex items-center gap-2 text-red-400"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
        </nav>

        <!-- Main Content -->
        <div class="ml-64 p-8">
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

    </body>
</html>
