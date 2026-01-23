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

@WebServlet("/admin/users")
public class AdminUserServlet extends AdminBaseServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try (Connection conn = DBConnection.getConnection()) { // fresh connection per request
            UserDAO userDAO = new UserDAO(conn);

            switch (action) {
                case "new":
                    showNewForm(req, resp);
                    break;
                case "edit":
                    showEditForm(req, resp, userDAO);
                    break;
                case "delete":
                    deleteUser(req, resp, userDAO);
                    break;
                default:
                    listUsers(req, resp, userDAO);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);

            if ("insert".equals(action)) {
                insertUser(req, resp, userDAO);
            } else if ("update".equals(action)) {
                updateUser(req, resp, userDAO);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    // ===== METHODS =====

    private void listUsers(HttpServletRequest req, HttpServletResponse resp, UserDAO userDAO)
            throws ServletException, IOException {

        List<User> users = userDAO.getAllUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/admin/user-list.jsp").forward(req, resp);
    }

    private void showNewForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/admin/user-form.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp, UserDAO userDAO)
            throws ServletException, IOException {

        int userId = Integer.parseInt(req.getParameter("id"));
        User user = userDAO.getUserById(userId);

        req.setAttribute("user", user);
        req.getRequestDispatcher("/admin/user-form.jsp").forward(req, resp);
    }

    private void insertUser(HttpServletRequest req, HttpServletResponse resp, UserDAO userDAO)
            throws IOException {

        User user = new User();
        user.setUserName(req.getParameter("userName"));
        user.setEmail(req.getParameter("email"));
        user.setPasswordHash(
                PasswordUtil.hashPassword(req.getParameter("password"))
        );
        user.setRole(req.getParameter("role"));
        user.setStatus(req.getParameter("status"));
        user.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        userDAO.addUser(user);
        resp.sendRedirect(req.getContextPath() + "/admin/users");
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
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp, UserDAO userDAO)
            throws IOException {

        int userId = Integer.parseInt(req.getParameter("id"));
        userDAO.deleteUser(userId);

        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}
