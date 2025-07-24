<%-- 
    Document   : managerEditDiscount
    Created on : Jun 28, 2025, 10:21:12 PM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Cập nhật mã giảm giá</title>
        <link rel="stylesheet" href="./manager-css/managerEditDiscount.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>
        <div class="form-container">
            <h2>Cập nhật mã giảm giá</h2>

            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="success-message">${success}</div>
            </c:if>

            <!-- JSTL sau để định dạng ngày trước khi đưa vào trường <input type="datetime-local">: -->
    
            <fmt:formatDate value="${discount.validFrom}" pattern="yyyy-MM-dd'T'HH:mm" var="validFromVal"/>
            <fmt:formatDate value="${discount.validTo}" pattern="yyyy-MM-dd'T'HH:mm" var="validToVal"/>



            <form method="post" action="managerEditDiscountServlet" class="discount-form">
                <div class="form-group">
                    <label for="discount_code">Mã voucher (không thể sửa):</label>
                    <input type="text" id="discount_code" class="form-control" value="${discount.code}" readonly>
                </div>

                <div class="form-group">
                    <label for="description">Mô tả:</label>
                    <input type="text" id="description" name="description" class="form-control" maxlength="255"
                           value="${not empty description ? description : discount.description}">
                </div>

                <div class="form-group">
                    <label for="discount_percent">Phần trăm giảm (%):</label>
                    <input type="number" id="discount_percent" name="discount_percent" class="form-control" required min="1" max="50" step="0.01"
                           value="${not empty discount_percent ? discount_percent : discount.percent}">
                </div>

                <div class="form-group">
                    <label for="quantity">Số lượng (1-100):</label>
                    <input type="number" id="quantity" name="quantity" class="form-control" required min="1" max="100"
                           value="${not empty quantity ? quantity : discount.quantity}">
                </div>

                <div class="form-group">
                    <label for="valid_from">Ngày bắt đầu:</label>
                    <input type="datetime-local" id="valid_from" name="valid_from" class="form-control" required
                           value="${not empty valid_from ? valid_from : validFromVal}">
                </div>

                <div class="form-group">
                    <label for="valid_to">Ngày kết thúc:</label>
                    <input type="datetime-local" id="valid_to" name="valid_to" class="form-control" required
                           value="${not empty valid_to ? valid_to : validToVal}">
                </div>

                <div class="form-group">
                    <label>Trạng thái:</label><br>
                    <input type="radio" id="status_active" name="status" value="1" 
                           <c:if test="${(not empty status ? status == '1' : discount.status)}">checked</c:if> >
                           <label for="status_active">Đang hoạt động</label>
                           <input type="radio" id="status_inactive" name="status" value="0"
                           <c:if test="${(not empty status ? status == '0' : !discount.status)}">checked</c:if> >
                           <label for="status_inactive">Ngừng hoạt động</label>
                    </div>

                    <div class="form-group" style="display: flex; justify-content: space-between;">
                        <a href="managerDiscountServlet?page=${page}&pageSize=${pageSize}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&fromDate=${fromDate}&toDate=${toDate}"
                       class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Lưu thay đổi
                    </button>
                </div>

                <input type="hidden" name="discount_id" value="${discount.id}">
                <input type="hidden" name="discount_code" value="${discount.code}">
                <input type="hidden" name="page" value="${page}">
                <input type="hidden" name="pageSize" value="${pageSize}">
                <input type="hidden" name="keyword" value="${keyword}">
                <input type="hidden" name="status" value="${status}">
                <input type="hidden" name="fromDate" value="${fromDate}">
                <input type="hidden" name="toDate" value="${toDate}">
            </form>
        </div>
    </body>
</html>