/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author 84823
 */

public class Constants {

    // Thay bằng Client ID thật của anh lấy từ Google Cloud Console
    public static final String GOOGLE_CLIENT_ID = "1011626607904-oroog9kq0dj2t481qcqkp39325sgcjvj.apps.googleusercontent.com";

    // Thay bằng Client Secret thật của anh
    public static final String GOOGLE_CLIENT_SECRET = "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";

    // Địa chỉ callback trỏ đến servlet xử lý Google login (theo urlPatterns của anh)
    public static final String GOOGLE_REDIRECT_URI = "http://localhost:8080/SWP391_G3_SPMS_Practice/LoginGoogle";

    // URL lấy access token của Google
    public static final String GOOGLE_LINK_GET_TOKEN = "https://oauth2.googleapis.com/token";

    // URL lấy thông tin user, thêm access token vào cuối
    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

    // Grant type cố định cho OAuth2
    public static final String GOOGLE_GRANT_TYPE = "authorization_code";
}

