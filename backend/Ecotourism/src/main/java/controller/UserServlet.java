package controller;

import java.io.IOException;
import java.sql.Connection;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import util.DBConnection;
import util.PasswordUtil;

@WebServlet("/users")
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

            resp.sendRedirect("user?action=profile");
        }
    }
}
