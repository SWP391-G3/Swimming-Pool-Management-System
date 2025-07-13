<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    model.staff.StaffJoinedTable staff = (model.staff.StaffJoinedTable) session.getAttribute("staff");
    model.customer.User user = (model.customer.User) session.getAttribute("currentUser");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Báo cáo thiết bị của tôi</title>
    <link rel="stylesheet" href="./manager-css/manager-device-v3.css">
    <link rel="stylesheet" href="./manager-css/manager-panel.css">
    <style>
        body { background: #f3f6fa; }
        .content-panel { padding: 20px 40px; }
        .header { margin-bottom: 12px; }
        .header h2 { color: #2563eb; font-weight: bold; margin: 0 0 12px 0; font-size: 1.32em;}
        .btn-back { background: #43a047; color: #fff; border: none; border-radius: 6px; padding: 8px 22px; font-weight: 600; cursor: pointer; margin-bottom: 14px; text-decoration: none; transition: background 0.14s;}
        .btn-back:hover { background: #2e7d32; color: #fff; }
        .filter-form { display: flex; gap: 10px; margin-bottom: 20px; flex-wrap: wrap;}
        .filter-form select { padding: 7px 12px; border-radius: 6px; border: 1px solid #cdd8e3; font-size: 1em; }
        .btn-filter { background: #2690ff; color: #fff; border: none; padding: 7px 18px; border-radius: 6px; cursor: pointer; font-weight: 500;}
        .btn-filter:hover { background: #1976d2;}
        .btn-reset { background: #ede7f6; color: #8e24aa; border: none; padding: 7px 18px; border-radius: 6px; cursor: pointer; font-weight: 500; margin-left: 2px; text-decoration: none;}
        .btn-reset:hover { background: #d1c4e9; color: #6d1b7b;}
        .table-device-report {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.04);
            margin-bottom: 20px;
        }
        .table-device-report th, .table-device-report td {
            padding: 10px 14px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .table-device-report th {
            background: #f5f5f5;
            font-weight: 600;
        }
        .table-device-report tr:last-child td { border-bottom: none; }
        .badge {
            display: inline-block;
            padding: 4px 14px;
            border-radius: 15px;
            font-size: 0.98em;
            font-weight: 500;
            color: #fff;
        }
        .badge-done { background: #43a047;}
        .badge-pending { background: #f9a825; color: #333;}
        .badge-rejected { background: #e53935;}
        .no-service {
            width: 100%;
            text-align: center;
            color: #888;
            font-style: italic;
            font-size: 1.13em;
            margin-top: 44px;
        }
        .pagination {
            margin-top: 18px;
            text-align: center;
        }
        .pagination a, .pagination span {
            margin: 0 3px;
            padding: 6px 14px;
            border: 1px solid #ccc;
            text-decoration: none;
            border-radius: 5px;
            color: #333;
            background: #fff;
            font-weight: 500;
            transition: background 0.14s, color 0.14s;
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
        /* Modal style lấy từ service-reports */
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
            from { opacity: 0; }
            to { opacity: 1; }
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
            0% { transform: scale(0.97) translateY(40px); opacity: 0; }
            80% { transform: scale(1.04) translateY(-8px);}
            100% { transform: scale(1) translateY(0); opacity: 1; }
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
        .custom-modal-close:hover { color: #1976d2; }
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
    </style>
</head>
<body>
<div class="layout">
    <%@ include file="./staffSidebar.jsp" %>
    <div class="content-panel">
        <div class="header">
            <h2>Báo cáo thiết bị của tôi</h2>
            <a href="staffListDeviceServlet" class="btn-back">&larr; Quay lại danh sách thiết bị</a>
        </div>
        <!-- Bộ lọc trạng thái -->
        <form class="filter-form" method="get" action="staffDeviceReport">
            <select name="status">
                <option value="">--Tất cả trạng thái--</option>
                <option value="pending" ${status == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                <option value="done" ${status == 'done' ? 'selected' : ''}>Hoàn thành</option>
                <option value="rejected" ${status == 'rejected' ? 'selected' : ''}>Từ chối</option>
            </select>
            <button type="submit" class="btn-filter">Lọc</button>
            <a href="staffDeviceReport" class="btn-reset">Reset</a>
        </form>
        <c:choose>
            <c:when test="${empty reportList}">
                <div class="no-service">Chưa có báo cáo thiết bị nào.</div>
            </c:when>
            <c:otherwise>
                <table class="table-device-report">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên thiết bị</th>
                            <th>Lý do</th>
                            <th>Đề xuất</th>
                            <th>Ngày gửi</th>
                            <th>Trạng thái</th>
                            <th>Chi tiết</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${reportList}">
                            <tr>
                                <td>${r.reportId}</td>
                                <td><b>${r.deviceName}</b></td>
                                <td>${r.reportReason}</td>
                                <td>${r.suggestion}</td>
                                <td>${r.reportDate}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.status eq 'done'}">
                                            <span class="badge badge-done">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${r.status eq 'pending'}">
                                            <span class="badge badge-pending">Chờ xử lý</span>
                                        </c:when>
                                        <c:when test="${r.status eq 'rejected'}">
                                            <span class="badge badge-rejected">Từ chối</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge">${r.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <button type="button"
                                            class="btn-filter"
                                            style="padding:6px 14px;font-size:0.98em;"
                                            onclick="showDeviceReportDetail(
                                                '${fn:escapeXml(r.deviceName)}',
                                                '${fn:escapeXml(r.reportReason)}',
                                                '${fn:escapeXml(r.suggestion)}',
                                                '${r.reportDate}',
                                                '${r.status}',
                                                ${r.deviceId},
                                                ${r.reportId}
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
            <c:if test="${endPage > 1}">
                <c:if test="${page > 1}">
                    <a href="staffDeviceReport?page=1&status=${status}&pageSize=${pageSize}">&laquo;</a>
                </c:if>
                <c:forEach var="i" begin="1" end="${endPage}">
                    <a href="staffDeviceReport?page=${i}&status=${status}&pageSize=${pageSize}" class="${i == page ? 'active' : ''}">${i}</a>
                </c:forEach>
                <c:if test="${page < endPage}">
                    <a href="staffDeviceReport?page=${endPage}&status=${status}&pageSize=${pageSize}">&raquo;</a>
                </c:if>
            </c:if>
        </div>
    </div>
</div>

<!-- Modal Chi tiết -->
<div id="deviceReportDetailModal" class="custom-modal">
    <div class="custom-modal-content">
        <button class="custom-modal-close" onclick="closeDeviceReportDetail()">&times;</button>
        <div class="custom-modal-header">
            <div class="custom-modal-icon">
                <svg viewBox="0 0 24 24" width="36" height="36" fill="#38b6ff"><circle cx="12" cy="12" r="10" fill="#e3f5fe"/><path d="M12 8v4M12 16h.01" stroke="#1c70e6" stroke-width="2" stroke-linecap="round"/></svg>
            </div>
            <span id="modalDeviceName" class="custom-modal-title"></span>
        </div>
        <div class="custom-modal-body">
            <div><b>Lý do:</b> <span id="modalReportReason"></span></div>
            <div><b>Đề xuất:</b> <span id="modalSuggestion"></span></div>
            <div><b>Ngày gửi:</b> <span id="modalReportDate"></span></div>
            <div><b>Trạng thái:</b> <span id="modalStatus"></span></div>
        </div>
    </div>
</div>
<script>
    function showDeviceReportDetail(deviceName, reportReason, suggestion, reportDate, status, deviceId, reportId) {
        document.getElementById('modalDeviceName').innerText = deviceName;
        document.getElementById('modalReportReason').innerText = reportReason;
        document.getElementById('modalSuggestion').innerText = suggestion;
        document.getElementById('modalReportDate').innerText = reportDate;
        let statusLabel = '';
        if (status === 'pending') statusLabel = 'Chờ xử lý';
        else if (status === 'done') statusLabel = 'Hoàn thành';
        else if (status === 'rejected') statusLabel = 'Từ chối';
        else statusLabel = status;
        document.getElementById('modalStatus').innerText = statusLabel;

        document.getElementById('deviceReportDetailModal').style.display = 'flex';
    }
    function closeDeviceReportDetail() {
        document.getElementById('deviceReportDetailModal').style.display = 'none';
    }
</script>
</body>
</html>