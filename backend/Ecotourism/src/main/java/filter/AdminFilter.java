package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

@WebFilter("/admin/*") // Protect all admin pages
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            // Not logged in → redirect to login
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // Check user role
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
            // Not admin → redirect to home page or error page
            res.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        // User is admin → allow access
        chain.doFilter(request, response);
    }
}
