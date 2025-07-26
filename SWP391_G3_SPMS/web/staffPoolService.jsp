<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    model.staff.StaffJoinedTable staff = (model.staff.StaffJoinedTable) session.getAttribute("staff");
    model.customer.User user = (model.customer.User) session.getAttribute("staffAccount");
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Dịch vụ hồ bơi - Nhân viên</title>
        <link rel="stylesheet" href="./manager-css/manager-device-v3.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
        <style>
            body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: #f4f6f8;
        margin: 0;
        padding: 0;
        color: #333;
    }

    .content-panel {
        padding: 30px 50px;
        max-width: 1200px;
        margin: 0 auto;
    }

    .header h2 {
        color: #1e3a8a;
        font-size: 2rem;
        margin-bottom: 24px;
    }

    .filter-form {
        display: flex;
        flex-wrap: wrap;
        gap: 12px;
        margin-bottom: 28px;
        align-items: center;
    }

    .filter-form input,
    .filter-form select {
        padding: 10px 14px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 1rem;
        background: #fff;
        box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.05);
    }

    .btn-filter,
    .btn-reset {
        padding: 10px 20px;
        border-radius: 8px;
        font-weight: 600;
        font-size: 0.95rem;
        cursor: pointer;
        border: none;
        transition: background 0.2s ease;
    }

    .btn-filter {
        background: #3b82f6;
        color: #fff;
    }

    .btn-filter:hover {
        background: #2563eb;
    }

    .btn-reset {
        background: #f0f0f0;
        color: #6b21a8;
        border: 1px solid #d1d5db;
    }

    .btn-reset:hover {
        background: #e9e9e9;
        color: #4c1d95;
    }

    .service-card-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 24px;
        margin-bottom: 32px;
    }

    .service-card {
        background: #fff;
        border-radius: 16px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
        padding: 24px 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .service-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .service-thumb img {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 10px;
        border: 1px solid #e5e7eb;
        background: #f9fafb;
        transition: transform 0.2s ease;
    }

    .service-card:hover .service-thumb img {
        transform: scale(1.05);
    }

    .service-title {
        font-size: 1.2rem;
        font-weight: 700;
        margin: 12px 0 6px;
        color: #1f2937;
        text-align: center;
    }

    .service-info {
        font-size: 0.95rem;
        color: #4b5563;
        margin: 2px 0;
        text-align: center;
    }

    .status-badge {
        display: inline-block;
        padding: 5px 14px;
        border-radius: 999px;
        font-size: 0.85rem;
        font-weight: 600;
        color: white;
    }

    .status-active {
        background: #22c55e;
    }

    .status-maintenance {
        background: #facc15;
        color: #111827;
    }

    .status-inactive {
        background: #ef4444;
    }

    .btn-detail {
        margin-top: 16px;
        padding: 8px 24px;
        border-radius: 8px;
        background: #3b82f6;
        color: #fff;
        border: none;
        cursor: pointer;
        font-weight: 600;
        font-size: 0.95rem;
        transition: background 0.2s ease;
    }

    .btn-detail:hover {
        background: #2563eb;
    }

    .no-service {
        width: 100%;
        text-align: center;
        color: #9ca3af;
        font-style: italic;
        font-size: 1.1rem;
        margin-top: 48px;
    }

    .pagination {
        margin-top: 32px;
        text-align: center;
    }

    .pagination a,
    .pagination span {
        margin: 0 5px;
        padding: 8px 14px;
        border-radius: 8px;
        text-decoration: none;
        font-size: 0.95rem;
        font-weight: 600;
        color: #374151;
        border: 1px solid #e5e7eb;
        background: #fff;
        transition: background 0.2s ease;
    }

    .pagination a:hover {
        background: #e0f2fe;
        color: #2563eb;
        border-color: #2563eb;
    }

    .pagination .active {
        background-color: #2563eb;
        color: white;
        border-color: #2563eb;
    }

    .pagination .disabled {
        color: #9ca3af;
        border-color: #f3f4f6;
        background: #f9fafb;
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
                                        Báo cáo
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
