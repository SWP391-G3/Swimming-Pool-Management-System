<%-- 
    Document   : managerDevice
    Created on : May 28, 2025, 10:10:26 PM
    Author     : Tuan Anh
--%>
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
        <link rel="stylesheet" href="./manager-css/manager-device.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
    </head>
    <body>
        <div class="layout">
            <!-- Sidebar  --> 
            <%@ include file="../managerSidebar.jsp" %>

            <div class="content-panel">
                <div class="header">
                    <h2>Quản lý thiết bị hồ bơi</h2>
                    <form class="search-form" method="get" action="DeviceServlet">
                        <input type="text" name="keyword" placeholder="Tìm theo tên thiết bị..." value="${param.keyword}">
                        <select name="status">
                            <option value="">-- Tất cả trạng thái --</option>
                            <option value="available" ${param.status == 'available' ? 'selected' : ''}>Tốt</option>
                            <option value="maintenance" ${param.status == 'maintenance' ? 'selected' : ''}>Bảo trì</option>
                            <option value="broken" ${param.status == 'broken' ? 'selected' : ''}>Hỏng</option>
                        </select>
                        <button type="submit">Tìm kiếm</button>
                    </form>

                    <a href="DeviceServlet?action=add" class="btn-add">+ Thêm thiết bị</a>
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
                        <c:forEach var="device" items="${devices}">
                            <tr>
                                <td>${device.deviceId}</td>
                                <td>
                                    <img src="${device.deviceImage}" alt="Thiết bị" class="thumb">
                                </td>
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
                                    <a href="DeviceServlet?action=update&id=${device.deviceId}" class="btn-edit">Cập nhập</a>
                                    <form action="DeviceServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="deviceId" value="${device.deviceId}">
                                        <button type="submit" class="btn-delete" onclick="return confirm('Bạn chắc chắn muốn xóa thiết bị này?')">Xóa</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>

                </table>
                        
                <!-- Phân trang -->


                <div class="pagination">
                    <c:if test="${page > 1}">
                        <a href="DeviceServlet?page=${page-1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}">&laquo;</a>
                    </c:if>
                    <c:forEach begin="1" end="${endP}" var="i">
                        <a href="DeviceServlet?page=${i}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}"
                           class="${i == page ? 'active' : ''}">${i}</a>
                    </c:forEach>
                    <c:if test="${page < endP}">
                        <a href="DeviceServlet?page=${page+1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}">&raquo;</a>
                    </c:if>
                </div>




            </div>


        </div>



    </body>



</html>
