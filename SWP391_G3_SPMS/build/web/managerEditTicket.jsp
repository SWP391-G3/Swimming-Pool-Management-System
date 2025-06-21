<%-- 
    Document   : managerEditTicket
    Created on : Jun 21, 2025, 9:58:07 PM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật loại vé</title>
        <link rel="stylesheet" href="./manager-css/managerEditTicket-v1.css">
    </head>
    <body>
        <div class="form-add-ticket">
            <h2 style="text-align:center; margin-bottom:20px;">Cập nhật loại vé</h2>
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            <form method="post" action="managerEditTicket">
                <input type="hidden" name="id" value="${ticket.id}" />
                <input type="hidden" name="page" value="${param.page != null ? param.page : page}" />
                <input type="hidden" name="pageSize" value="${param.pageSize != null ? param.pageSize : pageSize}" />
                <input type="hidden" name="keyword" value="${param.keyword != null ? fn:escapeXml(param.keyword) : fn:escapeXml(keyword)}" />
                <input type="hidden" name="status" value="${param.status != null ? fn:escapeXml(param.status) : fn:escapeXml(status)}" />
                <input type="hidden" name="poolId" value="${param.poolId != null ? fn:escapeXml(param.poolId) : fn:escapeXml(poolId)}" />



                <div class="form-row">
                    <label>Mã loại vé:</label>
                    <input type="text" name="typeCode" required value="${ticket.code}" readonly />
                </div>
                <div class="form-row">
                    <label>Tên loại vé:<span class="note">*</span></label>
                    <input type="text" name="typeName" required value="${ticket.name}">
                </div>
                <div class="form-row">
                    <label>Giá vé:<span class="note">*</span></label>
                    <input type="number" name="basePrice" required min="0" value="${ticket.basePrice}">
                </div>
                <div class="form-row">
                    <label>Mô tả:</label>
                    <textarea name="description" rows="2">${ticket.description}</textarea>
                </div>
                <div class="form-row">
                    <label for="isCombo">Có phải vé combo?</label>
                    <select name="isCombo" id="isCombo">
                        <option value="0" <c:if test="${not ticket.isCombo}">selected</c:if>>Không</option>
                        <option value="1" <c:if test="${ticket.isCombo}">selected</c:if>>Có</option>
                        </select>
                    </div>

                    <div class="form-row multiselect">
                        <label for="poolIds">Áp dụng tại hồ bơi:<span class="note">*</span></label>
                        <select name="poolIds" id="poolIds" multiple required style="height: 90px;">
                        <c:forEach items="${poolList}" var="pool">
                            <c:choose>

                                <c:when test="${not empty param.poolIds}">
                                    <option value="${pool.id}" <c:if test="${fn:contains(param.poolIds, pool.id)}">selected</c:if>>${pool.name}</option>
                                </c:when>

                                <c:otherwise>
                                    <option value="${pool.id}" <c:if test="${fn:contains(poolIdsString, pool.id)}">selected</c:if>>${pool.name}</option>
                                </c:otherwise>
                            </c:choose>
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
    </body>
</html>