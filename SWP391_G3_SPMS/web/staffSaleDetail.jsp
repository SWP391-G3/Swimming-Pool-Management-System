<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết giao dịch - Hệ thống bể bơi</title>
        <link rel="stylesheet" href="./manager-css/manager-device-v2.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- CSS giống như trên, nhưng đơn giản hơn... -->
        <style>
            :root {
                --primary-color: #2196F3;
                --primary-dark: #1976D2;
                --success-color: #4CAF50;
                --warning-color: #FF9800;
                --error-color: #F44336;
                --background-color: #F8FAFE;
                --surface-color: #FFFFFF;
                --text-primary: #212121;
                --text-secondary: #757575;
                --border-color: #E0E0E0;
                --shadow: 0 4px 12px rgba(0,0,0,0.1);
                --border-radius: 12px;
                --transition: all 0.3s ease;
                --sidebar-width: 250px;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, var(--background-color) 0%, #E3F2FD 100%);
                color: var(--text-primary);
                line-height: 1.6;
            }

            .layout {
                display: flex;
                min-height: 100vh;
            }

            .main-content {
                flex: 1;
                margin-left: var(--sidebar-width);
                padding: 20px;
            }

            .header {
                background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
                color: white;
                padding: 20px 24px;
                border-radius: var(--border-radius);
                margin-bottom: 20px;
                box-shadow: var(--shadow);
                position: relative;
                overflow: hidden;
            }

            .header h1 {
                font-size: 24px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 8px;
            }

            .back-btn {
                background: rgba(255,255,255,0.2);
                color: white;
                padding: 8px 16px;
                border-radius: 8px;
                text-decoration: none;
                font-size: 14px;
                font-weight: 500;
                transition: var(--transition);
                display: inline-flex;
                align-items: center;
                gap: 8px;
                margin-top: 12px;
            }

            .back-btn:hover {
                background: rgba(255,255,255,0.3);
                color: white;
                transform: translateY(-1px);
            }

            .detail-container {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin-bottom: 20px;
            }

            .detail-section {
                background: var(--surface-color);
                padding: 20px;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
                border-left: 4px solid var(--primary-color);
            }

            .detail-section h3 {
                font-size: 18px;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 16px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .detail-section h3 i {
                color: var(--primary-color);
                font-size: 20px;
            }

            .detail-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 16px;
            }

            .detail-item {
                display: flex;
                flex-direction: column;
                gap: 4px;
            }

            .detail-label {
                font-size: 12px;
                font-weight: 600;
                color: var(--text-secondary);
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .detail-value {
                font-size: 15px;
                color: var(--text-primary);
                font-weight: 500;
            }

            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                display: inline-block;
            }

            .status-completed {
                background: #e8f5e8;
                color: var(--success-color);
            }

            .status-pending {
                background: #fff3cd;
                color: var(--warning-color);
            }

            .customer-type {
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 11px;
                font-weight: 600;
            }

            .customer-existing {
                background: #e8f5e8;
                color: var(--success-color);
            }

            .customer-guest {
                background: #e3f2fd;
                color: var(--primary-color);
            }

            .items-section {
                background: var(--surface-color);
                padding: 20px;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
                margin-bottom: 20px;
            }

            .items-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .item-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 16px;
                background: var(--background-color);
                border-radius: 8px;
                margin-bottom: 8px;
                border: 1px solid var(--border-color);
            }

            .item-info {
                flex: 1;
            }

            .item-name {
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 2px;
            }

            .item-code {
                font-size: 12px;
                color: var(--text-secondary);
                font-family: 'Courier New', monospace;
            }

            .item-price {
                text-align: right;
            }

            .item-quantity {
                font-size: 12px;
                color: var(--text-secondary);
                margin-bottom: 2px;
            }

            .item-amount {
                font-weight: 600;
                color: var(--success-color);
            }

            .total-section {
                background: linear-gradient(135deg, var(--success-color) 0%, #45A049 100%);
                color: white;
                padding: 20px;
                border-radius: var(--border-radius);
                text-align: center;
                box-shadow: var(--shadow);
            }

            .total-amount {
                font-size: 28px;
                font-weight: 700;
                margin: 0;
            }

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
            }

            @media (max-width: 1024px) {
                .main-content {
                    margin-left: 0;
                    padding: 16px;
                }

                .detail-container {
                    grid-template-columns: 1fr;
                    gap: 16px;
                }

                .detail-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <div class="layout">
            <%@ include file="./staffSidebar.jsp" %>

            <div class="main-content">
                <!-- Header -->
                <div class="header">
                    <h1>
                        <i class="fas fa-receipt"></i>
                        Chi tiết giao dịch
                        <c:if test="${detailInfo.sale != null}">
                            #${detailInfo.sale.saleId}
                        </c:if>
                    </h1>
                    <a href="staff_sale_history" class="back-btn">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại danh sách
                    </a>
                </div>

                <!-- Error Message -->
                <c:if test="${error != null}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-triangle"></i>
                        <span>${error}</span>
                    </div>
                </c:if>

                <c:if test="${detailInfo != null && detailInfo.sale != null}">
                    <!-- Sale & Customer Info -->
                    <div class="detail-container">
                        <!-- Sale Information -->
                        <div class="detail-section">
                            <h3><i class="fas fa-info-circle"></i> Thông tin giao dịch</h3>
                            <div class="detail-grid">
                                <div class="detail-item">
                                    <div class="detail-label">Mã giao dịch</div>
                                    <div class="detail-value">#${detailInfo.sale.saleId}</div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Ngày bán</div>
                                    <div class="detail-value">
                                        <fmt:formatDate value="${detailInfo.sale.saleDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Mã booking</div>
                                    <div class="detail-value">#${detailInfo.sale.bookingId}</div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Phương thức</div>
                                    <div class="detail-value">${detailInfo.sale.paymentMethod}</div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Trạng thái</div>
                                    <div class="detail-value">
                                        <span class="status-badge status-${detailInfo.sale.paymentStatus}">
                                            <c:choose>
                                                <c:when test="${detailInfo.sale.paymentStatus == 'completed'}">Hoàn thành</c:when>
                                                <c:when test="${detailInfo.sale.paymentStatus == 'pending'}">Đang xử lý</c:when>
                                                <c:when test="${detailInfo.sale.paymentStatus == 'failed'}">Thất bại</c:when>
                                                <c:otherwise>${detailInfo.sale.paymentStatus}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Ghi chú</div>
                                    <div class="detail-value">${detailInfo.sale.notes != null ? detailInfo.sale.notes : 'Không có'}</div>
                                </div>
                            </div>
                        </div>

                        <!-- Customer Information -->
                        <div class="detail-section">
                            <h3><i class="fas fa-user"></i> Thông tin khách hàng</h3>
                            <div class="detail-grid">
                                <div class="detail-item">
                                    <div class="detail-label">Họ tên</div>
                                    <div class="detail-value">${detailInfo.sale.customerName}</div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Số điện thoại</div>
                                    <div class="detail-value">${detailInfo.sale.customerPhone}</div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Email</div>
                                    <div class="detail-value">${detailInfo.sale.customerEmail != null ? detailInfo.sale.customerEmail : 'Không có'}</div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Loại khách hàng</div>
                                    <div class="detail-value">
                                        <c:choose>
                                            <c:when test="${detailInfo.sale.userId != null}">
                                                <span class="customer-type customer-existing">Có tài khoản</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="customer-type customer-guest">Khách vãng lai</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Booking Information -->
                    <c:if test="${detailInfo.booking != null}">
                        <div class="detail-section">
                            <h3><i class="fas fa-calendar-alt"></i> Thông tin đặt chỗ</h3>
                            <div class="detail-grid">
                                <div class="detail-item">
                                    <div class="detail-label">Ngày sử dụng</div>
                                    <div class="detail-value">
                                        <fmt:formatDate value="${detailInfo.booking.bookingDate}" pattern="dd/MM/yyyy"/>
                                    </div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Thời gian</div>
                                    <div class="detail-value">${detailInfo.booking.startTime} - ${detailInfo.booking.endTime}</div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Số người</div>
                                    <div class="detail-value">${detailInfo.booking.slotCount} người</div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Trạng thái booking</div>
                                    <div class="detail-value">
                                        <span class="status-badge status-${detailInfo.booking.bookingStatus}">
                                            <c:choose>
                                                <c:when test="${detailInfo.booking.bookingStatus == 'confirmed'}">Đã xác nhận</c:when>
                                                <c:when test="${detailInfo.booking.bookingStatus == 'pending'}">Đang xử lý</c:when>
                                                <c:when test="${detailInfo.booking.bookingStatus == 'cancelled'}">Đã hủy</c:when>
                                                <c:when test="${detailInfo.booking.bookingStatus == 'completed'}">Hoàn thành</c:when>
                                                <c:otherwise>${detailInfo.booking.bookingStatus}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Tickets -->
                    <c:if test="${detailInfo.tickets != null && fn:length(detailInfo.tickets) > 0}">
                        <div class="items-section">
                            <h3><i class="fas fa-ticket-alt"></i> Danh sách vé (${fn:length(detailInfo.tickets)})</h3>
                            <ul class="items-list">
                                <c:forEach var="ticket" items="${detailInfo.tickets}">
                                    <li class="item-row">
                                        <div class="item-info">
                                            <div class="item-name">${ticket.ticketTypeName}</div>
                                            <div class="item-code">Mã: ${ticket.ticketCode != null ? ticket.ticketCode : 'Chưa có'}</div>
                                        </div>
                                        <div class="item-price">
                                            <div class="item-quantity">SL: ${ticket.quantity}</div>
                                            <div class="item-amount">
                                                <fmt:formatNumber value="${ticket.ticketPrice}" type="number" groupingUsed="true"/>₫
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>

                    <!-- Services -->
                    <c:if test="${detailInfo.services != null && fn:length(detailInfo.services) > 0}">
                        <div class="items-section">
                            <h3><i class="fas fa-concierge-bell"></i> Dịch vụ thuê (${fn:length(detailInfo.services)})</h3>
                            <ul class="items-list">
                                <c:forEach var="service" items="${detailInfo.services}">
                                    <li class="item-row">
                                        <div class="item-info">
                                            <div class="item-name">${service.serviceName}</div>
                                            <div class="item-code">${service.description != null ? service.description : ''}</div>
                                        </div>
                                        <div class="item-price">
                                            <div class="item-quantity">SL: ${service.quantity}</div>
                                            <div class="item-amount">
                                                <fmt:formatNumber value="${service.servicePrice}" type="number" groupingUsed="true"/>₫
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>

                    <!-- Total Amount -->
                    <div class="total-section">
                        <h2 class="total-amount">
                            Tổng tiền: <fmt:formatNumber value="${detailInfo.sale.totalAmount}" type="number" groupingUsed="true"/>₫
                        </h2>
                    </div>
                </c:if>
            </div>
        </div>
    </body>
</html>