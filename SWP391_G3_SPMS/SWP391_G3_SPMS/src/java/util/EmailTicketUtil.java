/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import jakarta.activation.DataHandler;
import jakarta.activation.DataSource;
import jakarta.mail.util.ByteArrayDataSource;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.UnsupportedEncodingException;
import javax.imageio.ImageIO;
import com.google.zxing.*;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.common.BitMatrix;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Properties;
import model.customer.*;
import java.util.*;
import java.math.BigDecimal;

/**
 *
 * @author LAZYVL
 */
public class EmailTicketUtil {

    // Cấu hình email server (Gmail example)
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String ADMIN_EMAIL = "tonghung24112003ff@gmail.com";
    private static final String ADMIN_PASSWORD = "uwtu xjsn tlol wubu"; // Gmail App Password
    private static String lastError = "";

    // Phương thức gửi mail vé kèm QR code
    public static boolean sendEmail(String toEmail, String subject, String htmlContent, String bookingId) throws MessagingException, UnsupportedEncodingException, Exception {
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

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(ADMIN_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));

            // Create multipart/related for HTML + inline image
            MimeMultipart multipart = new MimeMultipart("related");

            // Part 1: HTML
            MimeBodyPart htmlPart = new MimeBodyPart();
            // Chèn img vào HTML
            String htmlWithQR = htmlContent
                    + "<div style='text-align:center;margin:32px 0;'><strong>Mã QR Checkin:</strong><br>"
                    + "<img src='cid:qrCode' style='margin:12px auto;width:180px;height:180px;'/></div>";
            htmlPart.setContent(htmlWithQR, "text/html; charset=utf-8");
            multipart.addBodyPart(htmlPart);

            // Part 2: QR image
            MimeBodyPart imagePart = new MimeBodyPart();
            byte[] qrBytes = generateQRCodeImage(bookingId);
            DataSource fds = new ByteArrayDataSource(qrBytes, "image/png");
            imagePart.setDataHandler(new DataHandler(fds));
            imagePart.setHeader("Content-ID", "<qrCode>");
            imagePart.setFileName("qrcode.png");
            multipart.addBodyPart(imagePart);

            message.setContent(multipart);
            
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

    public static String createResponseTemplate(BookingPageData pageData, HttpServletRequest request, HttpServletResponse response) {
        User user = pageData.getUser();
        Pool pool = pageData.getPool();
        List<TicketSelection> selectedTickets = pageData.getSelectedTickets();
        List<PoolServiceSelection> selectedRents = pageData.getSelectedRents();
        Discounts selectedDiscount = pageData.getSelectedDiscount();
        String bookingDate = pageData.getBookingDate() != null ? pageData.getBookingDate().toString() : "";
        String startTime = pageData.getStartTime() != null ? pageData.getStartTime().toString().substring(0, 5) : "";
        String endTime = pageData.getEndTime() != null ? pageData.getEndTime().toString().substring(0, 5) : "";
        int slotCount = pageData.getSlotCount();

        BigDecimal total = pageData.getFinalAmount();
        BigDecimal discountAmount = pageData.getDiscountAmount();
        BigDecimal finalAmount = pageData.getFinalAmount();

        return "<div style='font-family: Arial, sans-serif; max-width: 700px; margin: 0 auto; background: #fff; border: 1px solid #e5e7eb; border-radius: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); padding: 32px;'>"
                + "<h2 style='color: #2c5aa0; margin-bottom: 16px;'>Đặt vé thành công!</h2>"
                + "<p>Xin chào <strong>" + user.getFull_name() + "</strong>,</p>"
                + "<p>Bạn đã đặt vé thành công tại <strong>" + pool.getPool_name() + "</strong>.</p>"
                + "<div style='background-color: #f5f5f5; padding: 15px; border-left: 4px solid #2c5aa0; margin: 20px 0; border-radius: 8px;'>"
                + "<h4 style='margin-bottom: 8px;'>Thông tin người đặt</h4>"
                + "<div><strong>Họ và tên:</strong> " + user.getFull_name() + "</div>"
                + "<div><strong>Số điện thoại:</strong> " + (user.getPhone() != null ? user.getPhone() : "") + "</div>"
                + "<div><strong>Địa chỉ:</strong> " + user.getAddress()+ "</div>"
                + "</div>"
                + "<div style='background-color: #e8f4f8; padding: 15px; border-radius: 8px; margin: 20px 0;'>"
                + "<h4 style='margin-bottom: 8px;'>Thông tin bể bơi</h4>"
                + "<div><strong>Tên bể:</strong> " + pool.getPool_name() + "</div>"
                + "<div><strong>Thời gian:</strong> " + startTime + " – " + endTime + " (" + bookingDate + ")</div>"
                + "<div><strong>Địa điểm bể:</strong> " + pool.getPool_road() + ", " + pool.getPool_address() + "</div>"
                + "<div><strong>Số lượng slot:</strong> " + slotCount + "</div>"
                + "</div>"
                + "<div style='margin: 24px 0 16px 0;'>"
                + "<h4 style='margin-bottom: 8px;'>Chi tiết đơn hàng</h4>"
                + "<table style='width: 100%; font-size: 14px; border-collapse: collapse;'>"
                + "<thead>"
                + "<tr style='color: #888; border-bottom: 1px solid #e5e7eb;'>"
                + "<th style='text-align: left; padding: 8px;'>Sản phẩm</th>"
                + "<th style='text-align: center; padding: 8px;'>Số lượng</th>"
                + "<th style='text-align: right; padding: 8px;'>Thành tiền</th>"
                + "</tr>"
                + "</thead>"
                + "<tbody>"
                + // Vé bơi
                (selectedTickets != null
                        ? selectedTickets.stream().map(t
                                -> "<tr>"
                + "<td style='padding: 8px;'>" + t.getTypeName() + "</td>"
                + "<td style='padding: 8px; text-align: center;'>x" + t.getQuantity() + "</td>"
                + "<td style='padding: 8px; text-align: right;'>"
                + String.format("%,d", t.getPrice().intValue() * t.getQuantity()) + " đ</td>"
                + "</tr>"
                        ).reduce("", String::concat)
                        : "")
                + // Dịch vụ thuê
                (selectedRents != null
                        ? selectedRents.stream().map(r
                                -> "<tr>"
                + "<td style='padding: 8px;'>" + r.getServiceName() + "</td>"
                + "<td style='padding: 8px; text-align: center;'>x" + r.getQuantity() + "</td>"
                + "<td style='padding: 8px; text-align: right;'>"
                + String.format("%,d", r.getPrice().intValue() * r.getQuantity()) + " đ</td>"
                + "</tr>"
                        ).reduce("", String::concat)
                        : "")
                + "</tbody>"
                + "</table>"
                + "</div>"
                + "<div style='margin: 24px 0 8px 0; border-bottom: 1px solid #e5e7eb;'></div>"
                + "<div style='font-size: 16px; display: flex; justify-content: space-between; margin-bottom: 8px;'>"
                + "<span style='font-weight: 500;'>Tổng </span>"
                + "<span style='font-weight: 600; color: #333;'>" + String.format("%,.0f đ", total) + "</span>"
                + "</div>"
                + "<div style='font-size: 16px; display: flex; justify-content: space-between; margin-bottom: 8px;'>"
                + "<span style='font-weight: 500;'>Ưu đãi </span>"
                + (selectedDiscount != null && discountAmount != null
                        ? "<span style='color: #198754; font-weight: 600;'>(" + selectedDiscount.getDiscountCode() + ") -" + String.format("%,.0f đ", discountAmount) + "</span>"
                        : "<span style='color: #888; font-size: 14px;'>Không áp dụng ưu đãi</span>")
                + "</div>"
                + "<div style='font-size: 22px; font-weight: bold; color: #2563eb; display: flex; justify-content: space-between; margin-top: 8px;'>"
                + "<span>Tổng tiền </span>"
                + "<span>" + String.format("%,.0f đ", finalAmount) + "</span>"
                + "</div>"
                + "<p style='margin-top: 32px;'>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!</p>"
                + "<p style='color: #666; font-size: 14px; margin-top: 18px;'>"
                + "Vui lòng không trả lời email này.<br>"
                + "Nếu bạn có thắc mắc, vui lòng liên hệ qua website."
                + "</p>"
                + "</div>";
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
