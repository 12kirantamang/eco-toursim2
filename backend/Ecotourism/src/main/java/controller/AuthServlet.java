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

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("logout".equalsIgnoreCase(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) session.invalidate();
            response.sendRedirect(request.getContextPath() + "/auth");
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action) {
            case "login":
                handleLogin(request, response);
                break;
            case "register":
                handleRegister(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Open a fresh connection for this request
        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);

            User user = userDAO.getUserByEmail(email);

            if (user != null) {
                if ("BLOCKED".equalsIgnoreCase(user.getStatus())) {
                    request.setAttribute("error", "Your account is blocked. Contact admin.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }

                if (PasswordUtil.checkPassword(password, user.getPasswordHash())) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);

                    if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/index.jsp");
                    }
                } else {
                    request.setAttribute("error", "Invalid email or password");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);

            if (userDAO.isEmailExist(email)) {
                request.setAttribute("error", "Email already registered!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            String hashedPassword = PasswordUtil.hashPassword(password);

            User user = new User();
            user.setUserName(name);
            user.setEmail(email);
            user.setPasswordHash(hashedPassword);
            user.setRole(role);
            user.setStatus("ACTIVE");
            user.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));

            boolean registered = userDAO.addUser(user);

            if (registered) {
                request.setAttribute("success", "Registration successful! Please login.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed. Try again!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}
