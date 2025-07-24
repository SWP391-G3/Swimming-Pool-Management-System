<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lịch sử bán vé - Hệ thống bể bơi</title>
        <link rel="stylesheet" href="./manager-css/manager-device-v2.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

        <style>
            /* =============== VARIABLES =============== */
            :root {
                --primary-color: #2196F3;
                --primary-dark: #1976D2;
                --secondary-color: #03DAC6;
                --success-color: #4CAF50;
                --warning-color: #FF9800;
                --error-color: #F44336;
                --background-color: #F8FAFE;
                --surface-color: #FFFFFF;
                --text-primary: #212121;
                --text-secondary: #757575;
                --border-color: #E0E0E0;
                --shadow: 0 4px 12px rgba(0,0,0,0.1);
                --shadow-hover: 0 8px 24px rgba(0,0,0,0.15);
                --border-radius: 12px;
                --transition: all 0.3s ease;
                --sidebar-width: 280px;
            }

            /* =============== RESET & BASE =============== */
            .main-content {
                margin-left: var(--sidebar-width);
                padding: 20px;
                max-width: calc(100vw - var(--sidebar-width));
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: transparent;
                min-height: 100vh;
                overflow-x: hidden;
            }

            /* =============== HEADER SECTION =============== */
            .header {
                background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
                color: white;
                padding: 24px 30px;
                border-radius: var(--border-radius);
                margin-bottom: 20px;
                box-shadow: var(--shadow);
                position: relative;
                overflow: hidden;
            }

            .header::before {
                content: '';
                position: absolute;
                top: -30px;
                right: -30px;
                width: 100px;
                height: 100px;
                background: rgba(255,255,255,0.1);
                border-radius: 50%;
            }

            .header-content {
                position: relative;
                z-index: 2;
            }

            .header h1 {
                font-size: 26px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 16px;
                text-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .header h1 i {
                font-size: 28px;
                color: rgba(255,255,255,0.9);
            }

            .header-info {
                display: flex;
                flex-wrap: wrap;
                gap: 16px;
                font-size: 14px;
                align-items: center;
            }

            .info-item {
                display: flex;
                align-items: center;
                gap: 10px;
                background: rgba(255,255,255,0.15);
                padding: 10px 16px;
                border-radius: 20px;
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255,255,255,0.2);
                transition: var(--transition);
                font-weight: 500;
                min-width: 180px;
            }

            .info-item:hover {
                background: rgba(255,255,255,0.25);
                transform: translateY(-1px);
            }

            .info-item i {
                font-size: 16px;
                color: rgba(255,255,255,0.9);
                min-width: 16px;
            }

            .info-item.action-item {
                background: rgba(255,255,255,0.2);
                border: 2px solid rgba(255,255,255,0.3);
                cursor: pointer;
            }

            .info-item.action-item:hover {
                background: rgba(255,255,255,0.35);
                border-color: rgba(255,255,255,0.5);
                transform: translateY(-2px);
            }

            .history-btn {
                display: flex;
                align-items: center;
                gap: 8px;
                color: white;
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
                transition: var(--transition);
            }

            .history-btn:hover {
                color: rgba(255,255,255,0.9);
            }

            /* =============== STATISTICS SECTION =============== */
            .statistics-section {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 18px;
                margin-bottom: 20px;
            }

            .stat-card {
                background: var(--surface-color);
                padding: 24px 20px;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
                text-align: center;
                transition: var(--transition);
                border-top: 4px solid var(--primary-color);
                position: relative;
            }

            .stat-card:hover {
                transform: translateY(-4px);
                box-shadow: var(--shadow-hover);
            }

            .stat-icon {
                font-size: 32px;
                color: var(--primary-color);
                margin-bottom: 12px;
            }

            .stat-value {
                font-size: 28px;
                font-weight: 700;
                color: var(--text-primary);
                margin-bottom: 6px;
            }

            .stat-label {
                font-size: 12px;
                color: var(--text-secondary);
                text-transform: uppercase;
                letter-spacing: 0.8px;
                font-weight: 600;
            }

            /* =============== FILTER SECTION =============== */
            .filter-section {
                background: var(--surface-color);
                padding: 24px;
                border-radius: var(--border-radius);
                margin-bottom: 20px;
                box-shadow: var(--shadow);
                border-left: 4px solid var(--secondary-color);
            }

            .filter-form {
                display: grid;
                grid-template-columns: 2fr 1fr 1fr 1fr 1fr auto auto;
                gap: 16px;
                align-items: end;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                gap: 6px;
            }

            .form-group label {
                font-weight: 600;
                color: var(--text-primary);
                font-size: 13px;
                margin-bottom: 4px;
            }

            .form-input, .form-select {
                padding: 12px 16px;
                border: 2px solid var(--border-color);
                border-radius: 10px;
                font-size: 14px;
                transition: var(--transition);
                background: var(--surface-color);
                font-family: inherit;
            }

            .form-input:focus, .form-select:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(33, 150, 243, 0.1);
            }

            .btn {
                padding: 12px 20px;
                border: none;
                border-radius: 10px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: var(--transition);
                display: flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
                justify-content: center;
                min-width: 120px;
                font-family: inherit;
            }

            .btn-primary {
                background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
                color: white;
                box-shadow: 0 3px 12px rgba(33, 150, 243, 0.3);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(33, 150, 243, 0.4);
            }

            .btn-secondary {
                background: var(--border-color);
                color: var(--text-primary);
                border: 2px solid transparent;
            }

            .btn-secondary:hover {
                background: var(--text-secondary);
                color: white;
                transform: translateY(-2px);
            }

            /* =============== TABLE SECTION =============== */
            .table-section {
                background: var(--surface-color);
                border-radius: var(--border-radius);
                overflow: hidden;
                box-shadow: var(--shadow);
                margin-bottom: 20px;
            }

            .table-header {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                padding: 18px 24px;
                border-bottom: 2px solid var(--border-color);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .table-title {
                font-size: 20px;
                font-weight: 600;
                color: var(--text-primary);
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .table-title i {
                font-size: 22px;
                color: var(--primary-color);
            }

            .table-stats {
                font-size: 14px;
                color: var(--text-secondary);
                font-weight: 500;
            }

            .table-container {
                overflow-x: auto;
            }

            .data-table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
            }

            .data-table th {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                color: var(--text-primary);
                font-weight: 600;
                padding: 16px 12px;
                text-align: left;
                border-bottom: 2px solid var(--border-color);
                white-space: nowrap;
                font-size: 13px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .data-table td {
                padding: 16px 12px;
                border-bottom: 1px solid var(--border-color);
                vertical-align: middle;
                font-size: 13px;
            }

            .data-table tbody tr {
                transition: var(--transition);
            }

            .data-table tbody tr:hover {
                background: var(--background-color);
                transform: scale(1.002);
            }

            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: 600;
                text-transform: capitalize;
                display: inline-block;
                min-width: 80px;
                text-align: center;
            }

            .status-completed {
                background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c9 100%);
                color: var(--success-color);
                border: 1px solid rgba(76, 175, 80, 0.2);
            }

            .status-pending {
                background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
                color: var(--warning-color);
                border: 1px solid rgba(255, 152, 0, 0.2);
            }

            .status-failed {
                background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                color: var(--error-color);
                border: 1px solid rgba(244, 67, 54, 0.2);
            }

            .customer-type {
                padding: 4px 10px;
                border-radius: 16px;
                font-size: 11px;
                font-weight: 600;
                display: inline-block;
                min-width: 50px;
                text-align: center;
            }

            .customer-existing {
                background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c9 100%);
                color: var(--success-color);
                border: 1px solid rgba(76, 175, 80, 0.2);
            }

            .customer-guest {
                background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
                color: var(--primary-color);
                border: 1px solid rgba(33, 150, 243, 0.2);
            }

            .btn-detail {
                background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
                color: white;
                padding: 8px 14px;
                border-radius: 8px;
                font-size: 12px;
                border: none;
                cursor: pointer;
                transition: var(--transition);
                display: flex;
                align-items: center;
                gap: 4px;
                text-decoration: none;
                font-weight: 600;
                box-shadow: 0 2px 8px rgba(33, 150, 243, 0.3);
            }

            .btn-detail:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 16px rgba(33, 150, 243, 0.4);
                color: white;
            }

            /* =============== PAGINATION =============== */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 16px;
                padding: 20px;
                background: var(--surface-color);
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
            }

            .pagination a {
                padding: 10px 18px;
                background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
                color: white;
                text-decoration: none;
                border-radius: 10px;
                font-weight: 600;
                font-size: 13px;
                transition: var(--transition);
                box-shadow: 0 3px 12px rgba(33, 150, 243, 0.3);
                min-width: 100px;
                text-align: center;
            }

            .pagination a:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(33, 150, 243, 0.4);
            }

            .pagination .current {
                padding: 10px 18px;
                background: var(--surface-color);
                color: var(--text-primary);
                border: 2px solid var(--primary-color);
                border-radius: 10px;
                font-weight: 600;
                font-size: 14px;
            }

            /* =============== EMPTY STATE =============== */
            .empty-state {
                text-align: center;
                padding: 60px 30px;
                color: var(--text-secondary);
            }

            .empty-state i {
                font-size: 56px;
                color: var(--border-color);
                margin-bottom: 16px;
            }

            .empty-state h3 {
                font-size: 20px;
                margin-bottom: 8px;
                color: var(--text-primary);
                font-weight: 600;
            }

            .empty-state p {
                font-size: 14px;
                max-width: 350px;
                margin: 0 auto;
                line-height: 1.5;
            }

            /* =============== ERROR MESSAGE =============== */
            .error-message {
                background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
                color: var(--error-color);
                padding: 16px 20px;
                border-radius: var(--border-radius);
                margin-bottom: 20px;
                border-left: 4px solid var(--error-color);
                display: flex;
                align-items: center;
                gap: 12px;
                box-shadow: var(--shadow);
                font-weight: 500;
                font-size: 14px;
            }

            .error-message i {
                font-size: 18px;
            }

            /* =============== RESPONSIVE =============== */
            @media (max-width: 1400px) {
                .filter-form {
                    grid-template-columns: 2fr 1fr 1fr 1fr 1fr;
                    gap: 14px;
                }

                .filter-form .btn {
                    grid-column: span 2;
                }
            }

            @media (max-width: 1024px) {
                .main-content {
                    margin-left: 0;
                    padding: 16px;
                    max-width: 100vw;
                }

                .filter-form {
                    grid-template-columns: 1fr;
                    gap: 12px;
                }

                .header h1 {
                    font-size: 22px;
                }

                .header-info {
                    flex-direction: column;
                    gap: 10px;
                    align-items: stretch;
                }

                .info-item {
                    min-width: 100%;
                    justify-content: center;
                }

                .statistics-section {
                    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                    gap: 14px;
                }

                .stat-card {
                    padding: 20px 16px;
                }

                .data-table th,
                .data-table td {
                    padding: 12px 8px;
                    font-size: 12px;
                }
            }

            @media (max-width: 768px) {
                .main-content {
                    padding: 12px;
                }

                .header {
                    padding: 20px 16px;
                }

                .header h1 {
                    font-size: 20px;
                    flex-direction: column;
                    text-align: center;
                    gap: 10px;
                }

                .statistics-section {
                    grid-template-columns: 1fr;
                }

                .data-table {
                    font-size: 11px;
                }

                .data-table th,
                .data-table td {
                    padding: 10px 6px;
                }

                .btn-detail {
                    padding: 6px 10px;
                    font-size: 11px;
                }
            }

            /* =============== ANIMATIONS =============== */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .statistics-section {
                animation: fadeInUp 0.5s ease-out;
            }

            .filter-section {
                animation: fadeInUp 0.7s ease-out;
            }

            .table-section {
                animation: fadeInUp 0.9s ease-out;
            }

            /* =============== SCROLL BAR =============== */
            .table-container::-webkit-scrollbar {
                height: 6px;
            }

            .table-container::-webkit-scrollbar-track {
                background: var(--background-color);
                border-radius: 8px;
            }

            .table-container::-webkit-scrollbar-thumb {
                background: var(--primary-color);
                border-radius: 8px;
            }

            .table-container::-webkit-scrollbar-thumb:hover {
                background: var(--primary-dark);
            }
        </style>
    </head> 
    <body>
        <div class="layout">
            <%@ include file="./staffSidebar.jsp" %>

            <div class="main-content">
                <!-- Header -->
                <div class="header">
                    <div class="header-content">
                        <h1>
                            <i class="fas fa-history"></i>
                            Lịch sử bán vé trực tiếp
                        </h1>
                        <div class="header-info">
                            <div class="info-item">
                                <i class="fas fa-swimming-pool"></i>
                                <span>Bể bơi: ${staff.poolName}</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-building"></i>
                                <span>Chi nhánh: ${staff.branchName}</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-user-tag"></i>
                                <span>Nhân viên soát vé</span>
                            </div>
                            <div class="info-item action-item">
                                <a href="staff_sale" class="history-btn">
                                    <i class="fas fa-cash-register"></i>
                                    <span>Bán vé trực tiếp</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Error Message -->
                <c:if test="${error != null}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-triangle"></i>
                        <span>${error}</span>
                    </div>
                </c:if>

                <!-- Statistics Section -->
                <c:if test="${statistics != null}">
                    <div class="statistics-section">
                        <div class="stat-card">
                            <div class="stat-icon"><i class="fas fa-receipt"></i></div>
                            <div class="stat-value">${statistics.totalTransactions}</div>
                            <div class="stat-label">Tổng giao dịch</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon"><i class="fas fa-money-bill-wave"></i></div>
                            <div class="stat-value">
                                <fmt:formatNumber value="${statistics.totalRevenue}" type="number" maxFractionDigits="0"/>₫
                            </div>
                            <div class="stat-label">Tổng doanh thu</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon"><i class="fas fa-chart-line"></i></div>
                            <div class="stat-value">
                                <fmt:formatNumber value="${statistics.avgTransactionValue}" type="number" maxFractionDigits="0"/>₫
                            </div>
                            <div class="stat-label">Trung bình/GD</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon"><i class="fas fa-arrow-up"></i></div>
                            <div class="stat-value">
                                <fmt:formatNumber value="${statistics.maxTransactionValue}" type="number" maxFractionDigits="0"/>₫
                            </div>
                            <div class="stat-label">GD cao nhất</div>
                        </div>
                    </div>
                </c:if>

                <!-- Filter Section -->
                <div class="filter-section">
                    <form method="GET" action="staff_sale_history" class="filter-form">
                        <div class="form-group">
                            <label for="search">Tìm kiếm</label>
                            <input type="text" id="search" name="search" class="form-input" 
                                   placeholder="Mã GD, tên khách, SĐT..." value="${search}">
                        </div>
                        <div class="form-group">
                            <label for="fromDate">Từ ngày</label>
                            <input type="date" id="fromDate" name="fromDate" class="form-input" value="${fromDate}">
                        </div>
                        <div class="form-group">
                            <label for="toDate">Đến ngày</label>
                            <input type="date" id="toDate" name="toDate" class="form-input" value="${toDate}">
                        </div>
                        <div class="form-group">
                            <label for="sortBy">Sắp xếp theo</label>
                            <select id="sortBy" name="sortBy" class="form-select">
                                <option value="date" ${sortBy == 'date' ? 'selected' : ''}>Ngày bán</option>
                                <option value="amount" ${sortBy == 'amount' ? 'selected' : ''}>Giá trị</option>
                                <option value="customer" ${sortBy == 'customer' ? 'selected' : ''}>Khách hàng</option>
                                <option value="status" ${sortBy == 'status' ? 'selected' : ''}>Trạng thái</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="sortOrder">Thứ tự</label>
                            <select id="sortOrder" name="sortOrder" class="form-select">
                                <option value="desc" ${sortOrder == 'desc' ? 'selected' : ''}>Giảm dần</option>
                                <option value="asc" ${sortOrder == 'asc' ? 'selected' : ''}>Tăng dần</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i> Tìm kiếm
                        </button>
                        <a href="staff_sale_history" class="btn btn-secondary">
                            <i class="fas fa-undo"></i> Đặt lại
                        </a>
                    </form>
                </div>

                <!-- Table Section -->
                <div class="table-section">
                    <div class="table-header">
                        <div class="table-title">
                            <i class="fas fa-list"></i>
                            Danh sách giao dịch
                        </div>
                        <div class="table-stats">
                            Tìm thấy <strong>${totalRecords}</strong> giao dịch
                            <c:if test="${currentPage != null && totalPages != null}">
                                - Trang <strong>${currentPage}</strong>/<strong>${totalPages}</strong>
                            </c:if>
                        </div>
                    </div>

                    <div class="table-container">
                        <c:choose>
                            <c:when test="${salesHistory != null && fn:length(salesHistory) > 0}">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>Mã GD</th>
                                            <th>Ngày bán</th>
                                            <th>Khách hàng</th>
                                            <th>SĐT</th>
                                            <th>Loại KH</th>
                                            <th>Tổng tiền</th>
                                            <th>Phương thức</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="sale" items="${salesHistory}">
                                            <tr>
                                                <td><strong>#${sale.saleId}</strong></td>
                                                <td>
                                                    <fmt:formatDate value="${sale.saleDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                </td>
                                                <td><strong>${sale.customerName}</strong></td>
                                                <td>${sale.customerPhone}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${sale.userId != null}">
                                                            <span class="customer-type customer-existing">Có TK</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="customer-type customer-guest">Khách</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <strong style="color: var(--success-color); font-size: 14px;">
                                                        <fmt:formatNumber value="${sale.totalAmount}" type="number" groupingUsed="true"/>₫
                                                    </strong>
                                                </td>
                                                <td>${sale.paymentMethod}</td>
                                                <td>
                                                    <span class="status-badge status-${sale.paymentStatus}">
                                                        <c:choose>
                                                            <c:when test="${sale.paymentStatus == 'completed'}">Hoàn thành</c:when>
                                                            <c:when test="${sale.paymentStatus == 'pending'}">Đang xử lý</c:when>
                                                            <c:when test="${sale.paymentStatus == 'failed'}">Thất bại</c:when>
                                                            <c:otherwise>${sale.paymentStatus}</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="staff_sale_history?saleId=${sale.saleId}" class="btn-detail">
                                                        <i class="fas fa-eye"></i> Chi tiết
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="fas fa-inbox"></i>
                                    <h3>Không có giao dịch nào</h3>
                                    <p>Chưa có lịch sử bán vé nào phù hợp với bộ lọc của bạn.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages != null && totalPages > 1}">
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="?page=${currentPage - 1}&search=${search}&fromDate=${fromDate}&toDate=${toDate}&sortBy=${sortBy}&sortOrder=${sortOrder}">
                                <i class="fas fa-chevron-left"></i> Trước
                            </a>
                        </c:if>

                        <span class="current">Trang ${currentPage} / ${totalPages}</span>

                        <c:if test="${currentPage < totalPages}">
                            <a href="?page=${currentPage + 1}&search=${search}&fromDate=${fromDate}&toDate=${toDate}&sortBy=${sortBy}&sortOrder=${sortOrder}">
                                Sau <i class="fas fa-chevron-right"></i>
                            </a>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
    </body>
</html>