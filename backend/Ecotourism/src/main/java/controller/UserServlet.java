package controller;

import java.io.IOException;
import java.sql.Connection;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import util.DBConnection;
import util.PasswordUtil;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User loginUser = (User) session.getAttribute("user");

        if (loginUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "profile";

        if ("profile".equals(action)) {
            req.setAttribute("user", loginUser);
            req.getRequestDispatcher("/userProfile.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User loginUser = (User) session.getAttribute("user");

        if (loginUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");

        if ("update".equals(action)) {
            try (Connection conn = DBConnection.getConnection()) { // fresh connection per request
                UserDAO userDAO = new UserDAO(conn);

                loginUser.setUserName(req.getParameter("userName"));
                loginUser.setEmail(req.getParameter("email"));

                String password = req.getParameter("password");
                if (password != null && !password.isBlank()) {
                    loginUser.setPasswordHash(
                            PasswordUtil.hashPassword(password)
                    );
                }

                userDAO.updateUser(loginUser);
                session.setAttribute("user", loginUser);

                resp.sendRedirect("users?action=profile");

            } catch (Exception e) {
                e.printStackTrace();
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
            }
        }
    }
}
