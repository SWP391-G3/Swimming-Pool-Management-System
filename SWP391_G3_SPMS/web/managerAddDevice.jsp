<%-- 
    Document   : addDevice
    Created on : May 28, 2025, 10:10:26 PM
    Author     : Tuan Anh
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm thiết bị</title>
        <link rel="stylesheet" href="./manager-css/managerAddUpdate-device-v1.css">
    </head>
    <body>
        <div class="container">
            <h2>Thêm thiết bị mới</h2>

            <!-- Hiển thị lỗi phía client -->
            <div id="noteError" style="color: red; font-weight: bold; margin-bottom: 10px;"></div>

            <!-- Thông báo lỗi phía server (nếu có) -->
            <c:if test="${not empty error}">
                <div style="color: red; font-weight: bold; margin-bottom: 10px;">
                    ${error}
                </div>
            </c:if>

            <form action="managerAddDeviceServlet" method="post" onsubmit="return validateForm();" enctype="multipart/form-data">

                <div class="form-group">
                    <label>Hồ bơi:</label>
                    <select name="poolId" required>
                        <option value="">-- Tất cả hồ bơi --</option>
                        <c:forEach var="pool" items="${poolList}">
                            <option value="${pool.poolId}" 
                                    <c:if test="${(not empty param.poolId ? param.poolId : poolId) == pool.poolId.toString()}">selected</c:if>>
                                ${pool.poolName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Tên thiết bị:</label>
                    <input type="text" name="deviceName" required value="${param.deviceName}">
                </div>

                <div class="form-group">
                    <label>Số lượng:</label>
                    <input type="number" name="quantity" required min="1" max="1000" value="${param.quantity}">
                </div>

                <div class="form-group">
                    <label>Trạng thái:</label>
                    <select name="deviceStatus">
                        <option value="">-- Tất cả trạng thái --</option>
                        <option value="available" ${param.deviceStatus == 'available' ? 'selected' : ''}>Tốt</option>
                        <option value="maintenance" ${param.deviceStatus == 'maintenance' ? 'selected' : ''}>Bảo trì</option>
                        <option value="broken" ${param.deviceStatus == 'broken' ? 'selected' : ''}>Hỏng</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Ghi chú:</label>
                    <textarea name="notes" maxlength="200" placeholder="Không vượt quá 200 ký tự">${param.notes}</textarea>
                </div>


                <div class="form-group">
                    <label>Ảnh (chọn file):</label>
                    <input type="file" name="deviceImageFile" accept="image/*">
                    <!-- Không dùng input type="text" nữa -->
                </div>

                <input type="hidden" name="returnPoolId" value="${poolId}">
                <input type="hidden" name="returnKeyword" value="${keyword}">
                <input type="hidden" name="returnStatus" value="${status}">
                <input type="hidden" name="returnPage" value="${page}">
                <input type="hidden" name="pageSize" value="${pageSize}">

                <div class="button-group">
                    <a href="managerListDeviceServlet?page=${page}&poolId=${poolId}&keyword=${keyword}&status=${status}&pageSize=${pageSize}" class="btn-back">Quay lại</a>
                    <button type="submit">Thêm</button>
                    <button type="button" onclick="document.getElementById('excel-upload-form').style.display = 'block';" class="btn-add" style="background: #3b82f6; color: #fff;">Nhập nhiều thiết bị (Excel)</button>


                </div>

                <!-- Nút mở form upload Excel -->


                <!-- Form upload file Excel (ẩn/hiện bằng JS) -->
                <div id="excel-upload-form" style="display:none; padding: 18px; margin-left: 400px ; border: 1px solid #ddd; margin: 16px 0; background: #fbfbfb;">
                    <form action="managerImportDeviceExcelServlet" method="post" enctype="multipart/form-data">
                        <label>Chọn file Excel (.xlsx): </label>
                        <input type="file" name="excelFile" accept=".xlsx, .xls" required>
                        <button type="submit">Upload</button>
                        <button type="button" onclick="document.getElementById('excel-upload-form').style.display = 'none';">Hủy</button>
                    </form>
                    <div style="margin-top:8px">
                        <a href="template/device_import_template.xlsx" download>Tải file mẫu Excel</a>
                    </div>
                </div>

            </form>
        </div>



        <script>
            function validateForm() {
                let form = document.forms[0];
                let deviceName = form["deviceName"].value.trim();
                let poolId = form["poolId"].value;
                let quantity = form["quantity"].value.trim();
                let deviceStatus = form["deviceStatus"].value;
                let notes = form["notes"].value;
                let imageField = form["deviceImageFile"];
                let noteError = document.getElementById("noteError");
                noteError.innerText = "";

                // Kiểm tra các trường bắt buộc
                if (deviceName === "") {
                    noteError.innerText = "Tên thiết bị không được để trống.";
                    form["deviceName"].focus();
                    return false;
                }
                if (poolId === "" || poolId === null) {
                    noteError.innerText = "Bạn phải chọn hồ bơi.";
                    form["poolId"].focus();
                    return false;
                }
                if (quantity === "" || isNaN(quantity) || parseInt(quantity) < 1) {
                    noteError.innerText = "Số lượng không được để trống và phải lớn hơn 0.";
                    form["quantity"].focus();
                    return false;
                }
                if (deviceStatus === "" || deviceStatus === null) {
                    noteError.innerText = "Bạn phải chọn trạng thái thiết bị.";
                    form["deviceStatus"].focus();
                    return false;
                }
                if (imageField && imageField.value.trim() === "") {
                    noteError.innerText = "Bạn phải chọn ảnh cho thiết bị.";
                    imageField.focus();
                    return false;
                }

                // Kiểm tra ghi chú
                const specialChars = /[<>"]/;
                if (notes.length > 200) {
                    noteError.innerText = "Ghi chú không được vượt quá 200 ký tự.";
                    form["notes"].focus();
                    return false;
                }
                if (specialChars.test(notes)) {
                    noteError.innerText = "Ghi chú không được chứa ký tự đặc biệt như <, > hoặc \".";
                    form["notes"].focus();
                    return false;
                }

                return true;
            }
        </script>


    </body>
</html>