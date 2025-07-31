<%-- 
    Document   : adminViewCustomerContact
    Created on : Jul 13, 2025, 10:39:53 AM
    Author     : Lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List,model.admin.ContactWithAdmin,model.customer.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Contacts</title>
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
            @keyframes fade-in {
                from {
                    opacity: 0;
                    transform: translateY(-10px) scale(0.98);
                }
                to {
                    opacity: 1;
                    transform: translateY(0) scale(1);
                }
            }

            .animate-fade-in {
                animation: fade-in 0.25s ease-out;
            }
            .pagination a {
                transition: all 0.2s ease-in-out;
            }
        </style>
    </head>
    <body class="bg-gradient-to-br from-blue-50 via-indigo-50 to-purple-50 text-gray-800 flex min-h-screen">

        <!-- Sidebar -->
        <nav id="sidebar"
             class="w-72 sidebar-gradient text-white p-4 flex flex-col h-screen fixed top-0 left-0 shadow-2xl overflow-y-auto z-50">
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
                        <div
                            class="w-12 h-12 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full flex items-center justify-center">
                            <i class="fas fa-user text-white text-lg"></i>
                        </div>
                        <div
                            class="absolute -bottom-1 -right-1 w-5 h-5 bg-green-400 rounded-full border-2 border-white pulse-animation">
                        </div>
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
                   class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
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

                <a href="adminViewCustomerContact" class="nav-item active-nav px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
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

        <!-- Main content -->
        <div class="flex-1 ml-72 p-6 space-y-8 overflow-y-auto">
            <main>
                <h2 class="text-xl font-bold mb-4">Danh sách liên hệ khách hàng</h2>

                <!-- Bộ lọc tìm kiếm -->
                <form action="adminFilterContact" method="get"
                      class="mb-6 bg-white p-6 rounded-2xl shadow-md grid grid-cols-1 md:grid-cols-4 gap-4 items-end text-sm border border-blue-100">

                    <!-- Từ khóa tên/email -->
                    <div class="flex flex-col">
                        <label for="keyword" class="mb-1 font-semibold text-gray-600">Tìm kiếm tên / email:</label>
                        <input type="text" id="keyword" name="keyword"
                               value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>"
                               class="border border-gray-300 rounded-lg px-3 py-2 focus:ring-blue-400 focus:border-blue-400 shadow-sm">
                    </div>

                    <!-- Lọc theo trạng thái -->
                    <div class="flex flex-col">
                        <label for="status" class="mb-1 font-semibold text-gray-600">Trạng thái:</label>
                        <select id="status" name="status"
                                class="border border-gray-300 rounded-lg px-3 py-2 focus:ring-blue-400 focus:border-blue-400 shadow-sm">
                            <option value="">Tất cả</option>
                            <option value="1" <%= "1".equals(request.getParameter("status")) ? "selected" : "" %>>Đã phản hồi</option>
                            <option value="0" <%= "0".equals(request.getParameter("status")) ? "selected" : "" %>>Chưa phản hồi</option>
                        </select>
                    </div>

                    <!-- Lọc theo tiêu đề -->
                    <div class="flex flex-col">
                        <label for="subject" class="mb-1 font-semibold text-gray-600">Tiêu đề:</label>
                        <select id="subject" name="subject"
                                class="border border-gray-300 rounded-lg px-3 py-2 focus:ring-blue-400 focus:border-blue-400 shadow-sm">
                            <option value="">Tất cả</option>
                            <%
                                String selectedSubject = request.getParameter("subject");
                            %>
                            <option value="Chất lượng bể bơi" <%= "Chất lượng bể bơi".equals(selectedSubject) ? "selected" : "" %>>Chất lượng bể bơi</option>
                            <option value="Thái độ phục vụ" <%= "Thái độ phục vụ".equals(selectedSubject) ? "selected" : "" %>>Thái độ phục vụ</option>
                            <option value="Cơ sở vật chất" <%= "Cơ sở vật chất".equals(selectedSubject) ? "selected" : "" %>>Cơ sở vật chất</option>
                            <option value="Góp ý khác" <%= "Góp ý khác".equals(selectedSubject) ? "selected" : "" %>>Góp ý khác</option>
                        </select>
                    </div>

                    <!-- Nút lọc -->
                    <div class="flex">
                        <button type="submit"
                                class="inline-flex items-center gap-2 bg-blue-500 hover:bg-blue-600 text-white font-semibold px-5 py-2.5 rounded-lg shadow">
                            <i class="fas fa-filter"></i> Lọc
                        </button>
                    </div>
                </form>



                <div class="table-container bg-white shadow-md rounded-lg overflow-hidden">
                    <table class="min-w-full divide-y divide-gray-200 text-sm text-left">                    
                        <thead class="bg-blue-100 text-gray-700 font-semibold">
                            <tr>
                                <th class="px-4 py-3">ID</th>
                                <th class="px-4 py-3">Tên khách hàng</th>
                                <th class="px-4 py-3">Email</th>
                                <th class="px-4 py-3">Tiêu đề</th>
                                <th class="px-4 py-3">Ngày gửi</th>
                                <th class="px-4 py-3">Trạng thái</th>
                                <th class="px-4 py-3">Hành động</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <%
                                List<ContactWithAdmin> list = (List<ContactWithAdmin>) request.getAttribute("listContact");
                                if (list != null) {
                                    for (ContactWithAdmin c : list) {
                            %>
                            <tr class="hover:bg-blue-50 transition-all">
                                <td class="px-4 py-2"><%= c.getContact_id() %></td>
                                <td class="px-4 py-2"><%= c.getCustomer_name() %></td>
                                <td class="px-4 py-2"><%= c.getCustomer_email() %></td>
                                <td class="px-4 py-2"><%= c.getSubject() %></td>
                                <td class="px-4 py-2"><%= c.getCreated_at() %></td>
                                <td class="px-4 py-2">
                                    <span class="inline-block px-2 py-1 rounded-full text-xs font-medium
                                          <%= c.getIs_resolved() ? "bg-green-100 text-green-700" : "bg-yellow-100 text-yellow-700" %>">
                                        <%= c.getIs_resolved() ? "Đã phản hồi" : "Chưa phản hồi" %>
                                    </span>
                                </td>
                                <td class="px-4 py-2 space-x-1">
                                    <a href="#"
                                       onclick="showPopupDetail(
                                                       '<%= c.getContact_id() %>',
                                                       '<%= c.getCustomer_name().replace("'", "\\'") %>',
                                                       '<%= c.getCustomer_email().replace("'", "\\'") %>',
                                                       '<%= c.getSubject().replace("'", "\\'") %>',
                                                       '<%= c.getContent().replace("'", "\\'") %>',
                                                       '<%= c.getCreated_at() %>',
                                       <%= Boolean.TRUE.equals(c.getIs_resolved()) ? "true" : "false" %>

                                               )"
                                       class="inline-block bg-blue-500 hover:bg-blue-600 text-white px-2 py-1 rounded text-xs">
                                        <i class="fas fa-eye mr-1"></i>Xem
                                    </a>

                                    <a href="adminResponseContact?id=<%= c.getContact_id() %>" 
                                       class="inline-block bg-green-500 hover:bg-green-600 text-white px-2 py-1 rounded text-xs">
                                        <i class="fas fa-reply mr-1"></i>Phản hồi
                                    </a>

                                </td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>

                    </table>
                    <!-- Phân trang -->
                    <div class="mt-6 flex justify-center p-3">
                        <div class="mt-6 flex justify-center items-center space-x-2 text-sm">

                            <%
                                int currentPage = (int) request.getAttribute("currentPage");
                                int totalPages = (int) request.getAttribute("totalPages");
                                String baseUrl = "adminViewCustomerContact?page=";
                            %>

                            <!-- Previous -->
                            <a href="<%= baseUrl + (currentPage > 1 ? (currentPage - 1) : 1) %>"
                               class="px-3 py-1.5 rounded-md border text-gray-600 hover:bg-gray-100 <%= currentPage == 1 ? "opacity-50 cursor-not-allowed pointer-events-none" : "" %>">
                                <i class="fas fa-angle-left mr-1"></i>Trước
                            </a>

                            <!-- Các trang -->
                            <%
                                for (int i = 1; i <= totalPages; i++) {
                            %>
                            <a href="<%= baseUrl + i %>"
                               class="px-3 py-1.5 rounded-md border <%= (i == currentPage ? "bg-blue-500 text-white" : "text-gray-700 hover:bg-gray-100") %>">
                                <%= i %>
                            </a>
                            <%
                                }
                            %>

                            <!-- Next -->
                            <a href="<%= baseUrl + (currentPage < totalPages ? (currentPage + 1) : totalPages) %>"
                               class="px-3 py-1.5 rounded-md border text-gray-600 hover:bg-gray-100 <%= currentPage == totalPages ? "opacity-50 cursor-not-allowed pointer-events-none" : "" %>">
                                Tiếp<i class="fas fa-angle-right ml-1"></i>
                            </a>

                        </div>
                    </div>
            </main>
        </div>

        <!-- Popup xem chi tiết -->
        <div id="popupDetail" class="fixed inset-0 z-[9999] bg-black bg-opacity-50 flex items-center justify-center hidden">
            <div class="bg-white w-[95%] max-w-xl rounded-2xl shadow-2xl p-6 relative animate-fade-in border border-blue-200">
                <!-- Nút đóng -->
                <button onclick="closePopup()" 
                        class="absolute top-4 right-4 text-gray-500 hover:text-red-500 text-2xl font-bold transition-all duration-200">
                    &times;
                </button>

                <!-- Tiêu đề -->
                <h3 class="text-xl font-bold mb-6 text-blue-600 flex items-center gap-2">
                    <i class="fas fa-envelope-open-text"></i>
                    Chi tiết liên hệ
                </h3>

                <!-- Nội dung popup -->
                <div class="space-y-4 text-[15px] text-gray-800 leading-6 max-h-[60vh] overflow-y-auto pr-1.5">
                    <p><span class="font-semibold text-gray-600">ID:</span> <span id="popupContactId"></span></p>
                    <p><span class="font-semibold text-gray-600">Tên khách hàng:</span> <span id="popupName"></span></p>
                    <p><span class="font-semibold text-gray-600">Email:</span> <span id="popupEmail" class="inline-block px-2 py-1 rounded-full text-xs font-semibold bg-blue-200 text-blue-500"></span></p>
                    <p><span class="font-semibold text-gray-600">Tiêu đề:</span> <span id="popupSubject"></span></p>
                    <p><span class="font-semibold text-gray-600">Nội dung:</span> 
                        <span id="popupContent"
                              class="block bg-gray-50 border border-gray-200 rounded-lg p-3 text-sm text-gray-700 mt-1 shadow-sm">
                        </span>
                    </p>
                    <p><span class="font-semibold text-gray-600">Ngày gửi:</span> <span id="popupDate"></span></p>
                    <p><span class="font-semibold text-gray-600">Trạng thái:</span> 
                        <span id="popupStatus" class="inline-block px-2 py-1 rounded-full text-xs font-semibold bg-yellow-100 text-yellow-800"></span>
                    </p>
                </div>
                <!-- Nút Phản hồi -->
                <div class="mt-6 text-right">
                    <a id="replyButton"
                       href="#"
                       class="inline-flex items-center gap-2 bg-green-500 hover:bg-green-600 text-white font-medium text-sm px-4 py-2 rounded-lg transition-all duration-200 shadow">
                        <i class="fas fa-reply"></i> Phản hồi
                    </a>
                </div>

            </div>
        </div>


        <script>
            function showPopupDetail(contactId, name, email, subject, content, date, isResolved) {
                const isResolvedBool = (isResolved === true || isResolved === 'true');
                document.getElementById("popupContactId").innerText = contactId;
                document.getElementById("popupName").innerText = name;
                document.getElementById("popupEmail").innerText = email;
                document.getElementById("popupSubject").innerText = subject;
                document.getElementById("popupContent").innerText = content;
                document.getElementById("popupDate").innerText = date;
                document.getElementById("popupStatus").innerText = isResolved ? "Đã phản hồi" : "Chưa phản hồi";
                document.getElementById("popupDetail").classList.remove("hidden");

                document.getElementById("replyButton").href = "adminResponseContact?id=" + contactId;

            }

            function closePopup() {
                document.getElementById("popupDetail").classList.add("hidden");
            }


        </script>


    </body>
</html>
