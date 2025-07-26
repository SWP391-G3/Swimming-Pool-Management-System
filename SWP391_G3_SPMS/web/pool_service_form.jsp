<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    request.setAttribute("activeMenu", "pool-service");
    boolean isEdit = request.getAttribute("poolService") != null;
    pageContext.setAttribute("isEdit", isEdit);
    model.manager.PoolService poolService = (model.manager.PoolService) request.getAttribute("poolService");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title><c:choose><c:when test="${isEdit}">Cập nhật dịch vụ hồ bơi</c:when><c:otherwise>Thêm mới dịch vụ hồ bơi</c:otherwise></c:choose></title>
                <link rel="stylesheet" href="./manager-css/manager-device-v3.css">
                <link rel="stylesheet" href="./manager-css/manager-panel.css">
                <style>
                    html, body, .layout, .content-panel {
                        height: 100%;
                        min-height: 100vh;
                    }
                    .content-panel {
                        padding: 40px 0;
                        background: #f8fafd;
                        display: flex;
                        flex-direction: column;
                        align-items: stretch;
                    }
                    .form-panel {
                        width: 100%;
                        max-width: 70%;
                        background: #fff;
                        border-radius: 14px;
                        box-shadow: 0 3px 16px rgba(60,72,100,.13);
                        padding: 42px 52px 34px;
                        margin: 0 auto;
                    }
                    .form-header {
                        display: flex;
                        align-items: center;
                        margin-bottom: 32px;
                    }
                    .btn-back {
                        background: #ede7f6;
                        color: #7c2cd9;
                        border: none;
                        padding: 9px 22px;
                        border-radius: 4px;
                        margin-right: 20px;
                        cursor: pointer;
                        font-weight: 500;
                        text-decoration: none;
                    }
                    .form-panel h2 {
                        margin: 0;
                        font-size: 1.45rem;
                    }
                    .form-row {
                        display: flex;
                        gap: 40px;
                        margin-bottom: 12px;
                    }
                    .form-group {
                        flex: 1;
                    }
                    .form-group label {
                        display: block;
                        margin-bottom: 7px;
                        font-weight: 500;
                    }
                    .form-group input, .form-group select, .form-group textarea {
                        width: 100%;
                        padding: 10px 14px;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                        font-size: 15px;
                    }
                    .form-group textarea {
                        resize: vertical;
                        min-height: 60px;
                    }
                    .form-img-preview {
                        display: flex;
                        align-items: center;
                        gap: 15px;
                        margin-top: 7px;
                    }
                    .form-img-preview img {
                        max-width: 120px;
                        max-height: 100px;
                        border-radius: 7px;
                        border: 1px solid #eee;
                    }
                    .form-actions {
                        display: flex;
                        justify-content: flex-end;
                        gap: 12px;
                        margin-top: 36px;
                    }
                    .btn-save {
                        background: #1976d2;
                        color: #fff;
                        border: none;
                        padding: 10px 36px;
                        border-radius: 4px;
                        font-weight: bold;
                        font-size: 16px;
                        cursor: pointer;
                    }
                    .btn-cancel {
                        background: #ede7f6;
                        color: #8e24aa;
                        border: none;
                        padding: 10px 28px;
                        border-radius: 4px;
                        font-weight: 500;
                        text-decoration: none;
                    }
                    select[multiple] {
                        height: auto;
                    }
                    .error-message {
                        color: red;
                        margin: 0 auto 20px auto;
                        font-weight: 500;
                        padding: 12px 20px;
                        background-color: #ffebee;
                        border-radius: 6px;
                        border: 1px solid #ef9a9a;
                        text-align: center;
                        max-width: 70%;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                    }
                    @media (max-width: 900px) {
                        .form-panel {
                            padding: 22px 8vw;
                        }
                        .form-row {
                            flex-direction: column;
                            gap: 0;
                        }
                        .error-message {
                            max-width: 90%;
                        }
                    }
                    img#image-preview {
                        display: none;
                    }
                </style>
            </head>
            <body>
                <div class="layout">
            <%@ include file="../managerSidebar.jsp" %>
            <div class="content-panel">
                <!-- Hiển thị thông báo lỗi từ session -->
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="error-message">${fn:escapeXml(sessionScope.errorMessage)}</div>
                    <c:remove var="errorMessage" scope="session"/>
                </c:if>

                <form class="form-panel" method="post" action="pool-service" enctype="multipart/form-data" autocomplete="off">
                    <div class="form-header">
                        <a href="pool-service" class="btn-back">← Danh sách</a>
                        <h2><c:choose><c:when test="${isEdit}">Cập nhật dịch vụ hồ bơi</c:when><c:otherwise>Thêm mới dịch vụ hồ bơi</c:otherwise></c:choose></h2>
                            </div>
                                <input type="hidden" name="action" value="<c:choose><c:when test='${isEdit}'>update</c:when><c:otherwise>add</c:otherwise></c:choose>"/>
                    <c:if test="${isEdit}">
                        <input type="hidden" name="pool_service_id" value="${poolService.poolServiceId}"/>
                    </c:if>

                    <!-- Hồ bơi -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="pool_id">Chọn hồ bơi <span style="color:red">*</span></label>
                            <select name="${isEdit ? 'pool_id' : 'pool_ids'}" id="pool_id"
                                    <c:if test="${!isEdit}">multiple size="${fn:length(poolList)}"</c:if> >
                                <c:if test="${isEdit}">
                                    <option value="">-- Chọn hồ bơi --</option>
                                </c:if>
                                <c:forEach var="pool" items="${poolList}">
                                    <option value="${pool.pool_id}" <c:if test="${isEdit && poolService.poolId == pool.pool_id}">selected</c:if>>
                                        ${pool.pool_name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Trạng thái -->
                        <div class="form-group">
                            <label for="service_status">Trạng thái</label>
                            <select name="service_status" id="service_status">
                                <option value="available" <c:if test="${isEdit && poolService.serviceStatus == 'available'}">selected</c:if>>Đang hoạt động</option>
                                <option value="maintenance" <c:if test="${isEdit && poolService.serviceStatus == 'maintenance'}">selected</c:if>>Bảo trì</option>
                                <option value="unavailable" <c:if test="${isEdit && poolService.serviceStatus == 'unavailable'}">selected</c:if>>Ngừng</option>
                                </select>
                            </div>
                        </div>

                        <!-- Tên dịch vụ -->
                        <div class="form-group" style="margin-bottom: 22px;">
                            <label for="service_name">Tên dịch vụ <span style="color:red">*</span></label>
                            <input type="text" name="service_name" id="service_name"
                                   value="${not empty param.service_name ? fn:escapeXml(param.service_name) : (isEdit ? fn:escapeXml(poolService.serviceName) : '')}" maxlength="100"
                            title="Tên dịch vụ không được chứa ký tự đặc biệt hoặc khoảng trắng thừa!"/>
                    </div>

                    <!-- Giá và số lượng -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="price">Giá dịch vụ (VND) <span style="color:red">*</span></label>
                            <input type="text" name="price" id="price" value="${not empty param.price ? fn:escapeXml(param.price) : (isEdit ? poolService.price : '')}" min="0" />
                        </div>
                        <div class="form-group">
                            <label for="quantity">Số lượng <span style="color:red">*</span></label>
                            <input type="text" 
                                   name="quantity" 
                                   id="quantity" 
                                   value="${not empty param.quantity ? fn:escapeXml(param.quantity) : (isEdit ? poolService.quantity : 1)}" 
                                   min="1" 
                                   max="1000"
                                   required
                                   oninput="validateQuantity(this)"
                                   />
                        </div>
                    </div>

                    <!-- Ảnh -->
                    <div class="form-group" style="margin-bottom: 20px;">
                        <label for="service_image">Ảnh dịch vụ (URL) <span style="color:red">*</span></label>
                        <input type="file" name="service_image" id="service_image" value="${not empty param.service_image ? fn:escapeXml(param.service_image) : (isEdit ? fn:escapeXml(poolService.serviceImage) : '')}" />

                    </div>

                    <!-- Mô tả -->
                    <div class="form-group" style="margin-bottom: 10px;">
                        <label for="description">Mô tả</label>
                        <textarea name="description" id="description" maxlength="1000">${not empty param.description ? fn:escapeXml(param.description) : (isEdit ? fn:escapeXml(poolService.description) : '')}</textarea>
                    </div>

                    <!-- Buttons -->
                    <div class="form-actions">
                        <a href="pool-service" class="btn-cancel">Huỷ</a>
                        <button type="submit" class="btn-save">
                            <c:choose><c:when test="${isEdit}">Lưu</c:when><c:otherwise>Thêm mới</c:otherwise></c:choose>
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", () => {

                window.addEventListener("DOMContentLoaded", function () {
                    if (priceInput && priceInput.value.trim() !== "") {
                        const value = parseFloat(priceInput.value);
                        if (!isNaN(value)) {
                            priceInput.value = value.toFixed(1); // hoặc toFixed(2) nếu muốn 2 số thập phân
                        }
                    }
                });
                const form = document.querySelector("form");
                const poolSelect = document.getElementById("pool_id");
                const nameInput = document.getElementById("service_name");
                const priceInput = document.getElementById("price");
                const quantityInput = document.getElementById("quantity");
                const urlInput = document.getElementById("service_image");

                // Kiểm tra hồ bơi
                const validatePool = () => {
                    if (!poolSelect.value) {
                        poolSelect.setCustomValidity("Chưa chọn hồ bơi!");
                    } else {
                        poolSelect.setCustomValidity("");
                    }
                    poolSelect.reportValidity();
                };

                // Kiểm tra tên dịch vụ
                const validateName = () => {
                    const v = nameInput.value.trim();
                    const regex = /^[A-Za-zÀ-ỹĐđ]+(?:\s[A-Za-zÀ-ỹĐđ]+)*$/;
                    if (!v) {
                        nameInput.setCustomValidity("Tên dịch vụ không được để trống!");
                    } else if (!regex.test(v)) {
                        nameInput.setCustomValidity("Tên dịch vụ chỉ được gồm chữ cái và mỗi khoảng trắng chỉ nằm giữa hai từ (VD: Tủ đựng đồ)!");
                    } else {
                        nameInput.setCustomValidity("");
                    }
                    nameInput.reportValidity();
                };

                // Kiểm tra giá
                // Kiểm tra giá
                const validatePrice = () => {
                    const v = priceInput.value.trim();

                    if (!v) {
                        priceInput.setCustomValidity("Giá dịch vụ không được để trống!");
                    } else if (!/^\d+(\.\d+)?$/.test(v)) {
                        // Cho phép số nguyên hoặc số thập phân (ví dụ: 10000 hoặc 10000.5)
                        priceInput.setCustomValidity("Giá dịch vụ phải là số nguyên dương hoặc số thập phân dương!");
                    } else {
                        const num = parseFloat(v);
                        if (num <= 0) {
                            priceInput.setCustomValidity("Giá dịch vụ phải lớn hơn 0!");
                        } else if (num > 100000000) {
                            priceInput.setCustomValidity("Giá dịch vụ không được vượt quá 100,000,000 VND!");
                        } else {
                            priceInput.setCustomValidity("");
                        }
                    }

                    priceInput.reportValidity();
                };


                // Kiểm tra số lượng
                // Kiểm tra số lượng - Phiên bản đã sửa
                const validateQuantity = () => {
                    const v = quantityInput.value.trim();

                    if (!v) {
                        quantityInput.setCustomValidity("Số lượng không được để trống!");
                    } else if (!/^\d+$/.test(v)) {
                        quantityInput.setCustomValidity("Số lượng chỉ được nhập số nguyên dương!");
                    } else {
                        const num = parseInt(v, 10);
                        if (num < 1) {
                            quantityInput.setCustomValidity("Số lượng tối thiểu phải là 1!");
                        } else if (num > 1000) {
                            quantityInput.setCustomValidity("Số lượng không được vượt quá 1000!");
                        } else {
                            quantityInput.setCustomValidity("");
                        }
                    }

                    quantityInput.reportValidity();
                };


                // Kiểm tra URL ảnh
                const validateURL = () => {
                    const v = urlInput.value.trim();
                    if (!v) {
                        urlInput.setCustomValidity("URL ảnh không được để trống!");
                    } else {
                        urlInput.setCustomValidity("");
                    }
                    urlInput.reportValidity();
                };

                // Gắn sự kiện
                [
                    [poolSelect, validatePool],
                    [nameInput, validateName],
                    [priceInput, validatePrice],
                    [quantityInput, validateQuantity],
                    [urlInput, validateURL]
                ].forEach(([el, fn]) => {
                    ["input", "blur", "change"].forEach(evt => el.addEventListener(evt, fn));
                });

                // Xử lý submit
                form.addEventListener("submit", e => {
                    validatePool();
                    validateName();
                    validatePrice();
                    validateQuantity();
                    validateURL();

                    if (!form.checkValidity()) {
                        e.preventDefault();
                        form.reportValidity();
                    }
                });
            });
        </script>

    </body>
</html>