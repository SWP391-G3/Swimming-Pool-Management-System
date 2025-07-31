<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="model.customer.User,java.text.SimpleDateFormat" %>
<%
    User user = (User) request.getAttribute("user");
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    String errorMsg = (String) request.getAttribute("error");
    String successMsg = (String) request.getAttribute("updateSuccess");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Chỉnh sửa tài khoản</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
            rel="stylesheet"
            />
        <link rel="stylesheet" href="css/styles.css" />
    </head>
    <body class="bg-gray-50 min-h-screen font-['Inter'] antialiased">
        <%@include file="header.jsp" %>
        <div class="container mx-auto px-4 py-8">

            <!-- Nút quay về -->
            <a
                href="my_account"
                class="inline-flex items-center text-blue-600 font-medium mb-8 hover:underline"
                >
                <svg
                    class="w-5 h-5 mr-2"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    >
                <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M15 19l-7-7 7-7"
                    />
                </svg>
                Tài khoản của tôi
            </a>

            <!-- Hero Image Section -->
            <div
                class="relative w-full h-52 md:h-64 mb-8 rounded-lg overflow-hidden shadow-lg"
                >
                <img
                    src="https://www.saharapoolbuilder.com/wp-content/uploads/2019/07/swimming-pool-depth-recommendations.jpg"
                    alt="Edit Account Banner"
                    class="w-full h-full object-cover"
                    />
                <div class="absolute inset-0 bg-gradient-to-b from-black/30 to-black/10"></div>
                <h1
                    class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-3xl md:text-4xl font-bold text-white text-center drop-shadow-lg"
                    >
                    CHỈNH SỬA TÀI KHOẢN
                </h1>
            </div>

            <!-- Main Content with Sidebar -->
            <div class="flex flex-col lg:flex-row gap-8">

                <!-- Sidebar -->
                <aside class="bg-white border border-gray-200 rounded-lg p-6 w-full lg:w-1/4 mb-6 lg:mb-0 shadow-sm">
                    <nav class="space-y-2">
                        <a href="profile?service=showProfile"
                           class="flex items-center gap-2 px-3 py-2 rounded-lg bg-blue-100 text-blue-700 font-semibold">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M5.121 17.804A13.937 13.937 0 0112 15c2.589 0 5.017.735 7.121 2.004M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                            </svg>
                            Thông tin cá nhân
                        </a>
                        <a href="profile?service=changePassword"
                           class="flex items-center gap-2 px-3 py-2 rounded-lg hover:bg-blue-50 text-gray-700 font-medium">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M12 11c0-1.054.816-2 2-2s2 .946 2 2a2 2 0 01-2 2c-1.184 0-2-.946-2-2zm0 0V7m0 4v4m0-4h4m-4 0H8"/>
                            </svg>
                            Thiết lập bảo mật
                        </a>
                    </nav>
                </aside>

                <!-- Edit Account Form -->
                <section class="flex-1 bg-white border border-gray-200 rounded-lg p-8 shadow-sm">
                    <h1 class="text-2xl font-bold mb-6 text-blue-700">Chỉnh sửa thông tin cá nhân</h1>

                    <!-- Hiển thị báo lỗi từ server -->
                    <% if (errorMsg != null && !errorMsg.isEmpty()) { %>
                    <div class="mb-6 p-4 bg-red-100 text-red-800 rounded" id="error">
                        <%= errorMsg %>
                    </div>
                    <% } %>
                    <!-- Hiển thị báo thành công -->
                    <% if (successMsg != null) { %>
                    <div class="mb-6 p-4 bg-emerald-100 text-emerald-800 rounded" id="successMessage">
                        <%= successMsg %>
                    </div>
                    <% } %>

                    <!-- Div hiển thị lỗi validation client-side -->
                    <div id="validationError" class="mb-6 p-4 bg-red-100 text-red-800 rounded hidden"></div>

                    <!-- Avatar + Upload -->
                    <div class="flex flex-col md:flex-row items-center gap-6 mb-8">
                        <div class="relative">
                            <img
                                id="avatarPreview"
                                src="<%= user != null && user.getImages() != null && !user.getImages().isEmpty() ? user.getImages() : "https://randomuser.me/api/portraits/men/32.jpg" %>"
                                alt="Avatar"
                                class="w-28 h-28 rounded-full border-4 border-blue-300 object-cover shadow"
                                />
                            <label
                                for="avatarUpload"
                                class="absolute bottom-0 right-0 bg-blue-600 w-9 h-9 flex items-center justify-center rounded-full cursor-pointer shadow-lg hover:bg-blue-700 transition"
                                >
                                <svg
                                    class="w-5 h-5 text-white"
                                    fill="none"
                                    stroke="currentColor"
                                    viewBox="0 0 24 24"
                                    >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="M15.232 5.232l3.536 3.536M9 13l3-3m2-2 3-3m2.121-2.121A2.828 2.828 0 0121 4.828c0 .746-.308 1.463-.879 2.034l-6.364 6.364a1 1 0 01-.293.207l-4 2a1 1 0 01-1.316-1.316l2-4a1 1 0 01.207-.293l6.364-6.364A2.828 2.828 0 0119.172 1c.746 0 1.463.308 2.034.879z"
                                    />
                                </svg>
                                <input
                                    id="avatarUpload"
                                    name="images"
                                    type="file"
                                    accept="image/*"
                                    class="hidden"
                                    onchange="previewAvatar(event)"
                                    form="editAccountForm"
                                    />
                            </label>
                        </div>
                        <div>
                            <div class="font-semibold text-lg text-gray-900 mb-1">
                                <%= user != null ? user.getFull_name() : "" %>
                            </div>
                            <div class="text-gray-500"><%= user != null ? user.getEmail() : "" %></div>
                        </div>
                    </div>

                    <form id="editAccountForm" action="profile" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                        <input type="hidden" name="service" value="updateProfile">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <!-- Họ và tên -->
                            <div>
                                <label class="block text-gray-600 mb-1 font-medium">Họ và tên</label>
                                <input
                                    type="text"
                                    name="full_name"
                                    id="full_name"
                                    class="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                    placeholder="Nhập họ và tên"
                                    value="<%= user != null ? user.getFull_name() : "" %>"
                                    oninput="clearValidationError()"
                                    />
                            </div>
                            <!-- Ngày sinh -->
                            <div>
                                <label class="block text-gray-600 mb-1 font-medium">Ngày sinh</label>
                                <input
                                    type="date"
                                    name="dob"
                                    id="dob"
                                    class="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                    value="<%= user != null && user.getDob() != null ? df.format(user.getDob()) : "" %>"
                                    oninput="clearValidationError()"
                                    />
                            </div>
                            <!-- Email -->
                            <div>
                                <label class="block text-gray-600 mb-1 font-medium">Email</label>
                                <input
                                    type="email"
                                    name="email"
                                    id="email"
                                    class="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                    placeholder="Nhập email"
                                    value="<%= user != null ? user.getEmail() : "" %>"
                                    oninput="clearValidationError()"
                                    />
                            </div>
                            <!-- Số điện thoại -->
                            <div>
                                <label class="block text-gray-600 mb-1 font-medium">Số điện thoại</label>
                                <input
                                    type="tel"
                                    name="phone"
                                    id="phone"
                                    class="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                    placeholder="Nhập số điện thoại"
                                    value="<%= user != null ? user.getPhone() : "" %>"
                                    oninput="clearValidationError()"
                                    />
                            </div>
                            <!-- Giới tính -->
                            <div>
                                <label class="block text-gray-600 mb-1 font-medium">Giới tính</label>
                                <select
                                    name="gender"
                                    class="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                    onchange="clearValidationError()"
                                    >
                                    <option value="Nam" <%= user != null && "Nam".equals(user.getGender()) ? "selected" : "" %>>Nam</option>
                                    <option value="Nữ" <%= user != null && "Nữ".equals(user.getGender()) ? "selected" : "" %>>Nữ</option>
                                    <option value="Khác" <%= user != null && "Khác".equals(user.getGender()) ? "selected" : "" %>>Khác</option>
                                </select>
                            </div>
                            <!-- Địa chỉ -->
                            <div>
                                <label class="block text-gray-600 mb-1 font-medium">Địa chỉ</label>
                                <input
                                    type="text"
                                    name="address"
                                    id="address"
                                    class="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
                                    placeholder="Nhập địa chỉ"
                                    value="<%= user != null ? user.getAddress() : "" %>"
                                    oninput="clearValidationError()"
                                    />
                            </div>
                        </div>
                        <!-- Nút lưu -->
                        <div class="mt-8 flex justify-end">
                            <button
                                type="submit"
                                class="bg-blue-600 text-white px-6 py-2 rounded-md font-semibold shadow hover:bg-blue-700 transition-colors"
                                >
                                Lưu thay đổi
                            </button>
                        </div>
                    </form>
                </section>
            </div>
        </div>
        <%@include file="footer.jsp" %>
        <script>
            // Preview avatar khi upload file
            function previewAvatar(event) {
                const reader = new FileReader();
                reader.onload = function () {
                    const output = document.getElementById("avatarPreview");
                    output.src = reader.result;
                };
                reader.readAsDataURL(event.target.files[0]);
            }

            // Xóa thông báo lỗi khi người dùng sửa input
            function clearValidationError() {
                const errorDiv = document.getElementById("validationError");
                errorDiv.classList.add("hidden");
                errorDiv.innerHTML = "";
            }

            // Hiển thị lỗi validation
            function showValidationError(message) {
                const errorDiv = document.getElementById("validationError");
                errorDiv.innerHTML = message;
                errorDiv.classList.remove("hidden");
                errorDiv.scrollIntoView({behavior: 'smooth', block: 'center'});
            }

            function validateFullName(fullName) {
                if (!fullName || fullName.trim() === "") {
                    return "Họ và tên không được để trống.";
                }
                if (fullName.length < 4 || fullName.length > 50) {
                    return "Họ và tên phải từ 4 đến 50 ký tự.";
                }
                if (fullName.startsWith(" ") || fullName.endsWith(" ")) {
                    return "Họ và tên không được có khoảng trắng ở đầu hoặc cuối.";
                }
                if (fullName.includes("  ")) {
                    return "Họ và tên chỉ được dùng một khoảng trắng giữa các từ.";
                }
                if (!/^[A-Za-zÀ-ỹĐđ'\- ]+$/.test(fullName)) {
                    return "Họ và tên chỉ được chứa chữ cái, dấu nháy đơn (') hoặc gạch nối (-).";
                }
                return "";
            }

            function validateEmail(email) {
                if (!email || email.trim() === "") {
                    return "Email không được để trống.";
                }
                if (!email.includes("@")) {
                    return "Email phải chứa ký tự @.";
                }
                const parts = email.split("@");
                if (parts.length !== 2) {
                    return "Email không đúng định dạng (chỉ chứa một ký tự @).";
                }
                const username = parts[0];
                const domain = parts[1];
                if (!/^[A-Za-z0-9._%+-]+$/.test(username)) {
                    return "Tên tài khoản Email không hợp lệ.";
                }
                if (!/^[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(domain)) {
                    return "Tên miền email không hợp lệ hoặc thiếu đuôi miền.";
                }
                const domainParts = domain.split(".");
                if (domainParts[domainParts.length - 1].length < 2) {
                    return "Đuôi miền email phải có ít nhất 2 ký tự.";
                }
                return "";
            }

            function validatePhone(phone) {
                if (!phone || phone.trim() === "") {
                    return "Số điện thoại không được để trống.";
                }
                if (!/^0\d{9}$/.test(phone)) {
                    return "Số điện thoại phải bắt đầu bằng số 0 và có đúng 10 chữ số.";
                }
                return "";
            }

            function validateDob(dobStr) {
                if (!dobStr || dobStr.trim() === "") {
                    return "Ngày sinh không được bỏ trống.";
                }
                try {
                    const dob = new Date(dobStr);
                    const today = new Date();
                    if (dob > today) {
                        return "Ngày sinh không được lớn hơn ngày hiện tại.";
                    }
                    const age = today.getFullYear() - dob.getFullYear();
                    if (age < 10 || age > 120) {
                        return "Tuổi phải từ 10 đến 120.";
                    }
                } catch (e) {
                    return "Ngày sinh không hợp lệ. Định dạng đúng: yyyy-MM-dd.";
                }
                return "";
            }

            function validateAddress(address) {
                if (!address || address.trim() === "") {
                    return "Địa chỉ không được để trống.";
                }
                if (address.length < 5 || address.length > 100) {
                    return "Địa chỉ phải từ 5 đến 100 ký tự.";
                }
                return "";
            }

            // Hàm validate form chính
            function validateForm() {
                const fullName = document.getElementById("full_name").value;
                const email = document.getElementById("email").value;
                const phone = document.getElementById("phone").value;
                const address = document.getElementById("address").value;
                const dob = document.getElementById("dob").value;

                let errors = [];

                // Validate từng field
                const fullNameError = validateFullName(fullName);
                if (fullNameError)
                    errors.push(fullNameError);

                const emailError = validateEmail(email);
                if (emailError)
                    errors.push(emailError);

                const phoneError = validatePhone(phone);
                if (phoneError)
                    errors.push(phoneError);

                const addressError = validateAddress(address);
                if (addressError)
                    errors.push(addressError);

                const dobError = validateDob(dob);
                if (dobError)
                    errors.push(dobError);

                // Nếu có lỗi, hiển thị và không submit
                if (errors.length > 0) {
                    showValidationError(errors.join("<br>"));
                    return false;
                }

                return true; // Cho phép submit
            }

            // Ẩn thông báo thành công sau 10 giây
            window.addEventListener('DOMContentLoaded', () => {
                const successDiv = document.getElementById('successMessage');
                if (successDiv) {
                    setTimeout(() => {
                        successDiv.style.display = 'none';
                    }, 10000); // 10,000 milliseconds = 10 seconds
                }
            });
        </script>

    </body>
</html>