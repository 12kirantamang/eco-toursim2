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

@WebServlet("/admin/users")
public class AdminUserServlet extends AdminBaseServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);

            switch (action) {
                case "insert":
                    insertUser(req, resp, userDAO);
                    break;
                case "update":
                    updateUser(req, resp, userDAO);
                    break;
                case "delete":
                    deleteUser(req, resp, userDAO);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    // ===== METHODS =====
    private void insertUser(HttpServletRequest req, HttpServletResponse resp, UserDAO userDAO)
            throws IOException {

        User user = new User();
        user.setUserName(req.getParameter("userName"));
        user.setEmail(req.getParameter("email"));
        user.setPasswordHash(PasswordUtil.hashPassword(req.getParameter("password")));
        user.setRole(req.getParameter("role"));
        user.setStatus(req.getParameter("status"));
        user.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        userDAO.addUser(user);

        String section = req.getParameter("redirectSection");
        if (section == null || section.isBlank()) section = "";
        else section = "#" + section;  // add fragment

        resp.sendRedirect(req.getContextPath() + "/admin/dashboard" + section);
    }

    private void updateUser(HttpServletRequest req, HttpServletResponse resp, UserDAO userDAO)
            throws IOException {

        int userId = Integer.parseInt(req.getParameter("userId"));
        User user = userDAO.getUserById(userId);

        user.setUserName(req.getParameter("userName"));
        user.setEmail(req.getParameter("email"));
        user.setRole(req.getParameter("role"));
        user.setStatus(req.getParameter("status"));

        String newPassword = req.getParameter("password");
        if (newPassword != null && !newPassword.isBlank()) {
            user.setPasswordHash(PasswordUtil.hashPassword(newPassword));
        }

        userDAO.updateUser(user);

        String section = req.getParameter("redirectSection");
        if (section == null || section.isBlank()) section = "";
        else section = "#" + section;  // add fragment

        resp.sendRedirect(req.getContextPath() + "/admin/dashboard" + section);
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp, UserDAO userDAO)
            throws IOException {

        int userId = Integer.parseInt(req.getParameter("id"));
        userDAO.deleteUser(userId);

        String section = req.getParameter("redirectSection");
        if (section == null || section.isBlank()) section = "";
        else section = "#" + section;  // add fragment

        resp.sendRedirect(req.getContextPath() + "/admin/dashboard" + section);
    }
}
