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
            <form action="DeviceServlet" method="post">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label>Hồ bơi:</label>
                    <select name="poolId" required>
                        <c:forEach var="pool" items="${poolList}">
                            <option value="${pool.poolId}">${pool.poolName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Ảnh (tên file):</label>
                    <input type="text" name="deviceImage">
                </div>
                <div class="form-group">
                    <label>Tên thiết bị:</label>
                    <input type="text" name="deviceName" required>
                </div>
                <div class="form-group">
                    <label>Số lượng:</label>
                    <input type="number" name="quantity" required min="0" max="1000">
                </div>
                <div class="form-group">
                    <label>Trạng thái:</label>
                    <select name="deviceStatus">
                        <option value="available">Tốt</option>
                        <option value="maintenance">Bảo trì</option>
                        <option value="broken">Hỏng</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Ghi chú:</label>
                    <textarea name="notes"></textarea>
                </div>
                <div class="button-group">
                    <button type="submit">Thêm</button>
                    <a href="DeviceServlet" class="btn-back">Quay lại</a>
                </div>
            </form>
        </div>
    </body>
</html>