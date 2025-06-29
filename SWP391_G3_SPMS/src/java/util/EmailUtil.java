/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

public class EmailUtil {

    public static void sendOTP(String toEmail, String otpCode, String purpose) throws MessagingException, UnsupportedEncodingException {

        final String fromEmail = "tonghung24112003ff@gmail.com";
        final String password = "uwtu xjsn tlol wubu"; // Gmail App Password

        // Nội dung email tùy theo mục đích
        String subject = "";
        String message = "";

        switch (purpose.toLowerCase()) {
            case "register":
                subject = "Mã xác thực đăng ký tài khoản";
                message = "Chào bạn,\n\n"
                        + "Cảm ơn bạn đã đăng ký tài khoản.\n"
                        + "Mã xác thực (OTP) của bạn là: " + otpCode + "\n\n"
                        + "Vui lòng nhập mã này trong vòng 2 phút để hoàn tất đăng ký.\n\n"
                        + "Trân trọng,\nĐội ngũ hỗ trợ";
                break;

            case "reset":
            case "reset-password":
                subject = "Mã OTP đặt lại mật khẩu";
                message = "Chào bạn,\n\n"
                        + "Bạn đã yêu cầu đặt lại mật khẩu.\n"
                        + "Mã OTP của bạn là: " + otpCode + "\n\n"
                        + "Vui lòng nhập mã này trong vòng 2 phút để tiếp tục.\n\n"
                        + "Trân trọng,\nĐội ngũ hỗ trợ";
                break;

            default:
                throw new IllegalArgumentException("Mục đích gửi email không hợp lệ: " + purpose);
        }

        // Thiết lập cấu hình gửi mail
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        // Tạo và gửi email
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(fromEmail));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
        msg.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));

        msg.setContent(message, "text/plain; charset=UTF-8");

        Transport.send(msg);
    }
}
