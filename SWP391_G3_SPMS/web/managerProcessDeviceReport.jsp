<%-- 
    Document   : managerProcessDeviceReport
    Created on : Jul 14, 2025, 9:34:15 PM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xử lý báo cáo thiết bị</title>
        <link rel="stylesheet" href="./manager-css/manager-ProcessDeviceReport.css">
    </head>
    <body>
        <div class="container">
            <!-- Header -->
            <div class="header">
                <h2>Xử lý báo cáo thiết bị</h2>
            </div>

            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="error-message">
                    <svg class="error-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    ${error}
                </div>
            </c:if>

            <c:if test="${not empty report}">
                
                <!-- History Section -->
                <c:if test="${not empty deviceReportsHistory}">
                    <div class="history-section">
                        <div class="report-card">
                            <div class="card-header">
                                <h3>
                                    <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                    </svg>
                                    Lịch sử báo cáo & xử lý thiết bị
                                </h3>
                            </div>
                            <div class="card-content">
                                <div class="table-container">
                                    <table class="history-table">
                                        <thead>
                                            <tr>
                                                <th>Thời gian báo cáo</th>
                                                <th>Nhân viên báo cáo</th>
                                                <th>Lý do</th>
                                                <th>Đề xuất</th>
                                                <th>Ghi chú xử lý</th>
                                                <th>Thời gian xử lý</th>
                                                <th>Người xử lý</th>
                                                <th>Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="r" items="${deviceReportsHistory}">
                                                <tr>
                                                    <td>
                                                        <fmt:formatDate value="${r.reportDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </td>
                                                    <td class="staff-name">${r.staffName}</td>
                                                    <td class="report-reason">${r.reportReason}</td>
                                                    <td class="suggestion">${r.suggestion}</td>
                                                    <td class="manager-note">${r.managerNote}</td>
                                                    <td>
                                                        <c:if test="${not empty r.processedAt}">
                                                            <fmt:formatDate value="${r.processedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                        </c:if>
                                                    </td>
                                                    <td class="processed-by">${r.processedByName}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${r.status == 'pending'}">
                                                                <span class="status-badge status-pending">
                                                                    <svg class="status-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                                                    </svg>
                                                                    Chờ xử lý
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${r.status == 'done'}">
                                                                <span class="status-badge status-done">
                                                                    <svg class="status-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                                    </svg>
                                                                    Đã xử lý
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="status-badge status-other">${r.status}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                
                
                
                
                
                
                <!-- Main Content Grid -->
                <div class="content-grid">
                    <!-- Report Information Card -->
                    <div class="report-card">
                        <div class="card-header">
                            <h3>
                                <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                </svg>
                                Thông tin báo cáo
                            </h3>
                        </div>
                        <div class="card-content">
                            <div class="field-group">
                                <div class="field-row">
                                    <label>ID báo cáo:</label>
                                    <span class="field-value">#${report.reportId}</span>
                                </div>
                                <div class="field-row">
                                    <label>Nhân viên báo cáo:</label>
                                    <span class="field-value">${report.staffName}</span>
                                </div>
                                <div class="field-row">
                                    <label>Hồ bơi:</label>
                                    <span class="field-value">${report.poolName}</span>
                                </div>
                                <div class="field-row">
                                    <label>Tên thiết bị:</label>
                                    <input type="text" value="${report.deviceName}" readonly class="form-control readonly">
                                </div>
                                <div class="field-row">
                                    <label>Lý do báo cáo:</label>
                                    <textarea readonly class="form-control readonly">${report.reportReason}</textarea>
                                </div>
                                <div class="field-row">
                                    <label>Đề xuất:</label>
                                    <textarea readonly class="form-control readonly">${report.suggestion}</textarea>
                                </div>
                                <div class="field-row">
                                    <label>Ngày báo cáo:</label>
                                    <span class="field-value">
                                        <fmt:formatDate value="${report.reportDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </span>
                                </div>
                                <div class="field-row">
                                    <label>Trạng thái:</label>
                                    <span class="status-badge ${report.status == 'pending' ? 'status-pending' : 'status-done'}">
                                        <c:choose>
                                            <c:when test="${report.status == 'pending'}">
                                                <svg class="status-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                                </svg>
                                                Chờ xử lý
                                            </c:when>
                                            <c:otherwise>
                                                <svg class="status-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                </svg>
                                                Đã xử lý
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Device Management Card -->
                    <c:if test="${not empty device}">
                        <div class="report-card">
                            <div class="card-header">
                                <h3>
                                    <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                    </svg>
                                    Xử lí báo cáo thiết bị
                                </h3>
                            </div>
                            <div class="card-content">
                                <div class="field-group">
                                    <div class="field-row">
                                        <label>Ảnh thiết bị:</label>
                                        <div class="device-image-container">
                                            <img src="${device.deviceImage}" alt="Thiết bị" class="device-image">
                                        </div>
                                    </div>

                                    <form method="post" action="managerProcessDeviceReportServlet">
                                        <input type="hidden" name="reportId" value="${report.reportId}">

                                        <div class="field-group">
                                            <label>Trạng thái thiết bị:</label>
                                            <select name="deviceStatus" class="form-control">
                                                <option value="available" ${device.deviceStatus == 'available' ? 'selected' : ''}>
                                                    ✓ Tốt
                                                </option>
                                                <option value="maintenance" ${device.deviceStatus == 'maintenance' ? 'selected' : ''}>
                                                    🔧 Bảo trì
                                                </option>
                                                <option value="broken" ${device.deviceStatus == 'broken' ? 'selected' : ''}>
                                                    ❌ Hỏng
                                                </option>
                                            </select>
                                        </div>

                                        <div class="field-group">
                                            <label>Số lượng thiết bị:</label>
                                            <input type="number" name="quantity" min="1" value="${device.quantity}" class="form-control">
                                        </div>

                                        <div class="field-group">
                                            <label>Ghi chú xử lý:</label>
                                            <textarea name="managerNote" maxlength="200" placeholder="Thêm ghi chú xử lý (nếu có)..." class="form-control"></textarea>
                                        </div>

                                        <div class="btn-group">
                                            <button type="submit" class="btn btn-primary">
                                                <svg class="btn-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                </svg>
                                                Cập nhật & Phê duyệt
                                            </button>
                                            <a href="managerListDeviceReportServlet" class="btn btn-secondary">
                                                <svg class="btn-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                                                </svg>
                                                Quay lại
                                            </a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Device Not Found Message -->
                    <c:if test="${empty device}">
                        <div class="report-card">
                            <div class="card-content">
                                <div class="no-device-message">
                                    <svg class="no-device-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                    </svg>
                                    <p>Thiết bị bị báo cáo không còn tồn tại trong hệ thống.</p>
                                    <a href="managerListDeviceReportServlet" class="btn btn-secondary">
                                        <svg class="btn-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                                        </svg>
                                        Quay lại
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>

                
            </c:if>

            <!-- No Report Found Message -->
            <c:if test="${empty report}">
                <div class="no-report-message">
                    <svg class="no-report-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                    <p>Không tìm thấy báo cáo này.</p>
                    <a href="managerListDeviceReportServlet" class="btn btn-secondary">
                        <svg class="btn-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                        </svg>
                        Quay lại
                    </a>
                </div>
            </c:if>
        </div>
    </body>
</html>