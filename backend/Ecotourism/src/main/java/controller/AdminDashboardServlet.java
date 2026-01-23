package controller;

import dao.UserDAO;
import dao.PlaceDAO;
import dao.BookingDAO;
import dao.BookingPlaceDAO;
import util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends AdminBaseServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) { // auto-close connection

            UserDAO userDAO = new UserDAO(conn);
            PlaceDAO placeDAO = new PlaceDAO(conn);
            BookingDAO bookingDAO = new BookingDAO(conn);
            BookingPlaceDAO bookingPlaceDAO = new BookingPlaceDAO(conn);

            request.setAttribute("users", userDAO.getAllUsers());
            request.setAttribute("places", placeDAO.getAllPlaces());
            request.setAttribute("bookings", bookingDAO.getAllBookings());
            request.setAttribute("bookingPlaces", bookingPlaceDAO.getAllBookingPlaces());

            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}
