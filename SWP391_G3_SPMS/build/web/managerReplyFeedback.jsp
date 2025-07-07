<%-- 
    Document   : managerReplyFeedback
    Created on : Jul 7, 2025, 10:27:54 PM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Phản hồi khách hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }

            .reply-container {
                background: white;
                border-radius: 15px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.1);
                overflow: hidden;
                width: 100%;
                max-width: 800px;
            }

            .header {
                background: linear-gradient(45deg, #2c5aa0, #3d7bd8);
                color: white;
                padding: 20px 30px;
                text-align: center;
            }

            .header h2 {
                margin-bottom: 10px;
                font-size: 1.8em;
            }

            .header p {
                opacity: 0.9;
                font-size: 0.95em;
            }

            .content {
                padding: 30px;
            }

            .feedback-info {
                background: #f8f9fa;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 25px;
                border-left: 4px solid #2c5aa0;
            }

            .feedback-info h3 {
                color: #2c5aa0;
                margin-bottom: 15px;
                font-size: 1.2em;
            }

            .info-row {
                display: flex;
                margin-bottom: 10px;
                align-items: center;
            }

            .info-label {
                font-weight: 600;
                color: #555;
                width: 120px;
                flex-shrink: 0;
            }

            .info-value {
                color: #333;
                flex: 1;
            }

            .star-rating {
                color: #ffc107;
            }

            .original-comment {
                background: #e8f4f8;
                border-radius: 8px;
                padding: 15px;
                margin-top: 10px;
                font-style: italic;
                border-left: 3px solid #17a2b8;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #333;
            }

            .form-group input,
            .form-group textarea {
                width: 100%;
                padding: 12px;
                border: 2px solid #e1e5e9;
                border-radius: 8px;
                font-size: 14px;
                transition: border-color 0.3s ease;
            }

            .form-group input:focus,
            .form-group textarea:focus {
                outline: none;
                border-color: #2c5aa0;
                box-shadow: 0 0 0 3px rgba(44, 90, 160, 0.1);
            }

            .form-group textarea {
                resize: vertical;
                min-height: 150px;
            }

            .button-group {
                display: flex;
                gap: 15px;
                justify-content: flex-end;
                margin-top: 30px;
            }

            .btn {
                padding: 12px 25px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-primary {
                background: linear-gradient(45deg, #2c5aa0, #3d7bd8);
                color: white;
            }

            .btn-primary:hover {
                background: linear-gradient(45deg, #1e3f73, #2c5aa0);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(44, 90, 160, 0.3);
            }

            .btn-secondary {
                background: #6c757d;
                color: white;
            }

            .btn-secondary:hover {
                background: #545b62;
                transform: translateY(-2px);
            }

            .required {
                color: #dc3545;
            }

            @media (max-width: 768px) {
                .reply-container {
                    margin: 10px;
                }

                .content {
                    padding: 20px;
                }

                .button-group {
                    flex-direction: column;
                }

                .btn {
                    justify-content: center;
                }
            }
        </style>
        
        <c:if test="${not empty errorMsg}">
  <div style="background:#ffe0e0;color:#b10000;padding:12px 18px;margin-bottom:18px;
              border:1px solid #ff8e8e;border-radius:8px;font-weight:bold;">
    <i class="fas fa-exclamation-triangle"></i> ${errorMsg}
  </div>
</c:if>
        
    </head>
    <body>
        <div class="reply-container">
            <div class="header">
                <h2><i class="fas fa-reply"></i> Phản hồi khách hàng</h2>
                <p>Gửi phản hồi cho khách hàng về đánh giá của họ</p>
            </div>

            <div class="content">
                <div class="feedback-info">
                    <h3><i class="fas fa-info-circle"></i> Thông tin phản hồi</h3>
                    <div class="info-row">
                        <span class="info-label">Khách hàng:</span>
                        <span class="info-value">${feedback.userName}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Email:</span>
                        <span class="info-value">${feedback.userEmail}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Hồ bơi:</span>
                        <span class="info-value">${feedback.poolName}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Đánh giá:</span>
                        <span class="info-value">
                            <span class="star-rating">
                                <c:forEach begin="1" end="5" var="star">
                                    <i class="fas fa-star ${star <= feedback.rating ? 'active' : ''}"></i>
                                </c:forEach>
                            </span>
                            (${feedback.rating}/5)
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Ngày tạo:</span>
                        <span class="info-value">
                            <fmt:formatDate value="${feedback.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                        </span>
                    </div>
                    <div class="original-comment">
                        <strong>Nội dung phản hồi gốc:</strong><br>
                        ${feedback.comment}
                    </div>
                </div>

                <form method="post" action="managerReplyFeedbackServlet" id="replyForm">
                    <input type="hidden" name="feedbackId" value="${feedback.feedbackId}">

                    <div class="form-group">
                        <label for="subject">
                            <i class="fas fa-envelope"></i> Tiêu đề email <span class="required">*</span>
                        </label>
                        <input type="text" id="subject" name="subject" required maxlength="200"
                               placeholder="Nhập tiêu đề email..."
                               value="Phản hồi về đánh giá của bạn tại ${feedback.poolName}">
                    </div>

                    <div class="form-group">
                        <label for="responseContent">
                            <i class="fas fa-comment"></i> Nội dung phản hồi <span class="required">*</span>
                        </label>
                        <textarea id="responseContent" name="responseContent" required maxlength="2000"
                                  placeholder="Nhập nội dung phản hồi của bạn..."></textarea>
                    </div>

                    <div class="button-group">
                        <a href="managerFeedbackServlet?${returnParams}" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i> Gửi phản hồi
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            document.getElementById('replyForm').addEventListener('submit', function (e) {
                const subject = document.getElementById('subject').value.trim();
                const content = document.getElementById('responseContent').value.trim();

                if (!subject || !content) {
                    alert('Vui lòng điền đầy đủ thông tin!');
                    e.preventDefault();
                    return;
                }

                if (subject.length > 200) {
                    alert('Tiêu đề không được vượt quá 200 ký tự!');
                    e.preventDefault();
                    return;
                }

                if (content.length > 2000) {
                    alert('Nội dung phản hồi không được vượt quá 2000 ký tự!');
                    e.preventDefault();
                    return;
                }

                if (!confirm('Bạn có chắc chắn muốn gửi phản hồi này?')) {
                    e.preventDefault();
                    return;
                }
            });

            // Character counter
            const textarea = document.getElementById('responseContent');
            const counter = document.createElement('div');
            counter.style.cssText = 'text-align: right; font-size: 12px; color: #666; margin-top: 5px;';
            textarea.parentNode.appendChild(counter);

            function updateCounter() {
                const remaining = 2000 - textarea.value.length;
                counter.textContent = remaining + ' ký tự còn lại';
                counter.style.color = remaining < 100 ? '#dc3545' : '#666';
            }

            textarea.addEventListener('input', updateCounter);
            updateCounter();
        </script>
    </body>
</html> 
