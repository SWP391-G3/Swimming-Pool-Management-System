<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    model.staff.StaffJoinedTable staff = (model.staff.StaffJoinedTable) session.getAttribute("staff");
    model.customer.User user = (model.customer.User) session.getAttribute("currentUser");
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Dịch vụ hồ bơi - Nhân viên</title>
        <link rel="stylesheet" href="./manager-css/manager-device-v3.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
        <style>
            .content-panel {
                padding: 20px 40px;
            }
            .staff-info-box {
                background: #f4f7fa;
                padding: 14px 22px;
                border-radius: 10px;
                margin-bottom: 22px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 15px;
                background: #c4d8f4
            }
            .staff-info-list {
                display: flex;
                flex-wrap: wrap;
                gap: 25px;
                align-items: center;
            }
            .staff-info-item b {
                color: #1976d2;
            }
            .logout-btn {
                background: #e53e3e;
                color: white;
                border: none;
                padding: 8px 20px;
                border-radius: 7px;
                font-weight: 600;
                font-size: 1em;
                cursor: pointer;
                transition: background 0.18s;
                text-decoration: none
            }
            .logout-btn:hover {
                background: #b91c1c;
            }
            /* CSS còn lại giữ nguyên */
            .filter-form {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }
            .filter-form input, .filter-form select {
                padding: 6px 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .btn-filter {
                background: #2690ff;
                color: #fff;
                border: none;
                padding: 6px 18px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
            }
            .btn-filter:hover {
                background: #1976d2;
            }
            .btn-reset {
                background: #ede7f6;
                color: #8e24aa;
                border: none;
                padding: 6px 18px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
                margin-left: 2px;
                text-decoration: none;
                display: inline-block;
            }
            .btn-reset:hover {
                background: #d1c4e9;
                color: #6d1b7b;
            }
            .service-card-grid {
                display: flex;
                flex-wrap: wrap;
                gap: 22px;
                margin-bottom: 28px;
                justify-content: center;
            }
            .service-card {
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 16px 0 rgba(34,34,34,0.07);
                padding: 22px 18px 18px 18px;
                display: flex;
                flex-direction: column;
                align-items: center;
                min-height: 220px;
                position: relative;
                transition: box-shadow 0.18s;
                max-width: 380px;
                width: 100%;
            }
            .service-card:hover {
                box-shadow: 0 8px 24px 0 rgba(52, 152, 219, 0.14);
            }
            .service-thumb img {
                width: 64px;
                height: 64px;
                object-fit: cover;
                border-radius: 8px;
                margin-bottom: 12px;
                background: #fafbfd;
                border: 1px solid #e0e0e0;
            }
            .service-title {
                font-weight: 700;
                font-size: 1.12em;
                margin-bottom: 8px;
                text-align: center;
            }
            .service-info {
                font-size: 0.99em;
                margin-bottom: 4px;
                color: #444;
                text-align: center;
            }
            .status-badge {
                display: inline-block;
                padding: 4px 12px;
                border-radius: 15px;
                font-size: 0.97em;
                font-weight: 500;
                color: #fff;
            }
            .status-active {
                background: #43a047;
            }
            .status-maintenance {
                background: #f9a825;
            }
            .status-inactive {
                background: #e53935;
            }
            .btn-detail {
                margin-top: 13px;
                padding: 6px 26px;
                border-radius: 6px;
                background: #2690ff;
                color: #fff;
                border: none;
                cursor: pointer;
                font-weight: 500;
                transition: background 0.18s;
                font-size: 1em;
            }
            .btn-detail:hover {
                background: #1976d2;
            }
            .no-service {
                width: 100%;
                text-align: center;
                color: #888;
                font-style: italic;
                font-size: 1.11em;
                margin-top: 38px;
            }
            .pagination {
                margin-top: 20px;
                text-align: center;
            }
            .pagination a, .pagination span {
                margin: 0 3px;
                padding: 6px 12px;
                border: 1px solid #ccc;
                text-decoration: none;
                border-radius: 4px;
                color: #333;
                background: #fff;
                font-weight: 500;
            }
            .pagination a:hover {
                background: #e3f0fd;
                color: #1a73e8;
                border-color: #1a73e8;
            }
            .pagination .active {
                background-color: #1976d2;
                color: white;
                font-weight: bold;
                border-color: #1976d2;
            }
            .pagination .disabled {
                color: #aaa;
                border-color: #eee;
                background: #fafafa;
                pointer-events: none;
            }
        </style>
    </head>
    <body>
        <div class="layout">
            <%@ include file="./staffSidebar.jsp" %>

            <div class="content-panel">
                <div class="header">
                    <h2>Dịch vụ hồ bơi</h2>
                </div>
                <!-- Bộ lọc -->
                <form class="filter-form" method="get" action="staffPoolService">
                    <input type="text" name="name" placeholder="Tên dịch vụ..." value="${fn:escapeXml(name)}">

                    <input type="number" name="minPrice" placeholder="Giá từ" value="${minPrice}">
                    <input type="number" name="maxPrice" placeholder="Đến" value="${maxPrice}">
                    <select name="pageSize">
                        <option value="5" ${pageSize == 5 ? 'selected' : ''}>5/trang</option>
                        <option value="10" ${pageSize == 10 ? 'selected' : ''}>10/trang</option>
                        <option value="15" ${pageSize == 15 ? 'selected' : ''}>15/trang</option>
                    </select>
                    <button type="submit" class="btn-filter">Lọc</button>
                    <a href="staffPoolService" class="btn-reset">Reset</a>
                </form>
                <!-- Danh sách dịch vụ dạng card -->
                <div class="service-card-grid">
                    <c:choose>
                        <c:when test="${empty list}">
                            <div class="no-service">Không có dịch vụ nào phù hợp.</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="ps" items="${list}">
                                <div class="service-card">
                                    <div class="service-thumb">
                                        <img src="${ps.serviceImage}" alt="${ps.serviceName}">
                                    </div>
                                    <div class="service-title">${ps.serviceName}</div>
                                    <div class="service-info"><b>Giá:</b> ${ps.price} VND</div>
                                    <div class="service-info"><b>Số lượng:</b> ${ps.quantity}</div>
                                    <div class="service-info">
                                        <b>Trạng thái:</b>
                                        <c:choose>
                                            <c:when test="${ps.serviceStatus eq 'available'}">
                                                <span class="status-badge status-active">Hoạt động</span>
                                            </c:when>
                                            <c:when test="${ps.serviceStatus eq 'maintenance'}">
                                                <span class="status-badge status-maintenance">Bảo trì</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-inactive">Ngưng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <button class="btn-detail"
                                            onclick="window.location.href = 'staffPoolServiceDetail?id=${ps.poolServiceId}'">
                                        Xem chi tiết
                                    </button>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <!-- Phân trang -->
                <div class="pagination">
                    <c:if test="${endPage > 1}">
                        <!-- Nút về đầu -->
                        <c:if test="${page > 1}">
                            <a href="staffPoolService?page=1&name=${fn:escapeXml(name)}&minPrice=${minPrice}&maxPrice=${maxPrice}&poolName=${fn:escapeXml(poolName)}&pageSize=${pageSize}">&laquo;</a>
                        </c:if>
                        <!-- Dấu ... đầu nếu cần -->
                        <c:if test="${page - 2 > 1}">
                            <span>...</span>
                        </c:if>

                        <!-- Trang đầu nếu đang cách xa trang hiện tại -->
                        <c:if test="${page - 2 > 0}">
                            <a href="staffPoolService?page=1&name=${fn:escapeXml(name)}&minPrice=${minPrice}&maxPrice=${maxPrice}&poolName=${fn:escapeXml(poolName)}&pageSize=${pageSize}" class="${page == 1 ? 'active' : ''}">1</a>
                        </c:if>

                        <!-- Vùng các trang xung quanh trang hiện tại -->
                        <c:forEach var="i" begin="${page - 1 > 1 ? page - 1 : 1}" end="${page + 1 < endPage ? page + 1 : endPage}">
                            <a href="staffPoolService?page=${i}&name=${fn:escapeXml(name)}&minPrice=${minPrice}&maxPrice=${maxPrice}&poolName=${fn:escapeXml(poolName)}&pageSize=${pageSize}" class="${i == page ? 'active' : ''}">${i}</a>
                        </c:forEach>

                        <!-- Trang cuối nếu đang cách xa trang hiện tại -->
                        <c:if test="${page + 2 < endPage}">
                            <a href="staffPoolService?page=${endPage}&name=${fn:escapeXml(name)}&minPrice=${minPrice}&maxPrice=${maxPrice}&poolName=${fn:escapeXml(poolName)}&pageSize=${pageSize}" class="${page == endPage ? 'active' : ''}">${endPage}</a>
                        </c:if>

                        <!-- Dấu ... cuối nếu cần -->
                        <c:if test="${page + 2 < endPage}">
                            <span>...</span>
                        </c:if>

                        <!-- Nút về cuối -->
                        <c:if test="${page < endPage}">
                            <a href="staffPoolService?page=${endPage}&name=${fn:escapeXml(name)}&minPrice=${minPrice}&maxPrice=${maxPrice}&poolName=${fn:escapeXml(poolName)}&pageSize=${pageSize}">&raquo;</a>
                        </c:if>
                    </c:if>
                </div>
            </div>
        </div>
    </body>
</html>
