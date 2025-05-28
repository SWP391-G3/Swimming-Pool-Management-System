<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List,model.Pool" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Cập nhật bể bơi</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./css/poolManagement.css"/>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <nav class="col-md-2 d-none d-md-block sidebar">
                    <h4 class="text-center mb-4">Admin Panel</h4>
                    <a href="adminPoolManagement"><i class="bi bi-water"></i> Quản lý bể bơi</a>
                    <a href="#"><i class="bi bi-people"></i> Quản lý nhân viên</a>
                    <a href="#"><i class="bi bi-person-check"></i> Quản lý khách hàng</a>
                    <a href="#"><i class="bi bi-calendar-check"></i> Quản lý đặt lịch</a>
                    <a href="#"><i class="bi bi-graph-up"></i> Thống kê & Báo cáo</a>
                    <a href="#"><i class="bi bi-gear"></i> Cài đặt hệ thống</a>
                </nav>

                <!-- Main content -->
                <main class="col-md-10 ms-sm-auto col-lg-10 main-content">
                    <div class="header-bar">
                        <h2 class="fw-bold text-primary">Cập nhật bể bơi</h2>
                        <a href="#"><i class="bi bi-person-circle"></i></a>
                    </div>
                    <% 
                        Pool p = (Pool) request.getAttribute("Pool");
                    %>
                    <form action="adminUpdatePool" method="POST" class="row g-3 mt-2">
                        <input type="hidden" name="pool_id" value="<%= p.getPool_id() %>"/>

                        <div class="col-md-6">
                            <label class="form-label">Tên bể bơi</label>
                            <input type="text" name="pool_name" class="form-control" value="<%= p.getPool_name() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Hình Ảnh</label>
                            <input type="text" name="pool_image" class="form-control" value="<%= p.getPool_image() %>" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Địa chỉ</label>
                            <input type="text" name="pool_road" class="form-control" value="<%= p.getPool_road() %>" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Khu vực</label>
                            <select name="pool_address" class="form-select" required>
                                <option value="<%= p.getPool_address() %>" selected>Hà Nội</option>
                                <option value="<%= p.getPool_address() %>">Hồ Chí Minh</option>
                                <option value="<%= p.getPool_address() %>">Đà Nẵng</option>
                                <option value="<%= p.getPool_address() %>">Quy Nhơn</option>
                                <option value="<%= p.getPool_address() %>">Cần Thơ</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Sức chứa</label>
                            <input type="number" name="max_slot" class="form-control" value="<%= p.getMax_slot() %>" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Giờ mở cửa</label>
                            <input type="time" name="open_time" class="form-control" value="<%= p.getOpen_time() %>" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Giờ đóng cửa</label>
                            <input type="time" name="close_time" class="form-control" value="<%= p.getClose_time() %>" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Trạng thái</label>
                            <select name="pool_status" class="form-select">
                                <option value="true" selected>Đang hoạt động</option>
                                <option value="false">Hủy hoạt động</option>
                            </select>
                        </div>

                        <div class="col-md-12">
                            <button type="submit" class="btn btn-success"><i class="bi bi-check-circle"></i> Cập nhật</button>
                            <a href="adminPoolManagement" class="btn btn-secondary"><i class="bi bi-arrow-left-circle"></i> Quay lại</a>
                        </div>
                    </form>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
