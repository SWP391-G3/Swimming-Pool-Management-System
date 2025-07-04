<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.customer.User"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý nhân viên</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="./css/admin/adminStaffCategory.css"/>
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
        </style>
    </head>
    <body class="bg-gray-100 text-gray-800">
        <%
            User currentUser = (User) session.getAttribute("currentUser");
            String userName = currentUser != null ? currentUser.getFull_name() : "";
        %>

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
                        <i class="fas fa-bars mr-2"></i>Menu Chính
                    </div>
                    <a href="adminPoolManagement" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon"><i class="fa-solid fa-water text-sm"></i></div>
                        <span class="font-medium text-sm">Quản lý bể bơi</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>
                    <a href="adminViewStaffCategory.jsp" class="nav-item active-nav px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon"><i class="fa-solid fa-user-tie text-sm"></i></div>
                        <span class="font-medium text-sm">Quản lý nhân viên</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>
                    <a href="adminViewCustomerList" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon"><i class="fa-solid fa-user-check text-sm"></i></div>
                        <span class="font-medium text-sm">Quản lý khách hàng</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>
                    <a href="#" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon"><i class="fa-solid fa-chart-line text-sm"></i></div>
                        <span class="font-medium text-sm">Thống kê & Báo cáo</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>
                    <div class="text-xs font-semibold text-blue-200 uppercase tracking-wider mb-2 px-3 mt-4">
                        <i class="fas fa-cog mr-2"></i>Hệ thống
                    </div>
                    <a href="#" class="nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
                        <div class="nav-icon"><i class="fa-solid fa-gear text-sm"></i></div>
                        <span class="font-medium text-sm">Cài đặt hệ thống</span>
                        <i class="fas fa-chevron-right ml-auto text-xs opacity-60"></i>
                    </a>
                    <div class="mt-3 pt-3 border-t border-white/20">
                        <a href="LogoutServlet" class="logout-btn nav-item px-3 py-2.5 rounded-xl flex items-center gap-3 Światowy z-10 font-semibold">
                            <div class="nav-icon"><i class="fa-solid fa-right-from-bracket text-sm"></i></div>
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


            <div class="main-content ml-0 md:ml-72 p-2 sm:p-4 md:p-6 w-full">
                <!-- Main -->
                <main class="w-full max-w-full space-y-6 p-5">
                    <div class="bg-white shadow rounded-xl p-8">
                        <h2 class="text-2xl font-bold text-blue-700 mb-6">
                            Chào mừng <%= userName %>, chọn một chức năng để quản lý:
                        </h2>

                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                            <!-- Nhân viên bể bơi -->
                            <a href="adminViewEmployeeList" class="card-link">
                                <i class="fa-solid fa-users-gear text-blue-600"></i>
                                <h3>Nhân viên bể bơi</h3>
                                <p>Xem và phân công nhân viên vận hành theo từng bể bơi, khu vực</p>
                            </a>

                            <!-- Quản lý bể bơi -->
                            <a href="adminViewManagerList" class="card-link card-link-green">
                                <i class="fa-solid fa-user-shield text-green-600"></i>
                                <h3>Quản lý bể bơi</h3>
                                <p>Theo dõi và bổ nhiệm người quản lý chịu trách nhiệm cho từng bể bơi, khu vực</p>
                            </a>
                        </div>
                    </div>
                </main>

            </div>
        </div>
    </body>
</html>
