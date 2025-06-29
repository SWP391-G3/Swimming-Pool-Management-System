<%-- 
    Document   : updateDevice
    Created on : May 28, 2025, 10:10:26 PM
    Author     : Tuan Anh
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cập Nhật Thiết Bị</title>
        <link rel="stylesheet" href="./manager-css/managerAddUpdate-device-v1.css">
    </head>
    <body>
        <div class="container"> 
            <h2>--- Cập nhật thiết bị ---</h2>

            <!-- Hiển thị lỗi client-side -->
            <div id="noteError" style="color: red; font-weight: bold; margin-bottom: 10px;"></div>

            <!-- Hiển thị lỗi server-side nếu có -->
            <c:if test="${not empty error}">
                <div style="color: red; font-weight: bold; margin-bottom: 10px;">
                    ${error}
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/managerUpdateDeviceServlet" onsubmit="return validateForm();" enctype="multipart/form-data">
                <input type="hidden" name="deviceId" value="${device.deviceId}">



                <div class="form-group">
                    <label>Hồ bơi:</label>
                    <select name="poolId">
                        <option value="">-- Tất cả hồ bơi --</option>
                        <c:forEach var="pool" items="${poolList}">
                            <option value="${pool.poolId}"
                                    <c:choose>
                                        <c:when test="${not empty param.poolId && param.poolId.trim() == pool.poolId.toString()}">selected</c:when>
                                        <c:when test="${empty param.poolId && pool.poolId == device.poolId}">selected</c:when>
                                    </c:choose>>
                                ${pool.poolName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Tên thiết bị:</label>
                    <input type="text" name="deviceName" required 
                           value="${not empty param.deviceName ? param.deviceName : device.deviceName}">
                </div>

                <div class="form-group">
                    <label>Số lượng:</label>
                    <input type="number" name="quantity" required min="1" max="1000"
                           value="${not empty param.quantity ? param.quantity : device.quantity}">
                </div>


                <div class="form-group">
                    <label>Trạng thái:</label>
                    <select name="deviceStatus">
                        <option value="">-- Tất cả trạng thái --</option>
                        <option value="available" 
                                ${param.deviceStatus == 'available' || (empty param.deviceStatus && device.deviceStatus == 'available') ? 'selected' : ''}>Tốt</option>
                        <option value="maintenance" 
                                ${param.deviceStatus == 'maintenance' || (empty param.deviceStatus && device.deviceStatus == 'maintenance') ? 'selected' : ''}>Bảo trì</option>
                        <option value="broken" 
                                ${param.deviceStatus == 'broken' || (empty param.deviceStatus && device.deviceStatus == 'broken') ? 'selected' : ''}>Hỏng</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Ghi chú:</label>
                    <textarea name="notes" maxlength="200" placeholder="Không vượt quá 200 ký tự">${not empty param.notes ? param.notes : device.notes}</textarea>
                </div>

                <input type="hidden" name="returnPoolId" value="${poolId}">
                <input type="hidden" name="returnKeyword" value="${keyword}">
                <input type="hidden" name="returnStatus" value="${status}">
                <input type="hidden" name="returnPage" value="${page}">
                <input type="hidden" name="pageSize" value="${pageSize}">

                <div class="form-group">
                    <label>Ảnh thiết bị (chọn file mới nếu muốn đổi):</label>
                    <!-- Hiện ảnh hiện tại nếu có -->
                    <c:if test="${not empty device.deviceImage}">
                        <img src="${device.deviceImage}" style="max-width: 120px; display:block; margin-bottom:8px">
                    </c:if>
                    <input type="file" name="deviceImageFile" accept="image/*">
                    <!-- Có thể giữ input hidden để truyền lại link ảnh cũ -->
                    <input type="hidden" name="oldImage" value="${device.deviceImage}">
                </div>



                <div class="button-group">
                    <button type="submit">Cập nhật</button>
                    <a href="managerListDeviceServlet?page=${page}&poolId=${poolId}&keyword=${keyword}&status=${status}&pageSize=${pageSize}" class="btn-back">Quay lại</a>
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