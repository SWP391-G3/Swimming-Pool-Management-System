<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Pool Detail</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/styleindex/poollist.css">
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            body {
                background: linear-gradient(120deg, #f0f4fd 0%, #eaf3fa 100%);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                min-height: 100vh;
            }
            .layout {
                display: flex;
                align-items: flex-start;
                justify-content: center;
                gap: 38px;
                max-width: 1440px;
                margin: 30px auto 0 auto;
                padding: 0 16px 40px 16px;
            }
            .main {
                flex: 2 1 650px;
                background: #fff;
                border-radius: 22px;
                box-shadow: 0 2px 14px #c5dbfa48;
                padding: 38px 30px 36px 30px;
                min-width: 0;
                max-width: 800px;
                position: relative;
            }
            .service-sidebar {
                flex: 1 1 340px;
                background: #f6fafd;
                border-radius: 15px;
                box-shadow: 0 2px 14px #c5dbfa30;
                padding: 28px 20px;
                min-width: 270px;
                margin-top: 10px;
                max-width: 400px;
            }
            @media (max-width: 1100px) {
                .layout {
                    flex-direction: column;
                    gap:0;
                }
                .main, .service-sidebar {
                    max-width: 99vw;
                }
                .service-sidebar {
                    width:100%;
                    margin-top:32px;
                }
            }
            @media (max-width: 650px) {
                .main {
                    padding: 12vw 2vw 5vw 2vw;
                }
            }
            .back-link {
                position: absolute;
                left: 18px;
                top: 22px;
                color: #1976d2;
                text-decoration: none;
                font-weight: bold;
                border: 1.3px solid #1976d2;
                border-radius: 6px;
                padding: 8px 20px;
                background: #e3f2fd;
                font-size: 1rem;
                transition: .18s;
                z-index: 2;
            }
            .back-link:hover {
                background: #1976d2;
                color: #fff;
            }
            h2 {
                color: #1769aa;
                text-align: left;
                font-size: 2rem;
                font-weight: 700;
                letter-spacing: 1px;
                margin-top: 0;
                margin-bottom: 26px;
                display: flex;
                align-items: center;
                gap: 18px;
                flex-wrap: wrap;
            }
            /* Carousel */
            .carousel-wrap {
                width: 100%;
                max-width: 460px;
                margin: 0 auto 26px auto;
                position:relative;
            }
            .carousel-img {
                width: 100%;
                height: 245px;
                border-radius: 16px;
                object-fit: cover;
                box-shadow: 0 2px 18px #b3cfff24;
                border: 2px solid #e3f2fd;
                display: block;
                transition: .25s;
            }
            .carousel-arrow {
                position:absolute;
                top:50%;
                transform:translateY(-50%);
                background:rgba(22,108,230,0.75);
                color:white;
                border:none;
                border-radius:50%;
                width:38px;
                height:38px;
                cursor:pointer;
                font-size:1.4rem;
                font-weight:bold;
                display:flex;
                align-items:center;
                justify-content:center;
                z-index:4;
                transition:.18s;
            }
            .carousel-arrow.left {
                left:10px;
            }
            .carousel-arrow.right {
                right:10px;
            }
            .carousel-arrow:hover {
                background:#1252a6;
            }
            .carousel-dots {
                text-align:center;
                margin-top:10px;
            }
            .carousel-dot {
                display:inline-block;
                width:10px;
                height:10px;
                border-radius:50%;
                margin:0 3px;
                background:#b5cdf6;
                cursor:pointer;
            }
            .carousel-dot.active {
                background:#1769aa;
            }
            /* Nút Đặt bể bơi */
            .btn-booking {
                display:inline-block;
                margin-left:18px;
                padding:12px 38px;
                background:#1976d2;
                color:#fff;
                border:none;
                border-radius: 9px;
                font-weight:600;
                font-size:1.11rem;
                box-shadow:0 3px 13px #1769aa21;
                letter-spacing:0.3px;
                transition:.18s;
                text-decoration:none;
                margin-bottom: 24px;
                margin-left: 280px;
            }
            .btn-booking:hover {
                background:#1252a6;
                color:#fff;
            }
            .info-row {
                margin-bottom: 17px;
                font-size: 1.12rem;
                display: flex;
                align-items: flex-start;
                gap: 4px;
            }
            .info-label {
                font-weight: 600;
                color: #1976d2;
                min-width: 132px;
                display: inline-block;
                letter-spacing: 0.2px;
            }
            .info-value {
                color: #21293b;
                font-weight: 500;
                flex: 1;
                word-break: break-word;
            }
            /* Feedback styles */
            .feedback-section {
                background:#f9fbff;
                border-radius:14px;
                margin:36px 0 0 0;
                padding:18px 18px 10px 18px;
                box-shadow:0 2px 12px #c5dbfa18;
            }
            .feedback-title {
                color:#0d6efd;
                font-weight:600;
                margin-bottom:10px;
                font-size:1.13rem;
            }
            .feedback-list {
                list-style:none;
                padding:0;
                margin:0;
            }
            .feedback-item {
                border-bottom:1px solid #eaf2fa;
                padding:11px 0 6px 0;
            }
            .feedback-rating {
                color:#f8bb24;
                margin-right:8px;
            }
            .feedback-empty {
                color:#888;
                font-size:1.04rem;
                margin-bottom:7px;
            }
            /* Service card */
            .service-title {
                color: #0d6efd;
                font-weight:600;
                text-align:center;
                margin-bottom:15px;
                font-size:1.19rem;
            }
            .service-card {
                margin-bottom: 22px;
                display:flex;
                gap:14px;
            }
            .service-card img {
                width:56px;
                height:56px;
                object-fit:cover;
                border-radius:7px;
            }
            .service-info {
                flex:1;
            }
            .service-name {
                font-weight:600;
                color:#1976d2;
                font-size:1.08rem;
            }
            .service-price {
                color:#ee6c21;
                font-weight:600;
                font-size:1.07rem;
            }
            .service-status {
                margin-left:12px;
                color:#13b25c;
                font-size:0.99rem;
                font-weight:600;
            }
            @media (max-width:900px) {
                .carousel-img {
                    height:135px;
                }
            }
            @media (max-width:600px) {
                .main {
                    padding: 5vw 1vw 5vw 1vw;
                }
                .info-label {
                    min-width:80px;
                }
                .carousel-img {
                    height: 75vw;
                    min-height:100px;
                }
                .carousel-wrap {
                    max-width:98vw;
                }
                .btn-booking {
                    margin-left:800px;
                    margin-top:12px;
                    width:100%;
                    font-size:1rem;
                }
            }

        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="layout">
            <div class="main">
                <div class="btn-wrapper">
                    <a href="customerViewPoolList" class="back-link">&#8592; Trang chủ</a>

                 
                </div>
                <c:if test="${not empty pool}">
                    <!-- CAROUSEL -->
                    <c:choose>
                        <c:when test="${not empty imageList && fn:length(imageList) > 0}">
                            <div class="carousel-wrap">
                                <button class="carousel-arrow left" onclick="prevImg()" type="button">&#8592;</button>
                                <img id="carouselImg"
                                     class="carousel-img"
                                     src="${imageList[0]}"
                                     alt="Ảnh hồ bơi"/>
                                <button class="carousel-arrow right" onclick="nextImg()" type="button">&#8594;</button>
                                <div class="carousel-dots" id="carouselDots"></div>
                            </div>
                            <script>
                                var imgs = [
                                <c:forEach var="img" items="${imageList}" varStatus="status">
                                "${img}"<c:if test="${!status.last}">,</c:if>
                                </c:forEach>
                                ];
                                var idx = 0;
                                var imgEl = document.getElementById('carouselImg');
                                var dotsEl = document.getElementById('carouselDots');
                                function showImg(n) {
                                    idx = (n + imgs.length) % imgs.length;
                                    imgEl.src = imgs[idx];
                                    updateDots();
                                }
                                function prevImg() {
                                    showImg(idx - 1);
                                }
                                function nextImg() {
                                    showImg(idx + 1);
                                }
                                function updateDots() {
                                    var s = "";
                                    for (let i = 0; i < imgs.length; i++)
                                        s += '<span class="carousel-dot' + (i == idx ? ' active' : '') + '" onclick="showImg(' + i + ')"></span>';
                                    dotsEl.innerHTML = s;
                                }
                                document.addEventListener('DOMContentLoaded', function () {
                                    updateDots();
                                });
                            </script>
                        </c:when>
                        <c:otherwise>
                            <img class="carousel-img" src="${pool.pool_image}" alt="${pool.pool_name}"/>
                        </c:otherwise>
                    </c:choose>

                    <!-- Chi tiết -->
                    <div class="info-row" style="margin-top: 12px"><span class="info-label">Tên hồ bơi:</span> <span class="info-value">${pool.pool_name}</span></div>
                    <div class="info-row"><span class="info-label">Đường</span> <span class="info-value">${pool.pool_road}</span></div>
                    <div class="info-row"><span class="info-label">Địa chỉ:</span> <span class="info-value">${pool.pool_address}</span></div>
                    <div class="info-row"><span class="info-label">Sức chứa bể:</span> <span class="info-value">${pool.max_slot}</span></div>
                    <div class="info-row">
                        <span class="info-label">Mở cửa:</span>
                        <span class="info-value">${pool.open_time}</span>
                        <span class="info-label" style="margin-left:24px;">Đóng cửa:</span>
                        <span class="info-value">${pool.close_time}</span>
                    </div>
                    <div class="info-row"><span class="info-label">Description:</span> <span class="info-value">${pool.pool_description}</span></div>
                       <c:if test="${not empty pool}">
                        <a class="btn-booking"

                           href="booking?service=showBookingPage&poolId=${pool.pool_id}">
                            Đặt bể bơi
                        </a>
                    </c:if>
                    <!-- Feedback dưới chi tiết -->
                    <div class="feedback-section">
                        <div class="feedback-title">Đánh giá của khách hàng</div>
                        <c:if test="${not empty feedbacks}">
                            <ul class="feedback-list">
                                <c:forEach var="fb" items="${feedbacks}">
                                    <li class="feedback-item">
                                        <span class="feedback-rating">
                                            <c:forEach var="i" begin="1" end="${fb.rating}">&#9733;</c:forEach>
                                            <c:forEach var="i" begin="1" end="${5 - fb.rating}">&#9734;</c:forEach>
                                            </span>
                                            <span>${fb.comment}</span>
                                        <div style="color:#aaa;font-size:12px;">
                                            <fmt:formatDate value="${fb.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:if>
                        <c:if test="${empty feedbacks}">
                            <div class="feedback-empty">Chưa có đánh giá nào cho hồ bơi này.</div>
                        </c:if>
                    </div>
                </c:if>
                <c:if test="${empty pool}">
                    <div class="notfound">Không tìm thấy </div>
                </c:if>
            </div>
            <!-- Service bên phải -->
            <div class="service-sidebar">
                <div class="service-title">Dịch vụ tại hồ bơi</div>
                <c:if test="${not empty services}">
                    <c:forEach var="service" items="${services}">
                        <div class="service-card">
                            <img src="${service.serviceImage}" alt="">
                            <div class="service-info">
                                <div class="service-name">${service.serviceName}</div>
                                <div style="color:#666;font-size:0.96rem;">${service.description}</div>
                                <span class="service-price">
                                    <fmt:formatNumber value="${service.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </span>
                                <span class="service-status">
                                    <c:choose>
                                        <c:when test="${service.serviceStatus == 'available'}">Còn hàng</c:when>
                                        <c:when test="${service.serviceStatus == 'maintenance'}">Bảo trì</c:when>
                                        <c:when test="${service.serviceStatus == 'broken'}">Hỏng</c:when>
                                        <c:otherwise>Không rõ</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty services}">
                    <div style="color:#888;text-align:center;">Không có dịch vụ nào.</div>
                </c:if>
            </div>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
