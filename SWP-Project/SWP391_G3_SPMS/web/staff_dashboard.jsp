<%-- 
    Document   : staff_dashboard
    Created on : May 23, 2025, 11:46:35 PM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String fullName = (String) session.getAttribute("full_name");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Staff Dashboard</title>
        <link rel="stylesheet" href="./staff-css/staff-dashboard.css">

    </head>
    <body>
        <div class="layout">
            <!-- Sidebar -->
            <nav class="sidebar">
                <div class="logo">POOL STAFF</div>
                <div class="user">
                    <div class="avatar">
                        <svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="5"/><path d="M12 14c-5 0-8 2.5-8 5v1h16v-1c0-2.5-3-5-8-5z"/></svg>
                    </div>
                    <div class="name"><c:out value="${sessionScope.full_name != null ? sessionScope.full_name : 'Nhân viên'}"/></div>
                </div>
                <ul class="menu">
                    <li><a href="staff_dashboard.jsp" class="active">
                            <svg viewBox="0 0 24 24"><path d="M3 12l9-9 9 9-1.41 1.41L12 5.83l-7.59 7.58z"/><path d="M3 12v8h6v-6h6v6h6v-8"/></svg>
                            Dashboard
                        </a></li>

                    <li><a href="StaffAccountServlet">
                            <svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="5"/><path d="M12 14c-5 0-8 2.5-8 5v1h16v-1c0-2.5-3-5-8-5z"/></svg>
                            Thông tin cá nhân
                        </a></li>

                    <li><a href="StaffScheduleServlet">
                            <svg viewBox="0 0 24 24"><path d="M19 4h-1V2h-2v2H8V2H6v2H5C3.9 4 3 4.9 3 6v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 16H5V9h14v11zm0-13H5V6h14v1z"/></svg>
                            Lịch làm việc
                        </a></li>

                    <li><a href="reports.jsp">
                            <svg viewBox="0 0 24 24"><path d="M3 13h2v-2H3v2zm4 4h2v-2H7v2zm8-8h2V7h-2v2zm-4 8h2v-6h-2v6zm8-2h2v-2h-2v2zM3 17h2v-2H3v2zm8-12v2h2V5h-2zm8 0v2h2V5h-2z"/></svg>
                            Báo cáo
                        </a></li>

                    <li><a href="checkin_checkout.jsp">
                            <svg viewBox="0 0 24 24"><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V5h14v14zm-7-2l-5-5h3V9h4v3h3l-5 5z"/></svg>
                            Check-in / Check-out
                        </a></li>
                    <li>
                        <a href="checkin_checkout.jsp">
                            <svg xmlns="http://www.w3.org/2000/svg" height="24" width="24" viewBox="0 0 24 24">
                            <path d="M16 13v-2H7V8l-5 4 5 4v-3h9zm3-10H5c-1.1 0-2 .9-2 2v4h2V5h14v14H5v-4H3v4c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2z"/>
                            </svg>
                            Đăng Xuất
                        </a>
                    </li>

                </ul>
                <div class="sidebar-footer">
                    &copy; 2025 Pool Management
                </div>
            </nav>
            <!-- Main Content -->
            <div class="content-panel">
                <div class="content-header">
                    <h2>Chào mừng, <c:out value="${sessionScope.full_name != null ? sessionScope.full_name : 'Nhân viên'}"/></h2>
                    <p class="desc">Truy cập nhanh các chức năng dành cho nhân viên.</p>
                </div>
                <div class="dashboard-cards">

                    <a href="StaffAccountServlet" class="dashboard-card">
                        <svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="5"/><path d="M12 14c-5 0-8 2.5-8 5v1h16v-1c0-2.5-3-5-8-5z"/></svg>
                        <div class="dashboard-card-title">Thông tin cá nhân</div>
                        <div class="dashboard-card-desc">Xem và chỉnh sửa thông tin cá nhân, liên hệ quản lý.</div>
                    </a>


                    <a href="StaffScheduleServlet" class="dashboard-card">
                        <svg viewBox="0 0 24 24"><path d="M19 4h-1V2h-2v2H8V2H6v2H5C3.9 4 3 4.9 3 6v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 16H5V9h14v11zm0-13H5V6h14v1z"/></svg>
                        <div class="dashboard-card-title">Lịch làm việc</div>
                        <div class="dashboard-card-desc">Xem lịch phân ca, lịch làm việc cá nhân và cập nhật.</div>
                    </a>

                    <a href="reports.jsp" class="dashboard-card">
                        <svg viewBox="0 0 24 24"><path d="M3 13h2v-2H3v2zm4 4h2v-2H7v2zm8-8h2V7h-2v2zm-4 8h2v-6h-2v6zm8-2h2v-2h-2v2zM3 17h2v-2H3v2zm8-12v2h2V5h-2zm8 0v2h2V5h-2z"/></svg>
                        <div class="dashboard-card-title">Báo cáo</div>
                        <div class="dashboard-card-desc">Xem báo cáo ca làm, thống kê, báo cáo sự cố/hỗ trợ.</div>
                    </a>

                    <a href="checkin_checkout.jsp" class="dashboard-card">
                        <svg viewBox="0 0 24 24"><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V5h14v14zm-7-2l-5-5h3V9h4v3h3l-5 5z"/></svg>
                        <div class="dashboard-card-title">Điểm danh / Check-in-out</div>
                        <div class="dashboard-card-desc">Điểm danh đầu/giữa/ra ca, quản lý thời gian làm việc.</div>
                    </a>

                </div>
            </div>
        </div>
    </body>
</html>