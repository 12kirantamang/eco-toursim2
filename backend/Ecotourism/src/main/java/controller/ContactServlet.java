package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to contact page
        response.sendRedirect(request.getContextPath() + "/contact.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Basic validation
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            subject == null || subject.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {
            
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/contact.jsp").forward(request, response);
            return;
        }

        // TODO: In production, you would:
        // 1. Save to database
        // 2. Send email notification
        // 3. Validate email format
        
        // For now, just show success message
        request.setAttribute("success", "Thank you for contacting us! We will get back to you soon.");
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }
}
