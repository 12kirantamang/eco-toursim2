package controller;

import dao.BookingDAO;
import dao.BookingPlaceDAO;
import util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/bookings")
public class AdminBookingServlet extends HttpServlet {

    private static final String ADMIN_BOOKINGS_JSP = "/admin/adminBookings.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {
            BookingDAO bookingDAO = new BookingDAO(conn);

            // Fetch all bookings
            List<?> bookings = bookingDAO.getAllBookings();

            // Set bookings list to request
            request.setAttribute("bookings", bookings);

            // Forward to admin bookings JSP
            request.getRequestDispatcher(ADMIN_BOOKINGS_JSP).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Cannot retrieve bookings.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String bookingIdStr = request.getParameter("bookingId");

        if ("delete".equalsIgnoreCase(action) && bookingIdStr != null) {

            try (Connection conn = DBConnection.getConnection()) {
                conn.setAutoCommit(false); // start transaction

                int bookingId = Integer.parseInt(bookingIdStr);
                BookingDAO bookingDAO = new BookingDAO(conn);
                BookingPlaceDAO bookingPlaceDAO = new BookingPlaceDAO(conn);

                // 1️⃣ Delete all related booking places first
                boolean placesDeleted = bookingPlaceDAO.deleteBookingPlacesByBookingId(bookingId);

                // 2️⃣ Delete the booking itself
                boolean bookingDeleted = bookingDAO.deleteBooking(bookingId);

                if (!bookingDeleted) {
                    throw new SQLException("Failed to delete booking with ID: " + bookingId);
                }

                conn.commit();
                response.sendRedirect(request.getContextPath() + "/admin/bookings");

            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid booking ID.");
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting booking.");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request.");
        }
    }
}
