/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author LAZYVL
 */
public class CheckCustomerInfor {
    // Kiểm tra họ và tên

    public static String validateFullName(String fullName) {
        if (fullName == null || fullName.trim().isEmpty()) {
            return "Họ và tên không được để trống.\n";
        }
        if (fullName.length() < 4 || fullName.length() > 50) {
            return "Họ và tên phải từ 4 đến 50 ký tự.\n";
        }
        if (fullName.startsWith(" ") || fullName.endsWith(" ")) {
            return "Họ và tên không được có khoảng trắng ở đầu hoặc cuối.\n";
        }
        if (fullName.contains("  ")) {
            return "Họ và tên chỉ được dùng một khoảng trắng giữa các từ.\n";
        }
        if (!fullName.matches("^[A-Za-zÀ-ỹĐđ'\\- ]+$")) {
            return "Họ và tên chỉ được chứa chữ cái, dấu nháy đơn (') hoặc gạch nối (-).\n";
        }
        return "";
    }

    // Kiểm tra email
    public static String validateEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return "Email không được để trống.\n";
        }
        if (!email.contains("@")) {
            return "Email phải chứa ký tự @.\n";
        }
        String[] parts = email.split("@");
        if (parts.length != 2) {
            return "Email không đúng định dạng (chỉ chứa một ký tự @).\n";
        }
        String username = parts[0];
        String domain = parts[1];
        if (!username.matches("^[A-Za-z0-9._%+-]+$")) {
            return "Tên tài khoản Email không hợp lệ.\n";
        }
        if (!domain.matches("^[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            return "Tên miền email không hợp lệ hoặc thiếu đuôi miền.\n";
        }
        String[] domainParts = domain.split("\\.");
        if (domainParts[domainParts.length - 1].length() < 2) {
            return "Đuôi miền email phải có ít nhất 2 ký tự.\n";
        }
        return "";
    }

    // Kiểm tra số điện thoại
    public static String validatePhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return "Số điện thoại không được để trống.\n";
        }
        if (!phone.matches("^0\\d{9}$")) {
            return "Số điện thoại phải bắt đầu bằng số 0 và có đúng 10 chữ số.\n";
        }
        return "";
    }

    // Kiểm tra ngày sinh (trả về chuỗi lỗi, và gán biến dob ra ngoài qua mảng 1 phần tử)
    public static String validateDob(String dobStr, Date[] dobOut) {
        if (dobStr == null || dobStr.trim().isEmpty()) {
            return "Ngày sinh không được bỏ trống.\n";
        }
        try {
            Date dob = new SimpleDateFormat("yyyy-MM-dd").parse(dobStr);
            Date today = new Date();
            if (dob.after(today)) {
                return "Ngày sinh không được lớn hơn ngày hiện tại.\n";
            }
            int yearNow = today.getYear() + 1900;
            int yearDob = dob.getYear() + 1900;
            int age = yearNow - yearDob;
            if (age < 10 || age > 120) {
                return "Tuổi phải từ 10 đến 120.\n";
            }
            dobOut[0] = dob;
        } catch (Exception e) {
            return "Ngày sinh không hợp lệ. Định dạng đúng: yyyy-MM-dd.\n";
        }
        return "";
    }
    
    // Kiểm tra address
    public static String validateAddress(String address) {
        if (address == null || address.trim().isEmpty()) {
            return "Địa chỉ không được để trống.\n";
        }
        if (address.length() < 5 || address.length() > 100) {
            return "Địa chỉ phải từ 5 đến 100 ký tự.\n";
        }
        return "";
    }
}
