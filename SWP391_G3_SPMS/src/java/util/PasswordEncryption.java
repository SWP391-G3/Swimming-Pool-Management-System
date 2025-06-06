/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.security.MessageDigest;

public class PasswordEncryption{
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashed = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hashed) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception ex) {
            throw new RuntimeException("Lỗi hash mật khẩu", ex);
        }
    }

    public static boolean checkPassword(String inputPassword, String storedHash) {
        return hashPassword(inputPassword).equals(storedHash);
    }
    
//    public static void main(String[] args) {
//        String password = "ccea582e8616f7fd66f21062a2ca3185d0422ecb411e2a85cdd361c3c8cf7719";
//        String hashedPassword = hashPassword(password);
//        System.out.println("Password gốc: " + password);
//        System.out.println("SHA-256 đã mã hóa: " + hashedPassword);
//    }//manager@123
//    //324d52ea400e79ae65163f0b369e295c4993d26204c66317ee8e53f31ae003e3
//    //K1i2e3n4@
//    //ccea582e8616f7fd66f21062a2ca3185d0422ecb411e2a85cdd361c3c8cf7719
//    //4eb2ecb13cc2c415de94598b2f1a9f834bf010dc17ccd199fde9ef39d5076fe1
}