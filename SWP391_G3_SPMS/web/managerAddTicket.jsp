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
    <style>
        .form-add-ticket {
            max-width: 800px;
            margin: 40px auto 0;
            padding: 32px 32px 24px 32px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 18px #0002;
        }
        .form-add-ticket .form-row {
            display: flex;
            align-items: center;
            margin-bottom: 18px;
        }
        .form-add-ticket label {
            width: 180px;
            min-width: 150px;
            flex-shrink: 0;
            font-weight: 500;
            color: #222;
            margin-right: 18px;
            text-align: right;
        }
        .form-add-ticket input,
        .form-add-ticket select,
        .form-add-ticket textarea {
            flex: 1;
            padding: 10px 12px;
            border: 1px solid #d2d2d2;
            border-radius: 5px;
            font-size: 1rem;
            background: #f9f9f9;
        }
        .form-add-ticket textarea {
            resize: vertical;
        }
        .form-add-ticket .form-row.multiselect label {
            align-self: flex-start;
            padding-top: 6px;
        }
        .form-add-ticket .form-row .note {
            color: #888;
            font-size: 0.95em;
            margin-left: 8px;
        }
        .form-add-ticket .action-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 24px;
        }
        .form-add-ticket .btn {
            padding: 8px 20px;
            border: none;
            border-radius: 5px;
            background: #007bff;
            color: #fff;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.2s;
        }
        .form-add-ticket .btn-cancel {
            background: #aaa;
        }
        .form-add-ticket .btn:hover {
            background: #0056b3;
        }
        .form-add-ticket .btn-cancel:hover {
            background: #888;
        }
        .form-add-ticket .error-message {
            color: #d00;
            font-style: italic;
            margin-bottom: 12px;
            text-align: center;
        }
        .form-add-ticket .success-message {
            color: #0a0;
            font-style: italic;
            margin-bottom: 12px;
            text-align: center;
        }

        @media (max-width: 650px) {
            .form-add-ticket .form-row {
                flex-direction: column;
                align-items: stretch;
            }
            .form-add-ticket label {
                text-align: left;
                margin-bottom: 6px;
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="layout">
    <div class="content-panel">
        <h2 style="text-align:center;">Thêm loại vé mới</h2>
        <form class="form-add-ticket" method="post" action="addTicketServlet">
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