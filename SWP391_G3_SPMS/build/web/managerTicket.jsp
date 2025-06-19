<%-- 
    Document   : managerTicket
    Created on : Jun 19, 2025, 2:53:03 AM
    Author     : Tuan Anh
--%>


<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setAttribute("activeMenu", "ticket");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Ticket</title>
    <link rel="stylesheet" href="./manager-css/managerTicket.css">
    <link rel="stylesheet" href="./manager-css/manager-panel.css">
</head>
<body>
    <div class="layout">
        <div class="sidebar">
            <!-- Sidebar content -->
            <%@ include file="../managerSidebar.jsp" %>
            
        </div>

        <div class="content-panel">
            <div class="content-header">
                <h2>Quản lý Ticket</h2>
                <p class="desc">Quản lý và theo dõi các vé đã phát hành tại chi nhánh</p>
            </div>

            <div class="ticket-controls">
                <div class="search-filter">
                    
                    <div class="search-box">
                        <input type="text" id="searchInput" placeholder="Tìm kiếm mã vé, khách hàng...">
                        <button>Tìm kiếm</button>
                    </div>
                    
                    <div class="filter-group">
                        <label for="poolFilter">Hồ bơi:</label>
                        <select id="poolFilter">
                            <option value="all">Tất cả hồ bơi</option>
                            <option value="1">Hồ bơi Quận 1</option>
                            <option value="2">Hồ bơi Quận 3</option>
                            <option value="3">Hồ bơi Quận 5</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label for="statusFilter">Trạng thái:</label>
                        <select id="statusFilter">
                            <option value="all">Tất cả</option>
                            <option value="pending">Chưa thanh toán</option>
                            <option value="completed">Đã thanh toán</option>
                            <option value="canceled">Đã hủy</option>
                        </select>
                    </div>

                    
                </div>

                <div class="action-buttons">
                    <button class="btn-add">
                        <svg viewBox="0 0 24 24" width="18" height="18" fill="white">
                            <path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z"/>
                        </svg>
                        Thêm vé mới
                    </button>
                    <button class="btn-copy">
                        <svg viewBox="0 0 24 24" width="18" height="18" fill="white">
                            <path d="M16 1H4c-1.1 0-2 .9-2 2v14h2V3h12V1zm3 4H8c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h11c1.1 0 2-.9 2-2V7c0-1.1-.9-2-2-2zm0 16H8V7h11v14z"/>
                        </svg>
                        Copy loại vé
                    </button>
                </div>
            </div>

            <div class="ticket-list">
                <table>
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Mã vé</th>
                            <th>Loại vé</th>
                            <th>Khách hàng</th>
                            <th>Hồ bơi</th>
                            <th>Ngày sử dụng</th>
                            <th>Giá vé</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>ADULT-TICKET-0012</td>
                            <td>Vé người lớn</td>
                            <td>Nguyễn Văn A</td>
                            <td>Hồ bơi Quận 1</td>
                            <td>15/06/2025</td>
                            <td>100,000 VND</td>
                            <td><span class="status-badge completed">Đã thanh toán</span></td>
                            <td>
                                <div class="action-buttons-cell">
                                    <button class="btn-detail">Chi tiết</button>
                                    <button class="btn-update">Cập nhật</button>
                                    <button class="btn-delete">Xóa</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>CHILD-TICKET-0045</td>
                            <td>Vé trẻ em</td>
                            <td>Trần Thị B</td>
                            <td>Hồ bơi Quận 1</td>
                            <td>16/06/2025</td>
                            <td>70,000 VND</td>
                            <td><span class="status-badge pending">Chưa thanh toán</span></td>
                            <td>
                                <div class="action-buttons-cell">
                                    <button class="btn-detail">Chi tiết</button>
                                    <button class="btn-update">Cập nhật</button>
                                    <button class="btn-delete">Xóa</button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="pagination">
                    <a href="#">&laquo;</a>
                    <a href="#" class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">&raquo;</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Copy loại vé -->
    <div id="copyTicketModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>Sao chép loại vé giữa các hồ bơi</h3>

            <div class="form-group">
                <label for="sourcePool">Hồ bơi nguồn:</label>
                <select id="sourcePool">
                    <option value="">Chọn hồ bơi nguồn</option>
                    <option value="1">Hồ bơi Quận 1</option>
                    <option value="2">Hồ bơi Quận 3</option>
                    <option value="3">Hồ bơi Quận 5</option>
                </select>
            </div>

            <div class="form-group">
                <label for="targetPool">Hồ bơi đích:</label>
                <select id="targetPool">
                    <option value="">Chọn hồ bơi đích</option>
                    <option value="1">Hồ bơi Quận 1</option>
                    <option value="2">Hồ bơi Quận 3</option>
                    <option value="3">Hồ bơi Quận 5</option>
                </select>
            </div>

            <div class="form-group">
                <label>
                    <input type="checkbox" id="overwriteExisting" checked>
                    Ghi đè loại vé đã tồn tại
                </label>
            </div>

            <div class="modal-footer">
                <button class="btn-confirm">Xác nhận sao chép</button>
                <button class="btn-cancel">Hủy</button>
            </div>
        </div>
    </div>
</body>
</html>
