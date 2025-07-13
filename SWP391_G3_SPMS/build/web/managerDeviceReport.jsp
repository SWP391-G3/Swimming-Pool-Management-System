<%-- 
    Document   : managerDeviceReport
    Created on : Jul 14, 2025, 12:46:51 AM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    request.setAttribute("activeMenu", "deviceReport");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Báo cáo thiết bị</title>
        <link rel="stylesheet" href="./manager-css/manager-deviceReport-v2.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
       
    </head>
    <body>
        <div class="layout">
            <!-- Sidebar  --> 
            <%@ include file="../managerSidebar.jsp" %>

            <div class="content-panel">

                <%
                    String updateSuccess = (String) session.getAttribute("updateSuccess");
                    String updateError = (String) session.getAttribute("updateError");
                    if (updateSuccess != null) {
                        request.setAttribute("updateSuccess", updateSuccess);
                        session.removeAttribute("updateSuccess");
                    }
                    if (updateError != null) {
                        request.setAttribute("updateError", updateError);
                        session.removeAttribute("updateError");
                    }
                %>

                <div class="header">

                    <c:if test="${not empty updateSuccess}">
                        <div style="color: green; font-weight: bold; margin-bottom: 10px;">
                            ${updateSuccess}
                        </div>
                    </c:if>
                    <c:if test="${not empty updateError}">
                        <div style="color: red; font-weight: bold; margin-bottom: 10px;">
                            ${updateError}
                        </div>
                    </c:if>

                    <!-- Nút quay lại quản lý thiết bị -->
                    <a href="managerListDeviceServlet" class="btn-back-to-device">← Quay lại quản lý thiết bị</a>


                    

                    <form class="filter-group" method="get" action="managerListDeviceReportServlet" id="searchForm">
                        <h2>Báo cáo thiết bị</h2>
                        <input type="text" name="keyword" placeholder="Tìm theo tên thiết bị, lý do báo cáo, nhân viên..." value="${keyword}">
                        <select name="poolId">
                            <option value="">-- Tất cả hồ bơi --</option>
                            <c:forEach var="pool" items="${poolList}">
                                <option value="${pool.poolId}" <c:if test="${fn:trim(pool.poolId) == fn:trim(poolId)}">selected</c:if>>${pool.poolName}</option>
                            </c:forEach>
                        </select>
                        <select name="status">
                            <option value="">-- Tất cả trạng thái --</option>
                            <option value="pending" ${status == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                            <option value="done" ${status == 'done' ? 'selected' : ''}>Đã xử lý</option>
                        </select>

                        <!-- Dropdown chọn số lượng/trang -->
                        <select name="pageSize" id="pageSizeSelect" onchange="document.getElementById('searchForm').submit();">
                            <option value="5" ${pageSize == 5 ? 'selected' : ''}>5/Trang</option>
                            <option value="10" ${pageSize == 10 ? 'selected' : ''}>10/Trang</option>
                            <option value="15" ${pageSize == 15 ? 'selected' : ''}>15/Trang</option>
                        </select>

                        <input type="hidden" name="page" value="${page}">
                        <button type="submit">Tìm kiếm</button>
                    </form>

                    <div style="margin-top: 10px; color: #666;">
                        Tổng số báo cáo: ${totalReports}
                    </div>
                </div>

                <table class="report-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nhân viên</th>
                            <th>Hồ bơi</th>
                            <th>Tên thiết bị</th>
                            <th>Lý do báo cáo</th>
                            <th>Đề xuất</th>
                            <th>Ngày báo cáo</th>
                            <th>Trạng thái</th>
                            <th>Device ID</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty reports}">
                                <tr>
                                    <td colspan="10" style="text-align: center; color: gray; font-style: italic;">
                                        Không tìm thấy báo cáo nào phù hợp.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="report" items="${reports}">
                                    <tr>
                                        <td>${report.reportId}</td>
                                        <td>${report.staffName}</td>
                                        <td>${report.poolName}</td>
                                        <td>${report.deviceName}</td>
                                        <td style="max-width: 200px; word-wrap: break-word;">${report.reportReason}</td>
                                        <td style="max-width: 200px; word-wrap: break-word;">${report.suggestion}</td>
                                        <td>
                                            <fmt:formatDate value="${report.reportDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td>
                                            <span class="status ${report.status}">
                                                <c:choose>
                                                    <c:when test="${report.status == 'pending'}">Chờ xử lý</c:when>
                                                    <c:when test="${report.status == 'done'}">Đã xử lý</c:when>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${report.deviceId != null}">
                                                    <span class="device-info">ID: ${report.deviceId}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: red;">Chưa gán</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:if test="${report.status == 'pending'}">
                                                <!-- Nút cập nhật device ID -->
                                                <a href="managerUpdateDeviceServlet?id=${report.deviceId}
                                                   &poolId=${poolId}
                                                   &keyword=${keyword}
                                                   &status=${status}
                                                   &page=${page}
                                                   &pageSize=${pageSize}" class="btn-action btn-update">Cập nhật</a>

                                                <!-- Nút đã duyệt -->
                                                <form action="managerApproveDeviceReportServlet" method="post" style="display:inline;">
                                                    <input type="hidden" name="reportId" value="${report.reportId}">
                                                    <input type="hidden" name="poolId" value="${poolId}">
                                                    <input type="hidden" name="keyword" value="${keyword}">
                                                    <input type="hidden" name="status" value="${status}">
                                                    <input type="hidden" name="page" value="${page}">
                                                    <input type="hidden" name="pageSize" value="${pageSize}">
                                                    <button type="submit" class="btn-approve" onclick="return confirm('Bạn chắc chắn muốn duyệt báo cáo này?')">Đã duyệt</button>
                                                </form>
                                            </c:if>
                                            <c:if test="${report.status == 'done'}">
                                                <span style="color: green; font-style: italic;">Đã xử lý</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>

                <!-- Phân trang -->
                <div class="pagination">
                    <c:if test="${page > 1}">
                        <a href="managerListDeviceReportServlet?page=${page-1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">&laquo;</a>
                    </c:if>
                    <c:forEach begin="1" end="${endP}" var="i">
                        <a href="managerListDeviceReportServlet?page=${i}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}"
                           class="${i == page ? 'active' : ''}">${i}</a>
                    </c:forEach>
                    <c:if test="${page < endP}">
                        <a href="managerListDeviceReportServlet?page=${page+1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">&raquo;</a>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- JavaScript tìm kiếm tự động -->
        <script>
            const searchInput = document.querySelector('input[name="keyword"]');
            const searchForm = document.getElementById('searchForm');
            let timeout = null;

            searchInput.addEventListener('input', function () {
                clearTimeout(timeout);
                timeout = setTimeout(() => {
                    document.querySelector('input[name="page"]').value = 1; // reset về trang 1
                    searchForm.submit();
                }, 400);
            });

            searchForm.addEventListener('submit', function (e) {
                const keyword = searchInput.value.trim();
                if (keyword.length > 100) {
                    alert("Từ khóa tìm kiếm không được vượt quá 100 ký tự.");
                    e.preventDefault();
                }
            });
        </script>
    </body>
</html>
