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
        <link rel="stylesheet" href="./manager-css/managerAddTicket.css">
    </head>
    <body>
        <div class="layout">
            <div class="content-panel">
                
                <h2 style="text-align:center;">Thêm loại vé mới</h2>
                <form class="form-add-ticket" method="post" action="managerAddTicket">
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
                        <label for="typeCode">Mã loại vé <span style="color:red">*</span></label>
                        <input type="text" name="typeCode" id="typeCode" required maxlength="20" value="${fn:escapeXml(param.typeCode)}"/>
                    </div>
                    <div class="form-row">
                        <label for="typeName">Tên loại vé <span style="color:red">*</span></label>
                        <input type="text" name="typeName" id="typeName" required maxlength="100" value="${fn:escapeXml(param.typeName)}"/>
                    </div>
                    <div class="form-row">
                        <label for="description">Mô tả</label>
                        <textarea name="description" id="description" rows="2" maxlength="255">${fn:escapeXml(param.description)}</textarea>
                    </div>
                    <div class="form-row">
                        <label for="basePrice">Giá vé cơ bản <span style="color:red">*</span></label>
                        <input type="number" name="basePrice" id="basePrice" min="0" step="1000" required value="${fn:escapeXml(param.basePrice)}"/>
                    </div>
                    <div class="form-row">
                        <label for="isCombo">Có phải vé combo?</label>
                        <select name="isCombo" id="isCombo">
                            <option value="0" ${param.isCombo == "0" ? "selected" : ""}>Không</option>
                            <option value="1" ${param.isCombo == "1" ? "selected" : ""}>Có</option>
                        </select>
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
                    <div class="action-buttons">
                        <button type="submit" class="btn"><i class="fas fa-save"></i> Lưu</button>
                        <a href="managerTicketServlet" class="btn btn-cancel">Hủy</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>

