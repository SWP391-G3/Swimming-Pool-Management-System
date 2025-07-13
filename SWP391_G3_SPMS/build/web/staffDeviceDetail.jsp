<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    model.staff.StaffJoinedTable staff = (model.staff.StaffJoinedTable) session.getAttribute("staff");
    model.customer.User user = (model.customer.User) session.getAttribute("currentUser");
%>
<!DOCTYPE html>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết thiết bị</title>
    <link rel="stylesheet" href="./manager-css/manager-device-v2.css">
            <link rel="stylesheet" href="./manager-css/manager-panel.css">

    <style>
        .device-detail-wrapper {
            width: 75vw;
            margin: 34px auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 18px 0 rgba(34,34,34,0.07);
            padding: 32px 26px 24px 26px;
        }
        .device-detail-image {
            display: flex;
            justify-content: center;
            margin-bottom: 22px;
        }
        .device-detail-image img {
            width: 128px;
            height: 128px;
            object-fit: cover;
            border-radius: 14px;
            box-shadow: 0 2px 8px 0 rgba(34,34,34,0.08);
            background: #fafbfd;
        }
        .device-detail-table td {
            padding: 7px 6px;
            font-size: 1.05em;
        }
        .status {
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.97em;
            font-weight: 500;
        }
        .status.available { background: #e0fafc; color: #0ea5e9; }
        .status.maintenance { background: #fff5d1; color: #eab308; }
        .status.broken { background: #ffe4e6; color: #ef4444; }
        .report-form {
            margin-top: 28px;
        }
        .report-form textarea {
            width: 100%;
            border-radius: 8px;
            border: 1px solid #d1d5db;
            padding: 10px;
            font-size: 1.05em;
            margin-bottom: 10px;
        }
        .btn-report {
            background: #f59e42;
            color: #fff;
            border: none;
            border-radius: 7px;
            padding: 8px 24px;
            font-weight: 600;
            cursor: pointer;
        }
        .btn-report:hover {
            background: #ef8500;
        }
        .report-message {
            color: #16a34a;
            margin-top: 6px;
            margin-bottom: 12px;
            font-weight: 500;
            text-align: center;
        }
        .btn-back {
            display: inline-block;
            margin-top: 24px;
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
            border-radius: 7px;
            padding: 7px 18px;
            background: #f3f6fa;
            border: 1px solid #ddd;
            transition: background 0.2s;
        }
        .btn-back:hover {
            background: #e0e7ff;
        }
        .staff-info-box {
                background: #f4f7fa;
                padding: 14px 22px;
                border-radius: 10px;
                margin-bottom: 22px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 15px;
            }
            .staff-info-list {
                display: flex;
                flex-wrap: wrap;
                gap: 25px;
                align-items: center;
            }
            .staff-info-item b {
                color: #1976d2;
            }
             .logout-btn {
                background: #e53e3e;
                color: white;
                border: none;
                padding: 8px 20px;
                border-radius: 7px;
                font-weight: 600;
                font-size: 1em;
                cursor: pointer;
                transition: background 0.18s;
                text-decoration: none
            }
            .logout-btn:hover {
                background: #b91c1c;
            }   
    </style>
</head>
<body>
    <div class="layout">
      <%@ include file="./staffSidebar.jsp" %>
    <div class="device-detail-wrapper">
        <div class="device-detail-image">
            <img src="${device.deviceImage}" alt="${device.deviceName}" />
        </div>
        <table class="device-detail-table">
            <tr>
                <td><b>Tên thiết bị:</b></td>
                <td>${device.deviceName}</td>
            </tr>
            <tr>
                <td><b>Hồ bơi:</b></td>
                <td>${device.poolName}</td>
            </tr>
            <tr>
                <td><b>Số lượng:</b></td>
                <td>${device.quantity}</td>
            </tr>
            <tr>
                <td><b>Trạng thái:</b></td>
                <td>
                    <span class="status ${device.deviceStatus}">
                        <c:choose>
                            <c:when test="${device.deviceStatus == 'available'}">Tốt</c:when>
                            <c:when test="${device.deviceStatus == 'maintenance'}">Bảo trì</c:when>
                            <c:when test="${device.deviceStatus == 'broken'}">Hỏng</c:when>
                        </c:choose>
                    </span>
                </td>
            </tr>
            <tr>
                <td><b>Ghi chú:</b></td>
                <td>${device.notes}</td>
            </tr>
        </table>
        <form class="report-form" method="post" action="staffDeviceDetailServlet">
            <input type="hidden" name="deviceId" value="${device.deviceId}">
            <input type="hidden" name="deviceName" value="${device.deviceName}">
            <input type="hidden" name="poolId" value="${device.poolId}">
            <label for="reportReason"><b>Lý do báo cáo:</b></label>
            <textarea name="reportReason" id="reportReason" rows="4" required placeholder="Nhập nội dung báo cáo..."></textarea>
            <label for="suggestion"><b>Gợi ý hướng xử lý (tuỳ chọn):</b></label>
            <textarea name="suggestion" id="suggestion" rows="2" placeholder="Ví dụ: đề xuất bảo trì, thay thế..."></textarea>
            <button type="submit" class="btn-report">Gửi báo cáo</button>
        </form>
        <c:if test="${not empty reportMessage}">
            <div class="report-message">${reportMessage}</div>
        </c:if>
        <a href="staffListDeviceServlet" class="btn-back">&larr; Quay lại danh sách</a>
    </div>
    </div>
</body>
</html>
