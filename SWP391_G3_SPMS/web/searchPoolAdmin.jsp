<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List,model.Pool" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Kết quả tìm kiếm bể bơi</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <link rel="stylesheet" href="./css/poolManagement.css"/>
    </head>

    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <nav class="col-md-2 d-none d-md-block sidebar">
                    <h4 class="text-center mb-4">Admin Panel</h4>
                    <a href="poolmanagement"><i class="bi bi-water"></i>   Quản lý bể bơi</a>
                    <a href="#"><i class="bi bi-people"></i> Quản lý nhân viên</a>
                    <a href="#"><i class="bi bi-person-check"></i> Quản lý khách hàng</a>
                    <a href="#"><i class="bi bi-calendar-check"></i>  Quản lý đặt lịch</a>
                    <a href="#"><i class="bi bi-graph-up"></i>  Thống kê & Báo cáo</a>
                    <a href="#"><i class="bi bi-gear"></i>  Cài đặt hệ thống</a>
                </nav>

                <!-- Main content -->
                <main class="col-md-10 ms-sm-auto col-lg-10 main-content">
                    <div class="header-bar">
                        <h2 class="fw-bold text-primary">Kết quả tìm kiếm</h2>
                        <a href="#"><i class="bi bi-person-circle"></i></a>
                    </div>
                    <% 
                        String key_name = (String) request.getAttribute("key_search");
                    %>
                    <p class="text-muted">Kết quả cho từ khóa: <strong>"<%= key_name %>"</strong></p>
                    <form action="poolservice" method="GET" class="row g-3 my-3">
                        <div class="col-md-3">
                            <input type="text" name="search" class="form-control" placeholder="Tìm theo tên bể bơi...">
                        </div>
                        <div class="col-md-3">
                            <select name="location" class="form-select">
                                <option value="">-- Lọc theo khu vực --</option>
                                <option value="Hà Nội">Hà Nội</option>
                                <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                                <option value="Đà Nẵng">Đà Nẵng</option>
                                <option value="Quy Nhơn">Quy Nhơn</option>
                                <option value="Cần Thơ">Cần Thơ</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select name="status" class="form-select">
                                <option value="">-- Lọc theo trạng thái --</option>
                                <option value="true">Đang hoạt động</option>
                                <option value="false">Hủy hoạt động</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select name="sort" class="form-select">
                                <option value="">-- Sắp xếp --</option>
                                <option value="capacity_asc">Sức chứa tăng dần</option>
                                <option value="capacity_desc">Sức chứa giảm dần</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                        </div>
                    </form>
                    <!-- Danh sách kết quả -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Tên bể bơi</th>
                                    <th>Địa chỉ</th>
                                    <th>Khu vực</th>
                                    <th>Sức chứa</th>
                                    <th>Giờ mở cửa</th>
                                    <th>Giờ đóng cửa</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <% 
                                List<Pool> listPool = (List<Pool>) request.getAttribute("listPool");
                                if(listPool != null){
                                for(Pool p : listPool){                              
                            %>
                            <tbody>
                                <tr>
                                    <td><%= p.getPool_id() %></td>                                   
                                    <td><%= p.getPool_name() %></td>                                   
                                    <td><%= p.getPool_road() %></td>                                   
                                    <td><%= p.getPool_address()%></td>                                   
                                    <td><%= p.getMax_slot() %></td>   
                                    <td><%= p.getOpen_time() %></td>                                   
                                    <td><%= p.getClose_time() %></td> 
                                    <td><%= p.isPool_status() ? "Đang hoạt động" : "Hủy hoạt động" %></td>                                                                  
                                    <td>
                                        <a href="updatePoolAdmin?id=<%=p.getPool_id()%>" class="btn btn-sm btn-warning"><i class="bi bi-arrow-clockwise"></i> Sửa</a>
                                        <a href="deletePoolAdmin?id=<%=p.getPool_id()%>" class="btn btn-sm btn-danger"><i class="bi bi-trash"></i> Xóa</a>
                                    </td>
                                </tr>
                            </tbody>
                            <% }}%>
                        </table>
                    </div>
                    <a href="addNewPoolAdmin.jsp" class="btn btn-success mt-3"><i class="bi bi-bag-plus"></i> Thêm bể bơi mới</a>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
