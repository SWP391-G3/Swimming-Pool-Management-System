package controller.login;

import com.google.api.client.googleapis.auth.oauth2.*;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.oauth2.Oauth2;
import com.google.api.services.oauth2.model.Userinfo;
import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

@WebServlet("/LoginGoogle")
public class LoginGoogle extends HttpServlet {

    private static final String CLIENT_ID = "1011626607904-oroog9kq0dj2t481qcqkp39325sgcjvj.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:8080/SWP391_G3_SPMS/LoginGoogle";
    private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
       
        if (code == null || code.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // 1. Exchange code for access token
            GoogleTokenResponse tokenResponse
                    = new GoogleAuthorizationCodeTokenRequest(
                            GoogleNetHttpTransport.newTrustedTransport(),
                            JSON_FACTORY,
                            "https://oauth2.googleapis.com/token",
                            CLIENT_ID,
                            CLIENT_SECRET,
                            code,
                            REDIRECT_URI
                    ).execute();

            // 2. Use access token to get user info
            GoogleCredential credential = new GoogleCredential().setAccessToken(tokenResponse.getAccessToken());
            Oauth2 oauth2 = new Oauth2.Builder(
                    GoogleNetHttpTransport.newTrustedTransport(),
                    JSON_FACTORY, credential)
                    .setApplicationName("SWP391_G3_SPMS")
                    .build();

            Userinfo userInfo = oauth2.userinfo().get().execute();
            String email = userInfo.getEmail();
            String name = userInfo.getName();
            String picture = userInfo.getPicture();

            // 3. Check user exists, if not create new user (role = customer)
            UserDAO userDao = new UserDAO();
            User user = userDao.getUserByEmail(email);
            if (user == null) {
                user = new User(
                        0,
                        email, // username
                        "", // password
                        name != null ? name : "", // full_name
                        email, // email
                        "", // phone
                        "", // address
                        4, // role_id
                        true, // status
                        null, // dob
                        "Other", // gender
                        picture != null ? picture : "",
                        java.time.LocalDate.now(),
                        java.time.LocalDate.now()
                );
                userDao.insertUser(user);
                user = userDao.getUserByEmail(email);

            }
            // 4. Set session and redirect
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            response.sendRedirect("homepage.jsp");
        } catch (GeneralSecurityException e) {
            throw new ServletException(e);
        }
    }
}
