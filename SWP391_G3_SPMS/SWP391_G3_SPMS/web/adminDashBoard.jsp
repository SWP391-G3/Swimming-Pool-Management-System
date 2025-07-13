<%-- 
    Document   : adminDashBoard
    Created on : Jul 8, 2025, 8:49:51 PM
    Author     : Lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@page import="model.admin.DashboardStats,model.admin.RevenueByMonth,model.admin.UserGrowth,model.admin.CustomerJoinStats" %>
<%@page import="model.admin.PoolStatusStats,model.admin.BookingTrendStats,model.admin.UserCountByRole,model.admin.DeviceStatusStats" %>
<% 
    DashboardStats ds = (DashboardStats) request.getAttribute("ds");
    RevenueByMonth rm = (RevenueByMonth) request.getAttribute("rm");
    UserGrowth ug = (UserGrowth) request.getAttribute("ug");
    PoolStatusStats ps = (PoolStatusStats) request.getAttribute("ps");
    BookingTrendStats bt = (BookingTrendStats) request.getAttribute("bt");
    UserCountByRole uc = (UserCountByRole) request.getAttribute("uc");
    DeviceStatusStats de = (DeviceStatusStats) request.getAttribute("de");
    CustomerJoinStats cj = (CustomerJoinStats) request.getAttribute("cj");

%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Swimming Pool Admin Dashboard</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <link rel="stylesheet" href="./css/admin/adminDashBoard.css"/>
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
                    <div class="flex-1">
                        <h4 class="text-sm font-semibold text-white">Nguyễn Văn A</h4>
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

                <a href="adminDashBoard" class="nav-item active-nav px-3 py-2.5 rounded-xl flex items-center gap-3 relative z-10">
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

        <!-- Main Content -->
        <div class="flex-1 ml-72 p-6 space-y-8 overflow-y-auto">

            <!-- Header -->
            <div class="text-center mb-8">
                <h1
                    class="text-4xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent mb-2">
                    Swimming Pool Management Dashboard
                </h1>
                <p class="text-gray-600">Tổng quan hoạt động hệ thống bể bơi</p>
                <div class="flex items-center justify-center mt-4 text-sm text-gray-500">
                    <i class="fas fa-calendar-alt mr-2"></i>
                    <span id="currentDate"></span>
                    <div class="mx-4 w-2 h-2 bg-green-400 rounded-full pulse-animation"></div>
                    <span class="text-green-600 font-medium">Hệ thống hoạt động bình thường</span>
                </div>
            </div>

            <!-- Quick Stats Cards -->
            <section class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div class="stat-card rounded-2xl p-6 shadow-lg border glow-effect">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-gray-600 text-sm font-medium">Tổng người dùng</p>
                            <p class="text-3xl font-bold text-blue-600" id="totalUsers"></p>
                            <p class="text-green-500 text-sm">
                                <% 
                                    String displayUserGrowth;
                                    if (ds.getUserGrowthPercent() == null) {
                                        displayUserGrowth = "N/A";
                                    } else if (ds.getUserGrowthPercent() > 0) {
                                        displayUserGrowth = "+" + ds.getUserGrowthPercent() + "%";
                                    } else {
                                        displayUserGrowth = ds.getUserGrowthPercent() + "%";
                                    }
                                %>
                                <i class="fas fa-chart-line mr-1"></i><%= displayUserGrowth %> so với tháng trước
                            </p>

                        </div>
                        <div class="stat-icon w-12 h-12 rounded-full flex items-center justify-center">
                            <i class="fas fa-users text-white text-lg"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card rounded-2xl p-6 shadow-lg border">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-gray-600 text-sm font-medium">Bể bơi hoạt động</p>
                            <p class="text-3xl font-bold text-green-600" id="activePools"></p>
                            <p class="text-gray-500 text-sm">
                                <i class="fas fa-circle text-green-400 mr-1"></i><%= ds.getTotalPools() %> tổng số bể
                            </p>
                        </div>
                        <div
                            class="w-12 h-12 bg-gradient-to-br from-green-500 to-emerald-600 rounded-full flex items-center justify-center">
                            <i class="fas fa-swimming-pool text-white text-lg"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card rounded-2xl p-6 shadow-lg border">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-gray-600 text-sm font-medium">Doanh thu tháng</p>
                            <%
                                NumberFormat vnCurrency = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                String formattedRevenue = vnCurrency.format(ds.getCurrentRevenue());
                            %>
                            <p class="text-3xl font-bold text-purple-600" id="monthlyRevenue"><%= formattedRevenue %></p>

                            <p class="text-purple-500 text-sm">
                                <% 
                                    String displayRevenuePercent;
                                    if (ds.getRevenueChangePercent() == null) {
                                        displayRevenuePercent = "N/A";
                                    } else if (ds.getRevenueChangePercent() > 0) {
                                        displayRevenuePercent = "+" + ds.getRevenueChangePercent() + "%";
                                    } else {
                                        displayRevenuePercent = ds.getRevenueChangePercent() + "%";
                                    }
                                %>
                                <i class="fas fa-chart-line mr-1"></i><%= displayRevenuePercent %> so với tháng trước
                            </p>

                        </div>
                        <div
                            class="w-12 h-12 bg-gradient-to-br from-purple-500 to-violet-600 rounded-full flex items-center justify-center">
                            <i class="fa-solid fa-money-check"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card rounded-2xl p-6 shadow-lg border">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-gray-600 text-sm font-medium">Đặt chỗ hôm nay</p>
                            <p class="text-3xl font-bold text-orange-600" id="todayBookings"></p>
                            <p class="text-orange-500 text-sm">
                                <i class="fas fa-clock mr-1"></i><%= ds.getPendingBookings() %> đang chờ xác nhận
                            </p>
                        </div>
                        <div
                            class="w-12 h-12 bg-gradient-to-br from-orange-500 to-red-500 rounded-full flex items-center justify-center">
                            <i class="fas fa-calendar-check text-white text-lg"></i>
                        </div>
                    </div>
                </div>
            </section>

            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
                <!-- Revenue Chart -->
                <div class="chart-container rounded-2xl p-6 shadow-lg">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-lg font-semibold text-gray-800" id="stat-revenue">Doanh thu theo tháng</h3>
                        <div class="flex items-center space-x-2">
                            <button id="btn6Month"
                                    class="px-3 py-1 bg-blue-100 text-blue-600 rounded-lg text-sm font-medium">6 tháng</button>
                            <button id="btn12Month" class="px-3 py-1 text-gray-500 rounded-lg text-sm">12 tháng</button>
                        </div>
                    </div>
                    <div class="p-4">
                        <canvas id="revenueChart" height="300"></canvas>
                        <div class="chart-legend" id="legend-revenueChart"></div>

                    </div>
                </div>

                <!-- User Growth Chart -->
                <div class="chart-container rounded-2xl p-6 shadow-lg">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-lg font-semibold text-gray-800" id="stat-user-growth">Tăng trưởng người dùng</h3>
                        <div class="flex items-center space-x-2">
                            <button id="userGrowthBtn6"
                                    class="px-3 py-1 bg-blue-100 text-blue-600 rounded-lg text-sm font-medium">6 tháng</button>
                            <button id="userGrowthBtn12" class="px-3 py-1 text-gray-500 rounded-lg text-sm">12
                                tháng</button>
                        </div>
                    </div>
                    <div class="p-4">
                        <canvas id="userGrowthChart" height="300"></canvas>
                        <div class="chart-legend" id="legend-userGrowthChart"></div>
                    </div>
                </div>
            </div>

            <!-- Pool Status and Bookings -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-8">
                <!-- Pool Status -->
                <div class="chart-container rounded-2xl p-6 shadow-lg">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4" id="stat-pool-status">Trạng thái bể bơi</h3>
                    <div class="p-4">
                        <canvas id="poolStatusChart"></canvas>
                        <div class="chart-legend" id="legend-poolStatusChart"></div>
                    </div>
                    <div class="mt-4 space-y-2">
                        <!-- ... giữ nguyên trạng thái bể bơi ... -->
                    </div>
                </div>

                <!-- Booking Trends -->
                <div class="chart-container rounded-2xl p-6 shadow-lg">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4" id="stat-booking-trends">Xu hướng đặt chỗ</h3>
                    <div class="p-4">
                        <canvas id="bookingTrendsChart"></canvas>
                        <div class="chart-legend" id="legend-bookingTrendsChart"></div>
                    </div>
                </div>

                <!-- User Types -->
                <div class="chart-container rounded-2xl p-6 shadow-lg">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4" id="stat-user-types">Phân loại người dùng</h3>
                    <div class="p-4">
                        <canvas id="userTypesChart"></canvas>
                        <div class="chart-legend" id="legend-userTypesChart"></div>
                    </div>
                </div>
            </div>

            <!-- Equipment and Services -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
                <!-- Equipment Status -->
                <div class="chart-container rounded-2xl p-6 shadow-lg">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4" id="stat-equipment">Tình trạng thiết bị</h3>
                    <div class="p-4">
                        <canvas id="equipmentChart"></canvas>
                        <div class="chart-legend" id="legend-equipmentChart"></div>
                    </div>
                </div>

                <!-- Popular Services -->
                <div class="chart-container rounded-2xl p-6 shadow-lg">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4" id="stat-services">Dịch vụ phổ biến</h3>
                    <div class="p-4">
                        <canvas id="servicesChart"></canvas>
                        <div class="chart-legend" id="legend-servicesChart"></div>
                    </div>
                </div>
            </div>

            <!-- Staff Performance -->
            <div class="chart-container rounded-2xl p-6 shadow-lg mb-8">
                <h3 class="text-lg font-semibold text-gray-800 mb-4" id="stat-staff">Số lượng nhân viên theo chi nhánh</h3>
                <div class="p-4">
                    <canvas id="staffChart" height="400"></canvas>
                    <div class="chart-legend" id="legend-staffChart"></div>
                </div>
            </div>

            <!-- Real-time Metrics -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                <div class="metric-card rounded-2xl p-6 text-center">
                    <div class="text-3xl font-bold mb-2" id="liveVisitors"><%= cj.getTota_customer() %></div>
                    <div class="text-sm opacity-90">Khách hàng hiện tại</div>
                    <div class="mt-2 flex items-center justify-center">
                        <div class="w-2 h-2 bg-green-300 rounded-full pulse-animation mr-2"></div>
                        <span class="text-xs">Cập nhật trực tiếp</span>
                    </div>
                </div>

                <div class="metric-card rounded-2xl p-6 text-center">
                    <div class="text-3xl font-bold mb-2" id="avgRating"><%= cj.getAverage_feedking() %></div>
                    <div class="text-sm opacity-90">Đánh giá trung bình</div>
                    <div class="mt-2 flex justify-center">
                        <div id="starContainer" class="flex text-yellow-300">

                        </div>
                    </div>
                </div>

                <div class="metric-card rounded-2xl p-6 text-center">
                    <div class="text-3xl font-bold mb-2" id="waterTemp"><%= cj.getTotal_service_today() %></div>
                    <div class="text-sm opacity-90">Số lượng dịch vụ đang được sử dụng</div>
                    <div class="mt-2 text-xs opacity-75">Cập nhật 5 phút trước</div>
                </div>
            </div>

        </div>

        <script>

            // Helper để render chú thích cho từng biểu đồ
            function renderLegend(legendId, labels, colors, datasetLabels) {
                const legend = document.getElementById(legendId);
                legend.innerHTML = '';

                // Legend cho single-line/bar chart: chỉ có 1 dataset
                if (datasetLabels && datasetLabels.length > 1) {
                    // Stacked bar chart (staffChart)
                    for (let i = 0; i < datasetLabels.length; i++) {
                        legend.insertAdjacentHTML('beforeend',
                                `<div class="chart-legend-item">
                                <span class="chart-legend-color" style="background:${colors[i]};"></span>
            ${datasetLabels[i]}
                            </div>`
                                );
                    }
                } else {
                    // Pie/doughnut/line chart
                    for (let i = 0; i < labels.length; i++) {
                        legend.insertAdjacentHTML('beforeend',
                                `<div class="chart-legend-item">
                                <span class="chart-legend-color" style="background:${colors[i]};"></span>
            ${labels[i]}
                            </div>`
                                );
                    }
                }
            }

            // Set current date
            document.getElementById('currentDate').textContent = new Date().toLocaleDateString('vi-VN', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });

            // Chart.js configurations
            const chartOptions = {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            usePointStyle: true
                        }
                    }
                },
                animation: {
                    duration: 800,
                    easing: 'easeOutCubic'
                }
            };

            // Dữ liệu doanh thu mẫu cho 6 tháng và 12 tháng
            const revenueLabels6 = ['T1', 'T2', 'T3', 'T4', 'T5', 'T6'];
            const revenueData6 = [<%= rm.getT1() %>, <%= rm.getT2() %>, <%= rm.getT3() %>,
            <%= rm.getT4() %>, <%= rm.getT5() %>, <%= rm.getT6() %>];

            const revenueLabels12 = ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'];
            const revenueData12 = [<%= rm.getT1() %>, <%= rm.getT2() %>, <%= rm.getT3() %>,
            <%= rm.getT4() %>, <%= rm.getT5() %>, <%= rm.getT6() %>,
            <%= rm.getT7() %>, <%= rm.getT8() %>, <%= rm.getT9() %>,
            <%= rm.getT10() %>, <%= rm.getT11() %>, <%= rm.getT12() %>];

            // Dữ liệu Tăng trưởng người dùng 6 tháng và 12 tháng
            const userGrowthLabels6 = ['T1', 'T2', 'T3', 'T4', 'T5', 'T6'];
            const userGrowthData6 = [<%= ug.getT1() %>, <%= ug.getT2() %>, <%= ug.getT3() %>,
            <%= ug.getT4() %>, <%= ug.getT5() %>, <%= ug.getT6() %>];

            const userGrowthLabels12 = ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'];
            const userGrowthData12 = [<%= ug.getT1() %>, <%= ug.getT2() %>, <%= ug.getT3() %>,
            <%= ug.getT4() %>, <%= ug.getT5() %>, <%= ug.getT6() %>,
            <%= ug.getT7() %>, <%= ug.getT8() %>, <%= ug.getT9() %>,
            <%= ug.getT10() %>, <%= ug.getT11() %>, <%= ug.getT12() %>];

            // Biến lưu chart doanh thu
            let revenueChart;
            // To avoid chart flickering: Only create each chart once!

            function createCharts() {
                // Set fixed heights for parent containers and canvases
                const fixChartHeight = (id, height = 300) => {
                    const container = document.getElementById(id).parentElement;
                    container.style.height = height + 'px';
                    document.getElementById(id).height = height;
                };

                fixChartHeight('revenueChart', 320);
                fixChartHeight('userGrowthChart', 320);
                fixChartHeight('poolStatusChart', 220);
                fixChartHeight('bookingTrendsChart', 220);
                fixChartHeight('userTypesChart', 220);
                fixChartHeight('equipmentChart', 220);
                fixChartHeight('servicesChart', 220);
                fixChartHeight('staffChart', 380);

                // Revenue Chart
                function renderRevenueChart(labels, data) {
                    const ctx = document.getElementById('revenueChart').getContext('2d');
                    if (revenueChart)
                        revenueChart.destroy(); // Xóa chart cũ nếu có
                    revenueChart = new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: labels,
                            datasets: [{
                                    label: 'Doanh thu (Triệu VNĐ)',
                                    data: data,
                                    borderColor: '#3b82f6',
                                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                                    fill: true,
                                    tension: 0.4,
                                    pointBackgroundColor: '#3b82f6',
                                    pointBorderColor: '#ffffff',
                                    pointBorderWidth: 2,
                                    pointRadius: 6
                                }]
                        },
                        options: {
                            ...chartOptions,
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    grid: {color: 'rgba(0, 0, 0, 0.05)'}
                                },
                                x: {grid: {display: false}}
                            }
                        }
                    });
                }
                // Khởi tạo lần đầu là 6 tháng
                renderRevenueChart(revenueLabels6, revenueData6);

                // User Growth Chart
                let userGrowthChart;

                function renderUserGrowthChart(labels, data) {
                    const ctx = document.getElementById('userGrowthChart').getContext('2d');
                    if (userGrowthChart)
                        userGrowthChart.destroy();
                    userGrowthChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                    label: 'Người dùng mới',
                                    data: data,
                                    backgroundColor: 'rgba(139, 92, 246, 0.8)',
                                    borderRadius: 8,
                                    borderSkipped: false
                                }]
                        },
                        options: {
                            ...chartOptions,
                            scales: {
                                y: {beginAtZero: true}
                            }
                        }
                    });
                }

                // Pool Status Chart
                new Chart(document.getElementById('poolStatusChart').getContext('2d'), {
                    type: 'doughnut',
                    data: {
                        labels: ['Hoạt động', 'Ngừng hoạt động'],
                        datasets: [{
                                data: [<%= ps.getTotal_active() %>, <%= ps.getTotal_inactive() %>],
                                backgroundColor: ['#10b981', '#ef4444'],
                                borderWidth: 0
                            }]
                    },
                    options: {
                        ...chartOptions,
                        cutout: '60%'
                    }
                });

                // Booking Trends Chart
                new Chart(document.getElementById('bookingTrendsChart').getContext('2d'), {
                    type: 'line',
                    data: {
                        labels: ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'],
                        datasets: [{
                                label: 'Lượt đặt',
                                data: [<%= bt.getT2() %>, <%= bt.getT3() %>, <%= bt.getT4() %>,
            <%= bt.getT5() %>, <%= bt.getT6() %>, <%= bt.getT7() %>, <%= bt.getCn() %>],
                                borderColor: '#f59e0b',
                                backgroundColor: 'rgba(245, 158, 11, 0.1)',
                                fill: true,
                                tension: 0.4
                            }]
                    },
                    options: {
                        ...chartOptions,
                        scales: {y: {beginAtZero: true}}
                    }
                });

                // User Types Chart
                new Chart(document.getElementById('userTypesChart').getContext('2d'), {
                    type: 'pie',
                    data: {
                        labels: ['Khách hàng', 'Nhân viên', 'Quản lý', 'Admin'],
                        datasets: [{
                                data: [<%= uc.getCustomer() %>, <%= uc.getStaff() %>,
            <%= uc.getManager() %>, <%= uc.getAdmin() %>],
                                backgroundColor: ['#3b82f6', '#10b981', '#f59e0b', '#ef4444']
                            }]
                    },
                    options: chartOptions
                });

                // Equipment Chart
                new Chart(document.getElementById('equipmentChart').getContext('2d'), {
                    type: 'doughnut',
                    data: {
                        labels: ['Hoạt động tốt', 'Cần bảo trì', 'Hỏng hóc'],
                        datasets: [{
                                data: [<%= de.getAvailableCount() %>, <%= de.getMaintenanceCount() %>, <%= de.getBrokenCount() %>],
                                backgroundColor: ['#22c55e', '#f59e0b', '#ef4444'],
                                borderWidth: 0
                            }]
                    },
                    options: {
                        ...chartOptions,
                        cutout: '50%'
                    }
                });

                // Services Chart (use bar with indexAxis:'y' for best browser compatibility)
                // Giả sử bạn lấy được từ DB/backend (test tĩnh trước)
                //const serviceNames = ['Tủ đựng đồ', 'Áo phao', 'Đồ bơi trẻ em', 'Đồ bơi người lớn', 'Kính Bơi', 'Mũ bơi', 'Ván bơi'];         
                //const serviceUsages = [150, 120, 95, 80, 65, 50, 30];

                const serviceNames = [
            <%
                        List<String> names = (List<String>) request.getAttribute("service_name");
                        if (names != null) {
                            for (int i = 0; i < names.size(); i++) {
                                String safeName = names.get(i).replace("'", "\\'");
                                out.print("'" + safeName + "'");
                                if (i < names.size() - 1) out.print(", ");
                            }
                        }
            %>
                ];
                console.log(serviceNames);

                const serviceUsages = [
            <%
                        List<Integer> totals = (List<Integer>) request.getAttribute("service_total");
                        if (totals != null) {
                            for (int i = 0; i < totals.size(); i++) {
                                out.print(totals.get(i));
                                if (i < totals.size() - 1) out.print(", ");
                            }
                        }
            %>
                ];



                // Tạo mảng màu động, đủ số dịch vụ
                const barColors = [
                    '#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#99CCFF',
                    '#ef8bff', '#ffb347', '#6ee7b7', '#fca5a5'
                ];
                const backgroundColor = serviceNames.map((_, i) => barColors[i % barColors.length]);

                // Vẫn giữ nguyên format Chart.js như bạn muốn
                new Chart(document.getElementById('servicesChart').getContext('2d'), {
                    type: 'bar',
                    data: {
                        labels: serviceNames,
                        datasets: [{
                                data: serviceUsages,
                                backgroundColor: backgroundColor
                            }]
                    },
                    options: {
                        ...chartOptions,
                        indexAxis: 'y',
                        scales: {
                            y: {
                                beginAtZero: true,
                                // --- Thêm đoạn này để luôn show đủ nhãn ---
                                ticks: {
                                    autoSkip: false
                                }
                            }
                        }
                    }
                });

                const branchLabels = [
            <%
                        List<String> labels = (List<String>) request.getAttribute("branchLabels");
                        if (labels != null) {
                            for (int i = 0; i < labels.size(); i++) {
                                out.print("'" + labels.get(i).replace("'", "\\'") + "'");
                                if (i < labels.size() - 1) out.print(", ");
                            }
                        }
            %>
                ];

                const activeStaffData = [
            <%
                        List<Integer> active = (List<Integer>) request.getAttribute("activeStaffData");
                        if (active != null) {
                            for (int i = 0; i < active.size(); i++) {
                                out.print(active.get(i));
                                if (i < active.size() - 1) out.print(", ");
                            }
                        }
            %>
                ];

                const inactiveStaffData = [
            <%
                        List<Integer> inactive = (List<Integer>) request.getAttribute("inactiveStaffData");
                        if (inactive != null) {
                            for (int i = 0; i < inactive.size(); i++) {
                                out.print(inactive.get(i));
                                if (i < inactive.size() - 1) out.print(", ");
                            }
                        }
            %>
                ];

                // Staff Chart
                new Chart(document.getElementById('staffChart').getContext('2d'), {
                    type: 'bar',
                    data: {
                        labels: branchLabels,
                        datasets: [
                            {
                                label: 'Hoạt động',
                                data: activeStaffData,
                                backgroundColor: '#10b981'
                            },
                            {
                                label: 'Không hoạt động',
                                data: inactiveStaffData,
                                backgroundColor: '#ef4444'
                            }
                        ]
                    },
                    options: {
                        ...chartOptions,
                        scales: {
                            x: {stacked: true},
                            y: {stacked: true, beginAtZero: true}
                        }
                    }
                });
                document.getElementById('btn6Month').addEventListener('click', () => {
                    renderRevenueChart(revenueLabels6, revenueData6);
                    document.getElementById('btn6Month').classList.add('bg-blue-100', 'text-blue-600');
                    document.getElementById('btn12Month').classList.remove('bg-blue-100', 'text-blue-600');
                    document.getElementById('btn12Month').classList.add('text-gray-500');
                });

                document.getElementById('btn12Month').addEventListener('click', () => {
                    renderRevenueChart(revenueLabels12, revenueData12);
                    document.getElementById('btn12Month').classList.add('bg-blue-100', 'text-blue-600');
                    document.getElementById('btn6Month').classList.remove('bg-blue-100', 'text-blue-600');
                    document.getElementById('btn6Month').classList.add('text-gray-500');
                });

                // Khởi tạo mặc định là 6 tháng
                renderUserGrowthChart(userGrowthLabels6, userGrowthData6);

                document.getElementById('userGrowthBtn6').addEventListener('click', function () {
                    renderUserGrowthChart(userGrowthLabels6, userGrowthData6);
                    this.classList.add('bg-blue-100', 'text-blue-600');
                    document.getElementById('userGrowthBtn12').classList.remove('bg-blue-100', 'text-blue-600');
                    document.getElementById('userGrowthBtn12').classList.add('text-gray-500');
                });

                document.getElementById('userGrowthBtn12').addEventListener('click', function () {
                    renderUserGrowthChart(userGrowthLabels12, userGrowthData12);
                    this.classList.add('bg-blue-100', 'text-blue-600');
                    document.getElementById('userGrowthBtn6').classList.remove('bg-blue-100', 'text-blue-600');
                    document.getElementById('userGrowthBtn6').classList.add('text-gray-500');
                });
            }

            // Only run once DOM is fully ready
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', createCharts);
            } else {
                createCharts();
            }




            // Real-time data simulation (NO scrollTop etc)
            function updateRealTimeData() {
                // Simulate live visitors count
                const visitors = document.getElementById('liveVisitors');
                const currentCount = parseInt(visitors.textContent);
                const newCount = <%= cj.getTota_customer() %>;
                visitors.textContent = newCount;

                // Simulate water temperature
                const temp = document.getElementById('waterTemp');
                const newTemp = <%= cj.getTotal_service_today() %>;
                temp.textContent = newTemp;
            }
            // Update real-time data every 10 seconds
            setInterval(updateRealTimeData, 10000);

            // Add smooth animations for stat cards (IntersectionObserver can cause scroll jump if you call scrollIntoView, so don't do it!)
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.animationDelay = Math.random() * 0.5 + 's';
                        entry.target.classList.add('animate-fade-in');
                    }
                });
            }, {threshold: 0.1});

            document.querySelectorAll('.stat-card, .chart-container').forEach(el => {
                observer.observe(el);
            });

            // Add CSS animations
            const style = document.createElement('style');
            style.textContent = `
                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(20px);
                    }
                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }
            
                .animate-fade-in {
                    animation: fadeIn 0.6s ease-out forwards;
                }
            
                .counter-up {
                    animation: countUp 2s ease-out;
                }
            
                @keyframes countUp {
                    from {
                        transform: scale(0.8);
                        opacity: 0;
                    }
                    to {
                        transform: scale(1);
                        opacity: 1;
                    }
                }
            
                .glow-pulse {
                    animation: glowPulse 3s ease-in-out infinite;
                }
            
                @keyframes glowPulse {
                    0%, 100% {
                        box-shadow: 0 0 20px rgba(59, 130, 246, 0.3);
                    }
                    50% {
                        box-shadow: 0 0 30px rgba(59, 130, 246, 0.6);
                    }
                }
            `;
            document.head.appendChild(style);

            // Counter animation for stat numbers
            function animateCounter(element, target, duration = 2000) {
                const start = 0;
                const increment = target / (duration / 16);
                let current = start;

                const timer = setInterval(() => {
                    current += increment;
                    if (current >= target) {
                        current = target;
                        clearInterval(timer);
                    }
                    element.textContent = Math.floor(current);
                }, 16);
            }

            // Initialize counter animations
            setTimeout(() => {
                animateCounter(document.getElementById('totalUsers'), <%= ds.getTotalUsers() %>);
                animateCounter(document.getElementById('activePools'), <%= ds.getActivePools() %>);
                animateCounter(document.getElementById('todayBookings'), <%= ds.getTodayBookings() %>);
            }, 500);

            // Add hover effects for interactive elements
            document.querySelectorAll('.stat-card').forEach(card => {
                card.addEventListener('mouseenter', () => {
                    card.style.transform = 'translateY(-8px) scale(1.02)';
                    card.style.transition = 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)';
                });

                card.addEventListener('mouseleave', () => {
                    card.style.transform = 'translateY(0) scale(1)';
                });
            });

            // Add click effects for navigation items
            document.querySelectorAll('.nav-item').forEach(item => {
                item.addEventListener('click', (e) => {
                    // Remove active class from all items
                    document.querySelectorAll('.nav-item').forEach(nav => {
                        nav.classList.remove('active-nav');
                    });

                    // Add active class to clicked item
                    item.classList.add('active-nav');

                    // Add ripple effect
                    const ripple = document.createElement('div');
                    ripple.style.cssText = `
                        position: absolute;
                        border-radius: 50%;
                        background: rgba(255, 255, 255, 0.3);
                        transform: scale(0);
                        animation: ripple 0.6s linear;
                        width: 20px;
                        height: 20px;
                        left: ${e.offsetX - 10}px;
                        top: ${e.offsetY - 10}px;
                    `;

                    item.appendChild(ripple);

                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });

            // Add ripple animation keyframes
            const rippleStyle = document.createElement('style');
            rippleStyle.textContent = `
                @keyframes ripple {
                    to {
                        transform: scale(4);
                        opacity: 0;
                    }
                }
            `;
            document.head.appendChild(rippleStyle);

            function showNotification(message, type = 'info') {
                console.log('Showing notification:', message, type); // Debug

                const notification = document.createElement('div');

                const bgColor =
                        type === 'success' ? 'bg-green-500' :
                        type === 'warning' ? 'bg-yellow-500' :
                        type === 'error' ? 'bg-red-500' :
                        'bg-blue-500';

                const iconClass =
                        type === 'success' ? 'fa-check-circle' :
                        type === 'warning' ? 'fa-exclamation-triangle' :
                        type === 'error' ? 'fa-times-circle' :
                        'fa-info-circle';

                // Tailwind + fallback styles
                notification.className = `
        fixed top-4 right-4 p-4 rounded-lg shadow-md
        transform translate-x-full transition-transform duration-300
            ${bgColor} text-white z-[9999] max-w-xs w-full sm:w-auto border
    `.replace(/\s+/g, ' ').trim();

                notification.innerHTML = `
        <div class="flex items-center">
            <i class="fas ${iconClass} mr-2"></i>
            <span class="flex-1">${message}</span>
            <button onclick="this.closest('div').parentElement.remove()" class="ml-4 text-white hover:text-gray-200">
                <i class="fas fa-times"></i>
            </button>
        </div>
    `;

                document.body.appendChild(notification);

                // Trigger animation
                setTimeout(() => {
                    notification.style.transform = 'translateX(0)';
                }, 50);

                // Remove after 5s
                setTimeout(() => {
                    notification.style.transform = 'translateX(100%)';
                    setTimeout(() => notification.remove(), 300);
                }, 5000);
            }

// Tự động hiển thị 3 loại notification mỗi 10s (ngẫu nhiên)
            const notifications = [
                {message: 'Có 3 đặt chỗ mới cần xác nhận', type: 'info'},
                {message: 'Bể bơi số 2 cần bảo trì định kỳ', type: 'warning'},
                {message: 'Doanh thu hôm nay đã đạt mục tiêu', type: 'success'}
            ];

            let notificationIndex = 0;

            setInterval(() => {
                if (Math.random() > 0.7) {
                    showNotification(
                            notifications[notificationIndex].message,
                            notifications[notificationIndex].type
                            );
                    notificationIndex = (notificationIndex + 1) % notifications.length;
                }
            }, 10000);



            // Add loading skeleton effect
            function showLoadingSkeleton() {
                const skeletonStyle = document.createElement('style');
                skeletonStyle.textContent = `
                    .skeleton {
                        background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
                        background-size: 200% 100%;
                        animation: loading 1.5s infinite;
                    }
                
                    @keyframes loading {
                        0% {
                            background-position: 200% 0;
                        }
                        100% {
                            background-position: -200% 0;
                        }
                    }
                `;
                document.head.appendChild(skeletonStyle);
            }

            showLoadingSkeleton();

            // Add search functionality (placeholder)
            function addSearchFunctionality() {
                const searchHTML = `
            <div class="mb-6">
                <div class="relative max-w-md">
                    <input id="statSearchInput" type="text" placeholder="Tìm kiếm thống kê..." 
                           class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    <div class="absolute inset-y-0 left-0 flex items-center pl-3">
                        <i class="fas fa-search text-gray-400"></i>
                    </div>
                </div>
            </div>
        `;
                // Insert search bar after header
                const header = document.querySelector('.text-center.mb-8');
                header.insertAdjacentHTML('afterend', searchHTML);

                // Xử lý tìm kiếm & cuộn đến phần phù hợp
                const input = document.getElementById('statSearchInput');
                input.addEventListener('keydown', function (e) {
                    if (e.key === 'Enter') {
                        jumpToStatSection(this.value);
                    }
                });
                // Có thể thêm lắng nghe sự kiện blur hoặc button search nếu muốn
            }

            // Hàm tìm và cuộn đến phần thống kê phù hợp
            function jumpToStatSection(keyword) {
                if (!keyword.trim())
                    return;

                keyword = keyword.trim().toLowerCase();

                // Danh sách các id và tiêu đề (tùy chỉnh cho từng phần)
                const statSections = [
                    {id: 'stat-revenue', label: 'doanh thu theo tháng'},
                    {id: 'stat-user-growth', label: 'tăng trưởng người dùng'},
                    {id: 'stat-pool-status', label: 'trạng thái bể bơi'},
                    {id: 'stat-booking-trends', label: 'xu hướng đặt chỗ'},
                    {id: 'stat-user-types', label: 'phân loại người dùng'},
                    {id: 'stat-equipment', label: 'tình trạng thiết bị'},
                    {id: 'stat-services', label: 'dịch vụ phổ biến'},
                    {id: 'stat-staff', label: 'số lượng nhân viên theo chi nhánh'}
                    // ... thêm các mục khác nếu có ...
                ];

                // Tìm phần gần khớp nhất (tìm trong label)
                const found = statSections.find(section =>
                    section.label.toLowerCase().includes(keyword) ||
                            keyword.includes(section.label.toLowerCase())
                );
                if (found) {
                    const el = document.getElementById(found.id);
                    if (el) {
                        el.scrollIntoView({behavior: 'smooth', block: 'center'});
                        el.classList.add('ring', 'ring-blue-400', 'ring-offset-2'); // hiệu ứng nổi bật
                        setTimeout(() => el.classList.remove('ring', 'ring-blue-400', 'ring-offset-2'), 1200);
                    }
                } else {
                    showNotification('Không tìm thấy mục thống kê phù hợp.', 'warning');
                }
            }

            addSearchFunctionality();

            // Export functionality
            function addExportButtons() {
                const exportHTML = `
                    <div class="fixed bottom-4 right-4 space-y-2 z-40">
                        <button onclick="exportToPDF()" class="bg-red-500 hover:bg-red-600 text-white p-3 rounded-full shadow-lg transition-all duration-300 hover:scale-110">
                            <i class="fas fa-file-pdf"></i>
                        </button>
                        <button onclick="exportToExcel()" class="bg-green-500 hover:bg-green-600 text-white p-3 rounded-full shadow-lg transition-all duration-300 hover:scale-110">
                            <i class="fas fa-file-excel"></i>
                        </button>
                    </div>
                `;
                document.body.insertAdjacentHTML('beforeend', exportHTML);
            }

            function exportToPDF() {
                showNotification('Đang xuất báo cáo PDF...', 'info');
                // Placeholder for PDF export functionality
                setTimeout(() => {
                    showNotification('Xuất PDF thành công!', 'success');
                }, 2000);
            }

            function exportToExcel() {
                showNotification('Đang xuất dữ liệu Excel...', 'info');
                // Placeholder for Excel export functionality
                setTimeout(() => {
                    showNotification('Xuất Excel thành công!', 'success');
                }, 2000);
            }

            window.exportToPDF = exportToPDF;
            window.exportToExcel = exportToExcel;

            addExportButtons();

            // Dark mode toggle
            function addDarkModeToggle() {
                const toggleHTML = `
                    <button id="darkModeToggle" class="fixed top-4 right-4 bg-gray-800 hover:bg-gray-700 text-white p-2 rounded-full shadow-lg transition-all duration-300 z-40">
                        <i class="fas fa-moon"></i>
                    </button>
                `;
                document.body.insertAdjacentHTML('beforeend', toggleHTML);

                document.getElementById('darkModeToggle').addEventListener('click', toggleDarkMode);
            }

            function toggleDarkMode() {
                document.body.classList.toggle('dark-mode');
                const isDark = document.body.classList.contains('dark-mode');
                const toggle = document.getElementById('darkModeToggle');

                if (isDark) {
                    toggle.innerHTML = '<i class="fas fa-sun"></i>';
                    document.body.style.background = 'linear-gradient(135deg, #1f2937 0%, #111827 100%)';
                } else {
                    toggle.innerHTML = '<i class="fas fa-moon"></i>';
                    document.body.style.background = 'linear-gradient(135deg, #dbeafe 0%, #e0e7ff 50%, #f3e8ff 100%)';
                }
            }

            addDarkModeToggle();

            // Initialize tooltips
            function initializeTooltips() {
                const tooltipElements = document.querySelectorAll('[data-tooltip]');
                tooltipElements.forEach(element => {
                    element.addEventListener('mouseenter', showTooltip);
                    element.addEventListener('mouseleave', hideTooltip);
                });
            }

            function showTooltip(event) {
                const tooltip = document.createElement('div');
                tooltip.className = 'absolute bg-gray-800 text-white text-sm px-2 py-1 rounded shadow-lg z-50';
                tooltip.textContent = event.target.getAttribute('data-tooltip');
                tooltip.style.top = event.target.offsetTop - 30 + 'px';
                tooltip.style.left = event.target.offsetLeft + 'px';
                event.target.parentElement.appendChild(tooltip);
            }

            function hideTooltip(event) {
                const tooltip = event.target.parentElement.querySelector('.absolute.bg-gray-800');
                if (tooltip) {
                    tooltip.remove();
                }
            }

            initializeTooltips();

            // Hàm render số sao dựa theo điểm đánh giá
            function renderStars(rating) {
                const starContainer = document.getElementById('starContainer');
                starContainer.innerHTML = '';

                const fullStars = Math.floor(rating);
                const halfStar = (rating - fullStars >= 0.25 && rating - fullStars < 0.75) ? 1 : 0;
                const emptyStars = 5 - fullStars - halfStar;

                for (let i = 0; i < fullStars; i++) {
                    starContainer.innerHTML += '<i class="fas fa-star"></i>';
                }
                if (halfStar) {
                    starContainer.innerHTML += '<i class="fas fa-star-half-alt"></i>';
                }
                for (let i = 0; i < emptyStars; i++) {
                    starContainer.innerHTML += '<i class="far fa-star"></i>';
                }
            }

            // Hàm cập nhật điểm trung bình và số sao
            function updateAvgRating(rating) {
                document.getElementById('avgRating').textContent = rating.toFixed(1);
                renderStars(rating);
            }

            // Gọi hàm này khi cần cập nhật điểm trung bình của đánh giá
            const avgRatingFromDB = <%= cj.getAverage_feedking() %>;
            updateAvgRating(avgRatingFromDB);

            console.log('Swimming Pool Dashboard initialized successfully!');
        </script>
    </body>

</html>