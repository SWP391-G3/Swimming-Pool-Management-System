package com.vnpay.common;

import com.google.gson.JsonObject;
import dao.customer.BookingDetailDAO;
import dao.customer.PaymentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.*;
import java.text.*;
import java.util.*;

@WebServlet(name = "VNPayRefundServlet", urlPatterns = {"/vnpayrefund"})
public class vnpayRefundServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Nhận tham số từ URL
        String order_id = req.getParameter("order_id");
        String amount = req.getParameter("amount");
        String trans_date = req.getParameter("trans_date");
        String user = req.getParameter("user");

        // Truyền attribute sang JSP
        req.setAttribute("order_id", order_id);
        req.setAttribute("amount", amount);
        req.setAttribute("trans_date", trans_date);
        req.setAttribute("user", user);

        req.getRequestDispatcher("vnpayRefund.jsp").forward(req, resp);
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
        wr.write(vnp_Params.toString().getBytes("UTF-8"));
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

        // Xử lý kết quả hoàn tiền và cập nhật trạng thái
        String successMsg = null, errorMsg = null;
        JsonObject resJson = new com.google.gson.JsonParser().parse(response.toString()).getAsJsonObject();
        String vnp_ResponseCode = resJson.has("vnp_ResponseCode") ? resJson.get("vnp_ResponseCode").getAsString() : "";
        if (responseCode == 200 && "00".equals(vnp_ResponseCode)) {
            // Hoàn tiền thành công
            try {
                int bookingId = Integer.parseInt(vnp_TxnRef);
                BookingDetailDAO bookingDAO = new BookingDetailDAO();
                PaymentDAO paymentDAO = new PaymentDAO();
                bookingDAO.cancelBooking(bookingId);
                paymentDAO.updatePaymentStatus(bookingId, "refunded");
                successMsg = "Hoàn tiền thành công! Đơn booking đã bị huỷ.";

                // Redirect đến trang kết quả refund, truyền đầy đủ thông tin
                resp.sendRedirect(req.getContextPath() + "/vnpayRefundReturn.jsp?"
                        + "refundSuccess=true"
                        + "&vnp_TxnRef=" + URLEncoder.encode(vnp_TxnRef, "UTF-8")
                        + "&bookingId=" + bookingId
                        + "&amount=" + req.getParameter("amount")
                        + "&refundMsg=" + URLEncoder.encode(successMsg, "UTF-8")
                        + "&refundUser=" + URLEncoder.encode(vnp_CreateBy, "UTF-8")
                );
                return;
            } catch (Exception e) {
                errorMsg = "Hoàn tiền thành công nhưng lỗi khi cập nhật trạng thái booking/payment!";
            }
        } else {
            errorMsg = "Hoàn tiền thất bại! " + response.toString();
            resp.sendRedirect(req.getContextPath() + "/vnpayRefundReturn.jsp?"
                    + "refundSuccess=false"
                    + "&vnp_TxnRef=" + URLEncoder.encode(vnp_TxnRef, "UTF-8")
                    + "&bookingId=" + vnp_TxnRef
                    + "&amount=" + req.getParameter("amount")
                    + "&refundMsg=" + URLEncoder.encode(errorMsg, "UTF-8")
                    + "&refundUser=" + URLEncoder.encode(vnp_CreateBy, "UTF-8")
            );
            return;
        }

        req.setAttribute("successMsg", successMsg);
        req.setAttribute("errorMsg", errorMsg);

        // Trả về lại form (giữ lại các thông tin đã điền)
        req.getRequestDispatcher("vnpayRefund.jsp").forward(req, resp);
    }
}
