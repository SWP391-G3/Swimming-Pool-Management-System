package controller.HomePage;

import dao.customer.ContactDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.customer.Contact;
import model.customer.User;
import java.util.Date;

public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        request.getRequestDispatcher("Contact.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Kiểm tra session user (nếu có)
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        Integer userId = (user != null) ? user.getUser_id(): null;

        // Tạo đối tượng Contact
        Contact contact = new Contact();
        contact.setUserId(userId);
        contact.setName(name);
        contact.setEmail(email);
        contact.setSubject(subject);
        contact.setContent(message);
        contact.setCreatedAt(new Date());
        contact.setResolved(false);

        // Gọi DAO để lưu vào CSDL
        ContactDAO contactDAO = new ContactDAO();
        contactDAO.insertContact(contact);

        // Chuyển hướng hoặc forward tới trang cảm ơn
        request.setAttribute("success", "Cảm ơn bạn đã liên hệ! Chúng tôi sẽ phản hồi sớm.");
        request.getRequestDispatcher("Contact.jsp").forward(request, response);
    }
}
