<%-- 
    Document   : manager
    Created on : May 28, 2025, 5:05:13 PM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "model.User" %>
<% 
            User currentUser1 = (User) session.getAttribute("currentUser");
            String userName1;
            if(currentUser1 != null) {
                userName1 = currentUser1.getFull_name();
            } else {
                userName1 = "";
            }
%>

<%
    String fullName = (String) session.getAttribute("full_name");
    // Đảm bảo dòng này để sidebar highlight đúng mục
    request.setAttribute("activeMenu", "dashboard");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Manager Panel</title>
    <link rel="stylesheet" href="./manager-css/manager-panel.css">
</head>
<body>
    <div class="layout">
        <%-- Sidebar động --%>
        <%@ include file="managerSidebar.jsp" %>
        <div class="content-panel">
            <div class="content-header">
                <h2>Chào mừng, <%= userName %></h2>
                <p class="desc">Truy cập nhanh các chức năng dành cho quản lý.</p>
            </div>
            <div class="dashboard-cards">
                <a href="managerListDeviceServlet" class="dashboard-card">
                    <div class="dashboard-card-title">Quản lý thiết bị</div>
                    <div class="dashboard-card-desc">Theo dõi, thêm thiết bị, bảo trì thiết bị bể bơi.</div>
                </a>
                <a href="voucher-management.jsp" class="dashboard-card">
                    <div class="dashboard-card-title">Quản lý voucher</div>
                    <div class="dashboard-card-desc">Tạo, xem, cập nhật, xóa mã giảm giá/voucher.</div>
                </a>
                <a href="area-revenue.jsp" class="dashboard-card">
                    <div class="dashboard-card-title">Quản lý doanh thu khu vực</div>
                    <div class="dashboard-card-desc">Thống kê doanh thu, phân tích hiệu quả theo từng khu vực.</div>
                </a>
                <a href="feedback-management.jsp" class="dashboard-card">
                    <div class="dashboard-card-title">Quản lý feedback</div>
                    <div class="dashboard-card-desc">Xem, phản hồi, đánh giá ý kiến khách hàng.</div>
                </a>
            </div>
        </div>
    </div>
</body>
</html>