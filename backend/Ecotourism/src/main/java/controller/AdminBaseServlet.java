package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

public abstract class AdminBaseServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null 
            || !"ADMIN".equals(((User) session.getAttribute("user")).getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        super.service(req, resp); // proceed to doGet/doPost
    }
}