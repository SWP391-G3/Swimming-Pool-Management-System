/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

import jakarta.activation.DataHandler;
import jakarta.activation.DataSource;
import jakarta.mail.util.ByteArrayDataSource;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import javax.imageio.ImageIO;
import com.google.zxing.*;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.common.BitMatrix;

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

    // Phương thức gửi mail vé kèm QR code
    public static void sendBookingConfirmation(String toEmail,String customerName,String bookingId,String bookingDate,String ticketInfo) throws MessagingException, UnsupportedEncodingException, Exception {
        final String fromEmail = "tonghung24112003ff@gmail.com";
        final String password = "uwtu xjsn tlol wubu"; // Gmail App Password

        String subject = "Xác nhận đặt vé #" + bookingId;
        String message = "Xin chào " + customerName + ",\n\n"
                + "Cảm ơn bạn đã đặt vé với chúng tôi!\n\n"
                + "Thông tin vé:\n"
                + ticketInfo + "\n\n"
                + "Booking ID: " + bookingId + "\n"
                + "Ngày đặt: " + bookingDate + "\n\n"
                + "Vui lòng dùng mã QR đính kèm để check-in.\n\n"
                + "Trân trọng,\nĐội ngũ hỗ trợ";

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

        // Tạo QR code bookingId
        MimeBodyPart textPart = new MimeBodyPart();
        textPart.setText(message);

        MimeBodyPart qrPart = new MimeBodyPart();
        byte[] qrBytes = generateQRCodeImage(bookingId);
        DataSource source = new ByteArrayDataSource(qrBytes, "image/png");
        qrPart.setDataHandler(new DataHandler(source));
        qrPart.setFileName("booking_qr.png");

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(textPart);
        multipart.addBodyPart(qrPart);

        // Tạo và gửi email
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(fromEmail));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
        msg.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
        msg.setContent(multipart);

        Transport.send(msg);
    }

    // Hàm tạo QR code PNG từ bookingId
    private static byte[] generateQRCodeImage(String bookingId) throws Exception {
        int width = 300;
        int height = 300;
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(bookingId, BarcodeFormat.QR_CODE, width, height);

        BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                bufferedImage.setRGB(x, y, bitMatrix.get(x, y) ? 0xFF000000 : 0xFFFFFFFF);
            }
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(bufferedImage, "png", baos);
        return baos.toByteArray();
    }
}
