<%-- 
    Document   : updateDevice
    Created on : May 30, 2025, 5:42:00 PM
    Author     : Tuan Anh
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cập Nhật Thiết Bị</title>
        <link rel="stylesheet" href="./manager-css/managerAddUpdate-device.css">
    </head>
    <body>
        <div class="container"> 
            <h2>--- Cập nhật thiết bị ---</h2>

            <!-- hiển thị lỗi -->
            <c:if test="${not empty error}">
                <div style="color: red; font-weight: bold; margin-bottom: 10px;">
                    ${error}
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/DeviceServlet">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="deviceId" value="${device.deviceId}">

                <div class="form-group">
                    <label>Tên thiết bị:</label>
                    <input type="text" name="deviceName" required 
                           value="${not empty param.deviceName ? param.deviceName : device.deviceName}">
                </div>

                <div class="form-group">
                    <label>Hồ bơi:</label>
                    <select name="poolId">
                        <c:forEach var="pool" items="${poolList}">
                            <option value="${pool.poolId}"
                                <c:choose>
                                    <c:when test="${param.poolId == pool.poolId}">
                                        selected
                                    </c:when>
                                    <c:when test="${empty param.poolId && pool.poolId == device.poolId}">
                                        selected
                                    </c:when>
                                </c:choose>
                            >${pool.poolName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Ảnh thiết bị (nếu muốn thay đổi):</label>
                    <input type="text" name="deviceImage" 
                           value="${not empty param.deviceImage ? param.deviceImage : device.deviceImage}"
                           placeholder="Nhập link ảnh hoặc chọn ảnh mới">
                </div>

                <div class="form-group">
                    <label>Số lượng:</label>
                    <input type="number" name="quantity" required min="0"
                           value="${not empty param.quantity ? param.quantity : device.quantity}">
                </div>

                <div class="form-group">
                    <label>Trạng thái:</label>
                    <select name="deviceStatus">
                        <option value="available" 
                            ${param.deviceStatus == 'available' || (empty param.deviceStatus && device.deviceStatus == 'available') ? 'selected' : ''}>Tốt</option>
                        <option value="maintenance" 
                            ${param.deviceStatus == 'maintenance' || (empty param.deviceStatus && device.deviceStatus == 'maintenance') ? 'selected' : ''}>Bảo trì</option>
                        <option value="broken" 
                            ${param.deviceStatus == 'broken' || (empty param.deviceStatus && device.deviceStatus == 'broken') ? 'selected' : ''}>Hỏng</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Ghi chú:</label>
                    <textarea name="notes">${not empty param.notes ? param.notes : device.notes}</textarea>
                </div>

                <div class="button-group">
                    <button type="submit">Cập nhật</button>
                    <a href="DeviceServlet" class="btn-back">Quay lại</a>
                </div>
            </form>
        </div>
    </body>
</html>
