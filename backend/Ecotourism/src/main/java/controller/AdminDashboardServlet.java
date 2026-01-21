package controller;

import dao.UserDAO;
import dao.PlaceDAO;
import dao.BookingDAO;
import dao.BookingPlaceDAO;
import model.User;
import model.Place;
import model.Booking;
import model.BookingPlace;
import util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends AdminBaseServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {

            // DAOs
            UserDAO userDAO = new UserDAO(conn);
            PlaceDAO placeDAO = new PlaceDAO(conn);
            BookingDAO bookingDAO = new BookingDAO(conn);
            BookingPlaceDAO bookingPlaceDAO = new BookingPlaceDAO(conn);

            // Fetch all data
            List<User> users = userDAO.getAllUsers();
            List<Place> places = placeDAO.getAllPlaces();
            List<Booking> bookings = bookingDAO.getAllBookings();
            List<BookingPlace> bookingPlaces = bookingPlaceDAO.getAllBookingPlaces();

            // Set attributes for JSP
            request.setAttribute("users", users);
            request.setAttribute("places", places);
            request.setAttribute("bookings", bookings);
            request.setAttribute("bookingPlaces", bookingPlaces);

            // Forward to JSP
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }
}
