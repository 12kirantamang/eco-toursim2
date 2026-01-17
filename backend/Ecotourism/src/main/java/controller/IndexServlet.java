package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/home") // URL ကို /home လို့ပြောင်းလိုက်ပါ (သို့မဟုတ် index.jsp ကို တိုက်ရိုက်မခေါ်ဘဲ ဖြတ်ရမယ့် path)
public class IndexServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // Login မဝင်ရသေးရင် သာမန် ဧည့်သည်စာမျက်နှာကို ပြမယ်
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            // Role အလိုက် လမ်းကြောင်းခွဲမယ်
            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            } else if ("VISITOR".equals(user.getRole())) {
                // Visitor ဆိုရင် index.jsp ကိုပဲ ပြန်ပြမယ် (Redirect မလုပ်ဘဲ Forward လုပ်တာ ပိုစိတ်ချရပါတယ်)
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        }
    }
}