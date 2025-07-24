<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Dashboard - Swimming Pool Management System</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <!-- AOS (Animate On Scroll) -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-gradient: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            --warning-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --info-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --dark-gradient: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            --chart-primary: #667eea;
            --chart-secondary: #764ba2;
            --chart-success: #38ef7d;
            --chart-warning: #f5576c;
            --chart-info: #00f2fe;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }

        .dashboard-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
        }
        
        .dashboard-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            right: -50%;
            bottom: -50%;
            background: linear-gradient(45deg, rgba(255,255,255,0.05) 0%, rgba(255,255,255,0) 100%);
            transform: rotate(30deg);
            z-index: 0;
        }
        
        .branch-info {
            background: rgba(255,255,255,0.15);
            border-radius: 15px;
            padding: 1.5rem;
            margin-top: 1rem;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
            position: relative;
            z-index: 1;
            transition: all 0.4s ease;
        }

        .branch-info:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        .user-info {
            background: rgba(255,255,255,0.1);
            border-radius: 10px;
            padding: 1rem;
            backdrop-filter: blur(5px);
            transition: all 0.4s ease;
        }

        .user-info:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .stat-card {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
            border: none;
            z-index: 1;
        }
        
        .stat-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: var(--gradient);
            z-index: -1;
        }

        .stat-card::after {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            bottom: -50%;
            left: -50%;
            background: var(--gradient);
            transform: rotate(45deg);
            opacity: 0.03;
            z-index: -1;
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            margin-bottom: 1rem;
            background: var(--gradient);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
        }
        
        .stat-card:hover .stat-icon {
            transform: rotate(15deg) scale(1.1);
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            color: #2c3e50;
            margin-bottom: 0.5rem;
            line-height: 1;
            transition: all 0.3s ease;
        }
        
        .stat-card:hover .stat-number {
            color: var(--chart-primary);
        }
        
        .stat-label {
            color: #7f8c8d;
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }
        
        .stat-card:hover .stat-label {
            color: #5d6d7e;
        }
        
        .stat-comparison {
            font-size: 0.9rem;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .comparison-up { 
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .comparison-down { 
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .comparison-neutral { 
            background: linear-gradient(135deg, #e2e3e5, #d6d8db);
            color: #383d41;
            border: 1px solid #d6d8db;
        }
        
        .chart-container {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            border: none;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }
        
        .chart-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }
        
        .chart-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: var(--chart-primary);
        }
        
        .chart-title {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: #2c3e50;
            display: flex;
            align-items: center;
            padding-bottom: 1rem;
            border-bottom: 2px solid #ecf0f1;
        }
        
        .dashboard-canvas {
            width: 100% !important;
            max-width: 100%;
            height: 400px !important;
            transition: all 0.3s ease;
        }
        
        .filter-section {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            border: none;
            transition: all 0.4s ease;
        }
        
        .filter-section:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }
        
        .pool-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            border-left: 5px solid #3498db;
            position: relative;
            overflow: hidden;
        }
        
        .pool-card:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
            border-left-color: var(--chart-primary);
        }

        .pool-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 100px;
            height: 100px;
            background: linear-gradient(45deg, rgba(52, 152, 219, 0.1), rgba(46, 204, 113, 0.1));
            border-radius: 50%;
            transform: translate(30px, -30px);
            transition: all 0.5s ease;
        }
        
        .pool-card:hover::before {
            transform: translate(20px, -20px) scale(1.2);
        }
        
        .pool-name {
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 0.5rem;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }
        
        .pool-card:hover .pool-name {
            color: var(--chart-primary);
        }
        
        .pool-stats {
            display: flex;
            justify-content: space-between;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            flex-wrap: wrap;
        }

        .pool-stat-item {
            background: #f8f9fa;
            padding: 0.5rem 1rem;
            border-radius: 10px;
            margin: 0.2rem;
            border: 1px solid #e9ecef;
            transition: all 0.3s ease;
        }
        
        .pool-card:hover .pool-stat-item {
            background: #f1f8fe;
            border-color: #d1e7ff;
        }
        
        .utilization-bar {
            width: 100%;
            height: 12px;
            background: #ecf0f1;
            border-radius: 10px;
            margin: 1rem 0;
            overflow: hidden;
            position: relative;
        }
        
        .utilization-fill {
            height: 100%;
            background: linear-gradient(90deg, #27ae60, #f39c12, #e74c3c);
            transition: width 1s cubic-bezier(0.65, 0, 0.35, 1);
            border-radius: 10px;
            position: relative;
        }

        .utilization-fill::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            animation: shimmer 2s infinite;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }
        
        .revenue-trend { --gradient: var(--primary-gradient); }
        .booking-trend { --gradient: var(--warning-gradient); }
        .customer-trend { --gradient: var(--info-gradient); }
        .rating-trend { --gradient: var(--success-gradient); }
        .pool-trend { --gradient: linear-gradient(135deg, #a8edea, #fed6e3); }
        
        .summary-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .performance-indicator {
            display: inline-block;
            width: 15px;
            height: 15px;
            border-radius: 50%;
            margin-right: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
        }
        
        .indicator-excellent { background: linear-gradient(45deg, #27ae60, #2ecc71); }
        .indicator-good { background: linear-gradient(45deg, #3498db, #5dade2); }
        .indicator-average { background: linear-gradient(45deg, #f39c12, #f7dc6f); }
        .indicator-poor { background: linear-gradient(45deg, #e74c3c, #ec7063); }

        .btn-gradient {
            background: var(--primary-gradient);
            border: none;
            color: white;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-gradient:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            color: white;
        }

        .btn-gradient::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            right: -50%;
            bottom: -50%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.3), transparent);
            transform: rotate(45deg);
            opacity: 0;
            transition: all 0.5s ease;
        }

        .btn-gradient:hover::after {
            opacity: 1;
            animation: shine 1.5s infinite;
        }

        @keyframes shine {
            0% { transform: translateX(-100%) rotate(45deg); }
            100% { transform: translateX(100%) rotate(45deg); }
        }

        .quick-stats {
            background: rgba(255,255,255,0.9);
            border-radius: 15px;
            padding: 1rem;
            margin-bottom: 1rem;
            transition: all 0.4s ease;
        }

        .quick-stats:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .loading-spinner {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 9999;
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(5px);
        }

        .spinner {
            width: 50px;
            height: 50px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid #3498db;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .live-clock {
            font-family: 'Courier New', monospace;
            font-weight: bold;
            color: #ecf0f1;
            background: rgba(0,0,0,0.2);
            padding: 0.5rem 1rem;
            border-radius: 10px;
            margin-top: 0.5rem;
            transition: all 0.3s ease;
        }

        .user-info:hover .live-clock {
            background: rgba(0,0,0,0.3);
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.8rem;
            transition: all 0.3s ease;
        }

        .status-active {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
        }

        .status-inactive {
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            color: #721c24;
        }

        .alert {
            transition: all 0.5s ease;
        }

        .alert:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb {
            background: var(--chart-primary);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--chart-secondary);
        }

        /* Floating animation for important elements */
        .floating {
            animation: floating 3s ease-in-out infinite;
        }

        @keyframes floating {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }

        /* Pulse animation for notifications */
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        /* Custom chart tooltip style */
        .chartjs-tooltip {
            background: rgba(0, 0, 0, 0.7);
            border-radius: 5px;
            color: white;
            opacity: 1;
            pointer-events: none;
            position: absolute;
            transform: translate(-50%, 0);
            transition: all .1s ease;
            padding: 10px;
            font-size: 14px;
        }

        .chartjs-tooltip-key {
            display: inline-block;
            width: 10px;
            height: 10px;
            margin-right: 5px;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .dashboard-header {
                padding: 1rem 0;
            }
            
            .stat-card {
                padding: 1.5rem;
            }
            
            .chart-container {
                padding: 1.5rem;
            }
            
            .summary-cards {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            
            .pool-card {
                padding: 1.25rem;
            }
        }
    </style>
</head>


<body>
    <!-- Loading Spinner -->
    <div class="loading-spinner" id="loadingSpinner">
        <div class="spinner"></div>
    </div>

    <!-- Error Alerts -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show position-fixed top-0 end-0 m-3" style="z-index: 1000;">
            <i class="fas fa-exclamation-triangle me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <!-- Header -->
    <div class="dashboard-header animate__animated animate__fadeInDown" data-aos="fade-down">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <a class="btn btn-info btn-gradient mb-3" href="managerPanel.jsp">
                        <i class="bi bi-arrow-left-square-fill me-2"></i> Quay lại các chức năng quản lí
                    </a>
                    <h1 class="mb-3">
                        <i class="fas fa-tachometer-alt me-3"></i>Manager Dashboard
                    </h1>
                     
                    <p class="mb-0 fs-5">Quản lý và theo dõi hiệu suất chi nhánh ${branch.branchName}</p>
                    
                    <div class="branch-info animate__animated animate__fadeInUp" data-aos="fade-up">
                        <div class="row align-items-center">
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-building me-2 fs-5"></i>
                                    <div>
                                        <small class="text-light opacity-75">Chi nhánh</small>
                                        <div class="fw-bold">${branch.branchName}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-user-tie me-2 fs-5"></i>
                                    <div>
                                        <small class="text-light opacity-75">Manager</small>
                                        <div class="fw-bold">${currentUser}</div>
                                    </div>
                                </div>
                            </div>
<!--                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-swimming-pool me-2 fs-5"></i>
                                    <div>
                                        <small class="text-light opacity-75">Số hồ bơi</small>
                                        <div class="fw-bold">
                                            <c:choose>
                                                <c:when test="${poolStats != null}">
                                                    ${poolStats.size()}/5 hồ
                                                </c:when>
                                                <c:otherwise>
                                                    0/5 hồ
                                                </c:otherwise>
                                            </c:choose>
                                         </div>
                                    </div>
                                </div>
                            </div>-->
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 text-end">
                    <div class="user-info">
                        <div class="d-flex align-items-center justify-content-end mb-2">
                            <i class="fas fa-user-circle me-2 fs-4"></i>
                            <div>
                                <small class="text-light opacity-75">Đăng nhập bởi</small>
                                <div class="fw-bold">${currentUser}</div>
                            </div>
                        </div>
                        <div class="live-clock" id="liveClock">
                            <i class="fas fa-clock me-1"></i>
                            <span id="currentTime"></span>
                        </div>
                        <div class="mt-2">
                            <small class="text-light opacity-75">Server Time (UTC):</small>
                            <div class="fw-bold">${currentDateTimeUTC}</div>
                        </div>
                        <div class="mt-1">
                            <small class="text-light opacity-75">Cập nhật lần cuối:</small>
                            <div class="fw-bold" id="lastUpdate"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <!-- Filter Section -->
        <div class="filter-section animate__animated animate__fadeInUp" data-aos="fade-up">
            <div class="row align-items-center">
                <div class="col-lg-3 col-md-6 mb-3">
                    <label class="form-label fw-bold">
                        <i class="fas fa-calendar me-1"></i>Thời gian thống kê:
                    </label>
                    <select class="form-select" id="periodSelect" onchange="changePeriod()">
                        <option value="daily" ${selectedPeriod == 'daily' ? 'selected' : ''}>30 ngày gần nhất</option>
                        <option value="weekly" ${selectedPeriod == 'weekly' ? 'selected' : ''}>12 tuần gần nhất</option>
                        <option value="monthly" ${selectedPeriod == 'monthly' ? 'selected' : ''}>12 tháng gần nhất</option>
                    </select>
                </div>
<!--                <div class="col-lg-5 col-md-6 mb-3">
                    <label class="form-label fw-bold">
                        <i class="fas fa-tools me-1"></i>Thao tác nhanh:
                    </label>
                    <div class="d-flex gap-2 flex-wrap">
                        <button class="btn btn-gradient" onclick="refreshData()">
                            <i class="fas fa-sync-alt me-2"></i>Làm mới
                        </button>
                        <button class="btn btn-success btn-gradient" onclick="exportData()">
                            <i class="fas fa-download me-2"></i>Xuất báo cáo
                        </button>
                        <button class="btn btn-info btn-gradient" onclick="viewFullAnalysis()">
                            <i class="fas fa-chart-line me-2"></i>Phân tích chi tiết
                        </button>
                    </div>
                </div>-->
                <div class="col-lg-4 mb-3">
                    <div class="quick-stats">
                        <div class="row text-center">
                            <div class="col-4">
                                <div class="d-flex flex-column align-items-center">
                                    <i class="fas fa-water text-primary mb-1"></i>
                                    <small class="text-muted">Tổng hồ bơi</small>
                                    <div class="h5 mb-0 text-primary fw-bold">
                                        <c:choose>
                                            <c:when test="${poolStats != null}">
                                                ${poolStats.size()}
                                            </c:when>
                                            <c:otherwise>
                                                0/5
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="d-flex flex-column align-items-center">
                                    <i class="fas fa-check-circle text-success mb-1"></i>
                                    <small class="text-muted">Hoạt động</small>
                                    <div class="h5 mb-0 text-success fw-bold">
                                        <c:set var="activeCount" value="0"/>
                                        <c:if test="${poolStats != null}">
                                            <c:forEach var="pool" items="${poolStats}">
                                                <c:if test="${pool.status == 'Active'}">
                                                    <c:set var="activeCount" value="${activeCount + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                        ${activeCount}
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Summary Stats Cards -->
        <c:if test="${stats != null}">
            <div class="summary-cards">
                <div class="stat-card revenue-trend animate__animated animate__fadeInUp" data-aos="fade-up" data-aos-delay="100">
                    <div class="stat-icon">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="stat-number">
                        <fmt:formatNumber value="${stats.totalRevenue}" type="currency" 
                                        currencySymbol="" pattern="#,##0"/>₫
                    </div>
                    <div class="stat-label">Doanh Thu Tổng</div>
<c:if test="${previousStats != null && previousStats.totalRevenue != null}">
    <c:set var="revenueGrowth" value="${previousStats.totalRevenue > 0
        ? (stats.totalRevenue - previousStats.totalRevenue) * 100.0 / previousStats.totalRevenue
        : 100.0}"/>
    <div class="stat-comparison ${revenueGrowth > 0 ? 'comparison-up' : (revenueGrowth < 0 ? 'comparison-down' : 'comparison-neutral')}">
        <i class="fas fa-arrow-${revenueGrowth > 0 ? 'up' : (revenueGrowth < 0 ? 'down' : 'right')}"></i>
        <fmt:formatNumber value="${revenueGrowth}" pattern="#.##"/>%
        so với
        <c:choose>
            <c:when test="${selectedPeriod == 'monthly'}">12 tháng trước</c:when>
            <c:when test="${selectedPeriod == 'weekly'}">12 tuần trước</c:when>
            <c:otherwise>30 ngày trước</c:otherwise>
        </c:choose>
        <c:if test="${previousStats.totalRevenue == 0}">
            <span class="text-success ms-2">(Vượt trội)</span>
        </c:if>
    </div>
</c:if>
                </div>
                
                <div class="stat-card booking-trend animate__animated animate__fadeInUp" data-aos="fade-up" data-aos-delay="200">
                    <div class="stat-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-number">${stats.totalBookings}</div>
                    <div class="stat-label">Tổng Booking</div>
<c:if test="${previousStats != null}">
    <c:set var="bookingGrowth" value="${previousStats.totalBookings > 0
        ? (stats.totalBookings - previousStats.totalBookings) * 100.0 / previousStats.totalBookings
        : 100.0}"/>
    <div class="stat-comparison ${bookingGrowth > 0 ? 'comparison-up' : (bookingGrowth < 0 ? 'comparison-down' : 'comparison-neutral')}">
        <i class="fas fa-arrow-${bookingGrowth > 0 ? 'up' : (bookingGrowth < 0 ? 'down' : 'right')}"></i>
        <fmt:formatNumber value="${bookingGrowth}" pattern="#.##"/>%
        so với
        <c:choose>
            <c:when test="${selectedPeriod == 'monthly'}">12 tháng trước</c:when>
            <c:when test="${selectedPeriod == 'weekly'}">12 tuần trước</c:when>
            <c:otherwise>30 ngày trước</c:otherwise>
        </c:choose>
        <c:if test="${previousStats.totalBookings == 0}">
            <span class="text-success ms-2">(Vượt trội)</span>
        </c:if>
    </div>
</c:if>
                </div>
                
                <div class="stat-card customer-trend animate__animated animate__fadeInUp" data-aos="fade-up" data-aos-delay="300">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-number">${stats.totalCustomers}</div>
                    <div class="stat-label">Khách Hàng</div>
<c:if test="${previousStats != null}">
    <c:set var="customerGrowth" value="${previousStats.totalCustomers > 0
        ? (stats.totalCustomers - previousStats.totalCustomers) * 100.0 / previousStats.totalCustomers
        : 100.0}"/>
    <div class="stat-comparison ${customerGrowth > 0 ? 'comparison-up' : (customerGrowth < 0 ? 'comparison-down' : 'comparison-neutral')}">
        <i class="fas fa-arrow-${customerGrowth > 0 ? 'up' : (customerGrowth < 0 ? 'down' : 'right')}"></i>
        <fmt:formatNumber value="${customerGrowth}" pattern="#.##"/>%
        so với
        <c:choose>
            <c:when test="${selectedPeriod == 'monthly'}">12 tháng trước</c:when>
            <c:when test="${selectedPeriod == 'weekly'}">12 tuần trước</c:when>
            <c:otherwise>30 ngày trước</c:otherwise>
        </c:choose>
        <c:if test="${previousStats.totalCustomers == 0}">
            <span class="text-success ms-2">(Vượt trội)</span>
        </c:if>
    </div>
</c:if>
                </div>
                
                <div class="stat-card rating-trend animate__animated animate__fadeInUp" data-aos="fade-up" data-aos-delay="400">
                    <div class="stat-icon">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="stat-number">
                        <fmt:formatNumber value="${stats.avgRating}" pattern="#.#"/>
                    </div>
                    <div class="stat-label">Đánh Giá Trung Bình</div>
                    <div class="stat-comparison">
                        <c:choose>
                            <c:when test="${stats.avgRating >= 4.5}">
                                <span class="comparison-up">
                                    <i class="fas fa-trophy"></i>Xuất sắc
                                </span>
                            </c:when>
                            <c:when test="${stats.avgRating >= 4.0}">
                                <span class="comparison-up">
                                    <i class="fas fa-thumbs-up"></i>Tốt
                                </span>
                            </c:when>
                            <c:when test="${stats.avgRating >= 3.5}">
                                <span class="comparison-neutral">
                                    <i class="fas fa-hand-paper"></i>Khá
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="comparison-down">
                                    <i class="fas fa-exclamation-triangle"></i>Cần cải thiện
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <div class="stat-card pool-trend animate__animated animate__fadeInUp" data-aos="fade-up" data-aos-delay="500">
                    <div class="stat-icon">
                        <i class="fas fa-swimming-pool"></i>
                    </div>
                    <div class="stat-number">${stats.totalPools}</div>
                    <div class="stat-label">Hồ Bơi Hoạt Động</div>
<!--                    <div class="stat-comparison comparison-neutral">
                        <c:if test="${poolStats != null && poolStats.size() > 0}">
                            <c:set var="avgUtilization" value="0"/>
                            <c:forEach var="pool" items="${poolStats}">
                                <c:set var="avgUtilization" value="${avgUtilization + pool.utilizationRate}"/>
                            </c:forEach>
                            <i class="fas fa-chart-bar"></i>
                            <fmt:formatNumber value="${avgUtilization / poolStats.size()}" pattern="#.#"/>% tỷ lệ sử dụng TB
                        </c:if>
                    </div>-->
                </div>
            </div>
        </c:if>

        <!-- Charts Row 1 - Revenue and Peak Hours -->
        <div class="row">
            <div class="col-lg-8">
                <div class="chart-container animate__animated animate__fadeInLeft" data-aos="fade-right">
                    <div class="chart-title">
                        <i class="fas fa-chart-bar me-3"></i>Doanh Thu Chi Nhánh
                        <div class="ms-auto">
                            <div class="btn-group btn-group-sm">
                                <button class="btn btn-outline-primary active" onclick="changeRevenueChartType('line')">Đường</button>
                                <button class="btn btn-outline-primary" onclick="changeRevenueChartType('bar')">Cột</button>
                            </div>
                        </div>
                    </div>
                    <canvas id="revenueChart" class="dashboard-canvas"></canvas>
                    <div id="revenueChartAlert"></div>
                </div>
            </div>
             <div class="col-lg-4">
                <div class="chart-container animate__animated animate__fadeInLeft" data-aos="fade-right">
                    <div class="chart-title">
                        <i class="fas fa-swimming-pool me-3"></i>Doanh thu từng Hồ Bơi
                        <div class="ms-auto">
                            <div class="btn-group btn-group-sm">
                                <button class="btn btn-outline-primary active" onclick="changePoolChartType('bar')">Cột</button>
                                <button class="btn btn-outline-primary" onclick="changePoolChartType('radar')">Radar</button>
                            </div>
                        </div>
                    </div>
                    <canvas id="poolPerformanceChart" class="dashboard-canvas"></canvas>
                    <div id="poolPerformanceChartAlert"></div>
                </div>
            </div>
            
        </div>
        
        
        <!-- Pool Details Section -->
        <c:if test="${poolStats != null && poolStats.size() > 0}">
            <div class="chart-container animate__animated animate__fadeInUp" data-aos="fade-up">
                <div class="chart-title">
                    <i class="fas fa-water me-3"></i>Chi Tiết Từng Hồ Bơi
                    <div class="ms-auto">
                        <span class="badge bg-info">${poolStats.size()} hồ bơi trong chi nhánh</span>
                    </div>
                </div>
                <div class="row">
                    <c:forEach var="pool" items="${poolStats}" varStatus="status">
                        <div class="col-lg-4 col-md-6">
                            <div class="pool-card animate__animated animate__fadeInUp" data-aos="fade-up" data-aos-delay="${status.index * 100}">
                                <div class="pool-name">
                                    <i class="fas fa-swimming-pool me-2 text-primary"></i>
                                    ${pool.poolName}
                                </div>
                                <div class="text-muted small mb-3">
                                    <i class="fas fa-map-marker-alt me-1"></i>${pool.poolAddress}
                                </div>
                                
                                <div class="pool-stats">
                                    <div class="pool-stat-item">
                                        <strong>Doanh thu:</strong> 
                                        <span class="text-success fw-bold">
                                            <fmt:formatNumber value="${pool.revenue}" pattern="#,##0"/>₫
                                        </span>
                                    </div>
                                    <div class="pool-stat-item">
                                        <strong>Booking:</strong> 
                                        <span class="text-primary fw-bold">${pool.totalBookings}</span>
                                    </div>
                                </div>
                                
                                <div class="pool-stats">
                                    <div class="pool-stat-item">
                                        <strong>Khách hàng:</strong> 
                                        <span class="text-info fw-bold">${pool.totalCustomers}</span>
                                    </div>
                                    <div class="pool-stat-item">
                                        <strong>Rating:</strong> 
                                        <span class="text-warning fw-bold">
                                            <fmt:formatNumber value="${pool.avgRating}" pattern="#.#"/>
                                            <i class="fas fa-star"></i>
                                        </span>
                                    </div>
                                </div>
                                
                                <div class="utilization-bar">
                                    <div class="utilization-fill" style="width: ${pool.utilizationRate > 100 ? 100 : pool.utilizationRate}%"></div>
                                </div>
                                <div class="d-flex justify-content-between small text-muted mb-3">
<!--                                    <span>
                                        <strong>Tỷ lệ sử dụng:</strong> 
                                        <span class="fw-bold text-dark">
                                            <fmt:formatNumber value="${pool.utilizationRate}" pattern="#.#"/>%
                                        </span>
                                    </span>-->
                                    <span>
                                        <strong>Max:</strong> ${pool.maxSlot} slots
                                    </span>
                                </div>
                                
                                <div class="d-flex justify-content-between align-items-center">
                                    <small class="text-muted">
                                        <i class="fas fa-clock me-1"></i>
                                        ${pool.openTime} - ${pool.closeTime}
                                    </small>
                                    <span class="status-badge ${pool.status == 'Active' ? 'status-active' : 'status-inactive'}">
                                        <i class="fas fa-${pool.status == 'Active' ? 'check-circle' : 'pause-circle'} me-1"></i>
                                        ${pool.status}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    
                    <div class="col-lg-4">
                <div class="chart-container animate__animated animate__fadeInRight" data-aos="fade-left">
                    <div class="chart-title">
                        <i class="fas fa-clock me-3"></i>Khung Giờ Cao Điểm
                    </div>
                    <canvas id="peakHourChart" class="dashboard-canvas"></canvas>
                    <div id="peakHourChartAlert"></div>
                </div>
                        
            </div>
                    
                    
                </div>
                    
                    
            </div>
        </c:if>
        
        
        
        
        

<!--         Charts Row 2 - Pool Performance and Customer Trend 
        <div class="row">
           
            <div class="col-lg-6">
                <div class="chart-container animate__animated animate__fadeInRight" data-aos="fade-left">
                    <div class="chart-title">
                        <i class="fas fa-users-cog me-3"></i>Xu Hướng Khách Hàng
                        <div class="ms-auto">
                            <div class="btn-group btn-group-sm">
                                <button class="btn btn-outline-primary active" onclick="changeCustomerTrendType('line')">Đường</button>
                                <button class="btn btn-outline-primary" onclick="changeCustomerTrendType('area')">Vùng</button>
                            </div>
                        </div>
                    </div>
                    <canvas id="customerTrendChart" class="dashboard-canvas"></canvas>
                    <div id="customerTrendChartAlert"></div>
                </div>
            </div>
        </div>
        
         Charts Row 3 - Top Customers and Booking Status 
        <div class="row">
            <div class="col-lg-6">
                <div class="chart-container animate__animated animate__fadeInLeft" data-aos="fade-right">
                    <div class="chart-title">
                        <i class="fas fa-trophy me-3"></i>Top Khách Hàng VIP
                    </div>
                    <canvas id="topCustomersChart" class="dashboard-canvas"></canvas>
                    <div id="topCustomersChartAlert"></div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="chart-container animate__animated animate__fadeInRight" data-aos="fade-left">
                    <div class="chart-title">
                        <i class="fas fa-chart-pie me-3"></i>Trạng Thái Booking
                        <div class="ms-auto">
                            <div class="btn-group btn-group-sm">
                                <button class="btn btn-outline-primary active" onclick="changeBookingChartType('pie')">Tròn</button>
                                <button class="btn btn-outline-primary" onclick="changeBookingChartType('doughnut')">Vành</button>
                            </div>
                        </div>
                    </div>
                    <canvas id="bookingStatusChart" class="dashboard-canvas"></canvas>
                    <div id="bookingStatusChartAlert"></div>
                </div>
            </div>
        </div>-->

        
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <script>
    // Initialize AOS (Animate On Scroll)
    AOS.init({
        duration: 800,
        easing: 'ease-in-out',
        once: true,
        offset: 100
    });

    // Global variables
    var revenueChart, peakHourChart, poolPerformanceChart, customerTrendChart, topCustomersChart, bookingStatusChart;
    var currentPeriod = '${selectedPeriod}';
    var revenueChartType = 'line';
    var poolChartType = 'bar';
    var customerTrendType = 'line';
    var bookingChartType = 'pie';
    
    // Initialize when page loads
    document.addEventListener('DOMContentLoaded', function() {
        updateLiveClock();
        updateLastUpdateTime();
        loadAllCharts();
        startClockUpdater();
    });
    
    function updateLiveClock() {
        var now = new Date();
        var options = {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: false,
            timeZone: 'Asia/Ho_Chi_Minh'
        };
        document.getElementById('currentTime').textContent = now.toLocaleString('vi-VN', options);
    }
    
    function startClockUpdater() {
        setInterval(updateLiveClock, 1000);
    }
    
    function updateLastUpdateTime() {
        var now = new Date();
        var options = {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: false,
            timeZone: 'Asia/Ho_Chi_Minh'
        };
        document.getElementById('lastUpdate').textContent = now.toLocaleString('vi-VN', options);
    }
    
    function showLoading() {
        document.getElementById('loadingSpinner').style.display = 'flex';
    }
    
    function hideLoading() {
        document.getElementById('loadingSpinner').style.display = 'none';
    }
    
    function changePeriod() {
        var period = document.getElementById('periodSelect').value;
        showLoading();
        window.location.href = 'managerDashBoardServlet?period=' + period;
    }
    
    function refreshData() {
        showLoading();
        loadAllCharts();
        updateLastUpdateTime();
        setTimeout(function() {
            hideLoading();
            showNotification('Dữ liệu đã được cập nhật!', 'success');
        }, 1500);
    }
    
    function exportData() {
        var message = 'Tính năng xuất báo cáo đang được phát triển!' + '\n' +
                     'Sẽ bao gồm:' + '\n' +
                     '- Báo cáo doanh thu chi tiết' + '\n' +
                     '- Phân tích khách hàng' + '\n' +
                     '- Hiệu suất từng hồ bơi';
        showNotification(message, 'info');
    }
    
    function viewFullAnalysis() {
        var message = 'Tính năng phân tích chi tiết đang được phát triển!' + '\n' +
                     'Sẽ bao gồm:' + '\n' +
                     '- Dự báo xu hướng' + '\n' +
                     '- So sánh với các chi nhánh khác' + '\n' +
                     '- Khuyến nghị cải thiện';
        showNotification(message, 'info');
    }
    
    function showNotification(message, type) {
        type = type || 'info';
        var alertClass = type === 'success' ? 'alert-success' : type === 'error' ? 'alert-danger' : 'alert-info';
        var icon = type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-triangle' : 'info-circle';
        
        var notification = document.createElement('div');
        notification.className = 'alert ' + alertClass + ' alert-dismissible fade show position-fixed pulse';
        notification.style.cssText = 'top: 20px; right: 20px; z-index: 10000; min-width: 300px;';
        
        var messageHtml = message.replace(/\n/g, '<br>');
        notification.innerHTML = '<i class="fas fa-' + icon + ' me-2"></i>' +
                               messageHtml +
                               '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
        
        document.body.appendChild(notification);
        
        setTimeout(function() {
            if (notification.parentNode) {
                notification.classList.remove('pulse');
                notification.classList.add('animate__animated', 'animate__fadeOutRight');
                setTimeout(function() {
                    if (notification.parentNode) {
                        notification.remove();
                    }
                }, 500);
            }
        }, 5000);
    }
    
    function changeRevenueChartType(type) {
        revenueChartType = type;
        document.querySelectorAll('#revenueChart + .chart-title .btn-group .btn').forEach(btn => {
            btn.classList.remove('active');
        });
        event.target.classList.add('active');
        loadRevenueChart();
    }
    
    function changePoolChartType(type) {
        poolChartType = type;
        document.querySelectorAll('#poolPerformanceChart + .chart-title .btn-group .btn').forEach(btn => {
            btn.classList.remove('active');
        });
        event.target.classList.add('active');
        loadPoolPerformanceChart();
    }
    
    function changeCustomerTrendType(type) {
        customerTrendType = type;
        document.querySelectorAll('#customerTrendChart + .chart-title .btn-group .btn').forEach(btn => {
            btn.classList.remove('active');
        });
        event.target.classList.add('active');
        loadCustomerTrendChart();
    }
    
    function changeBookingChartType(type) {
        bookingChartType = type;
        document.querySelectorAll('#bookingStatusChart + .chart-title .btn-group .btn').forEach(btn => {
            btn.classList.remove('active');
        });
        event.target.classList.add('active');
        loadBookingStatusChart();
    }
    
    function loadAllCharts() {
        Promise.all([
            loadRevenueChart(),
            loadPeakHourChart(),
            loadPoolPerformanceChart(),
            loadCustomerTrendChart(),
            loadTopCustomersChart(),
            loadBookingStatusChart()
        ]).then(function() {
            hideLoading();
        }).catch(function(error) {
            console.error('Error loading charts:', error);
            hideLoading();
            showNotification('Có lỗi xảy ra khi tải dữ liệu biểu đồ', 'error');
        });
    }
    
    // Chart loading functions
    function loadRevenueChart() {
        return fetch('managerDashBoardServlet?action=revenue-data&period=' + currentPeriod)
            .then(function(response) { return response.json(); })
            .then(function(data) {
                var container = document.getElementById('revenueChart').parentNode;
                var canvas = document.getElementById('revenueChart');
                if (!data || data.length === 0) {
                    if (revenueChart) {
                        revenueChart.destroy();
                        revenueChart = null;
                    }
                    canvas.style.display = "none";
                    showChartInfo('revenueChartAlert', 'Không có dữ liệu doanh thu.');
                    return;
                }
                canvas.style.display = "block";
                document.getElementById('revenueChartAlert').innerHTML = '';
                var ctx = canvas.getContext('2d');
                if (revenueChart) {
                    revenueChart.destroy();
                }
                
                // Custom gradient for line chart
                var gradient = ctx.createLinearGradient(0, 0, 0, 400);
                gradient.addColorStop(0, 'rgba(102, 126, 234, 0.3)');
                gradient.addColorStop(1, 'rgba(102, 126, 234, 0)');
                
                revenueChart = new Chart(ctx, {
                    type: revenueChartType,
                    data: {
                        labels: data.map(function(item) { return item.label; }),
                        datasets: [{
                            label: 'Doanh Thu (₫)',
                            data: data.map(function(item) { return item.value; }),
                            borderColor: '#667eea',
                            backgroundColor: revenueChartType === 'line' ? gradient : '#667eea',
                            borderWidth: revenueChartType === 'line' ? 4 : 1,
                            fill: revenueChartType === 'line',
                            tension: 0.4,
                            pointBackgroundColor: '#fff',
                            pointBorderColor: '#667eea',
                            pointBorderWidth: 2,
                            pointRadius: 4,
                            pointHoverRadius: 6
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: { 
                            y: { 
                                beginAtZero: true,
                                grid: { color: 'rgba(0, 0, 0, 0.05)' }
                            },
                            x: {
                                grid: { display: false }
                            }
                        },
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return 'Doanh thu: ' + context.parsed.y.toLocaleString() + '₫';
                                    }
                                }
                            }
                        },
                        animation: {
                            duration: 1000,
                            easing: 'easeOutQuart'
                        }
                    }
                });
            })
            .catch(function(error) {
                var container = document.getElementById('revenueChart').parentNode;
                var canvas = document.getElementById('revenueChart');
                if (revenueChart) {
                    revenueChart.destroy();
                    revenueChart = null;
                }
                canvas.style.display = "none";
                showChartError('revenueChartAlert', "Lỗi lấy dữ liệu: " + error);
            });
    }
    
    function loadPeakHourChart() {
        return fetch('managerDashBoardServlet?action=peak-hour')
            .then(response => response.json())
            .then(data => {
                const alertDiv = document.getElementById('peakHourChartAlert');
                alertDiv.innerHTML = '';
                const canvas = document.getElementById('peakHourChart');
                canvas.style.display = "block";
                if (!data || data.length === 0) {
                    if (peakHourChart) peakHourChart.destroy();
                    canvas.style.display = "none";
                    showChartInfo('peakHourChartAlert', 'Không có dữ liệu khung giờ cao điểm!');
                    return;
                }
                if (peakHourChart) peakHourChart.destroy();
                const ctx = canvas.getContext('2d');
                
                // Sort data by hour for better visualization
                data.sort((a, b) => parseInt(a.label) - parseInt(b.label));
                
                peakHourChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: data.map(item => item.label + 'h'),
                        datasets: [{
                            label: 'Số lượng booking',
                            data: data.map(item => item.value),
                            backgroundColor: data.map(item => item.color || '#667eea'),
                            borderColor: data.map(item => item.borderColor || '#764ba2'),
                            borderWidth: 1,
                            borderRadius: 5
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { display: false },
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return 'Số booking: ' + context.parsed.y;
                                    }
                                }
                            }
                        },
                        scales: { 
                            y: { 
                                beginAtZero: true,
                                grid: { color: 'rgba(0, 0, 0, 0.05)' }
                            },
                            x: {
                                grid: { display: false }
                            }
                        },
                        animation: {
                            duration: 1000,
                            easing: 'easeOutQuart'
                        }
                    }
                });
            })
            .catch(error => {
                showChartError('peakHourChartAlert', 'Lỗi tải dữ liệu: ' + error);
                const canvas = document.getElementById('peakHourChart');
                canvas.style.display = "none";
                if (peakHourChart) peakHourChart.destroy();
            });
    }
    
    function loadPoolPerformanceChart() {
        return fetch('managerDashBoardServlet?action=pool-performance&period=monthly')
            .then(response => response.json())
            .then(data => {
                const alertDiv = document.getElementById('poolPerformanceChartAlert');
                alertDiv.innerHTML = '';
                const canvas = document.getElementById('poolPerformanceChart');
                canvas.style.display = "block";
                if (!data || data.length === 0) {
                    if (poolPerformanceChart) poolPerformanceChart.destroy();
                    canvas.style.display = "none";
                    showChartInfo('poolPerformanceChartAlert', 'Không có dữ liệu hiệu suất hồ bơi!');
                    return;
                }
                if (poolPerformanceChart) poolPerformanceChart.destroy();
                const ctx = canvas.getContext('2d');
                
                poolPerformanceChart = new Chart(ctx, {
                    type: poolChartType,
                    data: {
                        labels: data.map(item => item.label),
                        datasets: [{
                            label: 'Doanh Thu (₫)',
                            data: data.map(item => item.value),
                            backgroundColor: poolChartType === 'radar' ? 'rgba(102, 126, 234, 0.2)' : '#667eea',
                            borderColor: '#667eea',
                            borderWidth: poolChartType === 'radar' ? 2 : 1,
                            pointBackgroundColor: '#fff',
                            pointBorderColor: '#667eea',
                            pointBorderWidth: 2,
                            pointRadius: 4,
                            pointHoverRadius: 6
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: poolChartType === 'radar' ? {} : { 
                            y: { 
                                beginAtZero: true,
                                grid: { color: 'rgba(0, 0, 0, 0.05)' }
                            },
                            x: {
                                grid: { display: false }
                            }
                        },
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return 'Doanh thu: ' + context.parsed.y.toLocaleString() + '₫';
                                    }
                                }
                            }
                        },
                        animation: {
                            duration: 1000,
                            easing: 'easeOutQuart'
                        }
                    }
                });
            })
            .catch(error => {
                showChartError('poolPerformanceChartAlert', 'Lỗi tải dữ liệu: ' + error);
                const canvas = document.getElementById('poolPerformanceChart');
                canvas.style.display = "none";
                if (poolPerformanceChart) poolPerformanceChart.destroy();
            });
    }

//    function loadCustomerTrendChart() {
//        return fetch('managerDashBoardServlet?action=customer-trend&period=monthly')
//            .then(response => response.json())
//            .then(data => {
//                const alertDiv = document.getElementById('customerTrendChartAlert');
//                alertDiv.innerHTML = '';
//                const canvas = document.getElementById('customerTrendChart');
//
//                if (!Array.isArray(data)) {
//                    if (data && data.error) {
//                        showChartError('customerTrendChartAlert', 'Lỗi tải dữ liệu: ' + data.error);
//                    } else {
//                        showChartError('customerTrendChartAlert', 'Lỗi dữ liệu không hợp lệ!');
//                    }
//                    canvas.style.display = "none";
//                    if (customerTrendChart) customerTrendChart.destroy();
//                    return;
//                }
//
//                canvas.style.display = "block";
//                if (data.length === 0) {
//                    if (customerTrendChart) customerTrendChart.destroy();
//                    canvas.style.display = "none";
//                    showChartInfo('customerTrendChartAlert', 'Không có dữ liệu xu hướng khách hàng!');
//                    return;
//                }
//                if (customerTrendChart) customerTrendChart.destroy();
//                const ctx = canvas.getContext('2d');
//                
//                // Create gradients for area chart
//                var newCustomersGradient = ctx.createLinearGradient(0, 0, 0, 400);
//                newCustomersGradient.addColorStop(0, 'rgba(54, 162, 235, 0.3)');
//                newCustomersGradient.addColorStop(1, 'rgba(54, 162, 235, 0)');
//                
//                var returningCustomersGradient = ctx.createLinearGradient(0, 0, 0, 400);
//                returningCustomersGradient.addColorStop(0, 'rgba(255, 99, 132, 0.3)');
//                returningCustomersGradient.addColorStop(1, 'rgba(255, 99, 132, 0)');
//                
//                customerTrendChart = new Chart(ctx, {
//                    type: customerTrendType === 'area' ? 'line' : customerTrendType,
//                    data: {
//                        labels: data.map(item => item.periodLabel || item.label),
//                        datasets: [{
//                            label: 'Khách mới',
//                            data: data.map(item => item.newCustomers || item.value),
//                            borderColor: '#36A2EB',
//                            backgroundColor: customerTrendType === 'area' ? newCustomersGradient : 'rgba(54, 162, 235, 0.2)',
//                            borderWidth: 3,
//                            fill: customerTrendType === 'area',
//                            tension: 0.4,
//                            pointBackgroundColor: '#fff',
//                            pointBorderColor: '#36A2EB',
//                            pointBorderWidth: 2,
//                            pointRadius: 4,
//                            pointHoverRadius: 6
//                        }, {
//                            label: 'Khách quay lại',
//                            data: data.map(item => item.returningCustomers || 0),
//                            borderColor: '#FF6384',
//                            backgroundColor: customerTrendType === 'area' ? returningCustomersGradient : 'rgba(255, 99, 132, 0.2)',
//                            borderWidth: 3,
//                            fill: customerTrendType === 'area',
//                            tension: 0.4,
//                            pointBackgroundColor: '#fff',
//                            pointBorderColor: '#FF6384',
//                            pointBorderWidth: 2,
//                            pointRadius: 4,
//                            pointHoverRadius: 6
//                        }]
//                    },
//                    options: {
//                        responsive: true,
//                        maintainAspectRatio: false,
//                        scales: { 
//                            y: { 
//                                beginAtZero: true,
//                                grid: { color: 'rgba(0, 0, 0, 0.05)' }
//                            },
//                            x: {
//                                grid: { display: false }
//                            }
//                        },
//                        plugins: {
//                            tooltip: {
//                                callbacks: {
//                                    label: function(context) {
//                                        return context.dataset.label + ': ' + context.parsed.y;
//                                    }
//                                }
//                            }
//                        },
//                        animation: {
//                            duration: 1000,
//                            easing: 'easeOutQuart'
//                        }
//                    }
//                });
//            })
//            .catch(error => {
//                showChartError('customerTrendChartAlert', 'Lỗi tải dữ liệu: ' + error);
//                const canvas = document.getElementById('customerTrendChart');
//                canvas.style.display = "none";
//                if (customerTrendChart) customerTrendChart.destroy();
//            });
//    }

//    function loadTopCustomersChart() {
//        return fetch('managerDashBoardServlet?action=top-customers')
//            .then(response => response.json())
//            .then(data => {
//                const alertDiv = document.getElementById('topCustomersChartAlert');
//                alertDiv.innerHTML = '';
//                const canvas = document.getElementById('topCustomersChart');
//                canvas.style.display = "block";
//                if (!data || data.length === 0) {
//                    if (topCustomersChart) topCustomersChart.destroy();
//                    canvas.style.display = "none";
//                    showChartInfo('topCustomersChartAlert', 'Không có dữ liệu top khách hàng!');
//                    return;
//                }
//                if (topCustomersChart) topCustomersChart.destroy();
//                const ctx = canvas.getContext('2d');
//                
//                // Sort data by value descending
//                data.sort((a, b) => b.value - a.value);
//                
//                topCustomersChart = new Chart(ctx, {
//                    type: 'bar',
//                    data: {
//                        labels: data.map(item => item.label),
//                        datasets: [{
//                            label: 'Doanh Thu (₫)',
//                            data: data.map(item => item.value),
//                            backgroundColor: data.map((item, index) => 
//                                index % 2 === 0 ? '#FFCE56' : '#36A2EB'
//                            ),
//                            borderColor: data.map((item, index) => 
//                                index % 2 === 0 ? '#FFB347' : '#2E86C1'
//                            ),
//                            borderWidth: 1,
//                            borderRadius: 5
//                        }]
//                    },
//                    options: {
//                        responsive: true,
//                        maintainAspectRatio: false,
//                        indexAxis: 'y', // Horizontal bar chart
//                        scales: { 
//                            x: { 
//                                beginAtZero: true,
//                                grid: { color: 'rgba(0, 0, 0, 0.05)' }
//                            },
//                            y: {
//                                grid: { display: false }
//                            }
//                        },
//                        plugins: {
//                            legend: { display: false },
//                            tooltip: {
//                                callbacks: {
//                                    label: function(context) {
//                                        return 'Doanh thu: ' + context.parsed.x.toLocaleString() + '₫';
//                                    }
//                                }
//                            }
//                        },
//                        animation: {
//                            duration: 1000,
//                            easing: 'easeOutQuart'
//                        }
//                    }
//                });
//            })
//            .catch(error => {
//                showChartError('topCustomersChartAlert', 'Lỗi tải dữ liệu: ' + error);
//                const canvas = document.getElementById('topCustomersChart');
//                canvas.style.display = "none";
//                if (topCustomersChart) topCustomersChart.destroy();
//            });
//    }

//    function loadBookingStatusChart() {
//        return fetch('managerDashBoardServlet?action=booking-status')
//            .then(response => response.json())
//            .then(data => {
//                const alertDiv = document.getElementById('bookingStatusChartAlert');
//                alertDiv.innerHTML = '';
//                const canvas = document.getElementById('bookingStatusChart');
//                canvas.style.display = "block";
//                if (!data || data.length === 0) {
//                    if (bookingStatusChart) bookingStatusChart.destroy();
//                    canvas.style.display = "none";
//                    showChartInfo('bookingStatusChartAlert', 'Không có dữ liệu trạng thái booking!');
//                    return;
//                }
//                if (bookingStatusChart) bookingStatusChart.destroy();
//                const ctx = canvas.getContext('2d');
//                
//                bookingStatusChart = new Chart(ctx, {
//                    type: bookingChartType,
//                    data: {
//                        labels: data.map(item => item.label),
//                        datasets: [{
//                            label: 'Số lượng',
//                            data: data.map(item => item.value),
//                            backgroundColor: data.map(item => item.color || '#36A2EB'),
//                            borderColor: '#fff',
//                            borderWidth: bookingChartType === 'pie' ? 1 : 2,
//                            hoverOffset: 15
//                        }]
//                    },
//                    options: {
//                        responsive: true,
//                        maintainAspectRatio: false,
//                        plugins: {
//                            legend: { 
//                                position: 'bottom',
//                                labels: {
//                                    usePointStyle: true,
//                                    pointStyle: 'circle'
//                                }
//                            },
//                            tooltip: {
//                                callbacks: {
//                                    label: function(context) {
//                                        const label = context.label || '';
//                                        const value = context.raw || 0;
//                                        const total = context.dataset.data.reduce((a, b) => a + b, 0);
//                                        const percentage = Math.round((value / total) * 100);
//                                        return `${label}: ${value} (${percentage}%)`;
//                                    }
//                                }
//                            }
//                        },
//                        animation: {
//                            duration: 1000,
//                            easing: 'easeOutQuart'
//                        }
//                    }
//                });
//            })
//            .catch(error => {
//                showChartError('bookingStatusChartAlert', 'Lỗi tải dữ liệu: ' + error);
//                const canvas = document.getElementById('bookingStatusChart');
//                canvas.style.display = "none";
//                if (bookingStatusChart) bookingStatusChart.destroy();
//            });
//    }
    
    function showChartError(alertDivId, message) {
        var alertDiv = document.getElementById(alertDivId);
        if (alertDiv) {
            alertDiv.innerHTML = '<div class="alert alert-danger alert-dismissible fade show">' +
                               '<i class="fas fa-exclamation-circle me-2"></i>' + message +
                               '<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>';
        }
    }

    function showChartInfo(alertDivId, message) {
        var alertDiv = document.getElementById(alertDivId);
        if (alertDiv) {
            alertDiv.innerHTML = '<div class="alert alert-info alert-dismissible fade show">' +
                               '<i class="fas fa-info-circle me-2"></i>' + message +
                               '<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>';
        }
    }
    </script>
</body>
</html>