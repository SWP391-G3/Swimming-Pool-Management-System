<%-- 
    Document   : managerStaffInfo
    Created on : Jun 18, 2025, 2:23:51 AM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    request.setAttribute("activeMenu", "staff");
    // DEMO: Xóa 2 dòng dưới khi dùng code thực tế, chỉ để hiển thị nút phân trang test giao diện
    if (request.getAttribute("totalPages") == null) {
        request.setAttribute("totalPages", 3);
    }
    if (request.getAttribute("currentPage") == null) {
        request.setAttribute("currentPage", 1);
    }
    // Nếu status không có, mặc định là ""
    if (request.getParameter("status") == null)
        request.setAttribute("selectedStatus", "");
    else
        request.setAttribute("selectedStatus", request.getParameter("status"));
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Nhân Viên</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./manager-css/managerStaffInfo.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
    </head>
    <body>
        <div class="layout">
            <%@ include file="./managerSidebar.jsp" %>
            <div class="content-panel">
                <div class="content-header">
                    <h2>Quản lý Nhân Viên</h2>
                    <div class="desc">Danh sách nhân viên thuộc chi nhánh bạn quản lý</div>
                </div>
                <!-- Thanh tìm kiếm với lọc trạng thái -->
                <form class="staff-search-bar" method="get">
                    <input type="text" name="keyword" placeholder="Tìm kiếm theo tên, email, số điện thoại..." value="${param.keyword}">
                    <select name="status" style="padding:10px 16px;border-radius:7px;border:1px solid #cbd5e1;">
                        <option value="" ${selectedStatus == '' ? 'selected' : ''}>Tất cả trạng thái</option>
                        <option value="1" ${selectedStatus == '1' ? 'selected' : ''}>Đang hoạt động</option>
                        <option value="0" ${selectedStatus == '0' ? 'selected' : ''}>Đã khóa</option>
                    </select>
                    <button type="submit">Tìm kiếm</button>
                </form>
                <div class="staff-table-container">
                    <table class="staff-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Ảnh</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Điện thoại</th>
                                <th>Chi nhánh</th>
                                <th>Trạng thái</th>
                                <th>Chức năng</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="staff" items="${staffList}">
                                <tr>
                                    <td>${staff.user_id}</td>
                                    <td>
                                        <img class="staff-avatar" src="${staff.images != null ? staff.images : 'default-avatar.png'}" alt="avatar">
                                    </td>
                                    <td>${staff.full_name}</td>
                                    <td>${staff.email}</td>
                                    <td>${staff.phone}</td>
                                    <td>${staff.branch_name}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${staff.status == 1}">
                                                <span class="badge badge-active">Đang hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-inactive">Đã khóa</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="staff-actions">
                                        <button type="button" onclick="showStaffDetail(${staff.user_id})">
                                            Xem chi tiết
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty staffList}">
                                <tr>
                                    <td colspan="8" style="text-align:center;color:#64748b;">Không tìm thấy nhân viên nào</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                    <div class="pagination">
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <button type="button"
                                    class="${currentPage == i ? 'active' : ''}"
                                    onclick="goToPage(${i})">${i}</button>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-bg" id="staffDetailModalBg">
            <div class="modal" id="staffDetailModal">
                <button class="close-btn" onclick="closeStaffModal()">&times;</button>
                <div class="modal-title">Chi tiết nhân viên</div>
                <div class="modal-content" id="staffDetailContent"></div>
            </div>
        </div>
        <script>
            function goToPage(page) {
                const url = new URL(window.location.href);
                url.searchParams.set('page', page);
                window.location.href = url.toString();
            }
            // ...modal JS giữ nguyên...
        </script>
    </body>
</html>