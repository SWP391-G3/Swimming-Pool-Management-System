/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import util.*;
import java.security.MessageDigest;

public class HashGen {
    public static void runHash() {
        String[] passwords = {
            "admin@123",
            "manager@123",
            "staff@123",
            "customer@123",
            "staff2@123",
            "staff3@123",
            "staff4@123",
            "customer2@123",
            "customer3@123",
            "customer4@123"
        };
        for (String pw : passwords) {
            System.out.println(pw + " : " + hashPassword(pw));
        }
    }
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}
