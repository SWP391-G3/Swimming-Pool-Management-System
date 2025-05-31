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
        <title>Cập Nhập Thiết Bị</title>
        <link rel="stylesheet" href="./manager-css/managerAddUpdate-device.css">
    </head>
    <body>
        <div class="container"> 
            <h2>--- Cập nhập thiết bị ---</h2>
            <form method="post" action="${pageContext.request.contextPath}/DeviceServlet">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="deviceId" value="${device.deviceId}">
                <div class="form-group">
                    <label>Tên thiết bị:</label>
                    <input type="text" name="deviceName" value="${device.deviceName}" required>
                </div>
                <div class="form-group">
                    <label>Hồ bơi:</label>
                    <select name="poolId">
                        <c:forEach var="pool" items="${poolList}">
                            <option value="${pool.poolId}" ${pool.poolId == device.poolId ? 'selected' : ''}>${pool.poolName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Ảnh thiết bị (nếu muốn thay đổi):</label>
                    <input type="text" name="deviceImage" value="${device.deviceImage}" placeholder="Nhập link ảnh hoặc chọn ảnh mới">
                </div>
                <div class="form-group">
                    <label>Số lượng:</label>
                    <input type="number" name="quantity" value="${device.quantity}" required min="0">
                </div>
                <div class="form-group">
                    <label>Trạng thái:</label>
                    <select name="deviceStatus">
                        <option value="available" ${device.deviceStatus == 'available' ? 'selected' : ''}>Tốt</option>
                        <option value="maintenance" ${device.deviceStatus == 'maintenance' ? 'selected' : ''}>Bảo trì</option>
                        <option value="broken" ${device.deviceStatus == 'broken' ? 'selected' : ''}>Hỏng</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Ghi chú:</label>
                    <textarea name="notes">${device.notes}</textarea>
                </div>
                <div class="button-group">
                    <button type="submit">Cập nhật</button>
                    <a href="DeviceServlet" class="btn-back">Quay lại</a>
                </div>
            </form>
        </div>
    </body>
</html>