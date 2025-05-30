<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm thiết bị</title>
        <link rel="stylesheet" href="./manager-css/managerAddEdit-device.css">
    </head>
    <body>
        <div class="container">
            <h2>Thêm thiết bị mới</h2>
            <form action="DeviceServlet" method="post">
                <input type="hidden" name="action" value="add">
                <label><span>Hồ bơi:</span>
                    <select name="poolId" required>    <!-- required: bắt buộc phải chọn một giá trị trước khi gửi form -->
                        <c:forEach var="pool" items="${poolList}">
                            <option value="${pool.poolId}">${pool.poolName}</option>
                        </c:forEach>
                    </select>
                </label>
                <label><span>Ảnh (tên file):</span> <input type="text" name="deviceImage"></label>
                <label><span>Tên thiết bị:</span> <input type="text" name="deviceName" required></label>
                <label><span>Số lượng:</span> <input type="number" name="quantity" required min="0" max="1000"></label>
                <label><span>Trạng thái:</span>
                    <select name="deviceStatus">
                        <option value="available">Sẵn sàng</option>
                        <option value="maintenance">Bảo trì</option>
                        <option value="broken">Hỏng</option>
                    </select>
                </label>
                <label><span>Ghi chú:</span> <textarea name="notes"></textarea></label>
                <button type="submit">Thêm</button>
            </form>
            <a href="DeviceServlet" class="btn-back">Quay lại</a>
        </div>
    </body>
</html>