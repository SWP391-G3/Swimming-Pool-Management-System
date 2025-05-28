<%-- 
    Document   : managerEquipment
    Created on : May 28, 2025, 10:10:26 PM
    Author     : Tuan Anh
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    request.setAttribute("activeMenu", "equipment");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý thiết bị hồ bơi</title>
    <link rel="stylesheet" href="./manager-css/manager-equipment.css">
    <link rel="stylesheet" href="./manager-css/manager-dashboard.css">
</head>
<body>
    <div class="layout">
     <%--    <%@ include file="managerSidebar.jsp" %>  --%>
                                                       
        <div class="content-panel">
            <div class="header">
                <h2>Quản lý thiết bị hồ bơi</h2>
                <form class="search-form" method="get">
                    <input type="text" name="keyword" placeholder="Tìm theo tên thiết bị...">
                    <select name="status">
                        <option value="">-- Tất cả trạng thái --</option>
                        <option value="available">Sẵn sàng</option>
                        <option value="maintenance">Bảo trì</option>
                        <option value="broken">Hỏng</option>
                    </select>
                    <button type="submit">Tìm kiếm</button>
                </form>
                <a href="#" class="btn-add">+ Thêm thiết bị</a>
            </div>
            <table class="equipment-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Ảnh</th>
                        <th>Tên thiết bị</th>
                        <th>Số lượng</th>
                        <th>Trạng thái</th>
                        <th>Ngày mua</th>
                        <th>Ngày bảo trì</th>
                        <th>Ghi chú</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td><img src="device1.jpg" alt="Thiết bị" class="thumb"></td>
                        <td>Máy bơm nước</td>
                        <td>3</td>
                        <td><span class="status available">Sẵn sàng</span></td>
                        <td>2024-01-10</td>
                        <td>2025-02-10</td>
                        <td></td>
                        <td>
                            <a href="#" class="btn-edit">Sửa</a>
                            <button class="btn-delete">Xóa</button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td><img src="device2.jpg" alt="Thiết bị" class="thumb"></td>
                        <td>Máy lọc nước</td>
                        <td>1</td>
                        <td><span class="status maintenance">Bảo trì</span></td>
                        <td>2023-05-15</td>
                        <td>2025-01-12</td>
                        <td>Cần bảo trì định kỳ</td>
                        <td>
                            <a href="#" class="btn-edit">Sửa</a>
                            <button class="btn-delete">Xóa</button>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="pagination">
                <a href="#">&laquo;</a>
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">&raquo;</a>
            </div>
        </div>
    </div>
</body>
</html>