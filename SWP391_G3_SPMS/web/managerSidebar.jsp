<%-- 
    Document   : managerSidebar
    Created on : May 28, 2025, 10:21:39 PM
    Author     : Tuan Anh
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page import = "model.customer.User" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    String userName;
    String Location;
    if (currentUser != null && currentUser.getUser_id() == 2) {
        userName = currentUser.getFull_name();
        Location = "Hà Nội";
    } else if (currentUser != null && currentUser.getUser_id() == 3) {
        userName = currentUser.getFull_name();
        Location = "Hồ Chí Minh";
    } else if (currentUser != null && currentUser.getUser_id() == 4) {
        userName = currentUser.getFull_name();
        Location = "Đà Nẵng";
    } else if (currentUser != null && currentUser.getUser_id() == 5) {
        userName = currentUser.getFull_name();
        Location = "Cần Thơ";
    } else if (currentUser != null && currentUser.getUser_id() == 6) {
        userName = currentUser.getFull_name();
        Location = "Quy Nhơn";
    } else {
        userName = "";
        Location = "";
    }
%>

<nav class="sidebar">
    <div class="logo">POOL MANAGER</div>
    <div class="user">
        <div class="avatar">
            <svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="5"/><path d="M12 14c-5 0-8 2.5-8 5v1h16v-1c0-2.5-3-5-8-5z"/></svg>
        </div>
        <div class="name">Tên quản lý: <%= userName%></div>
        <div class="name">Khu vực: <%= Location%></div>
    </div>
    <ul class="menu">

        <li>
            <a href="managerListDeviceServlet"
               <c:if test="${activeMenu eq 'device'}">class="active"</c:if>>
                   <svg viewBox="0 0 24 24"><rect x="2" y="7" width="20" height="10" rx="2"/><rect x="7" y="14" width="10" height="6" rx="1.5" fill="#38bdf8" opacity="0.7"/><circle cx="12" cy="12" r="2" fill="#38bdf8"/></svg>
                   Quản lý thiết bị
               </a>
            </li>
            <li>
                <a href="pool-service"
                <c:if test="${activeMenu eq 'pool-service'}">class="active"</c:if>>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                        <path d="M18 14c1.1 0 2 .9 2 2v4H4v-4c0-1.1.9-2 2-2h12zm0-2H6c-1.66 0-3 1.34-3 3v5h18v-5c0-1.66-1.34-3-3-3zM12 2c1.66 0 3 1.34 3 3s-1.34 3-3 3S9 6.66 9 5s1.34-3 3-3zM12 8c2.21 0 4-1.79 4-4S14.21 0 12 0 8 1.79 8 4s1.79 4 4 4z"/>
                    </svg>
                     Quản lý dịch vụ 
                </a>
            </li>
            <li>
                <a href="managerStaff"
                <c:if test="${activeMenu eq 'staff'}">class="active"</c:if>>
                    <svg xmlns="http://www.w3.org/2000/svg"
                         viewBox="0 0 20 20"
                         fill="currentColor"
                         width="24" height="24">
                        <path d="M10 9a3 3 0 1 0 0-6 3 3 0 0 0 0 6ZM6 8a2 2 0 1 1-4 0 2 2 0 0 1 4 0ZM1.49 15.326a.78.78 0 0 1-.358-.442 3 3 0 0 1 4.308-3.516 6.484 6.484 0 0 0-1.905 3.959c-.023.222-.014.442.025.654a4.97 4.97 0 0 1-2.07-.655ZM16.44 15.98a4.97 4.97 0 0 0 2.07-.654.78.78 0 0 0 .357-.442 3 3 0 0 0-4.308-3.517 6.484 6.484 0 0 1 1.907 3.96 2.32 2.32 0 0 1-.026.654ZM18 8a2 2 0 1 1-4 0 2 2 0 0 1 4 0ZM5.304 16.19a.844.844 0 0 1-.277-.71 5 5 0 0 1 9.947 0 .843.843 0 0 1-.277.71A6.975 6.975 0 0 1 10 18a6.974 6.974 0 0 1-4.696-1.81Z"/>
                    </svg>
                    Nhân Viên
                </a>
            </li>
            <li>
                <a href="managerTicketServlet"
                <c:if test="${activeMenu eq 'ticket'}">class="active"</c:if>>
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                         viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
                         width="24" height="24">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M16.5 6v.75m0 3v.75m0 3v.75m0 3V18m-9-5.25h5.25M7.5 15h3M3.375 5.25c-.621 0-1.125.504-1.125 1.125v3.026a2.999 2.999 0 0 1 0 5.198v3.026c0 .621.504 1.125 1.125 1.125h17.25c.621 0 1.125-.504 1.125-1.125v-3.026a2.999 2.999 0 0 1 0-5.198V6.375c0-.621-.504-1.125-1.125-1.125H3.375Z" />
                    </svg>
                    Quản lý Ticket
                </a>

            </li>
            <li>
                <a href="managerDiscountServlet"
                <c:if test="${activeMenu eq 'voucher'}">class="active"</c:if>>
                    <svg viewBox="0 0 24 24"><rect x="4" y="6" width="16" height="12" rx="2" /><circle cx="8" cy="12" r="2" /><circle cx="16" cy="12" r="2" /></svg>
                    Quản lý voucher
                </a>
            </li>
            
            <li>
                <a href="managerFeedbackServlet"
                <c:if test="${activeMenu eq 'feedback'}">class="active"</c:if>>
                <svg viewBox="0 0 24 24"><path d="M21 6H3v12h4v4l4-4h10z"/></svg>
                Quản lý feedback
            </a>
        </li>
        <li>
            <a href="LogoutServlet">
                <svg viewBox="0 0 24 24"><path d="M16 13v-2H7V8l-5 4 5 4v-3h9zm3-10H5c-1.1 0-2 .9-2 2v4h2V5h14v14H5v-4H3v4c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2z"/></svg>
                Đăng xuất
            </a>
        </li>
    </ul>
    <div class="sidebar-footer">
        &copy; 2025 Pool Management
    </div>
</nav>