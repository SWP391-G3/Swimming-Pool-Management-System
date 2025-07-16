<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    request.setAttribute("activeMenu", "service-reports");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý báo cáo dịch vụ hồ bơi</title>
    <link rel="stylesheet" href="./manager-css/manager-deviceReport-v2.css">
    <link rel="stylesheet" href="./manager-css/manager-panel.css">
</head>
<body>
<div class="layout">
    <%@ include file="../managerSidebar.jsp" %>
    <div class="content-panel">
        <div class="header">
            
              <a href="pool-service" class="btn-back-to-device">← Quản lý dịch vụ</a> <br>
            <h2>Quản lý báo cáo dịch vụ hồ bơi</h2>
          

            <form class="filter-group" method="get" action="managerListServiceReportServlet" id="searchForm">
                <input type="text" name="name" placeholder="Tên dịch vụ..." value="${fn:escapeXml(name)}">
                <select name="poolId">
                    <option value="">-- Tất cả hồ bơi --</option>
                    <c:forEach var="pool" items="${poolList}">
                        <option value="${pool.pool_id}" <c:if test="${poolId == pool.pool_id}">selected</c:if>>${pool.pool_name}</option>
                    </c:forEach>
                </select>
                <select name="status">
                    <option value="">-- Tất cả trạng thái --</option>
                    <option value="pending" ${status == 'pending' ? 'selected' : ''}>Chờ duyệt</option>
                    <option value="done" ${status == 'done' ? 'selected' : ''}>Đã duyệt</option>
                </select>
                <select name="pageSize" onchange="document.getElementById('searchForm').submit();">
                    <option value="5" ${pageSize == 5 ? 'selected' : ''}>5/trang</option>
                    <option value="10" ${pageSize == 10 ? 'selected' : ''}>10/trang</option>
                    <option value="15" ${pageSize == 15 ? 'selected' : ''}>15/trang</option>
                </select>
                <input type="hidden" name="page" value="${page}">
                <button type="submit">Tìm kiếm</button>
            </form>

            <div style="margin-top: 10px; color: #666;">Tổng số báo cáo: ${totalReports}</div>
        </div>

        <table class="report-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên dịch vụ</th>
                    <th>Hồ bơi</th>
                    <th>Nhân viên</th>
                    <th>Lý do</th>
                    <th>Đề xuất</th>
                    <th>Ngày báo cáo</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                    <th>Chi tiết</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="9" style="text-align: center; color: gray; font-style: italic;">Không có báo cáo nào phù hợp.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="report" items="${list}">
                            <tr>
                                <td>${report.reportId}</td>
                                <td>${fn:escapeXml(report.serviceName)}</td>
                                <td>${fn:escapeXml(report.poolName)}</td>
                                <td>${fn:escapeXml(report.staffName)}</td>
                                <td style="max-width: 200px; word-wrap: break-word;">${fn:escapeXml(report.reportReason)}</td>
                                <td style="max-width: 200px; word-wrap: break-word;">${fn:escapeXml(report.suggestion)}</td>
                                <td><fmt:formatDate value="${report.reportDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td>
                                    <span class="status ${report.status}">
                                        <c:choose>
                                            <c:when test="${report.status == 'pending'}">Chờ duyệt</c:when>
                                            <c:when test="${report.status == 'done'}">Đã duyệt</c:when>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>
                                    <c:if test="${report.status == 'pending'}">
                                        <a href="ManagerProcessServiceReport?reportId=${report.reportId}" class="btn-action btn-update">Duyệt</a>
                                    </c:if>
                                    <c:if test="${report.status == 'done'}">
                                        <span style="color: green; font-style: italic;">Đã duyệt</span>
                                    </c:if>
                                </td>
                                <td>
                                    <a href="ManagerProcessServiceReport?reportId=${report.reportId}" class="btn-action btn-update">Chi tiết</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <div class="pagination">
            <c:if test="${page > 1}">
                <a href="service-reports?page=${page-1}&name=${fn:escapeXml(name)}&status=${status}&poolId=${poolId}&pageSize=${pageSize}">&laquo;</a>
            </c:if>
            <c:forEach begin="1" end="${endPage}" var="i">
                <a href="service-reports?page=${i}&name=${fn:escapeXml(name)}&status=${status}&poolId=${poolId}&pageSize=${pageSize}"
                   class="${i == page ? 'active' : ''}">${i}</a>
            </c:forEach>
            <c:if test="${page < endPage}">
                <a href="service-reports?page=${page+1}&name=${fn:escapeXml(name)}&status=${status}&poolId=${poolId}&pageSize=${pageSize}">&raquo;</a>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>
