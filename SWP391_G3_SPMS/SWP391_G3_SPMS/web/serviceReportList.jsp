<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    request.setAttribute("activeMenu", "service-reports");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý báo cáo dịch vụ hồ bơi</title>
        <link rel="stylesheet" href="./manager-css/manager-device-v3.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
        <style>
            .modal {
                display:none;
                position:fixed;
                z-index:9999;
                left:0;
                top:0;
                width:100vw;
                height:100vh;
                background:rgba(0,0,0,0.25);
                align-items:center;
                justify-content:center;
            }
            .custom-modal-content {
                background: #fff;
                min-width: 70vw;
                max-width: 97vw;
                border-radius: 20px;
                box-shadow: 0 10px 36px 0 rgba(44,124,246,0.15), 0 2.5px 10px 0 rgba(0,0,0,.10);
                padding: 40px 42px 26px 42px;
                position: relative;
                display: flex;
                flex-direction: column;
                animation: popupBounceIn .22s;
            }

            .modal-2col {
                display: flex;
                gap: 38px;
                justify-content: space-between;
                margin-bottom: 24px;
                margin-left: 0;
            }

            .modal-2col .col {
                flex: 1 1 0;
                display: flex;
                flex-direction: column;
                gap: 13px;
            }

            .modal-2col .col div {
                font-size: 1.11em;
                margin-bottom: 0;
                display: flex;
                align-items: flex-start;
            }

            .modal-2col b {
                min-width: 150px;
                color: #2989fd;
                font-weight: 700;
                font-size: 1.05em;
                margin-right: 6px;
            }

            .custom-modal {
                display: none;
                position: fixed;
                z-index: 9999;
                left: 0;
                top: 0;
                width: 100vw;
                height: 100vh;
                background: rgba(30, 41, 59, 0.14);
                align-items: center;
                justify-content: center;
                animation: modalFadeIn .2s;
            }
            @keyframes modalFadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .custom-modal-content {
                background: #fff;
                min-width: 340px;
                max-width: 94vw;
                border-radius: 20px;
                box-shadow: 0 8px 32px 0 rgba(44,124,246,0.09), 0 1.5px 6px 0 rgba(0,0,0,.05);
                padding: 32px 32px 22px 32px;
                position: relative;
                display: flex;
                flex-direction: column;
                animation: popupBounceIn .22s;
            }
            @keyframes popupBounceIn {
                0% {
                    transform: scale(0.97) translateY(40px);
                    opacity: 0;
                }
                80% {
                    transform: scale(1.04) translateY(-8px);
                }
                100% {
                    transform: scale(1) translateY(0);
                    opacity: 1;
                }
            }

            .custom-modal-close {
                position: absolute;
                right: 20px;
                top: 16px;
                font-size: 1.5em;
                background: none;
                border: none;
                color: #b6b8c7;
                cursor: pointer;
                font-weight: bold;
                transition: color .16s;
            }
            .custom-modal-close:hover {
                color: #1976d2;
            }

            .custom-modal-header {
                display: flex;
                align-items: center;
                gap: 16px;
                margin-bottom: 12px;
            }
            .custom-modal-icon {
                background: linear-gradient(135deg, #f3f9fe 60%, #dbf0fc 100%);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 46px;
                height: 46px;
                box-shadow: 0 1.5px 8px 0 #e3f2fd60;
            }
            .custom-modal-title {
                font-size: 1.28em;
                font-weight: 700;
                color: #1558c0;
                letter-spacing: 0.01em;
            }

            .custom-modal-body {
                margin-bottom: 24px;
                margin-left: 6px;
                color: #222;
            }
            .custom-modal-body div {
                margin-bottom: 9px;
                font-size: 1.04em;
            }
            .custom-modal-body b {
                font-weight: 600;
                color: #297aff;
            }

            .custom-modal-action {
                background: linear-gradient(90deg,#38b6ff 40%, #2690ff 100%);
                color: #fff;
                border: none;
                border-radius: 8px;
                padding: 10px 32px;
                font-weight: 600;
                font-size: 1.07em;
                cursor: pointer;
                transition: background 0.15s, box-shadow 0.13s;
                box-shadow: 0 1.5px 8px #e3f2fd30;
                margin-top: 5px;
            }
            .custom-modal-action:hover {
                background: linear-gradient(90deg, #1899ff 40%, #1866bf 100%);
                box-shadow: 0 2px 12px #bfe5ff;
                transform: translateY(-2px) scale(1.03);
            }


            .content-panel {
                padding: 20px 40px;
            }
            .filter-form {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }
            .filter-form input, .filter-form select {
                padding: 6px 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .btn-filter {
                background: #2690ff;
                color: #fff;
                border: none;
                padding: 6px 18px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
            }
            .btn-filter:hover {
                background: #1976d2;
            }
            .btn-reset {
                background: #ede7f6;
                color: #8e24aa;
                border: none;
                padding: 6px 18px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
                margin-left: 2px;
                text-decoration: none;
                display: inline-block;
            }
            .btn-reset:hover {
                background: #d1c4e9;
                color: #6d1b7b;
            }
            .table-service-report {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 1px 3px rgba(0,0,0,0.04);
                margin-bottom: 20px;
            }
            .table-service-report th, .table-service-report td {
                padding: 10px 14px;
                text-align: left;
                border-bottom: 1px solid #eee;
            }
            .table-service-report th {
                background: #f5f5f5;
                font-weight: 600;
            }
            .table-service-report tr:last-child td {
                border-bottom: none;
            }
            .status-badge {
                display: inline-block;
                padding: 3px 10px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 500;
                color: #fff;
            }
            .status-pending {
                background: #1976d2;
            }
            .status-done {
                background: #43a047;
            }
            .status-rejected {
                background: #e53935;
            }
            .pagination {
                margin-top: 20px;
                text-align: center;
            }
            .pagination a, .pagination span {
                margin: 0 3px;
                padding: 6px 12px;
                border: 1px solid #ccc;
                text-decoration: none;
                border-radius: 4px;
                color: #333;
                background: #fff;
                font-weight: 500;
            }
            .pagination a:hover {
                background: #e3f0fd;
                color: #1a73e8;
                border-color: #1a73e8;
            }
            .pagination .active {
                background-color: #1976d2;
                color: white;
                font-weight: bold;
                border-color: #1976d2;
            }
            .pagination .disabled {
                color: #aaa;
                border-color: #eee;
                background: #fafafa;
                pointer-events: none;
            }


            .btn-detail {
                background: linear-gradient(90deg, #42a5f5 0%, #1e88e5 100%);
                color: #fff;
                padding: 6px 16px;
                font-size: 0.96em;
                font-weight: 500;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background 0.2s, transform 0.15s, box-shadow 0.15s;
                box-shadow: 0 1px 4px rgba(0,0,0,0.12);

            }
        </style>
    </head>
    <body>
        <div class="layout">
            <%@ include file="../managerSidebar.jsp" %>
            <div class="content-panel">
                <div class="header">
                    <h2>Quản lý báo cáo dịch vụ hồ bơi</h2>
                    <button class="btn-add" onclick="window.location.href = 'pool-service'">&larr; Quản lý dịch vụ</button>
                </div>
                <!-- Bộ lọc -->
                <form class="filter-form" method="get" action="service-reports">
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
                    <select name="pageSize">
                        <option value="5" ${pageSize == 5 ? 'selected' : ''}>5/trang</option>
                        <option value="10" ${pageSize == 10 ? 'selected' : ''}>10/trang</option>
                        <option value="15" ${pageSize == 15 ? 'selected' : ''}>15/trang</option>
                    </select>
                    <button type="submit" class="btn-filter">Lọc</button>
                    <a href="service-reports" class="btn-reset">Reset</a>
                </form>
                <!-- Danh sách báo cáo -->
                <c:choose>
                    <c:when test="${empty list}">
                        <p style="text-align: center; color: gray; font-style: italic;">Không có báo cáo nào phù hợp.</p>
                    </c:when>
                    <c:otherwise>
                        <table class="table-service-report">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên dịch vụ</th>
                                    <th>Hồ bơi</th>
                                    <th>Nhân viên</th>
                                    <th>Ngày báo cáo</th>
                                    <th>Trạng thái</th>
                                    <th>Xem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="report" items="${list}">
                                    <tr>
                                        <td>${report.reportId}</td>
                                        <td><b>${report.serviceName}</b></td>
                                        <td>${report.poolName}</td>
                                        <td>${report.staffName}</td>
                                        <td>${report.reportDate}</td>
                                        <td>
                                            <span class="status-badge status-${report.status}">
                                                <c:choose>
                                                    <c:when test="${report.status == 'pending'}">Chờ duyệt</c:when>
                                                    <c:when test="${report.status == 'done'}">Đã duyệt</c:when>
                                                    <c:otherwise>${report.status}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <button type="button"
                                                    class="btn-detail"
                                                    onclick="showReportDetail(
                        '${fn:escapeXml(report.serviceName)}',
                        '${fn:escapeXml(report.reportReason)}',
                        '${fn:escapeXml(report.suggestion)}',
                        '${report.reportDate}',
                        '${report.status}',
                                                    ${report.serviceId},
                        '${fn:escapeXml(report.poolName)}',
                        '${fn:escapeXml(report.staffName)}',
                        '${fn:escapeXml(report.branchName)}',
                                                    ${report.reportId}
                )">
                                                Chi tiết
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>

                        </table>
                    </c:otherwise>
                </c:choose>
                <!-- Phân trang -->
                <div class="pagination">
                    <c:choose>
                        <c:when test="${endPage > 1}">
                            <c:set var="range" value="2"/>
                            <c:set var="start" value="${page - range > 1 ? page - range : 1}"/>
                            <c:set var="end" value="${page + range < endPage ? page + range : endPage}"/>
                            <c:if test="${page > 1}">
                                <a href="service-reports?page=1&name=${fn:escapeXml(name)}&poolId=${poolId}&status=${status}&pageSize=${pageSize}">&laquo;</a>
                            </c:if>
                            <c:if test="${start > 1}">
                                <span>...</span>
                            </c:if>
                            <c:forEach var="i" begin="${start}" end="${end}">
                                <a href="service-reports?page=${i}&name=${fn:escapeXml(name)}&poolId=${poolId}&status=${status}&pageSize=${pageSize}" class="${i == page ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            <c:if test="${end < endPage}">
                                <span>...</span>
                            </c:if>
                            <c:if test="${page < endPage}">
                                <a href="service-reports?page=${endPage}&name=${fn:escapeXml(name)}&poolId=${poolId}&status=${status}&pageSize=${pageSize}">&raquo;</a>
                            </c:if>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>
        <div id="reportDetailModal" class="custom-modal">
            <div class="custom-modal-content">
                <button class="custom-modal-close" onclick="closeReportDetail()">&times;</button>
                <div class="custom-modal-header">
                    <div class="custom-modal-icon">
                        <svg viewBox="0 0 24 24" width="36" height="36" fill="#38b6ff"><circle cx="12" cy="12" r="10" fill="#e3f5fe"/><path d="M12 8v4M12 16h.01" stroke="#1c70e6" stroke-width="2" stroke-linecap="round"/></svg>
                    </div>
                    <span id="modalServiceName" class="custom-modal-title"></span>
                </div>
                <div class="custom-modal-body modal-2col">
                    <div class="col">
                        <div><b>Hồ bơi:</b> <span id="modalPoolName"></span></div>
                        <div><b>Chi nhánh:</b> <span id="modalBranchName"></span></div>
                        <div><b>Nhân viên lập báo cáo:</b> <span id="modalStaffName"></span></div>
                    </div>
                    <div class="col">
                        <div><b>Ngày báo cáo:</b> <span id="modalReportDate"></span></div>
                        <div><b>Trạng thái:</b> <span id="modalStatus"></span></div>
                    </div>
                </div>
                <div><b>Lý do báo cáo:</b> <span id="modalReportReason"></span></div>
                <div><b>Gợi ý xử lý:</b> <span id="modalSuggestion"></span></div>
                <div style="display: flex; gap: 10px; margin-top:20px;">
                    <button id="modalApproveBtn" class="custom-modal-action" style="display:none;">Phê duyệt báo cáo</button>

                </div>
            </div>
        </div>

    </body>
    <script>
        let currentReportId = null;
        function showReportDetail(serviceName, reportReason, suggestion, reportDate, status, serviceId, poolName, staffName, branchName, reportId) {
            document.getElementById('modalServiceName').innerText = serviceName;
            document.getElementById('modalReportReason').innerText = reportReason;
            document.getElementById('modalSuggestion').innerText = suggestion;
            document.getElementById('modalReportDate').innerText = reportDate;
            document.getElementById('modalPoolName').innerText = poolName;
            document.getElementById('modalStaffName').innerText = staffName;
            document.getElementById('modalBranchName').innerText = branchName;
            currentReportId = reportId;
            let statusLabel = '';
            if (status === 'pending')
                statusLabel = 'Chờ duyệt';
            else if (status === 'approved')
                statusLabel = 'Đã duyệt';
            else if (status === 'rejected')
                statusLabel = 'Từ chối';
            else
                statusLabel = status;
            document.getElementById('modalStatus').innerText = statusLabel;

            // Show/Hide "Đã kiểm tra" button chỉ nếu là pending
            if (status === 'pending') {
                document.getElementById('modalApproveBtn').style.display = '';
                document.getElementById('modalApproveBtn').onclick = function () {
                    approveReport(currentReportId);
                }
            } else {
                document.getElementById('modalApproveBtn').style.display = 'none';
            }
            // Link cập nhật dịch vụ

            document.getElementById('reportDetailModal').style.display = 'flex';
        }

        function closeReportDetail() {
            document.getElementById('reportDetailModal').style.display = 'none';
        }
                var ctx = "${pageContext.request.contextPath}";
        function approveReport(reportId) {
            if (!reportId)
                return;
            const formData = new URLSearchParams();
            formData.append("action", "done");
            formData.append("id", reportId);

            fetch(ctx + '/service-reports', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formData.toString()
            })
                    .then(response => response.text()) // đổi sang text để debug lỗi
                    .then(text => {
                        try {
                            let data = JSON.parse(text);
                            if (data.success) {
                                alert('Đã duyệt báo cáo!');
                                location.reload();
                            } else {
                                alert('Có lỗi xảy ra khi duyệt báo cáo!');
                            }
                        } catch (e) {
                            alert("Server response lỗi: " + text);
                        }
                    })
                    .catch(() => {
                        alert('Có lỗi kết nối khi duyệt báo cáo!');
                    });
        }
    </script>

</html>
