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

@WebServlet("/admin/bookings")
public class AdminBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String bookingIdStr = req.getParameter("bookingId");

        if ("delete".equalsIgnoreCase(action) && bookingIdStr != null) {
            try (Connection conn = DBConnection.getConnection()) {
                conn.setAutoCommit(false); // start transaction

                int bookingId = Integer.parseInt(bookingIdStr);
                BookingDAO bookingDAO = new BookingDAO(conn);
                BookingPlaceDAO bookingPlaceDAO = new BookingPlaceDAO(conn);

                // Delete related booking places first
                bookingPlaceDAO.deleteBookingPlacesByBookingId(bookingId);

                // Delete the booking itself
                bookingDAO.deleteBooking(bookingId);

                conn.commit();

                // Redirect with optional section fragment
                String section = req.getParameter("redirectSection");
                if (section == null || section.isBlank()) section = "";
                else section = "#" + section;

                resp.sendRedirect(req.getContextPath() + "/admin/dashboard" + section);

            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid booking ID.");
            } catch (SQLException e) {
                e.printStackTrace();
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting booking.");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request.");
        }
    }
}
