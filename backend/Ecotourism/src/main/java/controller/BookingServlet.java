package controller;

import dao.BookingDAO;
import dao.BookingPlaceDAO;
import model.Booking;
import model.BookingPlace;
import util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {
            BookingDAO bookingDAO = new BookingDAO(conn);
            BookingPlaceDAO bookingPlaceDAO = new BookingPlaceDAO(conn);

            String action = request.getParameter("action");
            if (action == null) action = "list";

            switch (action) {
                case "delete":
                    int id = Integer.parseInt(request.getParameter("id"));
                    bookingDAO.deleteBooking(id);
                    response.sendRedirect(request.getContextPath() + "/booking");
                    break;

                default:
                    List<Booking> bookings = bookingDAO.getAllBookings();
                    List<BookingPlace> bookingPlaces = bookingPlaceDAO.getAllBookingPlaces();
                    request.setAttribute("bookings", bookings);
                    request.setAttribute("bookingPlaces", bookingPlaces);
                    request.getRequestDispatcher("admin/booking_list.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // start transaction

            BookingDAO bookingDAO = new BookingDAO(conn);
            BookingPlaceDAO bookingPlaceDAO = new BookingPlaceDAO(conn);

            // Read form
            int userId = Integer.parseInt(request.getParameter("userId"));
            LocalDate bookingDate = LocalDate.parse(request.getParameter("bookingDate"));
            String timeSlot = request.getParameter("timeSlot");
            int visitorCount = Integer.parseInt(request.getParameter("visitorCount"));
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            String[] placeIds = request.getParameterValues("placeIds");

            // Create booking
            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setBookingDate(bookingDate);
            booking.setTimeSlot(timeSlot);
            booking.setVisitorCount(visitorCount);
            booking.setTotalAmount(totalAmount);
            booking.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            boolean added = bookingDAO.addBooking(booking);
            if (!added) throw new SQLException("Booking creation failed");

            // Add booking places
            if (placeIds != null) {
                for (String pid : placeIds) {
                    BookingPlace bp = new BookingPlace();
                    bp.setBookingId(booking.getBookingId());
                    bp.setPlaceId(Integer.parseInt(pid));
                    boolean bpAdded = bookingPlaceDAO.addBookingPlace(bp);
                    if (!bpAdded)
                        throw new SQLException("BookingPlace creation failed for placeId " + pid);
                }
            }

            conn.commit(); // commit all if successful
            response.sendRedirect(request.getContextPath() + "/booking");

        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // rollback all changes if any failure
                    System.out.println("Transaction rolled back due to error");
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            request.setAttribute("error", "Booking failed: " + e.getMessage());
            request.getRequestDispatcher("admin/booking_form.jsp").forward(request, response);

        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); } catch (SQLException e) { e.printStackTrace(); }
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}
