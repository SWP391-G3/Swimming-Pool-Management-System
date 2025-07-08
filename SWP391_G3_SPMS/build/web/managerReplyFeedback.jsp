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
        <link rel="stylesheet" href="./manager-css/managerReplyFeedback-v1.css">
        
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
