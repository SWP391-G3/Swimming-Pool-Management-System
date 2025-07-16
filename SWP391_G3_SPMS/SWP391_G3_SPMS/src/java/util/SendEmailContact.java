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
}
