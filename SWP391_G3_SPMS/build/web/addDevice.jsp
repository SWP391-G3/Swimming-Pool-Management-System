<%-- 
    Document   : managerDevice
    Created on : May 28, 2025, 10:10:26 PM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm thiết bị</title>
        <link rel="stylesheet" href="./manager-css/managerAddUpdate-device.css">
    </head>
    <body>
        <div class="container">
            <h2>Thêm thiết bị mới</h2>

            <!-- ✅ Hiển thị thông báo lỗi -->
            <c:if test="${not empty error}">
                <div style="color: red; font-weight: bold; margin-bottom: 10px;">
                    ${error}
                </div>
            </c:if>

            <form action="DeviceServlet" method="post">
                <input type="hidden" name="action" value="add">

                <div class="form-group">
                    <label>Hồ bơi:</label>
                    <select name="poolId" required>
                        <c:forEach var="pool" items="${poolList}">
                            <option value="${pool.poolId}" 
                                    <c:if test="${param.poolId == pool.poolId}">selected</c:if>>
                                ${pool.poolName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Ảnh (tên file):</label>
                    <input type="text" name="deviceImage" value="${param.deviceImage}">
                </div>

                <div class="form-group">
                    <label>Tên thiết bị:</label>
                    <input type="text" name="deviceName" required value="${param.deviceName}">
                </div>

                <div class="form-group">
                    <label>Số lượng:</label>
                    <input type="number" name="quantity" required min="0" max="1000" value="${param.quantity}">
                </div>

                <div class="form-group">
                    <label>Trạng thái:</label>
                    <select name="deviceStatus">
                        <option value="available" ${param.deviceStatus == 'available' ? 'selected' : ''}>Tốt</option>
                        <option value="maintenance" ${param.deviceStatus == 'maintenance' ? 'selected' : ''}>Bảo trì</option>
                        <option value="broken" ${param.deviceStatus == 'broken' ? 'selected' : ''}>Hỏng</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Ghi chú:</label>
                    <textarea name="notes">${param.notes}</textarea>
                </div>

                <div class="button-group">
                    <button type="submit">Thêm</button>
                    <a href="DeviceServlet" class="btn-back">Quay lại</a>
                </div>
            </form>
        </div>
    </body>
</html>
