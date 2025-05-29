package controller.login;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.UserDAO;
import model.User;

import java.io.IOException;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Constants;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Form;

//@WebServlet(name = "LoginGoogle", urlPatterns = {"/LoginGoogle"})
public class LoginGoogle extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // 1. Lấy access token từ Google bằng code
            String accessToken = getToken(code);

            // 2. Lấy thông tin user JSON từ Google
            JsonObject userInfo = getUserInfo(accessToken);

            if (userInfo == null || !userInfo.has("email")) {
                response.sendRedirect("login.jsp");
                return;
            }

            String email = userInfo.get("email").getAsString();
            String name = userInfo.has("name") ? userInfo.get("name").getAsString() : email;

            // 3. Kiểm tra user trong DB theo email
            UserDAO userDao = new UserDAO();
            User user = userDao.getUserByEmail(email);

            if (user == null) {
                // 4. Nếu chưa có, tạo user mới
                user = new User();
                String username = email.substring(0, email.indexOf('@'));
                user.setUsername(username);
                user.setPassword(""); // Không cần mật khẩu với Google login
                user.setFull_name(name);
                user.setEmail(email);
                user.setPhone("");
                user.setAddress("");
                user.setRole_id(4); // Role mặc định
                user.setStatus(true);
                user.setCreate_at(LocalDate.now());

                userDao.insertUser(user);
            }

            // 5. Tạo session lưu user
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            // 6. Redirect về trang admin (hoặc trang khác)
            response.sendRedirect("customer.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp");
        }
    }

    // Hàm lấy access token từ Google bằng code
    private static String getToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form()
                        .add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI)
                        .add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE)
                        .build())
                .execute()
                .returnContent()
                .asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        return jobj.get("access_token").getAsString();
    }

    // Hàm lấy thông tin user JSON từ Google
    private static JsonObject getUserInfo(String accessToken) throws ClientProtocolException, IOException {
        String url = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;

        String response = Request.Get(url)
                .execute()
                .returnContent()
                .asString();

        return new Gson().fromJson(response, JsonObject.class);
    }
}