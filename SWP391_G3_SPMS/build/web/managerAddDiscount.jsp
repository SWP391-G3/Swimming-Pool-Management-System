

<%-- 
    Document   : managerAddDiscount
    Created on : Jun 28, 2025, 8:58:14 PM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm mã giảm giá</title>
        <link rel="stylesheet" href="./manager-css/managerAddDiscount.css"> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>
        <div class="form-container">
            <h2>Thêm mã giảm giá</h2>
            <form method="post" action="ManagerAddDiscountServlet" class="discount-form">
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="success-message">${success}</div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="success-message">${success}</div>
                </c:if>

                <div class="form-group">
                    <label for="discount_code">Mã voucher (duy nhất):</label>
                    <input type="text" id="discount_code" name="discount_code" class="form-control" required maxlength="50"
                           value="${not empty discount_code ? discount_code : param.discount_code}">
                </div>

                <div class="form-group">
                    <label for="description">Mô tả:</label>
                    <input type="text" id="description" name="description" class="form-control" maxlength="255"
                           value="${not empty description ? description : param.description}">
                </div>

                <div class="form-group">
                    <label for="discount_percent">Phần trăm giảm (%):</label>
                    <input type="number" id="discount_percent" name="discount_percent" class="form-control" required min="1" max="50"
                           value="${not empty discount_percent ? discount_percent : param.discount_percent}">
                </div>

                <div class="form-group">
                    <label for="quantity">Số lượng (1-100):</label>
                    <input type="number" id="quantity" name="quantity" class="form-control" required min="1" max="100"
                           value="${not empty quantity ? quantity : param.quantity}">
                </div>

                <div class="form-group">
                    <label for="valid_from">Ngày bắt đầu:</label>
                    <input type="datetime-local" id="valid_from" name="valid_from" class="form-control" required
                           value="${not empty valid_from ? valid_from : param.valid_from}">
                </div>

                <div class="form-group">
                    <label for="valid_to">Ngày kết thúc:</label>
                    <input type="datetime-local" id="valid_to" name="valid_to" class="form-control" required
                           value="${not empty valid_to ? valid_to : param.valid_to}">
                </div>

                <div class="form-group" style="justify-content: space-between;">
                    <a href="managerDiscountServlet?page=${param.page}&pageSize=${param.pageSize}&keyword=${fn:escapeXml(param.keyword)}&status=${fn:escapeXml(param.status)}&fromDate=${param.fromDate}&toDate=${param.toDate}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                    <div class="form-group" style="justify-content: flex-end;">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-plus-circle"></i> Thêm voucher
                        </button>
                    </div>


                    <!-- Hidden filter fields -->
                    <input type="hidden" name="page" value="${param.page}">
                    <input type="hidden" name="pageSize" value="${param.pageSize}">
                    <input type="hidden" name="keyword" value="${param.keyword}">
                    <input type="hidden" name="status" value="${param.status}">
                    <input type="hidden" name="fromDate" value="${param.fromDate}">
                    <input type="hidden" name="toDate" value="${param.toDate}">


                    </form>
                </div>

                <script>
                    function toggleDiscountValue() {
                        const type = document.getElementById('type').value;
                        const input = document.getElementById('discount_value');
                        const unit = document.getElementById('unit');

                        if (type === 'percent') {
                            input.min = 1;
                            input.max = 50;
                            unit.textContent = '%';
                        } else {
                            input.min = 1;
                            input.max = 500000;
                            unit.textContent = 'VNĐ';
                        }
                    }

                    document.addEventListener('DOMContentLoaded', function () {
                        toggleDiscountValue();
                    });
                </script>


                </body>
                </html>