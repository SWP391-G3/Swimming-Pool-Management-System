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
 * @author Lenovo
 */
public class SendEmailContact {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String ADMIN_EMAIL = "he186445caosyhuy@gmail.com";
    private static final String ADMIN_PASSWORD = "sowa hrvb vhyc qkqb";

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
            throw new RuntimeException(e.getMessage());
        }
    }

    public static String sendEmailContactTemplate(String reason) {
        return """
        <!DOCTYPE html>
        <html lang=\\"vi\\">
        <head>
            <meta charset=\\"UTF-8\\">
            <title>Phản hồi liên hệ - Hệ thống quản lý hồ bơi</title>
        </head>
        <body style=\\"font-family: 'Segoe UI', sans-serif; background-color: #f2f6fc; padding: 0; margin: 0;\\">
            <div style=\\"max-width: 600px; margin: 30px auto; background-color: #ffffff; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); overflow: hidden;\\">
                <div style=\\"background: linear-gradient(90deg, #0ea5e9, #38bdf8); color: white; padding: 20px; text-align: center;\\">
                    <h2 style=\\"margin: 0;\\">Hệ thống quản lý hồ bơi</h2>
                    <p style=\\"margin: 0; font-size: 14px;\\">Cảm ơn bạn đã liên hệ với chúng tôi!</p>
                </div>
                <div style=\\"padding: 30px;\\">
                    <h3 style=\\"color: #0ea5e9;\\">📩 Phản hồi từ hệ thống</h3>
                    <p>Xin chào quý khách,</p>
                    <p>Chúng tôi đã nhận được yêu cầu liên hệ từ bạn. Nội dung phản hồi của chúng tôi như sau:</p>
                    <div style=\\"background-color: #f0f9ff; border-left: 4px solid #0ea5e9; padding: 15px; margin: 20px 0; border-radius: 4px;\\">
    """ + "<p style=\\\"margin: 0; font-size: 15px;\\\">" + reason + "</p>" + """
                    </div>
                    <p>Nếu bạn có thêm bất kỳ câu hỏi nào, đừng ngần ngại liên hệ lại. Chúng tôi luôn sẵn sàng hỗ trợ bạn!</p>
                    <p style=\\"margin-top: 30px;\\">Trân trọng,<br><strong>Đội ngũ hỗ trợ hồ bơi</strong></p>
                </div>
                <div style=\\"background-color: #e0f2fe; padding: 15px; text-align: center; font-size: 13px; color: #0369a1;\\">
                    &copy; 2025 Hệ thống quản lý hồ bơi. Mọi quyền được bảo lưu.
                </div>
            </div>
        </body>
        </html>
    """;
    }
}
