<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    model.staff.StaffJoinedTable staffSidebar = (model.staff.StaffJoinedTable) session.getAttribute("staff");
    model.customer.User currentUser = (model.customer.User) session.getAttribute("currentUser");
    String staffName = (currentUser != null) ? currentUser.getFull_name() : "";
    String staffType = (staffSidebar != null) ? staffSidebar.getTypeName() : "";
    int staffTypeId = (staffSidebar != null) ? staffSidebar.getStaffTypeId() : -1;
    String branch = (staffSidebar != null) ? staffSidebar.getBranchName() : "";
    String pool = (staffSidebar != null) ? staffSidebar.getPoolName() : "";
%>
<nav class="sidebar">
    <div class="logo">POOL STAFF</div>
    <div class="user">
        <div class="avatar">
            <svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="5"/><path d="M12 14c-5 0-8 2.5-8 5v1h16v-1c0-2.5-3-5-8-5z"/></svg>
        </div>
        <div class="name"><%= staffName %></div>
        <div class="name"><%= branch %></div>
        <div class="name"><%= pool %></div>
        <div class="name"><%= staffType %></div>
    </div>
    <ul class="menu">
        <c:if test="${staff != null && staff.staffTypeId == 3}">
            <li>
                <a href="staffListDeviceServlet"
                   <c:if test="${activeMenu eq 'device'}">class="active"</c:if>>
                       <svg viewBox="0 0 24 24"><rect x="2" y="7" width="20" height="10" rx="2"/><rect x="7" y="14" width="10" height="6" rx="1.5" fill="#38bdf8" opacity="0.7"/><circle cx="12" cy="12" r="2" fill="#38bdf8"/></svg>
                      Nhân viên thiết bị
                   </a>
                </li>
        </c:if>
        <c:if test="${staff != null && staff.staffTypeId == 4}">
            <li>
                <a href="staffPoolService"
                   <c:if test="${activeMenu eq 'pool-service'}">class="active"</c:if>>
                       <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                           <path d="M18 14c1.1 0 2 .9 2 2v4H4v-4c0-1.1.9-2 2-2h12zm0-2H6c-1.66 0-3 1.34-3 3v5h18v-5c0-1.66-1.34-3-3-3zM12 2c1.66 0 3 1.34 3 3s-1.34 3-3 3S9 6.66 9 5s1.34-3 3-3zM12 8c2.21 0 4-1.79 4-4S14.21 0 12 0 8 1.79 8 4s1.79 4 4 4z"/>
                       </svg>
                       Nhân viên dịch vụ 
                   </a>
                </li>
        </c:if>

        <c:if test="${staff != null && staff.staffTypeId == 3}">
            <li>
                <a href="staffDeviceReport" <c:if test="${activeMenu eq 'device-history'}">class="active"</c:if>> <svg width="19" height="19" viewBox="0 0 24 24" fill="none"
                                                                                                                       xmlns="http://www.w3.org/2000/svg" style="vertical-align:middle;margin-right:6px;">
                            <path d="M13 3a9 9 0 1 0 7.44 14.03l1.43 1.43a1 1 0 1 0 1.42-1.42l-1.43-1.43A9 9 0 0 0 13 3zm0 16a7 7 0 1 1 0-14 7 7 0 0 1 0 14zm-.5-10v4.25l3.5 2.08a1 1 0 0 1-1 1.74l-4-2.4V9a1 1 0 1 1 2 0z" fill="#3b82f6"/>
                        </svg>
                        Lịch sử báo cáo thiết bị</a>
                </li>
        </c:if>
        <c:if test="${staff != null && staff.staffTypeId == 4}">
            <li>
                <a href="staffServiceReport" <c:if test="${activeMenu eq 'service-history'}">class="active"</c:if>> <svg width="19" height="19" viewBox="0 0 24 24" fill="none"
                                                    xmlns="http://www.w3.org/2000/svg" style="vertical-align:middle;margin-right:6px;">
                        <path d="M13 3a9 9 0 1 0 7.44 14.03l1.43 1.43a1 1 0 1 0 1.42-1.42l-1.43-1.43A9 9 0 0 0 13 3zm0 16a7 7 0 1 1 0-14 7 7 0 0 1 0 14zm-.5-10v4.25l3.5 2.08a1 1 0 0 1-1 1.74l-4-2.4V9a1 1 0 1 1 2 0z" fill="#3b82f6"/>
                    </svg>
                    Lịch sử báo cáo dịch vụ</a>
            </li>
        </c:if>



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
