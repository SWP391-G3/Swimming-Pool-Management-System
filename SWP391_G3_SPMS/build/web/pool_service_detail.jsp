<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    request.setAttribute("activeMenu", "pool-service");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết dịch vụ hồ bơi</title>
    <link rel="stylesheet" href="./manager-css/manager-device-v3.css">
    <link rel="stylesheet" href="./manager-css/manager-panel.css">
    <style>
        .detail-panel {
            max-width: 600px;
            margin: 40px auto;
            background: #fff;
            border-radius: 12px;
            padding: 30px 36px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.07);
        }
        .detail-row { margin-bottom: 18px; display: flex;}
        .detail-label { width: 170px; color: #222; font-weight: 600;}
        .detail-value { flex: 1; }
        .btn-back {
            margin-right: 12px;
            background: #ede7f6;
            color: #8e24aa;
            border: none;
            padding: 7px 22px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
        }
        .btn-back:hover { background: #d1c4e9; color: #6d1b7b;}
        .btn-edit {
            background: #42a5f5;
            color: #fff;
            border: none;
            padding: 7px 22px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            margin-left: 12px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-edit:hover { background: #1976d2; }
        .detail-title {
            margin-bottom: 28px;
            text-align: center;
            font-size: 26px;
            font-weight: 700;
            letter-spacing: .5px;
        }
    </style>
</head>
<body>
    <div class="layout">
        <%@ include file="../managerSidebar.jsp" %>
        <div class="content-panel">
            <div class="detail-panel">
                <div class="detail-title">Chi tiết dịch vụ hồ bơi</div>
                <div class="detail-row">
                    <div class="detail-label">ID:</div>
                    <div class="detail-value">${poolService.poolServiceId}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Tên dịch vụ:</div>
                    <div class="detail-value">${poolService.serviceName}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Mô tả:</div>
                    <div class="detail-value">${poolService.description}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Giá:</div>
                    <div class="detail-value"><b>${poolService.price}</b> VND</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Ảnh:</div>
                    <div class="detail-value">
                        <img src="${poolService.serviceImage}" alt="" style="height:70px;border-radius:4px;object-fit:cover;">
                    </div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Số lượng:</div>
                    <div class="detail-value">${poolService.quantity}</div>
                </div>
                <div class="detail-row">
                    <div class="detail-label">Trạng thái:</div>
                    <div class="detail-value">
                        <c:choose>
                            <c:when test="${poolService.serviceStatus eq 'available'}">
                                <span class="status-badge status-active">Hoạt động</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge status-inactive">Ngưng</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div style="margin-top: 28px; display: flex; justify-content: flex-end;">
                    <a href="pool-service" class="btn-back">Quay lại</a>
                    <a href="pool-service?action=edit&id=${poolService.poolServiceId}" class="btn-edit">Chỉnh sửa</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
