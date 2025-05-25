<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Booking" %>
<%@ page import="java.util.List" %>
<%
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
    int pageNum = (request.getAttribute("page") != null) ? (int) request.getAttribute("page") : 1;
    int totalPages = (request.getAttribute("totalPages") != null) ? (int) request.getAttribute("totalPages") : 1;
    String search = (String) request.getAttribute("search");
    String status = (String) request.getAttribute("status");
    String sort = (String) request.getAttribute("sort");
    String sortDir = (String) request.getAttribute("sortDir");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Today's Customer Bookings</title>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <style>
        .sortable:hover { cursor: pointer; text-decoration: underline; }
        .active-sort { font-weight: bold;}
    </style>
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-4 text-primary">Danh sách Booking</h2>
    <form class="row mb-4 g-2" method="get">
        <div class="col-md-3">
            <input type="text" name="search" class="form-control" placeholder="Tìm tên, email, số ĐT, bể bơi..." value="<%= (search != null ? search : "") %>"/>
        </div>
        <div class="col-md-2">
            <select name="status" class="form-select">
                <option value="all" <%= ("all".equals(status) ? "selected" : "") %>>Tất cả trạng thái</option>
                <option value="pending" <%= ("pending".equals(status) ? "selected" : "") %>>Pending</option>
                <option value="confirmed" <%= ("confirmed".equals(status) ? "selected" : "") %>>Confirmed</option>
                <option value="cancelled" <%= ("cancelled".equals(status) ? "selected" : "") %>>Cancelled</option>
            </select>
        </div>
        <div class="col-md-2">
            <select name="sort" class="form-select">
                <option value="date" <%= ("date".equals(sort) ? "selected" : "") %>>Ngày đặt</option>
                <option value="name" <%= ("name".equals(sort) ? "selected" : "") %>>Tên KH</option>
                <option value="pool" <%= ("pool".equals(sort) ? "selected" : "") %>>Tên bể bơi</option>
                <option value="status" <%= ("status".equals(sort) ? "selected" : "") %>>Trạng thái</option>
            </select>
        </div>
        <div class="col-md-2">
            <select name="sortDir" class="form-select">
                <option value="asc" <%= ("asc".equals(sortDir) ? "selected" : "") %>>Tăng dần</option>
                <option value="desc" <%= ("desc".equals(sortDir) ? "selected" : "") %>>Giảm dần</option>
            </select>
        </div>
        <div class="col-md-2">
            <button class="btn btn-primary w-100" type="submit">Lọc / Tìm kiếm</button>
        </div>
    </form>
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <div class="table-responsive">
        <table class="table table-hover table-bordered align-middle">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Tên khách hàng</th>
                    <th>SĐT</th>
                    <th>Email</th>
                    <th>Bể bơi</th>
                    <th>Ngày</th>
                    <th>Thời gian</th>
                    <th>Slot</th>
                    <th>Trạng thái</th>
                </tr>
            </thead>
            <tbody>
            <% if (bookings != null && bookings.size() > 0) {
                for (Booking b : bookings) {
            %>
                <tr>
                    <td><%= b.getBookingId() %></td>
                    <td><%= b.getCustomerName() %></td>
                    <td><%= b.getPhone() %></td>
                    <td><%= b.getEmail() %></td>
                    <td><%= b.getPoolName() %></td>
                    <td><%= b.getBookingDate() %></td>
                    <td><%= b.getStartTime() %> - <%= b.getEndTime() %></td>
                    <td><%= b.getSlotCount() %></td>
                    <td>
                        <span class="badge
                          <%= "confirmed".equals(b.getBookingStatus()) ? "bg-success" :
                              "pending".equals(b.getBookingStatus()) ? "bg-warning text-dark" :
                              "bg-danger" %>">
                          <%= b.getBookingStatus() %>
                        </span>
                    </td>
                </tr>
            <% }} else { %>
                <tr><td colspan="9" class="text-center text-secondary">Không có booking nào hôm nay.</td></tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <!-- Pagination -->
    <nav>
      <ul class="pagination justify-content-center">
        <% for (int i = 1; i <= totalPages; i++) { %>
            <li class="page-item <%= (i == pageNum) ? "active" : "" %>">
                <a class="page-link"
                   href="?search=<%= (search != null ? search : "") %>&status=<%= status %>&sort=<%= sort %>&sortDir=<%= sortDir %>&page=<%= i %>"><%= i %></a>
            </li>
        <% } %>
      </ul>
    </nav>
</div>
<script src="https://unpkg.com/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>