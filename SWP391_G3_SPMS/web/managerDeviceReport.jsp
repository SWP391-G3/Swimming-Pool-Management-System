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
       <style>
            /* Modern Modal Styles - Enhanced & Enlarged */
            .modal {
                display: none;
                position: fixed;
                z-index: 9999;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background: rgba(0, 0, 0, 0.6);
                backdrop-filter: blur(4px);
                animation: fadeIn 0.3s ease-out;
            }

            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }

            @keyframes slideIn {
                from { transform: scale(0.9) translateY(-20px); opacity: 0; }
                to { transform: scale(1) translateY(0); opacity: 1; }
            }

            @keyframes slideOut {
                from { transform: scale(1) translateY(0); opacity: 1; }
                to { transform: scale(0.9) translateY(-20px); opacity: 0; }
            }

            .modal-content {
                background: #ffffff;
                margin: 1% auto;
                padding: 0;
                border-radius: 16px;
                width: 98%;
                max-width: 1400px;
                position: relative;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                animation: slideIn 0.3s ease-out;
                max-height: 95vh;
                display: flex;
                flex-direction: column;
            }

            .modal.closing .modal-content {
                animation: slideOut 0.3s ease-in forwards;
            }

            .modal-header {
                background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
                color: white;
                padding: 1.5rem 2rem;
                border-radius: 16px 16px 0 0;
                display: flex;
                align-items: center;
                justify-content: space-between;
                position: relative;
                overflow: hidden;
                flex-shrink: 0;
            }

            .modal-header::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
                animation: rotate 20s linear infinite;
            }

            @keyframes rotate {
                from { transform: rotate(0deg); }
                to { transform: rotate(360deg); }
            }

            .modal-title {
                font-size: 1.5rem;
                font-weight: 700;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                position: relative;
                z-index: 1;
                flex: 1;
            }

            .modal-icon {
                width: 24px;
                height: 24px;
                stroke-width: 2.5;
                flex-shrink: 0;
            }

            .close {
                width: 40px;
                height: 40px;
                background: rgba(255, 255, 255, 0.2);
                border: none;
                border-radius: 50%;
                color: white;
                font-size: 20px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s ease;
                z-index: 2;
                flex-shrink: 0;
            }

            .close:hover {
                background: rgba(255, 255, 255, 0.3);
                transform: scale(1.1);
            }

            .modal-body {
                padding: 2.5rem;
                overflow-y: auto;
                flex: 1;
                background: #f8fafc;
                min-height: 0;
            }

            /* Modern History Table - Enhanced & Enlarged */
            .history-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background: white;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                table-layout: fixed;
                font-size: 0.95rem;
            }

            .history-table thead {
                background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            }

            .history-table th {
                padding: 1.25rem 1rem;
                text-align: left;
                font-weight: 600;
                color: #334155;
                font-size: 0.95rem;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                border-bottom: 2px solid #e2e8f0;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            /* Column widths for larger layout */
            .history-table th:nth-child(1) { width: 9%; } /* Thời gian báo cáo */
            .history-table th:nth-child(2) { width: 8%; } /* Nhân viên báo cáo */
            .history-table th:nth-child(3) { width: 8%; } /* Lý do */
            .history-table th:nth-child(4) { width: 8%; } /* Đề xuất */
            .history-table th:nth-child(5) { width: 9%; } /* Ghi chú xử lý */
            .history-table th:nth-child(6) { width: 9%; } /* Thời gian xử lý */
            .history-table th:nth-child(7) { width: 9%; } /* Người xử lý */
            .history-table th:nth-child(8) { width: 7%; }  /* Trạng thái */

            .history-table td {
                padding: 1.25rem 1rem;
                border-bottom: 1px solid #f1f5f9;
                color: #475569;
                font-size: 0.9rem;
                line-height: 1.5;
                vertical-align: top;
                word-wrap: break-word;
                overflow-wrap: break-word;
                max-width: 0;
            }

            .history-table tbody tr {
                transition: all 0.2s ease;
                height: auto;
            }

            .history-table tbody tr:hover {
                background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
                transform: translateX(4px);
            }

            .history-table tbody tr:last-child td {
                border-bottom: none;
            }

            /* Status badges for history - Enhanced */
            .status-badge-history {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.5rem 1rem;
                border-radius: 9999px;
                font-size: 0.8rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.025em;
                white-space: nowrap;
                min-width: fit-content;
            }

            .status-pending-history {
                background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%);
                color: white;
                animation: pulse 2s infinite;
            }

            .status-done-history {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                color: white;
            }

            .status-icon-history {
                width: 14px;
                height: 14px;
                flex-shrink: 0;
            }

            @keyframes pulse {
                0% { box-shadow: 0 0 0 0 rgba(251, 191, 36, 0.4); }
                70% { box-shadow: 0 0 0 8px rgba(251, 191, 36, 0); }
                100% { box-shadow: 0 0 0 0 rgba(251, 191, 36, 0); }
            }

            /* Empty state - Enhanced */
            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                color: #64748b;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                min-height: 300px;
            }

            .empty-icon {
                width: 80px;
                height: 80px;
                margin-bottom: 1.5rem;
                color: #cbd5e1;
            }

            .empty-state h3 {
                font-size: 1.25rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
                color: #475569;
            }

            .empty-state p {
                font-size: 1rem;
                line-height: 1.6;
                max-width: 400px;
            }

            /* Button styles for modal */
            .btn-detail {
                background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
                color: white;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                font-weight: 500;
                font-size: 0.875rem;
                margin-right: 0.5rem;
                border: none;
                cursor: pointer;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                gap: 0.375rem;
            }

            .btn-detail:hover {
                background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
                transform: translateY(-1px);
                box-shadow: 0 8px 20px -4px rgba(59, 130, 246, 0.3);
            }

            .btn-detail:active {
                transform: translateY(0);
            }

            /* Loading state - Enhanced */
            .loading-spinner {
                display: inline-block;
                width: 20px;
                height: 20px;
                border: 2px solid #f3f4f6;
                border-radius: 50%;
                border-top-color: #3b82f6;
                animation: spin 1s ease-in-out infinite;
            }

            @keyframes spin {
                to { transform: rotate(360deg); }
            }

            /* Scrollbar styling for modal */
            .modal-body::-webkit-scrollbar {
                width: 8px;
            }

            .modal-body::-webkit-scrollbar-track {
                background: #f1f5f9;
                border-radius: 4px;
            }

            .modal-body::-webkit-scrollbar-thumb {
                background: #cbd5e1;
                border-radius: 4px;
            }

            .modal-body::-webkit-scrollbar-thumb:hover {
                background: #94a3b8;
            }

            /* Responsive design - Enhanced for larger modal */
            @media (max-width: 1200px) {
                .modal-content {
                    width: 95%;
                    margin: 2% auto;
                }
                
                .history-table th:nth-child(5),
                .history-table td:nth-child(5) {
                    display: none;
                }
                
                /* Adjust remaining column widths */
                .history-table th:nth-child(1) { width: 15%; }
                .history-table th:nth-child(2) { width: 14%; }
                .history-table th:nth-child(3) { width: 24%; }
                .history-table th:nth-child(4) { width: 24%; }
                .history-table th:nth-child(6) { width: 14%; }
                .history-table th:nth-child(7) { width: 12%; }
                .history-table th:nth-child(8) { width: 7%; }
            }

            @media (max-width: 1024px) {
                .modal-content {
                    width: 98%;
                    max-width: none;
                    margin: 1rem auto;
                }
                
                .history-table th:nth-child(6),
                .history-table td:nth-child(6) {
                    display: none;
                }

                /* Adjust remaining column widths */
                .history-table th:nth-child(1) { width: 16%; }
                .history-table th:nth-child(2) { width: 15%; }
                .history-table th:nth-child(3) { width: 27%; }
                .history-table th:nth-child(4) { width: 27%; }
                .history-table th:nth-child(7) { width: 12%; }
                .history-table th:nth-child(8) { width: 8%; }
            }

            @media (max-width: 768px) {
                .modal-content {
                    margin: 0.5rem;
                    width: calc(100% - 1rem);
                    max-height: calc(100vh - 1rem);
                    border-radius: 12px;
                }

                .modal-header {
                    padding: 1.5rem 2rem;
                }

                .modal-title {
                    font-size: 1.4rem;
                }

                .modal-body {
                    padding: 1.5rem;
                }

                .history-table {
                    font-size: 0.85rem;
                }

                .history-table th,
                .history-table td {
                    padding: 1rem 0.75rem;
                }

                /* Hide more columns on mobile */
                .history-table th:nth-child(n+5),
                .history-table td:nth-child(n+5) {
                    display: none;
                }

                /* Adjust remaining column widths for mobile */
                .history-table th:nth-child(1) { width: 25%; }
                .history-table th:nth-child(2) { width: 20%; }
                .history-table th:nth-child(3) { width: 30%; }
                .history-table th:nth-child(4) { width: 25%; }
            }

            @media (max-width: 480px) {
                .modal-content {
                    margin: 0.25rem;
                    width: calc(100% - 0.5rem);
                    border-radius: 8px;
                }

                .modal-header {
                    padding: 1rem 1.5rem;
                }

                .modal-title {
                    font-size: 1.1rem;
                }

                .modal-body {
                    padding: 1rem;
                }

                .history-table th:nth-child(n+4),
                .history-table td:nth-child(n+4) {
                    display: none;
                }

                /* Adjust for very small screens */
                .history-table th:nth-child(1) { width: 30%; }
                .history-table th:nth-child(2) { width: 25%; }
                .history-table th:nth-child(3) { width: 45%; }
            }

            /* Dark mode support - Enhanced */
            @media (prefers-color-scheme: dark) {
                .modal-content {
                    background: #1e293b;
                    color: #e2e8f0;
                }

                .modal-body {
                    background: #0f172a;
                }

                .history-table {
                    background: #1e293b;
                }

                .history-table th {
                    background: linear-gradient(135deg, #334155 0%, #475569 100%);
                    color: #e2e8f0;
                    border-bottom-color: #475569;
                }

                .history-table td {
                    color: #cbd5e1;
                    border-bottom-color: #334155;
                }

                .history-table tbody tr:hover {
                    background: linear-gradient(135deg, #334155 0%, #475569 100%);
                }

                .empty-state {
                    color: #94a3b8;
                }

                .empty-state h3 {
                    color: #cbd5e1;
                }

                .empty-icon {
                    color: #64748b;
                }

                .modal-body::-webkit-scrollbar-track {
                    background: #334155;
                }

                .modal-body::-webkit-scrollbar-thumb {
                    background: #475569;
                }

                .modal-body::-webkit-scrollbar-thumb:hover {
                    background: #64748b;
                }
            }
        </style>
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
                                            <button type="button" class="btn-detail" onclick="showHistoryPopup('${report.deviceId}', '${report.deviceName}')">
                                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                                </svg>
                                                Lịch sử
                                            </button>
                                            <c:if test="${report.status == 'pending'}">
                                                <a href="managerProcessDeviceReportServlet?reportId=${report.reportId}" class="btn-action btn-update">Xử lý</a>
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

        <!-- Modern Modal Popup -->
        <div id="historyModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title">
                        <svg class="modal-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <span id="modalTitle">Lịch sử báo cáo thiết bị</span>
                    </h3>
                    <button class="close" onclick="closeHistoryPopup()">
                        <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="historyContent">
                        <div class="loading-spinner"></div>
                    </div>
                </div>
            </div>
        </div>

       <!-- Render ẩn lịch sử cho từng deviceId - KEEP TABLE WRAPPER -->
        <div id="historyHiddenRows" style="display:none;">
            <c:forEach var="deviceHistory" items="${allDevicesReportsHistory}">
                <c:set var="deviceId" value="${deviceHistory.key}" />
                <c:forEach var="r" items="${deviceHistory.value}">
                    <div class="history-data-row" data-deviceid="${deviceId}">
                        <table style="display: none;">
                            <tbody>
                                <tr>
                                    <td><fmt:formatDate value="${r.reportDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td>${r.staffName}</td>
                                    <td>${r.reportReason}</td>
                                    <td>${r.suggestion}</td>
                                    <td>${r.managerNote}</td>
                                    <td>
                                        <c:if test="${not empty r.processedAt}">
                                            <fmt:formatDate value="${r.processedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                        </c:if>
                                    </td>
                                    <td>${r.processedByName}</td>
                                    <td>
                                        <span class="status-badge-history ${r.status == 'pending' ? 'status-pending-history' : 'status-done-history'}">
                                            <c:choose>
                                                <c:when test="${r.status == 'pending'}">
                                                    <svg class="status-icon-history" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                                    </svg>
                                                    Chờ xử lý
                                                </c:when>
                                                <c:otherwise>
                                                    <svg class="status-icon-history" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                    </svg>
                                                    Đã xử lý
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </c:forEach>
            </c:forEach>
        </div>

        <script>
            function showHistoryPopup(deviceId, deviceName = '') {
                const modal = document.getElementById('historyModal');
                const modalTitle = document.getElementById('modalTitle');
                const historyContent = document.getElementById('historyContent');
                
                // Update modal title
                modalTitle.textContent = deviceName ? 
                    `Lịch sử báo cáo thiết bị: ${deviceName}` : 
                    'Lịch sử báo cáo thiết bị';
                
                // Show loading spinner
                historyContent.innerHTML = `
                    <div style="text-align: center; padding: 3rem;">
                        <div class="loading-spinner" style="margin: 0 auto 1rem;"></div>
                        <p style="color: #64748b;">Đang tải lịch sử...</p>
                    </div>
                `;
                
                // Show modal
                modal.style.display = 'block';
                
                // Simulate loading delay for better UX
                setTimeout(() => {
                    // Lấy các dòng lịch sử báo cáo cho deviceId
                    var rows = document.querySelectorAll('.history-data-row[data-deviceid="' + deviceId + '"]');
                    var content = '';
                    
                    if (rows.length > 0) {
                        content += `
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
                        `;
                        
                        // Lấy tr element từ mỗi row và thêm vào tbody
                        rows.forEach(function(row) {
                            const trElement = row.querySelector('tr');
                            if (trElement) {
                                content += trElement.outerHTML;
                            }
                        });
                        
                        content += '</tbody></table>';
                    } else {
                        content = `
                            <div class="empty-state">
                                <svg class="empty-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                </svg>
                                <h3>Chưa có lịch sử báo cáo</h3>
                                <p>Thiết bị này chưa có báo cáo nào được ghi nhận trong hệ thống.</p>
                            </div>
                        `;
                    }
                    
                    historyContent.innerHTML = content;
                }, 300);
            }

            function closeHistoryPopup() {
                const modal = document.getElementById('historyModal');
                modal.classList.add('closing');
                
                setTimeout(() => {
                    modal.style.display = 'none';
                    modal.classList.remove('closing');
                }, 300);
            }

            // Close modal when clicking outside
            window.onclick = function(event) {
                const modal = document.getElementById('historyModal');
                if (event.target === modal) {
                    closeHistoryPopup();
                }
            };

            // Close modal with Escape key
            document.addEventListener('keydown', function(event) {
                if (event.key === 'Escape') {
                    const modal = document.getElementById('historyModal');
                    if (modal.style.display === 'block') {
                        closeHistoryPopup();
                    }
                }
            });

            // JavaScript tìm kiếm tự động
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