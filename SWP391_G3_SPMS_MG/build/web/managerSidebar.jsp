<%-- 
    Document   : managerSidebar
    Created on : May 28, 2025, 10:21:39 PM
    Author     : Tuan Anh
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<nav class="sidebar">
    <div class="logo">POOL MANAGER</div>
    <div class="user">
        <div class="avatar">
            <svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="5"/><path d="M12 14c-5 0-8 2.5-8 5v1h16v-1c0-2.5-3-5-8-5z"/></svg>
        </div>
        <div class="name"><c:out value="${sessionScope.full_name != null ? sessionScope.full_name : 'Manager'}"/></div>
    </div>
    <ul class="menu">

        <li>
            <a href="ListDeviceServlet"
               <c:if test="${activeMenu eq 'device'}">class="active"</c:if>>
                   <svg viewBox="0 0 24 24"><rect x="2" y="7" width="20" height="10" rx="2"/><rect x="7" y="14" width="10" height="6" rx="1.5" fill="#38bdf8" opacity="0.7"/><circle cx="12" cy="12" r="2" fill="#38bdf8"/></svg>
                   Quản lý thiết bị
               </a>
            </li>
            <li>
                <a href="managerStaffInfo.jsp"
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
                <a href="voucher-management.jsp"
                <c:if test="${activeMenu eq 'voucher'}">class="active"</c:if>>
                    <svg viewBox="0 0 24 24"><rect x="4" y="6" width="16" height="12" rx="2" /><circle cx="8" cy="12" r="2" /><circle cx="16" cy="12" r="2" /></svg>
                    Quản lý voucher
                </a>
            </li>
            <li>
                <a href="area-revenue.jsp"
                <c:if test="${activeMenu eq 'revenue'}">class="active"</c:if>>
                    <svg viewBox="0 0 24 24"><rect x="3" y="12" width="4" height="8"/><rect x="10" y="8" width="4" height="12"/><rect x="17" y="4" width="4" height="16"/></svg>
                    Quản lý doanh thu khu vực
                </a>
            </li>
            <li>
                <a href="feedback-management.jsp"
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