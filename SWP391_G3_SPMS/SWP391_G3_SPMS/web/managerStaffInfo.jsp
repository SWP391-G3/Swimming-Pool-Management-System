<%-- 
    Document   : managerStaffInfo
    Created on : Jun 18, 2025, 2:23:51 AM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    request.setAttribute("activeMenu", "staff");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title> Nhân Viên</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./manager-css/managerStaffInfo-v2.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
    </head>
    <body>
        <div class="layout">
            <%@ include file="./managerSidebar.jsp" %>
            <div class="content-panel">
                <div class="content-header">
                    <h2>Nhân Viên</h2>
                    <div class="desc">Danh sách nhân viên thuộc chi nhánh bạn quản lý</div>
                </div>
                <!-- Thanh tìm kiếm với lọc trạng thái -->
                <form class="staff-search-bar"  method="get">
                    <input type="text" name="keyword" placeholder="Tìm kiếm theo tên, email, số điện thoại..." value="${param.keyword}">
                    <select name="status" style="padding:10px 16px;border-radius:7px;border:1px solid #cbd5e1;">
                        <option value="" ${param.status == null || param.status == '' ? 'selected' : ''}>Tất cả trạng thái</option>
                        <option value="1" ${param.status == '1' ? 'selected' : ''}>Đang hoạt động</option>
                        <option value="0" ${param.status == '0' ? 'selected' : ''}>Đã khóa</option>
                    </select>
                    <select name="poolId">
                        <option value="all" <c:if test="${poolId == 'all'}">selected</c:if>>-- Tất cả hồ bơi --</option>
                        <c:forEach var="pool" items="${poolList}">
                            <option value="${pool.id}" <c:if test="${pool.id.toString() == poolId}">selected</c:if>>${pool.name}</option>
                        </c:forEach>


                    </select>
                    <button type="submit">Tìm kiếm</button>
                </form>
                <div class="staff-table-container">
                    <table class="staff-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Chi nhánh</th>
                                <th>Làm việc tại</th>         <!-- Thêm cột này -->
                                <th>Tên Công việc</th>
                                <th>Trạng thái</th>
                                <th>Chức năng</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="staff" items="${staffList}">
                                <tr>
                                    <td>${staff.userId}</td>
                                    <td>${staff.fullName}</td>
                                    <td>${staff.email}</td>
                                    <td>${staff.branchName}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty staff.poolName}">
                                                ${staff.poolName}
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color:#aaa;">Chưa phân</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        ${staff.typeName}
                                    </td>
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
                                        <button type="button" onclick="showStaffDetail(${staff.userId})">
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

                    <c:if test="${endP >= 1}">
                        <div class="pagination">
                            <c:if test="${page > 1}">
                                <a href="managerStaff?page=${page-1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">«</a>
                            </c:if>
                            <c:forEach begin="1" end="${endP}" var="i">
                                <a href="managerStaff?page=${i}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}" class="${i == page ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            <c:if test="${page < endP}">
                                <a href="managerStaff?page=${page+1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">»</a>
                            </c:if>
                        </div>
                    </c:if>

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

        <script>

            function showStaffDetail(userId) {
                const modalBg = document.getElementById('staffDetailModalBg');

                // Show loading spinner
                document.getElementById('staffDetailContent').innerHTML = `
                <div class="loading-spinner">
                    <div class="spinner"></div>
                    <p>Đang tải thông tin nhân viên...</p>
                </div>
            `;

                modalBg.classList.add('show');

                fetch('managerStaffDetail?userId=' + userId)
                        .then(res => res.text())
                        .then(html => {
                            document.getElementById('staffDetailContent').innerHTML = html;
                        })
                        .catch(() => {
                            document.getElementById('staffDetailContent').innerHTML = `
                <div class="error-message">
                    <h3>Lỗi</h3>
                    <p>Không thể tải thông tin nhân viên. Vui lòng thử lại.</p>
                </div>
            `;
                        });
            }

            function closeStaffModal() {
                const modalBg = document.getElementById('staffDetailModalBg');
                modalBg.classList.remove('show');
            }


        </script>


    </body>
</html>