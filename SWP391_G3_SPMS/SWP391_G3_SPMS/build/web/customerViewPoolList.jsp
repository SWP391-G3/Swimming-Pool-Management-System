<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List,model.customer.Pool,model.customer.FeedbackHomepage,model.customer.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>PoolHub - Trang chủ</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/styleindex/poollist.css">
        <script src="https://cdn.tailwindcss.com"></script>

    </head>
    <body>

        <%@include file="header.jsp" %>

        <div style="display: flex; align-items: flex-start; padding: 10px 24px; gap: 16px">
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="location-box">
                    <button class="btn-location">Địa chỉ</button>
                    <ul class="location-list">

                        <!-- Thêm mục "Tất cả cơ sở" -->
                        <li>
                            <a href="#" class="${param.searchLocation == '' ? 'active' : ''}" onclick="setLocation('All')">Tất cả cơ sở</a>
                        </li>
                        <li>
                            <a href="#" class="${param.searchLocation == 'Hà Nội' ? 'active' : ''}" onclick="setLocation('Hà Nội')">Hà Nội</a>
                        </li>
                        <li>
                            <a href="#" class="${param.searchLocation == 'Hồ Chí Minh' ? 'active' : ''}" onclick="setLocation('Hồ Chí Minh')">Hồ Chí Minh</a>
                        </li>
                        <li>
                            <a href="#" class="${param.searchLocation == 'Đà Nẵng' ? 'active' : ''}" onclick="setLocation('Đà Nẵng')">Đà Nẵng</a>
                        </li>
                        <li>
                            <a href="#" class="${param.searchLocation == 'Quy Nhơn' ? 'active' : ''}" onclick="setLocation('Quy Nhơn')">Quy Nhơn</a>
                        </li>
                        <li>
                            <a href="#" class="${param.searchLocation == 'Cần Thơ' ? 'active' : ''}" onclick="setLocation('Cần Thơ')">Cần Thơ</a>
                        </li>


                    </ul>



                </div>
            </div>
            <!-- Main content -->
            <div class="main-content" style="flex:1;">
                <form class="filter-form" method="get" action="customerViewPoolList">
                    <c:if test="${param.searchLocation != null}">
                        <input type="hidden" name="searchLocation" value="${param.searchLocation}" />
                    </c:if>
                    <input
                        type="text"
                        name="searchName"
                        placeholder="Tên bể bơi"
                        value="${param.searchName != null ? param.searchName : ''}"
                        style=" padding: 4px; border-radius: 6px; border: 1px solid #ccc; width: 160px;"
                        />


                    <select name="capacity">
                        <option value="">Sức chứa</option>
                        <option value="small" ${param.capacity == 'small' ? 'selected' : ''}>Dưới 20</option>
                        <option value="medium" ${param.capacity == 'medium' ? 'selected' : ''}>20-50</option>
                        <option value="large" ${param.capacity == 'large' ? 'selected' : ''}>Trên 50</option>
                    </select>


                    <select name="openTime">
                        <option value="">Giờ mở</option>
                        <option value="05:00" ${param.openTime == '05:00' ? 'selected' : ''}>05:00</option>
                        <option value="06:00" ${param.openTime == '06:00' ? 'selected' : ''}>06:00</option>
                        <option value="07:00" ${param.openTime == '07:00' ? 'selected' : ''}>07:00</option>
                        <option value="08:00" ${param.openTime == '08:00' ? 'selected' : ''}>08:00</option>
                    </select>


                    <select name="closeTime">
                        <option value="">Giờ đóng</option>
                        <option value="19:00" ${param.closeTime == '19:00' ? 'selected' : ''}>19:00</option>
                        <option value="20:00" ${param.closeTime == '20:00' ? 'selected' : ''}>20:00</option>
                        <option value="21:00" ${param.closeTime == '21:00' ? 'selected' : ''}>21:00</option>
                    </select>

                    <button type="button" onclick="resetFilters()" 
                            style="width: 100px;  color: #1976d2; border: 1px solid #1976d2; border-radius: 6px; padding: 4px; margin-left: 8px;">
                        Reset
                    </button>


                    <button type="submit" style=" width: 100px;
                            background: #1976d2;
                            color: #fff;
                            border: none;
                            border-radius: 6px;
                            padding: 4px;">Tìm</button>
                </form>
                <c:if test="${empty pools}">
                    <div class="no-pool-message">Không có bể bơi nào phù hợp.</div>
                </c:if>
                <div class="pool-grid">
                    <c:forEach var="pool" items="${pools}">
                        <div class="pool-card">
                            <img 
                                src="${pool.pool_image}" 
                                alt="${pool.pool_name}" 
                                class="pool-img" 
                                style="cursor:pointer"
                                onclick="window.location.href = 'pool-detail?poolId=${pool.pool_id}'" 
                                />

                            <div class="pool-info">
                                <h3>${pool.pool_name}</h3>
                                <p><strong>Mô tả: </strong> ${pool.pool_description}</p>
                                <p><strong>Sức chứa:</strong> ${pool.max_slot}</p>
                                <p><strong>Giờ mở cửa:</strong> ${pool.open_time} - ${pool.close_time}</p>
                                <a href="booking?service=showBookingPage&poolId=${pool.pool_id}" class="btn-booking">Đặt bơi</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="customerViewPoolList?page=${currentPage-1}&searchName=${param.searchName}&capacity=${param.capacity}&openTime=${param.openTime}&closeTime=${param.closeTime}&searchLocation=${param.searchLocation}">&lt;&lt;</a>
                        </c:if>
                        <c:forEach begin="1" end="${totalPages}" var="pageNum">
                            <a href="customerViewPoolList?page=${pageNum}&searchName=${param.searchName}&capacity=${param.capacity}&openTime=${param.openTime}&closeTime=${param.closeTime}&searchLocation=${param.searchLocation}"
                               class="${pageNum == currentPage ? 'active' : ''}">
                                ${pageNum}
                            </a>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <a href="customerViewPoolList?page=${currentPage+1}&searchName=${param.searchName}&capacity=${param.capacity}&openTime=${param.openTime}&closeTime=${param.closeTime}&searchLocation=${param.searchLocation}">&gt;&gt;</a>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>

    <%@include file="footer.jsp" %>

    </body>

    <script>
        function setLocation(location) {
            // Lấy params hiện tại
            const url = new URL(window.location.href);
            url.searchParams.set('searchLocation', location === 'All' ? '' : location); // Nếu chọn "Tất cả cơ sở", không lọc theo location

            url.searchParams.set('page', 1); // Reset page về 1 mỗi khi đổi location

            // Redirect với đủ params
            window.location.href = url.pathname + '?' + url.searchParams.toString();
        }

        function resetFilters() {
            const url = new URL(window.location.href);
            // Xóa các param filter
            url.searchParams.delete('searchName');
            url.searchParams.delete('capacity');
            url.searchParams.delete('openTime');
            url.searchParams.delete('closeTime');
            url.searchParams.delete('searchLocation');
            url.searchParams.set('page', 1);
            // Reload lại trang
            window.location.href = url.pathname + '?' + url.searchParams.toString();
        }

    </script>
</html>