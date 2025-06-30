<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    request.setAttribute("activeMenu", "device");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý thiết bị hồ bơi</title>
        <link rel="stylesheet" href="./manager-css/manager-device-v3.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
    </head>
    <body>
        <div class="layout">
            <!-- Sidebar  --> 
            <%@ include file="../managerSidebar.jsp" %>

            <div class="content-panel">
                <%-- Thông báo thành công/lỗi đặt ở đây --%>
                <c:if test="${not empty sessionScope.importSuccess}">
                    <div class="alert alert-success" style="color: green; background: #e6f7e6; border: 1px solid #8fd98f; border-radius: 4px; padding: 8px 16px; margin: 16px 0 18px 0; font-weight: 500;">
                        ${sessionScope.importSuccess}
                    </div>
                    <%
                        session.removeAttribute("importSuccess");
                    %>
                </c:if>
                    <c:if test="${not empty sessionScope.importErrors}">
                    <div class="alert alert-danger" style="color: #b30000; background: #ffeaea; border: 1px solid #ffb3b3; border-radius: 4px; padding: 8px 16px; margin: 16px 0 18px 0; font-weight: 500;">
                        <ul style="margin:0 0 0 16px;">
                            <c:forEach var="err" items="${sessionScope.importErrors}">
                                <li>${err}</li>
                                </c:forEach>
                        </ul>
                    </div>
                    <%
                        session.removeAttribute("importErrors");
                    %>
                </c:if>
                
                <!-- Kết thúc vùng thông báo -->

                <div class="header">
                    <h2>Quản lý thiết bị hồ bơi</h2>

                    <form class="search-form" method="get" action="managerListDeviceServlet" id="searchForm">
                        <input type="text" name="keyword" placeholder="Tìm theo tên thiết bị..." value="${keyword}">
                        <select name="poolId">
                            <option value="">-- Tất cả hồ bơi --</option>
                            <c:forEach var="pool" items="${poolList}">
                                <option value="${pool.poolId}" <c:if test="${fn:trim(pool.poolId) == fn:trim(poolId)}">selected</c:if>>${pool.poolName}</option>
                            </c:forEach>
                        </select>
                        <select name="status">
                            <option value="">-- Tất cả trạng thái --</option>
                            <option value="available" ${status == 'available' ? 'selected' : ''}>Tốt</option>
                            <option value="maintenance" ${status == 'maintenance' ? 'selected' : ''}>Bảo trì</option>
                            <option value="broken" ${status == 'broken' ? 'selected' : ''}>Hỏng</option>
                        </select>
                        <select name="pageSize" id="pageSizeSelect" onchange="document.getElementById('searchForm').submit();">
                            <option value="5" ${pageSize == 5 ? 'selected' : ''}>5/Trang</option>
                            <option value="10" ${pageSize == 10 ? 'selected' : ''}>10/Trang</option>
                            <option value="15" ${pageSize == 15 ? 'selected' : ''}>15/Trang</option>
                        </select>
                        <input type="hidden" name="page" value="${page}">
                        <button type="submit">Tìm kiếm</button>
                    </form>

                    <a href="managerAddDeviceServlet?poolId=${poolId}&keyword=${keyword}&status=${status}&page=${page}&pageSize=${pageSize}" class="btn-add">+ Thêm thiết bị</a>
                </div>
                <table class="equipment-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Ảnh</th>
                            <th>Tên thiết bị</th>
                            <th>Hồ bơi</th>
                            <th>Số lượng</th>
                            <th>Trạng thái</th>
                            <th>Ghi chú</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty devices}">
                                <tr>
                                    <td colspan="8" style="text-align: center; color: gray; font-style: italic;">
                                        Không tìm thấy thiết bị nào phù hợp.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="device" items="${devices}">
                                    <tr>
                                        <td>${device.deviceId}</td>
                                        <td><img src="${device.deviceImage}" alt="Thiết bị" class="thumb"></td>
                                        <td>${device.deviceName}</td>
                                        <td>${device.poolName}</td>
                                        <td>${device.quantity}</td>
                                        <td>
                                            <span class="status ${device.deviceStatus}">
                                                <c:choose>
                                                    <c:when test="${device.deviceStatus == 'available'}">Tốt</c:when>
                                                    <c:when test="${device.deviceStatus == 'maintenance'}">Bảo trì</c:when>
                                                    <c:when test="${device.deviceStatus == 'broken'}">Hỏng</c:when>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>${device.notes}</td>
                                        <td>
                                            <a href="managerUpdateDeviceServlet?id=${device.deviceId}
                                               &poolId=${not empty poolId ? fn:trim(poolId) : ''}
                                               &keyword=${not empty keyword ? fn:trim(keyword) : ''}
                                               &status=${not empty status ? fn:trim(status) : ''}
                                               &page=${page}
                                               &pageSize=${pageSize}" class="btn-edit">Cập nhật</a>
                                            <form action="managerDeleteDeviceServlet" method="get" style="display:inline;">
                                                <input type="hidden" name="deviceId" value="${device.deviceId}">
                                                <input type="hidden" name="poolId" value="${poolId}">
                                                <input type="hidden" name="keyword" value="${keyword}">
                                                <input type="hidden" name="status" value="${status}">
                                                <input type="hidden" name="page" value="${page}">
                                                <input type="hidden" name="pageSize" value="${pageSize}">
                                                <button type="submit" class="btn-delete" onclick="return confirm('Bạn chắc chắn muốn xóa thiết bị này?')">Xóa</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>

                <!-- Phân trang -->
                <div class="pagination">
                    <c:if test="${page > 1}">
                        <a href="managerListDeviceServlet?page=${page-1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">&laquo;</a>
                    </c:if>
                    <c:forEach begin="1" end="${endP}" var="i">
                        <a href="managerListDeviceServlet?page=${i}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}"
                           class="${i == page ? 'active' : ''}">${i}</a>
                    </c:forEach>
                    <c:if test="${page < endP}">
                        <a href="managerListDeviceServlet?page=${page+1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">&raquo;</a>
                    </c:if>
                </div>
            </div>
        </div>

        <script>
            setTimeout(function () {
                var alert = document.querySelector('.alert');
                if (alert)
                    alert.style.display = 'none';
            }, 5000);
        </script>

        <script>
            const searchInput = document.querySelector('input[name="keyword"]');
            const searchForm = document.getElementById('searchForm');
            let timeout = null;

            searchInput.addEventListener('input', function () {
                clearTimeout(timeout);
                timeout = setTimeout(() => {
                    document.querySelector('input[name="page"]').value = 1; // reset về trang 1
                    searchForm.submit();
                }, 400);
            });
        </script>
    </body>
</html>