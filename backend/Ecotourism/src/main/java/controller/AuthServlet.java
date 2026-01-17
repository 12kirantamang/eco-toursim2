package controller;

import dao.UserDAO;
import model.User;
import util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO(); // Initialize DAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("register".equals(action)) {
            handleRegister(request, response);
        } else if ("logout".equals(action)) {
            request.getSession().invalidate();
            response.sendRedirect("home");
        }else {
            response.sendRedirect("index.jsp");
        }
    }

    // -------------------------------
    // LOGIN
    // -------------------------------
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.login(email, password);

        if (user != null) {
            // Login successful → set session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Role-based redirect
            switch (user.getRole()) {
                case "ADMIN":
                    response.sendRedirect("admin/dashboard.jsp");
                    break;
                case "VISITOR":
                    response.sendRedirect("index.jsp");
                    break;
                default:
                    response.sendRedirect("index.jsp");
            }

        } else {
            // Login failed
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // -------------------------------
    // REGISTER
    // -------------------------------
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // ADMIN, VISITOR

        // Check if email already exists
        if (userDAO.isEmailExist(email)) {
            request.setAttribute("error", "Email already registered!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User user = new User(name, email, password, role);

        boolean registered = userDAO.registerUser(user);

        if (registered) {
        	// Send welcome email
            String subject = "Welcome to EcoTourism Portal!";
            String body = "Hi " + name + ",\n\nThank you for registering at EcoTourism Portal.\nEnjoy exploring our eco-friendly tours!\n\n- EcoTourism Team";
            EmailUtil.sendEmail(email, subject, body);
            
            request.setAttribute("success", "Registration successful! Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Try again!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
