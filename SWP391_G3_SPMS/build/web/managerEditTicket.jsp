<%-- 
    Document   : managerEditTicket
    Created on : Jun 21, 2025, 9:58:07 PM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật loại vé</title>
        <link rel="stylesheet" href="./manager-css/managerEditTicket-v1.css">
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

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        <c:if test="${not empty stacktrace}">
            <pre style="color:red; background:#fce4e4; padding:10px; border-radius:4px; font-size:13px;">${stacktrace}</pre>
        </c:if>

        <div class="form-add-ticket">
            <h2 style="text-align:center; margin-bottom:20px;">Cập nhật loại vé</h2>
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            <form method="post" action="managerEditTicket" id="editTicketForm">
                <input type="hidden" name="id" value="${ticket.id}" />
                <input type="hidden" name="page" value="${param.page != null ? param.page : page}" />
                <input type="hidden" name="pageSize" value="${param.pageSize != null ? param.pageSize : pageSize}" />
                <input type="hidden" name="keyword" value="${param.keyword != null ? fn:escapeXml(param.keyword) : fn:escapeXml(keyword)}" />
                <input type="hidden" name="status" value="${param.status != null ? fn:escapeXml(param.status) : fn:escapeXml(status)}" />
                <input type="hidden" name="poolId" value="${param.poolId != null ? fn:escapeXml(param.poolId) : fn:escapeXml(poolId)}" />

                <div class="form-row">
                    <label>Loại vé:</label>
                    <span>
                        <c:choose>
                            <c:when test="${ticket.isCombo}">
                                <b>Combo</b>
                                <input type="hidden" name="isCombo" value="1" />
                            </c:when>
                            <c:otherwise>
                                <b>Đơn</b>
                                <input type="hidden" name="isCombo" value="0" />
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <div class="form-row">
                    <label>Mã loại vé:</label>
                    <input type="text" name="typeCode" required value="${ticket.code}" readonly />
                </div>
                <div class="form-row">
                    <label>Tên loại vé:<span class="note">*</span></label>
                    <input type="text" name="typeName" required value="${ticket.name}">
                </div>

                <div class="form-row">
                    <label>Mô tả:</label>
                    <textarea name="description" rows="2">${ticket.description}</textarea>
                </div>

                <c:if test="${!ticket.isCombo}">
                    <!-- Vé đơn -->
                    <div class="form-row">
                        <label>Giá vé:<span class="note">*</span></label>
                        <input type="number" name="basePrice" required min="0" value="${ticket.basePrice}">
                    </div>
                </c:if>

                <c:if test="${ticket.isCombo}">
                    <!-- Vé combo -->
                    <div class="combo-section">
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
                                                <input type="number" min="0" value="${comboDetail[single.id] != null ? comboDetail[single.id] : 0}" name="comboQty_${single.id}" class="combo-qty" style="width:60px" onchange="updateComboPrice()"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="form-row">
                            <label>Ưu đãi (%)</label>
                            <input type="number" id="discountPercent" name="discountPercent" min="0" max="100" value="${ticket.discountPercent != null ? ticket.discountPercent : 0}" onchange="updateComboPrice()" />
                        </div>
                        <div class="form-row combo-summary">
                            <label>Giá gốc:</label>
                            <span id="comboBasePrice">0</span> đ
                        </div>
                        <div class="form-row combo-summary">
                            <label>Giá sau ưu đãi:</label>
                            <span id="comboFinalPrice">0</span> đ
                            <input type="hidden" name="finalComboPrice" id="finalComboPrice" value="${ticket.basePrice}" />
                        </div>
                    </div>
                </c:if>

                <div class="form-row multiselect">
                    <label for="poolIds">Áp dụng tại hồ bơi:<span class="note">*</span></label>
                    <select name="poolIds" id="poolIds" multiple required style="height: 90px;">
                        <c:forEach items="${poolList}" var="pool">
                            <option value="${pool.id}" <c:if test="${fn:contains(poolIdsString, pool.id)}">selected</c:if>>${pool.name}</option>
                        </c:forEach>
                    </select>
                    <span class="note" style="margin-left:12px;">Giữ Ctrl (Windows) hoặc Cmd (Mac) để chọn nhiều hồ bơi</span>
                </div>
                <div class="form-row">
                    <label>Trạng thái:</label>
                    <select name="statusF">
                        <option value="active" <c:if test="${ticket.active}">selected</c:if>>Đang bán</option>
                        <option value="inactive" <c:if test="${!ticket.active}">selected</c:if>>Ngừng bán</option>
                        </select>
                    </div>
                    <div class="action-buttons">
                        <button type="submit" class="btn">Lưu thay đổi</button>
                        <a href="managerTicketServlet?page=${param.page != null ? param.page : page}&pageSize=${param.pageSize != null ? param.pageSize : pageSize}&keyword=${param.keyword != null ? fn:escapeXml(param.keyword) : fn:escapeXml(keyword)}&status=${param.status != null ? fn:escapeXml(param.status) : fn:escapeXml(status)}&poolId=${param.poolId != null ? fn:escapeXml(param.poolId) : fn:escapeXml(poolId)}" class="btn btn-cancel">Hủy</a>
                </div>
            </form>
        </div>

        <script>
            function updateComboPrice() {
                var base = 0;
                document.querySelectorAll(".combo-qty").forEach(function (input) {
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
                if (document.querySelector(".combo-qty"))
                    updateComboPrice();
                document.querySelectorAll(".combo-qty, #discountPercent").forEach(function (el) {
                    el.addEventListener("change", updateComboPrice);
                    el.addEventListener("input", updateComboPrice);
                });
            });
        </script>
    </body>
</html>