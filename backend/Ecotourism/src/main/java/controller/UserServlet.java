package controller;

import dao.UserDAO;
import model.User;
import util.DBConnection;
import util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBConnection.getConnection();
            userDAO = new UserDAO(connection);
        } catch (Exception e) {
            throw new ServletException("Cannot initialize UserDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                request.getRequestDispatcher("/userForm.jsp").forward(request, response);
                break;

            case "edit":
                int userId = Integer.parseInt(request.getParameter("userId"));
                User user = userDAO.getUserById(userId);
                request.setAttribute("user", user);
                request.getRequestDispatcher("/userForm.jsp").forward(request, response);
                break;

            default: // list
                List<User> users = userDAO.getAllUsers();
                request.setAttribute("users", users);
                request.getRequestDispatcher("/userList.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("save".equals(action)) {

            int userId = request.getParameter("userId") == null || request.getParameter("userId").isEmpty()
                    ? 0 : Integer.parseInt(request.getParameter("userId"));

            String userName = request.getParameter("userName");
            String email = request.getParameter("email");
            String password = request.getParameter("password"); // plaintext from form
            String role = request.getParameter("role");
            String status = request.getParameter("status");
            Timestamp createdAt = new Timestamp(System.currentTimeMillis());

            User user;

            if (userId == 0) {
                // NEW USER → hash password
                String hashedPassword = PasswordUtil.hashPassword(password);
                user = new User(0, userName, email, hashedPassword, role, status, createdAt);
                userDAO.addUser(user);
            } else {
                // EDIT USER → check if password is provided
                User existingUser = userDAO.getUserById(userId);
                String hashedPassword = (password == null || password.isEmpty())
                        ? existingUser.getPasswordHash() // keep old password
                        : PasswordUtil.hashPassword(password);     // new password
                user = new User(userId, userName, email, hashedPassword, role, status, createdAt);
                userDAO.updateUser(user);
            }

            response.sendRedirect("users");

        } else if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            userDAO.deleteUser(userId);
            response.sendRedirect("users");
        }
    }
}
