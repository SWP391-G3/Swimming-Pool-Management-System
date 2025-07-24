<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    request.setAttribute("activeMenu", "device");
    model.staff.StaffJoinedTable staff = (model.staff.StaffJoinedTable) session.getAttribute("staff");
    model.customer.User user = (model.customer.User) session.getAttribute("currentUser");
    
    // Lấy dữ liệu từ attribute do servlet truyền về
    String search = (String) request.getAttribute("search");
    String fromDate = (String) request.getAttribute("fromDate");
    String toDate = (String) request.getAttribute("toDate");
    String type = (String) request.getAttribute("type");
    String status = (String) request.getAttribute("status");
    String message = (String) request.getAttribute("message");
    java.util.List<model.staff.StaffCheckinInfo> list = (java.util.List<model.staff.StaffCheckinInfo>) request.getAttribute("list");
    
    // Thông tin phân trang
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer totalRecords = (Integer) request.getAttribute("totalRecords");
    
    // Giá trị mặc định nếu chưa có
    if (search == null) search = "";
    if (type == null) type = "checkin";
    if (status == null) status = "";
    if (currentPage == null) currentPage = 1;
    if (totalPages == null) totalPages = 1;
    if (totalRecords == null) totalRecords = 0;
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Check-in hồ bơi</title>
        <link rel="stylesheet" href="./manager-css/manager-device-v2.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
        <link rel="stylesheet" href="./css/staff/styles.css"/>
        <style>
            .container-checkin-main {
                display: flex;
                height: 100vh;
                background: #f4f6fa;
            }
            .checkin-left {
                flex: 1.5;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: flex-start;
                border-right: 1px solid #e4e4e4;
                background: #fff;
                min-width: 540px;
                padding-top: 32px;
            }
            .checkin-camera-box {
                width: 96%;
                max-width: 650px;
                height: 500px;
                max-height: 85vh;
                margin-bottom: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #f5f7fb;
                border: 2.5px solid #d0d2d6;
                border-radius: 22px;
                overflow: hidden;
                box-shadow: 0 2px 16px 0 rgba(0,0,0,0.08);
            }
            #reader > video {
                width: 100% !important;
                height: 100% !important;
                object-fit: cover;
                border-radius: 14px;
            }
            .checkin-result {
                margin-top: 36px;
                font-size: 23px;
                font-weight: 600;
                text-align: center;
                min-height: 40px;
            }
            .checkin-right {
                flex: 3;
                padding: 28px 36px;
                background: #f7fafd;
                overflow: auto;
            }
            .search-bar {
                margin-bottom: 22px;
                display: flex;
                gap: 14px;
                flex-wrap: wrap;
            }
            .booking-table {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                margin-bottom: 20px;
            }
            .booking-table th, .booking-table td {
                border: 1px solid #e4e4e4;
                padding: 9px 13px;
                text-align: center;
            }
            .booking-table th {
                background: #f3f3f3;
            }
            .btn-checkin {
                padding: 5px 18px;
                border-radius: 6px;
                border: 1px solid #bbb;
                background: #f5f7fb;
                cursor: pointer;
                transition: background 0.2s;
            }
            .btn-checkin:disabled {
                background: #e8e8e8;
                color: #aaa;
                cursor: not-allowed;
            }
            .refresh-btn {
                padding: 7px 18px;
                border-radius: 7px;
                border: 1px solid #1e88e5;
                color: #fff;
                background: #1976d2;
                font-weight: 500;
                margin-left: 14px;
                cursor: pointer;
                transition: background 0.2s;
            }
            .refresh-btn:hover {
                background: #115293;
            }

            /* Pagination styles */
            .pagination-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 20px;
                padding: 15px 0;
                border-top: 1px solid #e4e4e4;
            }

            .pagination-info {
                color: #666;
                font-size: 14px;
            }

            .pagination {
                display: flex;
                gap: 5px;
                align-items: center;
            }

            .pagination a, .pagination span {
                padding: 8px 12px;
                text-decoration: none;
                border: 1px solid #ddd;
                color: #333;
                border-radius: 4px;
                transition: background 0.2s;
            }

            .pagination a:hover {
                background: #f5f5f5;
            }

            .pagination .current {
                background: #1976d2;
                color: white;
                border-color: #1976d2;
            }

            .pagination .disabled {
                color: #ccc;
                cursor: not-allowed;
            }

            .pagination .disabled:hover {
                background: transparent;
            }
        </style>
    </head>
    <body>
        <div class="layout">
            <%@ include file="./staffSidebar.jsp" %>

            <div class="container-checkin-main">
                <!--LEFT: Camera & kết quả -->
                <div class="checkin-left">
                    <div class="checkin-camera-box" id="reader"></div>
                    <form id="qrCheckinForm" method="post" action="checkin" style="margin-top:18px;">
                        <input type="text" id="qrBookingId" name="bookingId" placeholder="Nhập/Quét mã booking..." style="width: 250px; padding:7px 12px; border-radius:7px; border:1px solid #ccc;">
                        <button type="submit" class="btn-checkin" style="margin-left:8px;">Check-in</button>
                    </form>
                    <div id="result" class="checkin-result">
                        <c:if test="${not empty message}">
                            <c:choose>
                                <c:when test="${fn:contains(message, 'thành công')}">
                                    <span style="color:#388e3c;">${message}</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#d32f2f;">${message}</span>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </div>
                </div>

                <!-- RIGHT: Danh sách đặt vé -->
                <div class="checkin-right">
                    <form class="search-bar" method="get" action="checkin_list" id="searchForm">
                        <input type="text" name="search" value="${search}" placeholder="Tìm kiếm tên người dùng hoặc mã booking..." style="flex:2; padding:8px 13px; border-radius:7px; border:1px solid #ccc;">
                        <input type="date" name="fromDate" value="${fromDate}" placeholder="Từ ngày" style="padding:7px 12px; border-radius:7px; border:1px solid #ccc;">
                        <input type="date" name="toDate" value="${toDate}" placeholder="Đến ngày" style="padding:7px 12px; border-radius:7px; border:1px solid #ccc;">
                        <select name="type" style="padding:7px 16px; border-radius:7px; border:1px solid #ccc;">
                            <option value="checkin" <c:if test="${type eq 'checkin'}">selected</c:if>>Danh sách check-in</option>
                            <option value="booking" <c:if test="${type eq 'booking'}">selected</c:if>>Danh sách Booking</option>
                            </select>
                            <select name="status" style="padding:7px 16px; border-radius:7px; border:1px solid #ccc;">
                                <option value="" <c:if test="${empty status}">selected</c:if>>Tất cả</option>
                            <option value="checkedin" <c:if test="${status eq 'checkedin'}">selected</c:if>>Đã Checkin</option>
                            <option value="notcheckedin" <c:if test="${status eq 'notcheckedin'}">selected</c:if>>Chưa Checkin</option>
                            </select>
                            <button type="submit" class="btn-checkin">Tìm</button>
                            <button type="button" class="refresh-btn" onclick="window.location.href = 'checkin_list';">Refresh</button>
                        </form>

                        <table class="booking-table">
                            <thead>
                                <tr>
                                    <th>Mã</th>
                                    <th>Tên</th>
                                    <th>Ngày đặt</th>
                                    <th>Thời gian đặt</th>
                                    <th>Thời gian checkin</th>
                                    <th>Trạng thái</th>
                                    <th>Checkin</th>
                                </tr>
                            </thead>
                            <tbody id="bookingTableBody">
                            <c:forEach var="b" items="${list}">
                                <tr>
                                    <td>${b.bookingId}</td>
                                    <td>${b.userName}</td>
                                    <td>${b.bookingDate}</td>
                                    <td>${b.startTime} - ${b.endTime}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty b.checkinTime}">
                                                ${b.checkinTime}
                                            </c:when>
                                            <c:otherwise>
                                                Chưa checkin
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.checked}">
                                                Đã Checkin
                                            </c:when>
                                            <c:otherwise>
                                                Chưa Checkin
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.checked}">
                                                <button class="btn-checkin" style="background:#e8e8e8;color:#aaa;cursor:not-allowed;" disabled>Đã Checkin</button>
                                            </c:when>
                                            <c:otherwise>
                                                <form method="post" action="checkin" style="margin:0;">
                                                    <input type="hidden" name="bookingId" value="${b.bookingId}">
                                                    <button type="submit" class="btn-checkin">Checkin</button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty list}">
                                <tr><td colspan="7" style="color:#b00;">Không có dữ liệu phù hợp</td></tr>
                            </c:if>
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <div class="pagination-container">
                        <div class="pagination-info">
                            Hiển thị <strong>${fn:length(list)}</strong> trong tổng số <strong>${totalRecords}</strong> bản ghi
                        </div>

                        <div class="pagination">
                            <!-- Previous button -->
                            <c:choose>
                                <c:when test="${currentPage > 1}">
                                    <a href="javascript:void(0)" onclick="goToPage(${currentPage - 1})">‹ Trước</a>
                                </c:when>
                                <c:otherwise>
                                    <span class="disabled">‹ Trước</span>
                                </c:otherwise>
                            </c:choose>

                            <!-- Page numbers -->
                            <c:set var="startPage" value="${currentPage - 2 > 1 ? currentPage - 2 : 1}" />
                            <c:set var="endPage" value="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}" />

                            <c:if test="${startPage > 1}">
                                <a href="javascript:void(0)" onclick="goToPage(1)">1</a>
                                <c:if test="${startPage > 2}">
                                    <span>...</span>
                                </c:if>
                            </c:if>

                            <c:forEach var="page" begin="${startPage}" end="${endPage}">
                                <c:choose>
                                    <c:when test="${page == currentPage}">
                                        <span class="current">${page}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="javascript:void(0)" onclick="goToPage(${page})">${page}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${endPage < totalPages}">
                                <c:if test="${endPage < totalPages - 1}">
                                    <span>...</span>
                                </c:if>
                                <a href="javascript:void(0)" onclick="goToPage(${totalPages})">${totalPages}</a>
                            </c:if>

                            <!-- Next button -->
                            <c:choose>
                                <c:when test="${currentPage < totalPages}">
                                    <a href="javascript:void(0)" onclick="goToPage(${currentPage + 1})">Tiếp ›</a>
                                </c:when>
                                <c:otherwise>
                                    <span class="disabled">Tiếp ›</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://unpkg.com/html5-qrcode"></script>
        <script>
                                        // Pagination function
                                        function goToPage(page) {
                                            const form = document.getElementById('searchForm');
                                            const pageInput = document.createElement('input');
                                            pageInput.type = 'hidden';
                                            pageInput.name = 'page';
                                            pageInput.value = page;
                                            form.appendChild(pageInput);
                                            form.submit();
                                        }

                                        // QR Scanner
                                        window.addEventListener('DOMContentLoaded', function () {
                                            if (!window.qrScannerStarted) {
                                                window.qrScannerStarted = true;
                                                const html5QrCode = new Html5Qrcode("reader");
                                                const qrConfig = {
                                                    fps: 10,
                                                    qrbox: {width: 400, height: 400}
                                                };

                                                function onScanSuccess(decodedText, decodedResult) {
                                                    document.getElementById('qrBookingId').value = decodedText;
                                                    document.getElementById('qrCheckinForm').submit();
                                                }

                                                Html5Qrcode.getCameras().then(devices => {
                                                    if (devices && devices.length) {
                                                        let camId = devices.find(d => d.label.toLowerCase().includes('back'))?.id || devices[0].id;
                                                        html5QrCode.start(camId, qrConfig, onScanSuccess);
                                                    } else {
                                                        document.getElementById('result').innerText = "Không tìm thấy camera!";
                                                    }
                                                }).catch(err => {
                                                    document.getElementById('result').innerText = "Không truy cập được camera: " + err;
                                                });
                                            }
                                        });
        </script>
    </body>
</html>