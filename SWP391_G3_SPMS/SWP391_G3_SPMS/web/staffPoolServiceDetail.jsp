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
    <title>Chi tiết dịch vụ hồ bơi</title>
    <link rel="stylesheet" href="./manager-css/manager-device-v3.css">
    <link rel="stylesheet" href="./manager-css/manager-panel.css">
    <style>
        .service-detail-wrapper {
            width: 75vw;
            margin: 34px auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 18px 0 rgba(34,34,34,0.07);
            padding: 32px 26px 24px 26px;
        }
        .service-detail-image {
            display: flex;
            justify-content: center;
            margin-bottom: 22px;
        }
        .service-detail-image img {
            width: 110px;
            height: 110px;
            object-fit: cover;
            border-radius: 14px;
            box-shadow: 0 2px 8px 0 rgba(34,34,34,0.08);
            background: #fafbfd;
            border: 1px solid #e6e8f0;
        }
        .service-detail-table td {
            padding: 7px 6px;
            font-size: 1.08em;
        }
        .status {
            padding: 2px 11px;
            border-radius: 12px;
            font-size: 0.98em;
            font-weight: 500;
        }
        .status.available { background: #e6ffed; color: #219150; }
        .status.maintenance { background: #fff5d1; color: #eab308; }
        .status.inactive { background: #ffe4e6; color: #ef4444; }
        .report-form {
            margin-top: 28px;
        }
        .report-form textarea {
            width: 100%;
            border-radius: 8px;
            border: 1px solid #d1d5db;
            padding: 10px;
            font-size: 1.08em;
            margin-bottom: 10px;
        }
        .btn-report {
            background: #1976d2;
            color: #fff;
            border: none;
            border-radius: 7px;
            padding: 8px 30px;
            font-weight: 600;
            cursor: pointer;
            font-size: 1.07em;
        }
        .btn-report:hover {
            background: #155aad;
        }
        .report-message {
            color: #16a34a;
            margin-top: 10px;
            margin-bottom: 14px;
            font-weight: 500;
            text-align: center;
        }
        .btn-back {
            display: inline-block;
            margin-top: 22px;
            color: #1976d2;
            text-decoration: none;
            font-weight: 600;
            border-radius: 7px;
            padding: 7px 18px;
            background: #f3f6fa;
            border: 1px solid #e1e9f5;
            transition: background 0.2s;
        }
        .btn-back:hover {
            background: #e0e7ff;
            color: #174da3;
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
    <div class="service-detail-wrapper">
        <div class="service-detail-image">
            <img src="${poolService.serviceImage}" alt="${poolService.serviceName}" />
        </div>
        <table class="service-detail-table">
            <tr>
                <td><b>Tên dịch vụ:</b></td>
                <td>${poolService.serviceName}</td>
            </tr>
            <tr>
                <td><b>Hồ bơi:</b></td>
                <td>${poolName}</td>
            </tr>
            <tr>
                <td><b>Giá:</b></td>
                <td>${poolService.price} VND</td>
            </tr>
            <tr>
                <td><b>Số lượng:</b></td>
                <td>${poolService.quantity}</td>
            </tr>
            <tr>
                <td><b>Mô tả:</b></td>
                <td>${poolService.description}</td>
            </tr>
            <tr>
                <td><b>Trạng thái:</b></td>
                <td>
                    <span class="status ${poolService.serviceStatus}">
                        <c:choose>
                            <c:when test="${poolService.serviceStatus eq 'available'}">Hoạt động</c:when>
                            <c:when test="${poolService.serviceStatus eq 'maintenance'}">Bảo trì</c:when>
                            <c:otherwise>Ngưng</c:otherwise>
                        </c:choose>
                    </span>
                </td>
            </tr>
        </table>
        <form class="report-form" method="post" action="staffPoolServiceDetail">
            <input type="hidden" name="serviceId" value="${poolService.poolServiceId}">
            <input type="hidden" name="serviceName" value="${poolService.serviceName}">
            <input type="hidden" name="poolId" value="${poolService.poolId}">
            <input type="hidden" name="poolName" value="${poolName}">
            <label for="reportReason"><b>Lý do báo cáo:</b></label>
            <textarea name="reportReason" id="reportReason" rows="4" required placeholder="Nhập nội dung báo cáo dịch vụ..."></textarea>
            <label for="suggestion"><b>Gợi ý hướng xử lý (tuỳ chọn):</b></label>
            <textarea name="suggestion" id="suggestion" rows="2" placeholder="Ví dụ: đề xuất bảo trì, nâng cấp..."></textarea>
            <button type="submit" class="btn-report">Gửi báo cáo</button>
        </form>
        <c:if test="${not empty reportMessage}">
            <div class="report-message">${reportMessage}</div>
        </c:if>
        <a href="staffPoolService" class="btn-back">&larr; Quay lại danh sách</a>
    </div>
</div>
</body>
</html>
