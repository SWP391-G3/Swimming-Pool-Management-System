<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm Bể Bơi Mới</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="style/poolManagement.css"/>
        <link rel="stylesheet" href="admin-css/admin-panel.css"/>
        <link rel="stylesheet" href="admin-css/admin-add-pool.css"/>
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
                    <a href="#"><i class="bi bi-graph-up"></i> Thống kê & Báo cáo</a>
                    <a href="#"><i class="bi bi-gear"></i> Cài đặt hệ thống</a>
                    <a href="#"><i class="bi bi-box-arrow-right"></i>Đăng xuất</a>
                </nav>

                <!-- Main content -->
                <main class="col-md-10 ms-sm-auto col-lg-10 main-content">
                    <div class="header-bar d-flex justify-content-between align-items-center px-4 py-3 shadow-sm rounded bg-white mb-4">
                        <h2 class="fw-bold text-primary mb-0">Thêm bể bơi mới</h2>
                        <a href="#" class="profile-icon d-flex align-items-center text-decoration-none">
                            <i class="bi bi-person-circle fs-3 text-dark"></i>
                        </a>
                    </div>
                    <% 
                        String error = (String) request.getAttribute("error");
                        if(error == null){
                            error = "";
                        }
                    %>
                    <form action="adminAddPool" method="POST" class="row g-3 mt-2">
                        <div class="col-md-6">
                            <label class="form-label">Tên bể bơi</label>
                            <input type="text" name="poolName" class="form-control" value="${param.poolName}" placeholder="Nhập tên bể bơi" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Hình ảnh</label>
                            <input type="text" name="poolImage" class="form-control" value="${param.poolImage}" placeholder="Nhập link hình ảnh" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Mô tả</label>
                            <input type="text" name="poolDescription" class="form-control" value="${param.poolDescription}" placeholder="Nhập mô tả" required>
                        </div> 

                        <div class="col-md-6">
                            <label class="form-label">Tên đường</label>
                            <input type="text" name="poolRoad" class="form-control" value="${param.poolRoad}" placeholder="Nhập địa chỉ" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Khu vực</label>
                            <select name="poolAddress" class="form-select" required>
                                <option value="">-- Chọn khu vực --</option>
                                <option value="Hà Nội">Hà Nội</option>
                                <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                                <option value="Đà Nẵng">Đà Nẵng</option>
                                <option value="Quy Nhơn">Quy Nhơn</option>
                                <option value="Cần Thơ">Cần Thơ</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Sức chứa</label>
                            <input type="number" name="maxSlot" class="form-control" value="${param.maxSlot}" placeholder="Nhập sức chứa" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Giờ mở cửa</label>
                            <input type="time" name="openTime" value="${param.openTime}" class="form-control" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Giờ đóng cửa</label>
                            <input type="time" name="closeTime" value="${param.closeTime}" class="form-control" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Trạng thái</label>
                            <select name="poolStatus" class="form-select">
                                <option value="true" selected>Đang hoạt động</option>
                                <option value="false">Hủy hoạt động</option>
                            </select>
                        </div>

                        <div class="col-md-12">
                            <button type="submit" class="btn btn-success"><i class="bi bi-plus-circle"></i> Thêm bể bơi</button>
                            <a href="adminPoolManagement" class="btn btn-secondary"><i class="bi bi-arrow-left-circle"></i> Quay lại</a>
                        </div>
                    </form>
                </main>
            </div>
        </div>

        <!-- Modal for Error Message -->
        <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="errorModalLabel">Lỗi</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p id="errorMessage"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Check for error on page load and show modal if error exists
            window.onload = function () {
            <% if (error != null && !error.isEmpty()) { %>
                document.getElementById('errorMessage').textContent = "<%= error %>";
                var myModal = new bootstrap.Modal(document.getElementById('errorModal'));
                myModal.show();
            <% } %>
            };
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
