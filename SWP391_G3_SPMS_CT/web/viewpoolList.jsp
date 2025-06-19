<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>PoolHub - Trang chủ</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/poollist.css">
     
    </head>
    <body>
        <%-- HEADER/NAVBAR giữ nguyên code navbar của bạn ở đây --%>
        <div class="header">
            <div class="container" style="max-width: none !important; padding: 0 24px">
                <div class="row">
                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col logo_section">
                        <div class="full">
                            <div class="center-desk">
                                <div class="titlePool">
                                    <a href="#">PoolHub</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-9 col-lg-9 col-md-9 col-sm-9">
                        <nav class="navigation navbar navbar-expand-md navbar-dark">
                            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample04" aria-controls="navbarsExample04" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse justify-content-between align-items-center" id="navbarsExample04">
                                <ul class="navbar-nav d-flex align-items-center flex-row">
                                    <li class="nav-item"><a class="nav-link" href="home">TRANG CHỦ</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#">GIỚI THIỆU</a></li>
                                    <li class="nav-item active"><a class="nav-link" href="homepage">BỂ BƠI</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#">ĐÁNH GIÁ</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#">LIÊN HỆ</a></li>
                                </ul>
                                <ul class="navbar-nav ms-auto d-flex align-items-center flex-row">
                                    <c:if test="${not empty sessionScope.currentUser}">
                                        <li class="nav-item d-flex align-items-center me-3">
                                            <span class="nav-link text-muted">
                                                Welcome, <strong>${sessionScope.currentUser.username}</strong>
                                            </span>
                                        </li>
                                        <li class="nav-item">
                                            <span class="nav-link px-1">|</span>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-danger" href="LogoutServlet">Logout</a>
                                        </li>
                                    </c:if>
                                    <c:if test="${empty sessionScope.currentUser}">
                                        <li class="nav-item">
                                            <a class="nav-link" href="login.jsp">Đăng nhập</a>
                                        </li>
                                        <li class="nav-item">
                                            <span class="nav-link px-1">|</span>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="register.jsp">Đăng ký</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
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
                <form class="filter-form" method="get" action="homepage">
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
                                <p><strong>Đường:</strong> ${pool.pool_road}</p>
                                <p><strong>Sức chứa:</strong> ${pool.max_slot}</p>
                                <p><strong>Giờ mở cửa:</strong> ${pool.open_time} - ${pool.close_time}</p>
                                <a href="#" class="btn-booking">Đặt bơi</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="homepage?page=${currentPage-1}&searchName=${param.searchName}&capacity=${param.capacity}&openTime=${param.openTime}&closeTime=${param.closeTime}&searchLocation=${param.searchLocation}">&lt;&lt;</a>
                        </c:if>
                        <c:forEach begin="1" end="${totalPages}" var="pageNum">
                            <a href="homepage?page=${pageNum}&searchName=${param.searchName}&capacity=${param.capacity}&openTime=${param.openTime}&closeTime=${param.closeTime}&searchLocation=${param.searchLocation}"
                               class="${pageNum == currentPage ? 'active' : ''}">
                                ${pageNum}
                            </a>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <a href="homepage?page=${currentPage+1}&searchName=${param.searchName}&capacity=${param.capacity}&openTime=${param.openTime}&closeTime=${param.closeTime}&searchLocation=${param.searchLocation}">&gt;&gt;</a>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
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

    </script>
</html>