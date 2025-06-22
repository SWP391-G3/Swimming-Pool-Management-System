<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    request.setAttribute("activeMenu", "pool-service");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý dịch vụ hồ bơi</title>
        <link rel="stylesheet" href="./manager-css/manager-device-v3.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
        <style>
            .content-panel {
                padding: 20px 40px;
            }
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
            .card {
                border: 1px solid #e1e1e1;
                border-radius: 8px;
                padding: 10px;
                margin-bottom: 15px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                cursor: pointer;
            }
            .card img {
                height: 50px;
                width: 50px;
                border-radius: 4px;
                object-fit: cover;
            }
            .card-content {
                display: flex;
                align-items: center;
                gap: 15px;
                flex-grow: 1;
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

            .table-pool-service {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 1px 3px rgba(0,0,0,0.04);
                margin-bottom: 20px;
            }
            .table-pool-service th, .table-pool-service td {
                padding: 10px 14px;
                text-align: left;
                border-bottom: 1px solid #eee;
            }
            .table-pool-service th {
                background: #f5f5f5;
                font-weight: 600;
            }
            .table-pool-service tr:last-child td {
                border-bottom: none;
            }
            .table-pool-service img {
                height: 42px;
                width: 42px;
                border-radius: 4px;
                object-fit: cover;
                background: #fafafa;
                border: 1px solid #eaeaea;
            }
            .status-badge {
                display: inline-block;
                padding: 3px 10px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 500;
                color: #fff;
            }
            .status-active {
                background: #43a047;
            }
            .status-inactive {
                background: #e53935;
            }
            .btn-delete {
                background: #ffebee;
                color: #d32f2f;
                border: none;
                padding: 6px 18px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
            }
            .btn-delete:hover {
                background: #ffcdd2;
                color: #b71c1c;
            }

            .btn-delete {
                background: #ffebee;
                color: #d32f2f;
                border: none;
                padding: 6px 18px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
            }
        </style>
    </head>
    <body>
        <div class="layout">
            <%@ include file="../managerSidebar.jsp" %>
            <div class="content-panel">
                <div class="header">
                    <h2>Quản lý dịch vụ hồ bơi</h2>
                    <button class="btn-add" onclick="window.location.href = 'pool-service?action=add'">+ Thêm dịch vụ</button>

                </div>
                <!-- Bộ lọc -->
                <form class="filter-form" method="get" action="pool-service">
                    <input type="text" name="name" placeholder="Tên dịch vụ..." value="${fn:escapeXml(name)}">
                    <select name="poolId">
                        <option value="">-- Tất cả hồ bơi --</option>
                        <c:forEach var="pool" items="${poolList}">
                            <option value="${pool.pool_id}" <c:if test="${poolId == pool.pool_id}">selected</c:if>>${pool.pool_name}</option>
                        </c:forEach>
                    </select>
                    <input type="number" name="minPrice" placeholder="Giá từ" value="${minPrice}">
                    <input type="number" name="maxPrice" placeholder="Đến" value="${maxPrice}">
                    <select name="pageSize">
                        <option value="5" ${pageSize == 5 ? 'selected' : ''}>5/trang</option>
                        <option value="10" ${pageSize == 10 ? 'selected' : ''}>10/trang</option>
                        <option value="15" ${pageSize == 15 ? 'selected' : ''}>15/trang</option>
                    </select>
                    <button type="submit" class="btn-filter">Lọc</button>
                    <a href="pool-service" class="btn-reset">Reset</a>
                </form>

                <!-- Danh sách dịch vụ -->
                <c:choose>
                    <c:when test="${empty list}">
                        <p style="text-align: center; color: gray; font-style: italic;">Không có dịch vụ nào phù hợp.</p>
                    </c:when>
                    <c:otherwise>
                        <table class="table-pool-service">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên dịch vụ</th>
                                    <th>Giá (VND)</th>
                                    <th>Ảnh</th>
                                    <th>Số lượng</th>
                                    <th>Trạng thái</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="ps" items="${list}">
                                    <tr  onclick="location.href = 'pool-service?action=detail&id=${ps.poolServiceId}'" style="cursor:pointer;">
                                        <td>${ps.poolServiceId}</td>
                                        <td><strong>${ps.serviceName}</strong></td>
                                        <td>${ps.price}</td>
                                        <td>
                                            <img src="${ps.serviceImage}" alt="">
                                        </td>
                                        <td>${ps.quantity}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${ps.serviceStatus eq 'available'}">
                                                    <span class="status-badge status-active">Hoạt động</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-inactive">Ngưng</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="white-space:nowrap;">
                                            <button class="btn-edit" onclick="event.stopPropagation(); window.location.href = 'pool-service?action=edit&id=${ps.poolServiceId}'">Chỉnh sửa</button>
                                            <button class="btn-delete" onclick="event.stopPropagation(); deleteService(${ps.poolServiceId})">Xóa</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
                <!-- Phân trang thông minh -->
                <div class="pagination">
                    <c:choose>
                        <c:when test="${endPage > 1}">
                            <c:set var="range" value="2"/>
                            <c:set var="start" value="${page - range > 1 ? page - range : 1}"/>
                            <c:set var="end" value="${page + range < endPage ? page + range : endPage}"/>

                            <!-- Trang đầu -->
                            <c:if test="${page > 1}">
                                <a href="pool-service?page=1&name=${fn:escapeXml(name)}&minPrice=${minPrice}&maxPrice=${maxPrice}&poolId=${poolId}&pageSize=${pageSize}">&laquo;</a>
                            </c:if>
                            <!-- Dấu ... trước -->
                            <c:if test="${start > 1}">
                                <span>...</span>
                            </c:if>
                            <!-- Các trang chính -->
                            <c:forEach var="i" begin="${start}" end="${end}">
                                <a href="pool-service?page=${i}&name=${fn:escapeXml(name)}&minPrice=${minPrice}&maxPrice=${maxPrice}&poolId=${poolId}&pageSize=${pageSize}" class="${i == page ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            <!-- Dấu ... sau -->
                            <c:if test="${end < endPage}">
                                <span>...</span>
                            </c:if>
                            <!-- Trang cuối -->
                            <c:if test="${page < endPage}">
                                <a href="pool-service?page=${endPage}&name=${fn:escapeXml(name)}&minPrice=${minPrice}&maxPrice=${maxPrice}&poolId=${poolId}&pageSize=${pageSize}">&raquo;</a>
                            </c:if>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>
        <script>
            function deleteService(id) {
                if (confirm('Xác nhận xóa dịch vụ?')) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'pool-service';

                    const actionInput = document.createElement('input');
                    actionInput.name = 'action';
                    actionInput.value = 'delete';
                    form.appendChild(actionInput);

                    const idInput = document.createElement('input');
                    idInput.name = 'id';
                    idInput.value = id;
                    form.appendChild(idInput);

                    document.body.appendChild(form);
                    form.submit();
                }
            }
        </script>
    </body>
</html>
