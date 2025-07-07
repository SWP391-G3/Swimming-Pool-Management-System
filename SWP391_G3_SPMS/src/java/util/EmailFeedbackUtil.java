/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/**
 *
 * @author Tuan Anh
 */
public class EmailFeedbackUtil {
    
     // Cấu hình email server (Gmail example)
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String ADMIN_EMAIL = "he186568nguyentuananh@gmail.com"; // Email của bạn
    private static final String ADMIN_PASSWORD = "wktz hygn xpft vgkm"; // App password của Gmail
    
    private static String lastError = "";
    
    public static boolean sendEmail(String toEmail, String subject, String content) {
        try {
            Properties properties = new Properties();
            properties.put("mail.smtp.host", SMTP_HOST);
            properties.put("mail.smtp.port", SMTP_PORT);
            properties.put("mail.smtp.auth", "true"); // phải đăng nhập
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
            
            Session session = Session.getInstance(properties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(ADMIN_EMAIL, ADMIN_PASSWORD);
                }
            });
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(ADMIN_EMAIL));  // người gửi
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));  // người nhận 
            message.setSubject(jakarta.mail.internet.MimeUtility.encodeText(subject, "UTF-8", "B")); // Tiêu đề
            message.setContent(content, "text/html; charset=utf-8");
            
            Transport.send(message);  // gửi mail
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            lastError = e.getClass().getName() + ": " + e.getMessage();
            return false;
        }
    }
    
    // Hàm lấy lỗi gần nhất (dùng cho debug)
    public static String getLastError() {
        return lastError;
    }
    
    public static String createResponseTemplate(String customerName, String poolName, 
                                               String originalComment, String adminResponse) {
        return "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>"
                + "<h2 style='color: #2c5aa0;'>Phản hồi từ Hệ thống Quản lý Hồ bơi</h2>"
                + "<p>Xin chào <strong>" + customerName + "</strong>,</p>"
                + "<p>Chúng tôi đã nhận được phản hồi của bạn về <strong>" + poolName + "</strong>.</p>"
                + "<div style='background-color: #f5f5f5; padding: 15px; border-left: 4px solid #2c5aa0; margin: 20px 0;'>"
                + "<h4>Phản hồi gốc của bạn:</h4>"
                + "<p style='font-style: italic;'>" + originalComment + "</p>"
                + "</div>"
                + "<div style='background-color: #e8f4f8; padding: 15px; border-radius: 5px; margin: 20px 0;'>"
                + "<h4>Phản hồi từ chúng tôi:</h4>"
                + "<p>" + adminResponse + "</p>"
                + "</div>"
                + "<p>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!</p>"
                + "<p style='color: #666; font-size: 14px; margin-top: 30px;'>"
                + "Đây là email do Tuấn Anh làm, vui lòng không trả lời email này.<br>"
                + "Nếu bạn có thắc mắc, vui lòng liên hệ hotline: hẹ hẹ"
                + "</p>"
                + "</div>";
    }
    
    
    
    
}
