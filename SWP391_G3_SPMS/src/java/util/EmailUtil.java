/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    public static void sendOTP(String toEmail, String otpCode) throws MessagingException {
        final String fromEmail = "tonghung24112003ff@gmail.com";
        final String password = "uwtu xjsn tlol wubu"; // App Password, không dùng password thật

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

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(fromEmail));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
        msg.setSubject("Your OTP Code for Password Reset");
        msg.setText("Dear user,\n\n"
                + "You have requested to reset your password.\n"
                + "Here is your OTP code: " + otpCode + "\n\n"
                + "Please enter this code within 2 minutes to proceed.\n\n"
                + "Best regards,\nSupport Team");

        Transport.send(msg);
    }
}
