package com.vnpay.common;

import com.google.gson.JsonObject;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import dao.customer.*;
import jakarta.servlet.http.HttpSession;
import model.customer.*;
import util.EmailTicketUtil;

@WebServlet(name = "VNPayReturnServlet", urlPatterns = {"/vnpayreturn"})
public class VNPayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Lấy param và build map để check chữ ký
        Map<String, String> fields = new HashMap<>();
        Enumeration<String> params = request.getParameterNames();
        while (params.hasMoreElements()) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, URLEncoder.encode(fieldValue, "UTF-8"));
            }
        }
        fields.remove("vnp_SecureHashType");
        fields.remove("vnp_SecureHash");

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        String hashData = buildHashString(fields);
        String signValue = Config.hmacSHA512(Config.secretKey, hashData);

        boolean checkSignature = signValue.equals(vnp_SecureHash);

        // Lấy các param cần thiết để hiển thị
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String vnp_BankCode = request.getParameter("vnp_BankCode");
        String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
        String vnp_PayDate = request.getParameter("vnp_PayDate");
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_Amount = request.getParameter("vnp_Amount");

        // bookingId là vnp_TxnRef
        int bookingId = 0;
        try {
            bookingId = Integer.parseInt(vnp_TxnRef);
        } catch (Exception e) {
        }

        // Truy vấn thêm thông tin booking nếu cần (ví dụ bookingDate)
        String bookingDate = "";
        BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
        PaymentDAO paymentDAO = new PaymentDAO();
        try {
            BookingDetails bookingDetail = bookingDetailDAO.getBookingDetailById(bookingId);
            if (bookingDetail != null) {
                bookingDate = bookingDetail.getBookingDate().toString();
            }
        } catch (Exception e) {
            bookingDate = "";
        }

        boolean paymentSuccess = false;
        String errorMessage = "Payment failed";

        if (checkSignature) {
            if ("00".equals(vnp_ResponseCode)) {
                try {
                    if (bookingId > 0) {
                        bookingDetailDAO.updateStatusToPaid(bookingId);
                        paymentDAO.updateTransactionReference(bookingId, String.valueOf(bookingId));
                        paymentDAO.updatePaymentStatus(bookingId, "completed");
                        paymentSuccess = true;
                        errorMessage = "";

                        // Lấy lại dữ liệu từ session
                        BookingPageData pageData = (BookingPageData) session.getAttribute("bookingPageData");
                        String htmlContent = EmailTicketUtil.createResponseTemplate(pageData, request, response);
                        User user = (User) session.getAttribute("customerAccount");
                        String email = (user != null) ? user.getEmail() : "";
                        String customerName = (user != null) ? user.getFull_name() : "";

                        if (pageData != null) {
                            try {
                                boolean emailSent = EmailTicketUtil.sendEmail(email,"Xác nhận đặt vé",htmlContent,bookingId + "");
                                // Xóa khỏi session sau khi gửi mail
                                session.removeAttribute("bookingPageData");
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }
                        } else {
                            errorMessage = "Dữ liệu booking đã hết hạn. Vui lòng thực hiện lại giao dịch.";
                        }
                    } else {
                        errorMessage = "Cannot find booking information!";
                    }
                } catch (Exception e) {
                    errorMessage = "An error occurred while updating booking status.";
                }
            } else {
                errorMessage = getResponseCodeMessage(vnp_ResponseCode);
            }
        } else {
            errorMessage = "Invalid signature from payment gateway!";
        }

        // Định dạng lại số tiền về VND
        String amount = "";
        try {
            if (vnp_Amount != null && !vnp_Amount.isEmpty()) {
                long amt = Long.parseLong(vnp_Amount) / 100;
                amount = String.format("%,d đ", amt);
            }
        } catch (Exception e) {
            amount = vnp_Amount;
        }

        // Định dạng lại ngày thanh toán
        String payDateFormatted = formatVnpayDate(vnp_PayDate);

        // Đặt các thuộc tính cho trang JSP
        request.setAttribute("paymentSuccess", paymentSuccess);
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("vnp_TxnRef", vnp_TxnRef);
        request.setAttribute("vnp_PayDate", payDateFormatted);
        request.setAttribute("vnp_BankCode", vnp_BankCode);
        request.setAttribute("vnp_TransactionNo", vnp_TransactionNo);
        request.setAttribute("vnp_ResponseCode", vnp_ResponseCode);
        request.setAttribute("bookingId", bookingId);
        request.setAttribute("bookingDate", bookingDate);
        request.setAttribute("amount", amount);

        request.getRequestDispatcher("vnpayReturn.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String vnp_RequestId = Config.getRandomNumber(8);
        String vnp_Version = "2.1.0";
        String vnp_Command = "refund";
        String vnp_TmnCode = Config.vnp_TmnCode;
        String vnp_TransactionType = req.getParameter("trantype");
        String vnp_TxnRef = req.getParameter("order_id");
        long amount = Integer.parseInt(req.getParameter("amount")) * 100;
        String vnp_Amount = String.valueOf(amount);
        String vnp_OrderInfo = "Hoan tien GD OrderId:" + vnp_TxnRef;
        String vnp_TransactionNo = "";
        String vnp_TransactionDate = req.getParameter("trans_date");
        String vnp_CreateBy = req.getParameter("user");

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());

        String vnp_IpAddr = Config.getIpAddress(req);

        JsonObject vnp_Params = new JsonObject();

        vnp_Params.addProperty("vnp_RequestId", vnp_RequestId);
        vnp_Params.addProperty("vnp_Version", vnp_Version);
        vnp_Params.addProperty("vnp_Command", vnp_Command);
        vnp_Params.addProperty("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.addProperty("vnp_TransactionType", vnp_TransactionType);
        vnp_Params.addProperty("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.addProperty("vnp_Amount", vnp_Amount);
        vnp_Params.addProperty("vnp_OrderInfo", vnp_OrderInfo);

        if (vnp_TransactionNo != null && !vnp_TransactionNo.isEmpty()) {
            vnp_Params.addProperty("vnp_TransactionNo", vnp_TransactionNo);
        }

        vnp_Params.addProperty("vnp_TransactionDate", vnp_TransactionDate);
        vnp_Params.addProperty("vnp_CreateBy", vnp_CreateBy);
        vnp_Params.addProperty("vnp_CreateDate", vnp_CreateDate);
        vnp_Params.addProperty("vnp_IpAddr", vnp_IpAddr);

        String hash_Data = String.join("|", vnp_RequestId, vnp_Version, vnp_Command, vnp_TmnCode,
                vnp_TransactionType, vnp_TxnRef, vnp_Amount, vnp_TransactionNo, vnp_TransactionDate,
                vnp_CreateBy, vnp_CreateDate, vnp_IpAddr, vnp_OrderInfo);

        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hash_Data);
        vnp_Params.addProperty("vnp_SecureHash", vnp_SecureHash);

        URL url = new URL(Config.vnp_ApiUrl);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json");
        con.setDoOutput(true);
        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
        wr.writeBytes(vnp_Params.toString());
        wr.flush();
        wr.close();
        int responseCode = con.getResponseCode();

        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String output;
        StringBuilder response = new StringBuilder();
        while ((output = in.readLine()) != null) {
            response.append(output);
        }
        in.close();
    }

    private String buildHashString(Map<String, String> fields) {
        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < fieldNames.size(); i++) {
            String key = fieldNames.get(i);
            String value = fields.get(key);
            sb.append(key).append("=").append(value);
            if (i < fieldNames.size() - 1) {
                sb.append("&");
            }
        }
        return sb.toString();
    }

    private String formatVnpayDate(String vnpPayDate) {
        if (vnpPayDate == null || vnpPayDate.isEmpty()) {
            return "";
        }
        try {
            // VNPay trả về yyyyMMddHHmmss
            SimpleDateFormat srcFormat = new SimpleDateFormat("yyyyMMddHHmmss");
            Date date = srcFormat.parse(vnpPayDate);
            SimpleDateFormat destFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            return destFormat.format(date);
        } catch (ParseException e) {
            return vnpPayDate;
        }
    }

    private String getResponseCodeMessage(String responseCode) {
        switch (responseCode) {
            case "01":
                return "Transaction not completed (customer canceled)";
            case "02":
                return "Transaction error";
            case "03":
                return "Incorrect card name";
            case "04":
                return "Invalid card";
            case "05":
                return "Payment failed due to account balance issues";
            case "06":
                return "Internal system error";
            case "07":
                return "Transaction suspected of fraud";
            case "09":
                return "Card/Account has authentication issues";
            case "10":
                return "Exceeded transaction limit";
            case "11":
                return "Expired payment request";
            case "12":
                return "Invalid payment token";
            case "13":
                return "Payment already processed";
            case "24":
                return "Invalid customer information";
            case "51":
                return "Account does not have enough balance";
            case "65":
                return "Account has exceeded daily transaction limit";
            case "75":
                return "Incorrect password too many times";
            case "79":
                return "Format of transaction authentication information is incorrect";
            case "99":
                return "Other errors";
            default:
                return "Payment failed with code: " + responseCode;
        }
    }
}
