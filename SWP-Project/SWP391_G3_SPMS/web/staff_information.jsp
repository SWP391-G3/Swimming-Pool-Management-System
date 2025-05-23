<%-- 
    Document   : staff_information
    Created on : May 24, 2025, 12:24:39 AM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thông tin cá nhân nhân viên</title>
        <link rel="stylesheet" href="./staff-css/staff-dashboard.css">
    </head>
    <body>
        <div class="layout">
            <!-- Sidebar (copy từ dashboard.jsp nếu cần) -->
            <nav class="sidebar">
                <div class="logo">POOL STAFF</div>
                <div class="user">
                    <div class="avatar">
                        <svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="5"/><path d="M12 14c-5 0-8 2.5-8 5v1h16v-1c0-2.5-3-5-8-5z"/></svg>
                    </div>
                    <div class="name">
                        <c:out value="${sessionScope.full_name != null ? sessionScope.full_name : 'Nhân viên'}"/>
                    </div>
                </div>
                <ul class="menu">
                    <li><a href="staff_dashboard.jsp">Dashboard</a></li>
                    <li><a href="StaffAccountServlet" class="active">Thông tin cá nhân</a></li>
                    <li><a href="staff_schedule.jsp">Lịch làm việc</a></li>
                    <li><a href="reports.jsp">Báo cáo</a></li>
                    <li><a href="checkin_checkout.jsp">Check-in / Check-out</a></li>

                </ul>
                <div class="sidebar-footer">
                    &copy; 2025 Pool Management
                </div>
            </nav>
            <!-- Main Content -->
            <div class="content-panel">
                <div class="content-header">
                    <h2>Thông tin cá nhân</h2>
                    <p class="desc">Xem và chỉnh sửa thông tin cá nhân của bạn.</p>
                </div>
                <div class="dashboard-cards" style="display:block;padding:38px 18px 0 18px;">
                    <div class="dashboard-card" style="max-width:500px;margin:0 auto;">
                        <c:if test="${not empty message}">
                            <div style="color: #059669; background:#e0fbe6; border-radius:8px; padding:12px; margin-bottom:15px; text-align:center">
                                ${message}
                            </div>
                        </c:if>
                        <c:if test="${user == null}">
                            <p style="color:red;">Không tìm thấy nhân viên!</p>
                        </c:if>

                        <form action="StaffAccountServlet" method="post" style="display:flex; flex-direction:column; gap:16px;">
                            <label>Họ và tên
                                <input type="text" name="full_name" value="${user.fullName}" required>
                            </label>
                            <label>Email
                                <input type="email" name="email" value="${user.email}" required>
                            </label>
                            <label>Số điện thoại
                                <input type="text" name="phone" value="${user.phone}">
                            </label>
                            <label>Tên đăng nhập
                                <input type="text" value="${user.username}" readonly style="background:#f3f3f3;">
                            </label>
                            <label>Địa chỉ
                                <input type="text" name="address" value="${user.address}">
                            </label>
                            <button type="submit" class="btn-primary">Cập nhật thông tin</button>
                            <a href="staff_dashboard.jsp" class="btn-link" style="margin-top:10px;text-align:center;display:block;">← Về trang Dashboard</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
