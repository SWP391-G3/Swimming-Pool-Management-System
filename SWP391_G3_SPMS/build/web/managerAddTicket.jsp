<%-- 
    Document   : managerAddTicket
    Created on : Jun 20, 2025, 7:31:45 PM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm loại vé mới</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link rel="stylesheet" href="./manager-css/managerAddTicket-v2.css">
        <style>
            .combo-section {
                background: #f9fafb;
                padding: 20px;
                border-radius: 8px;
                margin-top: 12px;
            }
            .combo-table {
                width: 100%;
                border-collapse: collapse;
            }
            .combo-table th, .combo-table td {
                border: 1px solid #e2e8f0;
                padding: 8px 6px;
                text-align: center;
            }
            .combo-table th {
                background: #f1f5f9;
            }
            .combo-summary {
                margin-top: 12px;
                font-weight: 500;
            }
        </style>
    </head>
    <body>
        <div class="layout">
            <div class="content-panel">
                <h2 style="text-align:center;">Thêm loại vé mới</h2>
                <form class="form-add-ticket" method="post" action="managerAddTicket" id="addTicketForm" autocomplete="off">
                    <input type="hidden" name="page" value="${param.page}" />
                    <input type="hidden" name="pageSize" value="${param.pageSize}" />
                    <input type="hidden" name="keyword" value="${fn:escapeXml(param.keyword)}" />
                    <input type="hidden" name="status" value="${fn:escapeXml(param.status)}" />
                    <input type="hidden" name="poolId" value="${fn:escapeXml(param.poolId)}" />

                    <c:if test="${not empty error}">
                        <div class="error-message">${error}</div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="success-message">${success}</div>
                    </c:if>

                    <div class="form-row">
                        <label>Loại vé <span style="color:red">*</span></label>
                        <label><input type="radio" name="ticketKind" value="single" checked onchange="toggleCombo()"> Vé đơn</label>
                        <label><input type="radio" name="ticketKind" value="combo" onchange="toggleCombo()"> Vé combo</label>
                    </div>

                    <div id="singleTicketSection">
                        <div class="form-row">
                            <label for="typeCode">Mã loại vé <span style="color:red">*</span></label>
                            <input type="text" name="typeCode" id="typeCode" required maxlength="20" value="${fn:escapeXml(param.typeCode)}"/>
                        </div>
                        <div class="form-row">
                            <label for="typeName">Tên loại vé <span style="color:red">*</span></label>
                            <input type="text" name="typeName" id="typeName" required maxlength="100" value="${fn:escapeXml(param.typeName)}"/>
                        </div>
                        <div class="form-row">
                            <label for="basePrice">Giá vé cơ bản <span style="color:red">*</span></label>
                            <input type="number" name="basePrice" id="basePrice" min="0" step="1000" required value="${fn:escapeXml(param.basePrice)}"/>
                        </div>
                        <div class="form-row">
                            <label for="description">Mô tả</label>
                            <textarea name="description" id="description" rows="2" maxlength="255">${fn:escapeXml(param.description)}</textarea>
                        </div>
                        <div class="form-row multiselect">
                            <label for="poolIds">Áp dụng tại hồ bơi <span style="color:red">*</span></label>
                            <select name="poolIds" id="poolIds" multiple required style="height: 80px;">
                                <c:forEach items="${poolList}" var="pool">
                                    <option value="${pool.id}" <c:if test="${fn:contains(param.poolIds, pool.id)}">selected</c:if>>${pool.name}</option>
                                </c:forEach>
                            </select>
                            <span class="note">Giữ Ctrl hoặc Cmd để chọn nhiều hồ bơi</span>
                        </div>
                    </div>

                    <div id="comboTicketSection" style="display:none;" class="combo-section">
                        <div class="form-row">
                            <label for="typeCodeCombo">Mã loại vé <span style="color:red">*</span></label>
                            <input type="text" name="typeCode" id="typeCodeCombo" maxlength="20" />
                        </div>
                        <div class="form-row">
                            <label for="typeNameCombo">Tên combo <span style="color:red">*</span></label>
                            <input type="text" name="typeName" id="typeNameCombo" maxlength="100" />
                        </div>
                        <div class="form-row">
                            <label for="descriptionCombo">Mô tả</label>
                            <textarea name="description" id="descriptionCombo" rows="2" maxlength="255"></textarea>
                        </div>
                        <div class="form-row multiselect">
                            <label for="poolIdsCombo">Áp dụng tại hồ bơi <span style="color:red">*</span></label>
                            <select name="poolIds" id="poolIdsCombo" multiple style="height: 80px;">
                                <c:forEach items="${poolList}" var="pool">
                                    <option value="${pool.id}">${pool.name}</option>
                                </c:forEach>
                            </select>
                            <span class="note">Giữ Ctrl hoặc Cmd để chọn nhiều hồ bơi</span>
                        </div>
                        <div class="form-row">
                            <label>Chọn thành phần combo:</label>
                            <table class="combo-table">
                                <thead>
                                    <tr>
                                        <th>Loại vé</th>
                                        <th>Đơn giá</th>
                                        <th>Số lượng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="single" items="${singleTypes}">
                                        <tr>
                                            <td>
                                                <input type="hidden" name="comboTypeId" value="${single.id}" />
                                                <input type="hidden" name="comboPrice" value="${single.basePrice}" />
                                                ${single.name}
                                            </td>
                                            <td>${single.basePrice}</td>
                                            <td>
                                                <input type="number" min="0" value="0" name="comboQty_${single.id}" class="combo-qty" style="width:60px" onchange="updateComboPrice()"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="form-row">
                            <label>Ưu đãi (%)</label>
                            <input type="number" id="discountPercent" name="discountPercent" min="0" max="100" value="0" onchange="updateComboPrice()" />%
                        </div>
                        <div class="form-row combo-summary">
                            <label>Giá gốc:</label>
                            <span id="comboBasePrice">0</span> đ
                        </div>
                        <div class="form-row combo-summary">
                            <label>Giá sau ưu đãi:</label>
                            <span id="comboFinalPrice">0</span> đ
                            <input type="hidden" name="finalComboPrice" id="finalComboPrice" />
                        </div>
                    </div>

                    <div class="action-buttons">
                        <button type="submit" class="btn"><i class="fas fa-save"></i> Lưu</button>
                        <a href="managerTicketServlet" class="btn btn-cancel">Hủy</a>
                    </div>
                </form>
            </div>
        </div>
        <script>
            function toggleCombo() {
                var isCombo = document.querySelector('input[name="ticketKind"]:checked').value === 'combo';
                document.getElementById('singleTicketSection').style.display = isCombo ? 'none' : '';
                document.getElementById('comboTicketSection').style.display = isCombo ? '' : 'none';
            }
            function updateComboPrice() {
                var base = 0;
                document.querySelectorAll("#comboTicketSection .combo-qty").forEach(function (input) {
                    var qty = parseInt(input.value) || 0;
                    var price = parseFloat(input.closest("tr").querySelector('input[name="comboPrice"]').value);
                    base += qty * price;
                });
                document.getElementById("comboBasePrice").innerText = base.toLocaleString();
                var discount = parseFloat(document.getElementById("discountPercent").value) || 0;
                var final = base * (1 - discount / 100);
                document.getElementById("comboFinalPrice").innerText = final.toLocaleString();
                document.getElementById("finalComboPrice").value = final;
            }
            document.addEventListener("DOMContentLoaded", function () {
                document.querySelectorAll(".combo-qty, #discountPercent").forEach(function (el) {
                    el.addEventListener("change", updateComboPrice);
                    el.addEventListener("input", updateComboPrice);
                });
            });

            function toggleCombo() {
                var isCombo = document.querySelector('input[name="ticketKind"]:checked').value === 'combo';
                document.getElementById('singleTicketSection').style.display = isCombo ? 'none' : '';
                document.getElementById('comboTicketSection').style.display = isCombo ? '' : 'none';

                // Disable các field không dùng để tránh lỗi khi submit
                document.querySelectorAll('#singleTicketSection input, #singleTicketSection textarea, #singleTicketSection select').forEach(el => {
                    el.disabled = isCombo;
                });
                document.querySelectorAll('#comboTicketSection input, #comboTicketSection textarea, #comboTicketSection select').forEach(el => {
                    el.disabled = !isCombo;
                });
            }
            document.addEventListener('DOMContentLoaded', toggleCombo);


        </script>
    </body>
</html>
