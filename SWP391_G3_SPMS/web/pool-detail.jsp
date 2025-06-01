<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Pool Detail</title>
        <style>
            body {
                background: linear-gradient(120deg, #f0f4fd 0%, #eaf3fa 100%);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                min-height: 100vh;
            }
            .container {
                max-width: 470px;
                margin: 40px auto;
                background: #fff;
                border-radius: 22px;
                box-shadow: 0 8px 40px rgba(25, 118, 210, 0.09), 0 1.5px 12px rgba(0,0,0,0.04);
                padding: 38px 30px 36px 30px;
                position: relative;
                overflow: hidden;
            }
            h2 {
                color: #1769aa;
                text-align: center;
                font-size: 2.2rem;
                font-weight: 700;
                letter-spacing: 1px;
                margin-top: 0;
                margin-bottom: 28px;
            }
            .pool-image {
                width: 100%;
                max-width: 355px;
                height: auto;
                display: block;
                margin: 0 auto 28px auto;
                border-radius: 16px;
                box-shadow: 0 3px 15px rgba(25, 118, 210, 0.12), 0 1px 3px rgba(0,0,0,0.06);
                border: 2px solid #e3f2fd;
                transition: transform 0.2s;
            }
            .pool-image:hover {
                transform: scale(1.027);
            }
            .info-row {
                margin-bottom: 18px;
                font-size: 1.11rem;
                display: flex;
                align-items: flex-start;
                gap: 4px;
            }
            .info-label {
                font-weight: 600;
                color: #1976d2;
                min-width: 118px;
                display: inline-block;
                letter-spacing: 0.2px;
            }
            .info-value {
                color: #21293b;
                font-weight: 500;
                flex: 1;
                word-break: break-word;
            }
            .status-badge {
                display: inline-block;
                padding: 7px 22px;
                border-radius: 16px;
                background: linear-gradient(90deg,#2196f3 60%,#42a5f5 100%);
                color: #fff;
                font-size: 1.03rem;
                font-weight: 700;
                margin-left: 8px;
                letter-spacing: 0.4px;
                box-shadow: 0 2px 10px rgba(33,150,243,0.08);
                border: none;
                transition: background 0.25s;
            }
            .status-badge.closed {
                background: linear-gradient(90deg,#e57373 60%,#f44336 100%);
            }
            .back-link {
                display: block;
                text-align: center;
                margin: 35px auto 0 auto;
                color: #1976d2;
                background: #f1f9ff;
                text-decoration: none;
                font-weight: 700;
                font-size: 1.07rem;
                border: 1.6px solid #2196f3;
                padding: 12px 32px;
                border-radius: 11px;
                transition: background 0.25s, color 0.2s, border 0.23s;
                width: fit-content;
                box-shadow: 0 2px 8px rgba(25, 118, 210, 0.05);
            }
            .back-link:hover, .back-link:focus {
                background: linear-gradient(90deg,#2196f3 60%,#42a5f5 100%);
                color: #fff;
                border-color: #42a5f5;
            }
            .notfound {
                color: #e57373;
                text-align: center;
                margin-top: 50px;
                font-size: 1.19rem;
                letter-spacing: 0.7px;
            }

            /* Responsive cho mobile */
            @media (max-width: 600px) {
                .container {
                    max-width: 98vw;
                    padding: 15px 3vw 20px 3vw;
                }
                .pool-image {
                    max-width: 99vw;
                    border-radius: 10px;
                }
                h2 {
                    font-size: 1.4rem;
                }
                .info-label {
                    min-width: 96px;
                }
            }
            @media (max-width: 600px) {
                .info-row .info-label:nth-child(3) {
                    margin-left: 8px !important;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Pool Detail</h2>
            <c:if test="${not empty pool}">
                <img class="pool-image" src="${pool.pool_image}" alt="${pool.pool_name}"/>
                <div class="info-row"><span class="info-label">Tên hồ bơi:</span> <span class="info-value">${pool.pool_name}</span></div>
                <div class="info-row"><span class="info-label">Đường</span> <span class="info-value">${pool.pool_road}</span></div>
                <div class="info-row"><span class="info-label">Địa chỉ:</span> <span class="info-value">${pool.pool_address}</span></div>
                <div class="info-row"><span class="info-label">Sức chứa bể::</span> <span class="info-value">${pool.max_slot}</span></div>
                <div class="info-row">
                    <span class="info-label">Mở cửa:</span>
                    <span class="info-value">${pool.open_time}</span>
                    <span class="info-label" style="margin-left:32px;">Đóng cửa:</span>
                    <span class="info-value">${pool.close_time}</span>
                </div>
                <div class="info-row"><span class="info-label">Description:</span> <span class="info-value">${pool.pool_description}</span></div>
                <div class="info-row">
                    <span class="info-label">Trạng thái:</span>
                    <c:choose>
                        <c:when test="${pool.pool_status}">
                            <span class="status-badge">Đang hoạt động</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge closed">Hủy hoạt động</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <a href="homepage.jsp" class="back-link">Quay lại trang chủ</a>
            </c:if>
            <c:if test="${empty pool}">
                <div class="notfound">Không tìm thấy </div>
            </c:if>
        </div>
    </body>
</html>
