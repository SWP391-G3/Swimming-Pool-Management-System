<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    model.staff.StaffJoinedTable staff = (model.staff.StaffJoinedTable) session.getAttribute("staff");
    model.staff.StaffSaleData saleData = (model.staff.StaffSaleData) session.getAttribute("staffSaleData");
    request.setAttribute("staff", staff);
    request.setAttribute("saleData", saleData);
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./manager-css/manager-device-v2.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
        <title>Bán vé trực tiếp - Hệ thống bể bơi</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
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
                --sidebar-width: 250px;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            html, body {
                height: 100%;
                overflow: hidden;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, var(--background-color) 0%, #E3F2FD 100%);
                color: var(--text-primary);
                line-height: 1.6;
            }

            /* Layout chính với sidebar - fill toàn bộ viewport */
            .main-layout {
                display: flex;
                height: 100vh;
                width: 100vw;
                position: fixed;
                top: 0;
                left: 0;
            }

            /* Content area - fill toàn bộ không gian còn lại */
            .content-area {
                flex: 1;
                margin-left: var(--sidebar-width);
                height: 100vh;
                width: calc(100vw - var(--sidebar-width));
                overflow: hidden;
                background: transparent;
            }

            .container {
                width: 100%;
                height: 100%;
                padding: 12px;
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }

            /* ✅ THÔNG BÁO THÀNH CÔNG */
            .success-notification {
                background: linear-gradient(135deg, var(--success-color) 0%, #45A049 100%);
                color: white;
                padding: 20px 24px;
                border-radius: var(--border-radius);
                margin-bottom: 12px;
                box-shadow: var(--shadow-hover);
                position: relative;
                overflow: hidden;
                flex-shrink: 0;
                animation: slideInDown 0.5s ease-out;
                border: 1px solid rgba(255,255,255,0.2);
            }

            .success-notification::before {
                content: '';
                position: absolute;
                top: 0;
                right: 0;
                width: 80px;
                height: 80px;
                background: rgba(255,255,255,0.1);
                border-radius: 50%;
                transform: translate(25px, -25px);
            }

            .success-header {
                position: relative;
                z-index: 2;
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 16px;
            }

            .success-header i {
                font-size: 28px;
                color: rgba(255,255,255,0.9);
                animation: bounceIn 0.8s ease-out;
            }

            .success-header h4 {
                font-size: 20px;
                font-weight: 600;
                margin: 0;
                color: white;
            }

            .success-details {
                position: relative;
                z-index: 2;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 16px;
                font-size: 14px;
            }

            .success-item {
                background: rgba(255,255,255,0.15);
                padding: 12px 16px;
                border-radius: 8px;
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255,255,255,0.1);
                transition: var(--transition);
            }

            .success-item:hover {
                background: rgba(255,255,255,0.2);
                transform: translateY(-1px);
            }

            .success-item-label {
                font-weight: 500;
                opacity: 0.9;
                margin-bottom: 4px;
            }

            .success-item-value {
                font-weight: 700;
                font-size: 15px;
                color: white;
            }

            .close-success {
                position: absolute;
                top: 16px;
                right: 16px;
                background: rgba(255,255,255,0.2);
                border: none;
                color: white;
                font-size: 16px;
                width: 32px;
                height: 32px;
                border-radius: 50%;
                cursor: pointer;
                transition: var(--transition);
                z-index: 3;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .close-success:hover {
                background: rgba(255,255,255,0.3);
                transform: scale(1.1);
            }

            @keyframes slideInDown {
                from {
                    opacity: 0;
                    transform: translateY(-30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @keyframes bounceIn {
                0% {
                    transform: scale(0.3);
                    opacity: 0;
                }
                50% {
                    transform: scale(1.1);
                }
                100% {
                    transform: scale(1);
                    opacity: 1;
                }
            }

            /* Header - cải thiện kích thước và layout */
            .header {
                background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
                color: white;
                padding: 24px 28px;
                border-radius: var(--border-radius);
                margin-bottom: 12px;
                box-shadow: var(--shadow);
                position: relative;
                overflow: hidden;
                flex-shrink: 0;
                min-height: 120px;
            }

            .header::before {
                content: '';
                position: absolute;
                top: 0;
                right: 0;
                width: 100px;
                height: 100px;
                background: rgba(255,255,255,0.1);
                border-radius: 50%;
                transform: translate(30px, -30px);
            }

            .header-content {
                position: relative;
                z-index: 2;
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .header h1 {
                font-size: 24px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 18px;
                color: white;
            }

            .header h1 i {
                font-size: 26px;
                color: rgba(255,255,255,0.9);
            }

            .header-info {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                font-size: 15px;
                align-items: center;
            }

            .info-item {
                display: flex;
                align-items: center;
                gap: 10px;
                background: rgba(255,255,255,0.15);
                padding: 12px 18px;
                border-radius: 15px;
                backdrop-filter: blur(10px);
                font-size: 15px;
                font-weight: 500;
                min-width: 200px;
                justify-content: flex-start;
                border: 1px solid rgba(255,255,255,0.1);
                transition: var(--transition);
            }

            .info-item:hover {
                background: rgba(255,255,255,0.2);
                transform: translateY(-1px);
            }

            .info-item i {
                font-size: 18px;
                color: rgba(255,255,255,0.9);
                margin-right: 4px;
                min-width: 18px;
            }

            .info-item span {
                color: white;
                font-weight: 500;
                white-space: nowrap;
            }

            /* Pool Info - compact tối đa */
            .pool-info {
                background: var(--surface-color);
                padding: 12px 16px;
                border-radius: var(--border-radius);
                margin-bottom: 10px;
                box-shadow: var(--shadow);
                border-left: 3px solid var(--secondary-color);
                transition: var(--transition);
                flex-shrink: 0;
            }

            .pool-info:hover {
                transform: translateY(-1px);
                box-shadow: var(--shadow-hover);
            }

            .pool-name {
                font-size: 15px;
                font-weight: 700;
                color: var(--primary-color);
                margin-bottom: 4px;
                display: flex;
                align-items: center;
                gap: 6px;
            }

            .pool-address {
                color: var(--text-secondary);
                font-size: 12px;
                display: flex;
                align-items: center;
                gap: 4px;
            }


            /* Main content - fill toàn bộ không gian còn lại */
            .main-content {
                display: grid;
                grid-template-columns: 1fr 350px;
                gap: 12px;
                align-items: stretch;
                flex: 1;
                overflow: hidden;
                height: 100%;
            }

            .left-column {
                height: 100%;
                overflow-y: auto;
                padding-right: 4px;
                display: flex;
                flex-direction: column;
            }

            .right-column {
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            /* Error styles */
            .error-message {
                background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
                color: var(--error-color);
                padding: 16px 20px;
                border-radius: var(--border-radius);
                margin-bottom: 12px;
                border-left: 4px solid var(--error-color);
                display: flex;
                align-items: center;
                gap: 12px;
                box-shadow: var(--shadow);
                animation: slideInDown 0.5s ease-out;
                flex-shrink: 0;
            }

            .error-message i {
                font-size: 20px;
                color: var(--error-color);
            }

            /* ✅ WARNING MESSAGE cho validation */
            .warning-message {
                background: linear-gradient(135deg, #fff3e0 0%, #ffcc02 30%);
                color: #e65100;
                padding: 12px 16px;
                border-radius: var(--border-radius);
                margin-bottom: 8px;
                border-left: 4px solid var(--warning-color);
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 13px;
                font-weight: 500;
                animation: slideInDown 0.3s ease-out;
            }

            .warning-message i {
                font-size: 16px;
                color: var(--warning-color);
            }

            /* Sections - tối ưu không gian */
            .section {
                background: var(--surface-color);
                padding: 16px;
                margin-bottom: 12px;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
                transition: var(--transition);
                display: flex;
                flex-direction: column;
            }

            .section:last-child {
                margin-bottom: 0;
            }

            .section:hover {
                transform: translateY(-1px);
                box-shadow: var(--shadow-hover);
            }

            .section-title {
                font-size: 16px;
                font-weight: 600;
                margin-bottom: 14px;
                color: var(--text-primary);
                display: flex;
                align-items: center;
                gap: 8px;
                padding-bottom: 8px;
                border-bottom: 2px solid var(--border-color);
                flex-shrink: 0;
            }

            .section-title i {
                color: var(--primary-color);
                font-size: 18px;
            }

            .section-content {
                flex: 1;
                overflow-y: auto;
            }

            /* Customer Search Styles */
            .customer-section {
                margin-bottom: 15px;
            }

            .customer-search-container {
                display: flex;
                flex-direction: column;
                gap: 16px;
            }

            .search-group {
                position: relative;
            }

            .search-group label {
                display: block;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 6px;
                font-size: 14px;
            }

            .required {
                color: var(--error-color);
            }

            .phone-search-wrapper {
                position: relative;
            }

            .form-input {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid var(--border-color);
                border-radius: var(--border-radius);
                font-size: 14px;
                transition: var(--transition);
                background: var(--surface-color);
            }

            .form-input:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(33, 150, 243, 0.1);
            }

            .phone-input {
                padding-right: 40px;
            }

            .search-dropdown {
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                background: var(--surface-color);
                border: 2px solid var(--primary-color);
                border-top: none;
                border-radius: 0 0 var(--border-radius) var(--border-radius);
                max-height: 200px;
                overflow-y: auto;
                z-index: 1000;
                display: none;
            }

            .dropdown-item {
                padding: 12px 16px;
                cursor: pointer;
                border-bottom: 1px solid var(--border-color);
                transition: var(--transition);
                display: flex;
                flex-direction: column;
                gap: 4px;
            }

            .dropdown-item:hover {
                background: var(--background-color);
            }

            .dropdown-item:last-child {
                border-bottom: none;
            }

            .dropdown-item-name {
                font-weight: 600;
                color: var(--text-primary);
            }

            .dropdown-item-info {
                font-size: 12px;
                color: var(--text-secondary);
            }

            .customer-info-display,
            .manual-input-section {
                background: var(--background-color);
                padding: 16px;
                border-radius: var(--border-radius);
                border: 1px solid var(--border-color);
            }

            .info-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 12px;
                margin-bottom: 12px;
            }

            .info-group {
                display: flex;
                flex-direction: column;
                gap: 6px;
            }

            .info-group label {
                font-size: 12px;
                font-weight: 600;
                color: var(--text-secondary);
                margin-bottom: 0;
            }

            .customer-status {
                display: flex;
                justify-content: flex-end;
            }

            .status-badge {
                padding: 4px 12px;
                border-radius: 15px;
                font-size: 12px;
                font-weight: 600;
            }

            .status-badge.existing-customer {
                background: var(--success-color);
                color: white;
            }

            .status-badge.new-customer {
                background: var(--warning-color);
                color: white;
            }

            /* Loading indicator */
            .loading-indicator {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 12px;
                color: var(--text-secondary);
                font-size: 12px;
            }

            .loading-spinner {
                width: 16px;
                height: 16px;
                border: 2px solid var(--border-color);
                border-top: 2px solid var(--primary-color);
                border-radius: 50%;
                animation: spin 1s linear infinite;
                margin-right: 8px;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }

            /* Items - tăng kích thước */
            .item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 16px 18px;
                border: 2px solid var(--border-color);
                margin-bottom: 10px;
                border-radius: var(--border-radius);
                transition: var(--transition);
                background: linear-gradient(135deg, #FAFAFA 0%, var(--surface-color) 100%);
                min-height: 65px;
            }

            .item:hover {
                border-color: var(--primary-color);
                transform: translateX(3px);
                box-shadow: 0 4px 15px rgba(33, 150, 243, 0.2);
            }

            .item:last-child {
                margin-bottom: 0;
            }

            .item-info {
                flex: 1;
                min-width: 0;
            }

            .item-name {
                font-weight: 600;
                color: var(--text-primary);
                font-size: 15px;
                margin-bottom: 4px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .item-price {
                color: var(--success-color);
                font-size: 14px;
                font-weight: 600;
            }

            /* ✅ DISABLED ITEM khi vượt quá số người */
            .item.disabled {
                opacity: 0.5;
                background: linear-gradient(135deg, #f5f5f5 0%, #e0e0e0 100%);
                border-color: #bdbdbd;
                pointer-events: none;
            }

            .item.disabled .btn-quantity {
                background: #bdbdbd;
                cursor: not-allowed;
            }

            /* Quantity Controls */
            .quantity-control {
                display: flex;
                align-items: center;
                gap: 10px;
                background: var(--surface-color);
                padding: 6px;
                border-radius: 20px;
                border: 2px solid var(--border-color);
                flex-shrink: 0;
            }

            .btn {
                padding: 8px 12px;
                border: none;
                border-radius: 50%;
                cursor: pointer;
                font-size: 13px;
                font-weight: 600;
                transition: var(--transition);
                display: flex;
                align-items: center;
                justify-content: center;
                min-width: 36px;
                height: 36px;
            }

            .btn-quantity {
                background: var(--primary-color);
                color: white;
            }

            .btn-quantity:hover:not(:disabled) {
                background: var(--primary-dark);
                transform: scale(1.1);
            }

            .btn-quantity:active {
                transform: scale(0.95);
            }

            .btn-quantity:disabled {
                background: #bdbdbd;
                cursor: not-allowed;
                transform: none;
            }

            .quantity-input {
                width: 50px;
                text-align: center;
                padding: 6px;
                border: none;
                border-radius: 5px;
                background: var(--background-color);
                font-size: 14px;
                font-weight: 600;
                color: var(--text-primary);
            }

            /* Summary - fill toàn bộ chiều cao */
            .summary {
                background: linear-gradient(135deg, var(--surface-color) 0%, #F8F9FA 100%);
                border: 2px solid var(--primary-color);
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            .summary-content {
                flex: 1;
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }

            .summary-order {
                flex: 1;
                overflow-y: auto;
                min-height: 0;
                padding-bottom: 8px;
            }

            .summary-line {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 8px 0;
                border-bottom: 1px solid var(--border-color);
                font-size: 13px;
            }

            .summary-line:last-child {
                border-bottom: none;
            }

            .summary-item-name {
                font-weight: 500;
                color: var(--text-primary);
                flex: 1;
                min-width: 0;
                margin-right: 8px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .summary-item-price {
                font-weight: 600;
                color: var(--success-color);
                flex-shrink: 0;
            }

            .summary-total {
                border-top: 2px solid var(--primary-color);
                font-weight: 700;
                font-size: 15px;
                padding-top: 10px;
                margin-top: 10px;
                background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                flex-shrink: 0;
            }

            .empty-cart {
                text-align: center;
                color: var(--text-secondary);
                font-style: italic;
                padding: 40px 20px;
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }

            .empty-cart i {
                font-size: 36px;
                margin-bottom: 10px;
                color: var(--border-color);
            }

            /* Payment Button */
            .btn-payment {
                width: 100%;
                padding: 14px;
                background: linear-gradient(135deg, var(--success-color) 0%, #45A049 100%);
                color: white;
                border: none;
                border-radius: var(--border-radius);
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                transition: var(--transition);
                margin-top: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 6px;
                flex-shrink: 0;
            }

            .btn-payment:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(76, 175, 80, 0.3);
            }

            .btn-payment:active {
                transform: translateY(0);
            }

            .btn-payment:disabled {
                background: var(--border-color);
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            /* Responsive cho header */
            @media (max-width: 1200px) {
                .header-info {
                    gap: 15px;
                }

                .info-item {
                    min-width: 180px;
                    padding: 10px 15px;
                    font-size: 14px;
                }

                .success-details {
                    grid-template-columns: 1fr 1fr;
                }
            }

            /* Responsive */
            @media (max-width: 1024px) {
                .content-area {
                    margin-left: 0;
                    width: 100vw;
                }

                .main-content {
                    grid-template-columns: 1fr;
                    gap: 12px;
                }

                .summary {
                    height: auto;
                    max-height: 400px;
                }

                .success-details {
                    grid-template-columns: 1fr;
                }
            }

            @media (max-width: 768px) {
                .container {
                    padding: 8px;
                }

                .header {
                    padding: 20px;
                    min-height: auto;
                }

                .header h1 {
                    font-size: 20px;
                    margin-bottom: 15px;
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

                .item {
                    flex-direction: column;
                    gap: 10px;
                    text-align: center;
                    min-height: auto;
                }

                .quantity-control {
                    justify-content: center;
                }

                .info-grid {
                    grid-template-columns: 1fr;
                    gap: 10px;
                }

                .success-details {
                    grid-template-columns: 1fr;
                }
            }

            /* Scrollbar */
            .left-column::-webkit-scrollbar,
            .section-content::-webkit-scrollbar,
            .summary-order::-webkit-scrollbar {
                width: 5px;
            }

            .left-column::-webkit-scrollbar-track,
            .section-content::-webkit-scrollbar-track,
            .summary-order::-webkit-scrollbar-track {
                background: var(--background-color);
            }

            .left-column::-webkit-scrollbar-thumb,
            .section-content::-webkit-scrollbar-thumb,
            .summary-order::-webkit-scrollbar-thumb {
                background: var(--primary-color);
                border-radius: 3px;
            }

            .left-column::-webkit-scrollbar-thumb:hover,
            .section-content::-webkit-scrollbar-thumb:hover,
            .summary-order::-webkit-scrollbar-thumb:hover {
                background: var(--primary-dark);
            }
        </style>
    </head>
    <body>
        <div class="main-layout">
            <!-- Include Sidebar -->
            <%@ include file="./staffSidebar.jsp" %>

            <!-- Main Content Area -->
            <div class="content-area">
                <div class="container">
                    <!-- ✅ THÔNG BÁO THÀNH CÔNG -->
                    <c:if test="${success}">
                        <div class="success-notification" id="success-notification">
                            <button class="close-success" onclick="hideSuccessNotification()" title="Đóng thông báo">
                                <i class="fas fa-times"></i>
                            </button>

                            <div class="success-header">
                                <i class="fas fa-check-circle"></i>
                                <h4>${successMessage}</h4>
                            </div>

                            <div class="success-details">
                                <div class="success-item">
                                    <div class="success-item-label">Mã booking</div>
                                    <div class="success-item-value">#${bookingId}</div>
                                </div>
                                <div class="success-item">
                                    <div class="success-item-label">Khách hàng</div>
                                    <div class="success-item-value">${customerName}</div>
                                </div>
                                <div class="success-item">
                                    <div class="success-item-label">Số điện thoại</div>
                                    <div class="success-item-value">${customerPhone}</div>
                                </div>
                                <div class="success-item">
                                    <div class="success-item-label">Tổng tiền</div>
                                    <div class="success-item-value">
                                        <fmt:formatNumber value="${totalAmount}" pattern="#,###"/> VNĐ
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Error Messages -->
                    <c:if test="${param.error != null}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-triangle"></i>
                            <span>
                                <c:choose>
                                    <c:when test="${param.error == 'missing_phone'}">Vui lòng nhập số điện thoại khách hàng!</c:when>
                                    <c:when test="${param.error == 'missing_name'}">Vui lòng nhập họ tên khách hàng!</c:when>
                                    <c:when test="${param.error == 'no_items'}">Vui lòng chọn ít nhất một sản phẩm!</c:when>
                                    <c:when test="${param.error == 'too_many_people'}">Tối đa 10 người/booking. Hiện tại: ${param.count} người!</c:when>
                                    <c:when test="${param.error == 'booking_failed'}">Tạo booking thất bại!</c:when>
                                    <c:when test="${param.error == 'payment_failed'}">Thanh toán thất bại!</c:when>
                                    <c:when test="${param.error == 'invalid_data'}">Dữ liệu không hợp lệ!</c:when>
                                    <c:when test="${param.error == 'system_error'}">Lỗi hệ thống!</c:when>
                                    <c:otherwise>Có lỗi xảy ra!</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </c:if>

                    <!-- Header -->
                    <div class="header">
                        <div class="header-content">
                            <h1>
                                <i class="fas fa-cash-register"></i>
                                Hệ thống bán vé trực tiếp
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
                                    <span>Chức vụ: ${staff.typeName}</span>
                                </div>
                                <div class="info-item">
                                    <i class="fas fa-clock"></i>
                                    <span id="current-time"></span>
                                </div>
                                <div class="info-item action-item">
                                    <a href="staff_sale_history" class="history-btn">
                                        <i class="fas fa-history"></i>
                                        <span>Lịch sử bán vé</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Pool Info -->
                    <div class="pool-info">
                        <div class="pool-name">
                            <i class="fas fa-water"></i>
                            ${saleData.pool.pool_name}
                        </div>
                        <div class="pool-address">
                            <i class="fas fa-map-marker-alt"></i>
                            ${saleData.pool.pool_address}
                        </div>
                    </div>

                    <!-- Main Content -->
                    <div class="main-content">
                        <div class="left-column">
                            <!-- Customer Search Section -->
                            <div class="section customer-section">
                                <div class="section-title">
                                    <i class="fas fa-user-search"></i>
                                    Thông tin khách hàng
                                </div>
                                <div class="section-content">
                                    <div class="customer-search-container">
                                        <!-- Phone Search -->
                                        <div class="search-group">
                                            <label for="customer-phone">Số điện thoại <span class="required">*</span></label>
                                            <div class="phone-search-wrapper">
                                                <input type="tel" 
                                                       id="customer-phone" 
                                                       class="form-input phone-input" 
                                                       placeholder="Nhập số điện thoại khách hàng"
                                                       autocomplete="off">
                                                <div class="search-dropdown" id="phone-dropdown"></div>
                                            </div>
                                        </div>

                                        <!-- Customer Info Display -->
                                        <div class="customer-info-display" id="customer-info" style="display: none;">
                                            <div class="info-grid">
                                                <div class="info-group">
                                                    <label>Họ và tên</label>
                                                    <input type="text" id="customer-name" class="form-input" readonly>
                                                </div>
                                                <div class="info-group">
                                                    <label>Email</label>
                                                    <input type="email" id="customer-email" class="form-input" readonly>
                                                </div>
                                            </div>
                                            <div class="customer-status">
                                                <span class="status-badge" id="customer-status"></span>
                                            </div>
                                        </div>

                                        <!-- Manual Input for New Customer -->
                                        <div class="manual-input-section" id="manual-input" style="display: none;">
                                            <div class="info-grid">
                                                <div class="info-group">
                                                    <label for="manual-name">Họ và tên <span class="required">*</span></label>
                                                    <input type="text" id="manual-name" class="form-input" placeholder="Nhập họ tên khách hàng">
                                                </div>
                                                <div class="info-group">
                                                    <label for="manual-email">Email</label>
                                                    <input type="email" id="manual-email" class="form-input" placeholder="Nhập email (tùy chọn)">
                                                </div>
                                            </div>
                                            <div class="customer-status">
                                                <span class="status-badge new-customer">Khách hàng mới</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Tickets Section -->
                            <div class="section">
                                <div class="section-title">
                                    <i class="fas fa-ticket-alt"></i>
                                    Chọn loại vé
                                </div>
                                <div class="section-content">
                                    <c:forEach var="ticket" items="${saleData.availableTicketTypes}">
                                        <div class="item" data-type="ticket" data-id="${ticket.ticketTypeId}" data-slot="1">
                                            <div class="item-info">
                                                <div class="item-name">${ticket.typeName}</div>
                                                <div class="item-price">
                                                    <fmt:formatNumber value="${ticket.basePrice}" type="number" groupingUsed="true"/>₫
                                                </div>
                                            </div>
                                            <div class="quantity-control">
                                                <button class="btn btn-quantity" onclick="changeQuantity('ticket-${ticket.ticketTypeId}', -1)">
                                                    <i class="fas fa-minus"></i>
                                                </button>
                                                <input type="number" id="ticket-${ticket.ticketTypeId}" class="quantity-input" value="0" min="0" readonly>
                                                <button class="btn btn-quantity" onclick="changeQuantity('ticket-${ticket.ticketTypeId}', 1)">
                                                    <i class="fas fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Services Section -->
                            <div class="section">
                                <div class="section-title">
                                    <i class="fas fa-concierge-bell"></i>
                                    Thuê đồ & Dịch vụ
                                    <span id="service-warning" class="warning-message" style="display: none; margin-left: auto;">
                                        <i class="fas fa-exclamation-triangle"></i>
                                        Không thể thuê nhiều hơn số người
                                    </span>
                                </div>
                                <div class="section-content">
                                    <c:forEach var="service" items="${saleData.availableServices}">
                                        <div class="item" data-type="service" data-id="${service.poolServiceId}">
                                            <div class="item-info">
                                                <div class="item-name">${service.serviceName}</div>
                                                <div class="item-price">
                                                    <fmt:formatNumber value="${service.price}" type="number" groupingUsed="true"/>₫
                                                </div>
                                            </div>
                                            <div class="quantity-control">
                                                <button class="btn btn-quantity" onclick="changeQuantity('service-${service.poolServiceId}', -1)">
                                                    <i class="fas fa-minus"></i>
                                                </button>
                                                <input type="number" id="service-${service.poolServiceId}" class="quantity-input" value="0" min="0" readonly>
                                                <button class="btn btn-quantity" onclick="changeQuantity('service-${service.poolServiceId}', 1)">
                                                    <i class="fas fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <!-- Summary Section -->
                        <div class="right-column">
                            <div class="section summary">
                                <div class="section-title">
                                    <i class="fas fa-receipt"></i>
                                    Tóm tắt đơn hàng
                                </div>

                                <div class="summary-content">
                                    <div class="summary-order" id="order-summary">
                                        <div class="empty-cart">
                                            <i class="fas fa-shopping-cart"></i>
                                            <div>Chưa có sản phẩm nào</div>
                                        </div>
                                    </div>

                                    <div class="summary-line summary-total">
                                        <span>Tổng cộng:</span>
                                        <span id="total-amount">0 ₫</span>
                                    </div>

                                    <button class="btn-payment" id="payment-btn" onclick="processPayment()" disabled>
                                        <i class="fas fa-credit-card"></i>
                                        Thanh toán
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ✅ Hidden data for slot validation -->
        <script type="application/json" id="ticket-slots">
            {
            <c:forEach var="ticket" items="${saleData.availableTicketTypes}" varStatus="status">
                "${ticket.ticketTypeId}": 1<c:if test="${!status.last}">,</c:if>
            </c:forEach>
            }
        </script>

        <script>
            let selectedItems = {};
            let searchTimeout;
            let currentCustomer = null;
            let ticketSlots = {}; // ✅ Slot data từ server

            // ✅ Load ticket slot data
            function loadTicketSlots() {
                try {
                    const slotsData = document.getElementById('ticket-slots');
                    if (slotsData) {
                        ticketSlots = JSON.parse(slotsData.textContent);
                        console.log('Loaded ticket slots:', ticketSlots);
                    }
                } catch (e) {
                    console.error('Error loading ticket slots:', e);
                    // Fallback - assume all tickets are 1 slot
                    document.querySelectorAll('[data-type="ticket"]').forEach(item => {
                        const id = item.dataset.id;
                        ticketSlots[id] = 1;
                    });
                }
            }

            // ✅ Tính tổng số người từ vé
            function calculateTotalPersons() {
                let totalPersons = 0;

                for (let itemId in selectedItems) {
                    if (itemId.startsWith('ticket-')) {
                        const ticketTypeId = itemId.replace('ticket-', '');
                        const quantity = selectedItems[itemId];
                        const slots = ticketSlots[ticketTypeId] || 1;
                        totalPersons += quantity * slots;
                    }
                }

                return totalPersons;
            }

            // ✅ Tính tổng số dịch vụ đã chọn
            function calculateTotalServices() {
                let totalServices = 0;

                for (let itemId in selectedItems) {
                    if (itemId.startsWith('service-')) {
                        totalServices += selectedItems[itemId];
                    }
                }

                return totalServices;
            }

            // ✅ Update person counter và validate services
            function updatePersonCounter() {
                const totalPersons = calculateTotalPersons();
                const totalServices = calculateTotalServices();

                document.getElementById('total-persons').textContent = totalPersons + ' người';

                // Validate và disable/enable service buttons
                validateServiceQuantities(totalPersons);

                // Show/hide warning
                const warningElement = document.getElementById('service-warning');
                if (totalServices > totalPersons && totalPersons > 0) {
                    warningElement.style.display = 'flex';
                } else {
                    warningElement.style.display = 'none';
                }
            }

            // ✅ Validate và disable service buttons
            function validateServiceQuantities(totalPersons) {
                document.querySelectorAll('[data-type="service"]').forEach(serviceItem => {
                    const serviceId = serviceItem.dataset.id;
                    const inputElement = document.getElementById('service-' + serviceId);
                    const currentQuantity = parseInt(inputElement.value) || 0;
                    const buttons = serviceItem.querySelectorAll('.btn-quantity');
                    const plusButton = buttons[1]; // Plus button

                    // Disable plus button nếu đã đạt giới hạn
                    if (currentQuantity >= totalPersons && totalPersons > 0) {
                        plusButton.disabled = true;
                        serviceItem.classList.add('disabled');
                    } else {
                        plusButton.disabled = false;
                        serviceItem.classList.remove('disabled');
                    }

                    // Nếu không có người nào, disable tất cả service buttons
                    if (totalPersons === 0) {
                        buttons.forEach(btn => btn.disabled = true);
                        serviceItem.classList.add('disabled');
                    } else {
                        // Enable minus button nếu có quantity
                        buttons[0].disabled = currentQuantity === 0; // Minus button
                    }
                });
            }

            // ✅ Hàm ẩn thông báo thành công
            function hideSuccessNotification() {
                const notification = document.getElementById('success-notification');
                if (notification) {
                    notification.style.animation = 'slideOutUp 0.3s ease-in';
                    setTimeout(() => {
                        notification.style.display = 'none';
                    }, 300);
                }
            }

            // ✅ Auto-hide thông báo sau 15 giây
            document.addEventListener('DOMContentLoaded', function () {
                loadTicketSlots(); // ✅ Load slot data

                const successNotification = document.getElementById('success-notification');
                if (successNotification) {
                    setTimeout(hideSuccessNotification, 15000);
                    window.scrollTo(0, 0);
                }

                updateTime();
                setInterval(updateTime, 1000);
                initCustomerSearch();
                updatePersonCounter(); // ✅ Initial update
            });

            // Update time
            function updateTime() {
                const now = new Date();
                const timeString = now.toLocaleTimeString('vi-VN', {
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit'
                });
                document.getElementById('current-time').textContent = timeString;
            }

            // Customer search functionality
            function initCustomerSearch() {
                const phoneInput = document.getElementById('customer-phone');
                const dropdown = document.getElementById('phone-dropdown');

                phoneInput.addEventListener('input', function () {
                    const phone = this.value.trim();

                    clearTimeout(searchTimeout);

                    if (phone.length >= 3) {
                        showLoading();
                        searchTimeout = setTimeout(function () {
                            searchCustomerByPhone(phone);
                        }, 300);
                    } else {
                        hideDropdown();
                        hideCustomerInfo();
                        hideManualInput();
                    }
                });

                document.addEventListener('click', function (e) {
                    if (!phoneInput.contains(e.target) && !dropdown.contains(e.target)) {
                        hideDropdown();
                    }
                });
            }

            function searchCustomerByPhone(phone) {
                fetch('staff_sale', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'action=searchCustomer&phone=' + encodeURIComponent(phone)
                })
                        .then(function (response) {
                            return response.text();
                        })
                        .then(function (data) {
                            hideLoading();
                            handleSearchResponse(data);
                        })
                        .catch(function (error) {
                            console.error('Error searching customer:', error);
                            hideLoading();
                            hideDropdown();
                            showManualInput();
                        });
            }

            function handleSearchResponse(responseText) {
                if (responseText.trim() === 'NOT_FOUND' || responseText.trim() === 'ERROR') {
                    hideDropdown();
                    showManualInput();
                } else {
                    var lines = responseText.trim().split('\n');
                    var customers = [];

                    for (var i = 0; i < lines.length; i++) {
                        var parts = lines[i].split('|');
                        if (parts.length >= 4) {
                            customers.push({
                                user_id: parts[0],
                                full_name: parts[1],
                                email: parts[2],
                                phone: parts[3]
                            });
                        }
                    }

                    if (customers.length > 0) {
                        showDropdown(customers);
                    } else {
                        hideDropdown();
                        showManualInput();
                    }
                }
            }

            function showLoading() {
                const dropdown = document.getElementById('phone-dropdown');
                dropdown.innerHTML = '<div class="loading-indicator">' +
                        '<div class="loading-spinner"></div>' +
                        'Đang tìm kiếm...' +
                        '</div>';
                dropdown.style.display = 'block';
            }

            function hideLoading() {
                const dropdown = document.getElementById('phone-dropdown');
                if (dropdown.querySelector('.loading-indicator')) {
                    dropdown.style.display = 'none';
                }
            }

            function showDropdown(customers) {
                const dropdown = document.getElementById('phone-dropdown');

                let html = '';
                for (let i = 0; i < customers.length; i++) {
                    const customer = customers[i];
                    html += '<div class="dropdown-item" onclick="selectCustomer(' +
                            customer.user_id + ', \'' +
                            escapeQuotes(customer.full_name) + '\', \'' +
                            escapeQuotes(customer.email) + '\', \'' +
                            escapeQuotes(customer.phone) + '\')">' +
                            '<div class="dropdown-item-name">' + customer.full_name + '</div>' +
                            '<div class="dropdown-item-info">' + customer.email + ' • ' + customer.phone + '</div>' +
                            '</div>';
                }

                dropdown.innerHTML = html;
                dropdown.style.display = 'block';
            }

            function escapeQuotes(str) {
                if (!str)
                    return '';
                return str.replace(/'/g, "\\'").replace(/"/g, '\\"');
            }

            function hideDropdown() {
                document.getElementById('phone-dropdown').style.display = 'none';
            }

            function selectCustomer(userId, name, email, phone) {
                currentCustomer = {
                    userId: userId,
                    name: name,
                    email: email,
                    phone: phone,
                    isExisting: true
                };

                document.getElementById('customer-phone').value = phone;
                document.getElementById('customer-name').value = name;
                document.getElementById('customer-email').value = email;
                document.getElementById('customer-status').textContent = 'Khách hàng có tài khoản';
                document.getElementById('customer-status').className = 'status-badge existing-customer';

                showCustomerInfo();
                hideDropdown();
                hideManualInput();
            }

            function showCustomerInfo() {
                document.getElementById('customer-info').style.display = 'block';
            }

            function hideCustomerInfo() {
                document.getElementById('customer-info').style.display = 'none';
            }

            function showManualInput() {
                document.getElementById('manual-input').style.display = 'block';
                hideCustomerInfo();

                currentCustomer = {
                    isExisting: false,
                    phone: document.getElementById('customer-phone').value
                };
            }

            function hideManualInput() {
                document.getElementById('manual-input').style.display = 'none';
            }

            // ✅ UPDATED changeQuantity với validation
            function changeQuantity(itemId, change) {
                const input = document.getElementById(itemId);
                let newValue = Math.max(0, parseInt(input.value) + change);

                // ✅ Validation cho services
                if (itemId.startsWith('service-') && change > 0) {
                    const totalPersons = calculateTotalPersons();
                    const currentServices = calculateTotalServices();

                    // Không cho phép vượt quá số người
                    if (currentServices >= totalPersons && totalPersons > 0) {
                        alert('Không thể thuê nhiều hơn ' + totalPersons + ' đồ vì chỉ có ' + totalPersons + ' người!');
                        return;
                    }
                }

                input.value = newValue;

                if (newValue > 0) {
                    selectedItems[itemId] = newValue;
                } else {
                    delete selectedItems[itemId];
                }

                updateSummary();
                updatePersonCounter(); // ✅ Update sau mỗi lần thay đổi
            }

            function updateSummary() {
                const summaryDiv = document.getElementById('order-summary');
                const paymentBtn = document.getElementById('payment-btn');
                let total = 0;

                summaryDiv.innerHTML = '';

                if (Object.keys(selectedItems).length === 0) {
                    summaryDiv.innerHTML = '<div class="empty-cart">' +
                            '<i class="fas fa-shopping-cart"></i>' +
                            '<div>Chưa có sản phẩm nào</div>' +
                            '</div>';
                    paymentBtn.disabled = true;
                } else {
                    for (let itemId in selectedItems) {
                        const quantity = selectedItems[itemId];
                        const element = document.getElementById(itemId).closest('.item');
                        const name = element.querySelector('.item-name').textContent;
                        const priceText = element.querySelector('.item-price').textContent;

                        const cleanPrice = priceText.replace(/[^\d,]/g, '').replace(/,/g, '');
                        const price = parseInt(cleanPrice);

                        const amount = price * quantity;
                        total += amount;

                        const summaryLine = document.createElement('div');
                        summaryLine.className = 'summary-line';

                        const nameSpan = document.createElement('span');
                        nameSpan.className = 'summary-item-name';
                        nameSpan.textContent = name + ' ×' + quantity;

                        const priceSpan = document.createElement('span');
                        priceSpan.className = 'summary-item-price';
                        priceSpan.textContent = formatCurrency(amount);

                        summaryLine.appendChild(nameSpan);
                        summaryLine.appendChild(priceSpan);
                        summaryDiv.appendChild(summaryLine);
                    }
                    paymentBtn.disabled = false;
                }

                document.getElementById('total-amount').textContent = formatCurrency(total);
            }

            function formatCurrency(amount) {
                return new Intl.NumberFormat('vi-VN').format(amount) + ' ₫';
            }

            function processPayment() {
                if (!currentCustomer) {
                    alert('Vui lòng nhập thông tin khách hàng!');
                    document.getElementById('customer-phone').focus();
                    return;
                }

                if (!currentCustomer.isExisting) {
                    const manualName = document.getElementById('manual-name').value.trim();
                    if (!manualName) {
                        alert('Vui lòng nhập họ tên khách hàng!');
                        document.getElementById('manual-name').focus();
                        return;
                    }
                    currentCustomer.name = manualName;
                    currentCustomer.email = document.getElementById('manual-email').value.trim();
                }

                if (Object.keys(selectedItems).length === 0) {
                    alert('Vui lòng chọn ít nhất một sản phẩm!');
                    return;
                }

                // ✅ Final validation trước khi submit
                const totalPersons = calculateTotalPersons();
                const totalServices = calculateTotalServices();

                if (totalServices > totalPersons && totalPersons > 0) {
                    alert('Số lượng đồ thuê (' + totalServices + ') không được vượt quá số người (' + totalPersons + ')!');
                    return;
                }

                const total = document.getElementById('total-amount').textContent;
                const itemCount = Object.keys(selectedItems).length;

                if (confirm('Xác nhận thanh toán:\n- Khách hàng: ' + currentCustomer.name + '\n- Số mặt hàng: ' + itemCount + '\n- Tổng tiền: ' + total + '\n\nBạn có muốn tiếp tục?')) {

                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'staff_sale';

                    form.appendChild(createHiddenInput('action', 'processPayment'));
                    form.appendChild(createHiddenInput('customerPhone', currentCustomer.phone));
                    form.appendChild(createHiddenInput('customerName', currentCustomer.name));
                    form.appendChild(createHiddenInput('customerEmail', currentCustomer.email || ''));
                    form.appendChild(createHiddenInput('isExisting', currentCustomer.isExisting.toString()));

                    if (currentCustomer.isExisting && currentCustomer.userId) {
                        form.appendChild(createHiddenInput('userId', currentCustomer.userId.toString()));
                    }

                    for (let itemId in selectedItems) {
                        const quantity = selectedItems[itemId];
                        const element = document.getElementById(itemId).closest('.item');
                        const priceText = element.querySelector('.item-price').textContent;
                        const cleanPrice = priceText.replace(/[^\d,]/g, '').replace(/,/g, '');

                        form.appendChild(createHiddenInput(itemId, quantity.toString()));
                        form.appendChild(createHiddenInput(itemId + '-price', cleanPrice));
                    }

                    document.body.appendChild(form);
                    form.submit();
                }
            }

            function createHiddenInput(name, value) {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = name;

                input.value = value;
                return input;
            }

            // ✅ CSS cho animation slideOutUp
            const style = document.createElement('style');
            style.textContent = `
                @keyframes slideOutUp {
                    from {
                        opacity: 1;
                        transform: translateY(0);
                    }
                    to {
                        opacity: 0;
                        transform: translateY(-30px);
                    }
                }
            `;
            document.head.appendChild(style);
        </script>
    </body>
</html>