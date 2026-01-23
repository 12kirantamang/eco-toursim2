package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Locale;

@WebServlet("/changeLanguage")
public class LanguageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String language = request.getParameter("lang");
        String redirectUrl = request.getParameter("redirect");

        if (language != null) {
            Locale locale;
            if ("ja".equals(language)) {
                locale = Locale.JAPANESE;
            } else {
                locale = Locale.ENGLISH;
            }

            // Store locale in session
            HttpSession session = request.getSession();
            session.setAttribute("locale", locale);
        }

        // Redirect back to the referring page or home
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            response.sendRedirect(redirectUrl);
        } else {
            String referer = request.getHeader("Referer");
            if (referer != null) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
