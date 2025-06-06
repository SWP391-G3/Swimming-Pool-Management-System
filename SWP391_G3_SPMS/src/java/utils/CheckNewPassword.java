/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author LAZYVL
 */
public class CheckNewPassword {
    // Hàm kiểm tra quy tắc mật khẩu mới
    public static String validateNewPassword(String newPassword, String oldPassword) {
        if (newPassword == null || newPassword.isEmpty()) {
            return "Mật khẩu mới không được để trống!";
        }
        if (newPassword.length() < 8) {
            return "Mật khẩu mới phải có ít nhất 8 ký tự!";
        }
        if (newPassword.matches(".*\\s+.*")) {
            return "Mật khẩu mới không được chứa khoảng trắng!";
        }
        int groups = 0;
        if (newPassword.matches(".*[a-z].*")) groups++;           // chữ thường
        if (newPassword.matches(".*[A-Z].*")) groups++;           // chữ hoa
        if (newPassword.matches(".*\\d.*")) groups++;             // số
        if (newPassword.matches(".*[^a-zA-Z0-9].*")) groups++;    // ký tự đặc biệt
        if (groups < 3) {
            return "Mật khẩu mới phải có ít nhất 3 trong 4 nhóm: chữ thường, chữ hoa, số, ký tự đặc biệt!";
        }
        if (oldPassword != null && newPassword.equals(oldPassword)) {
            return "Mật khẩu mới không được trùng với mật khẩu hiện tại!";
        }
        return null; // hợp lệ
    }
    
    //Ham kiem tra Register Password
    public static String validateRegisterPassword(String newPassword) {
        if (newPassword == null || newPassword.isEmpty()) {
            return "Mật khẩu  không được để trống!";
        }
        if (newPassword.length() < 8) {
            return "Mật khẩu  phải có ít nhất 8 ký tự!";
        }
        if (newPassword.matches(".*\\s+.*")) {
            return "Mật khẩu  không được chứa khoảng trắng!";
        }
        int groups = 0;
        if (newPassword.matches(".*[a-z].*")) groups++;           // chữ thường
        if (newPassword.matches(".*[A-Z].*")) groups++;           // chữ hoa
        if (newPassword.matches(".*\\d.*")) groups++;             // số
        if (newPassword.matches(".*[^a-zA-Z0-9].*")) groups++;    // ký tự đặc biệt
        if (groups < 3) {
            return "Mật khẩu  phải có ít nhất 3 trong 4 nhóm: chữ thường, chữ hoa, số, ký tự đặc biệt!";
        }
        return null; // hợp lệ
    }

}
