<%-- 
    Document   : adminResponseContact
    Created on : Jul 13, 2025, 12:27:38 PM
    Author     : Lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.admin.ContactWithAdmin,model.customer.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Response Contacts</title>
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
        <% 
            ContactWithAdmin cw = (ContactWithAdmin) request.getAttribute("cw");
            if(cw != null){
        %>

        <!-- Main Content -->
        <div class="flex-1 ml-72 p-6 space-y-8 overflow-y-auto">
            <main class="space-y-6 bg-white p-6 rounded-2xl shadow-lg animate-fade-in">
                <h2 class="text-2xl font-bold text-blue-700">Phản hồi đến khách hàng</h2>

                <form method="post" action="adminResponseContact" class="space-y-5">
                    <input type="hidden" name="contact_id" value="<%= cw.getContact_id() %>" />

                    <!-- Thông tin khách hàng -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-1">Tên khách hàng</label>
                            <input type="text" value="<%= cw.getCustomer_name() %>" disabled
                                   class="w-full px-4 py-2 border border-gray-300 bg-gray-100 rounded-lg shadow-sm text-gray-700" />
                        </div>
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-1">Email</label>
                            <input type="text" value="<%= cw.getCustomer_email() %>" disabled
                                   class="w-full px-4 py-2 border border-gray-300 bg-gray-100 rounded-lg shadow-sm text-gray-700" />
                        </div>
                    </div>

                    <!-- Thông tin liên hệ -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-1">Tiêu đề liên hệ</label>
                            <input type="text" value="<%= cw.getSubject() %>" disabled
                                   class="w-full px-4 py-2 border border-gray-300 bg-gray-100 rounded-lg shadow-sm text-gray-700" />
                        </div>
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-1">Ngày gửi</label>
                            <input type="text" value="<%= cw.getCreated_at() %>" disabled
                                   class="w-full px-4 py-2 border border-gray-300 bg-gray-100 rounded-lg shadow-sm text-gray-700" />
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-1">Nội dung liên hệ</label>
                        <textarea rows="4" disabled
                                  class="w-full px-4 py-3 border border-gray-300 bg-gray-100 rounded-lg shadow-sm text-gray-700 resize-none"><%= cw.getContent() %></textarea>
                    </div>
                    <% }%>     

                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-1">Nội dung phản hồi</label>
                        <textarea name="response_content" rows="6" required
                                  class="w-full px-4 py-3 border border-blue-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"></textarea>
                    </div>

                    <div class="flex justify-end gap-4 pt-2">
                        <a href="adminViewCustomerContact"
                           class="inline-flex items-center bg-gray-200 hover:bg-gray-300 text-gray-800 font-medium px-5 py-2.5 rounded-lg shadow-sm transition-colors">
                            <i class="fas fa-arrow-left mr-2"></i> Quay lại
                        </a>
                        <button type="submit"
                                class="inline-flex items-center bg-blue-600 hover:bg-blue-700 text-white font-semibold px-6 py-2.5 rounded-lg shadow-md transition-all">
                            <i class="fas fa-paper-plane mr-2"></i> Gửi phản hồi
                        </button>
                    </div>

                </form>
            </main>
        </div>

    </body>
</html>
