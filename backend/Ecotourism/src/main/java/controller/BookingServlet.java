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

@WebServlet("/bookings")
public class BookingServlet extends HttpServlet {

    private static final String LIST_JSP = "/user/booking_list.jsp";
    private static final String FORM_JSP = "/user/booking_form.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        try (Connection conn = DBConnection.getConnection()) {
            BookingDAO bookingDAO = new BookingDAO(conn);
            // Get bookings for this user only
            var bookings = bookingDAO.getBookingsByUserId(userId);

            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher(LIST_JSP).forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Failed to load your bookings", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // start transaction

            BookingDAO bookingDAO = new BookingDAO(conn);
            BookingPlaceDAO bookingPlaceDAO = new BookingPlaceDAO(conn);

            // ---------- Read form ----------
            LocalDate bookingDate = LocalDate.parse(request.getParameter("bookingDate"));
            String timeSlot = request.getParameter("timeSlot");
            int visitorCount = Integer.parseInt(request.getParameter("visitorCount"));
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            String[] placeIds = request.getParameterValues("placeIds"); // multi-select or checkboxes

            // ---------- Create Booking ----------
            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setBookingDate(bookingDate);
            booking.setTimeSlot(timeSlot);
            booking.setVisitorCount(visitorCount);
            booking.setTotalAmount(totalAmount);
            booking.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            // Add booking and get generated bookingId
            boolean added = bookingDAO.addBooking(booking);
            if (!added) {
                throw new SQLException("Failed to create booking");
            }

            // ---------- Add Booking Places ----------
            if (placeIds != null) {
                for (String pid : placeIds) {
                    BookingPlace bp = new BookingPlace();
                    bp.setBookingId(booking.getBookingId());
                    bp.setPlaceId(Integer.parseInt(pid));

                    boolean bpAdded = bookingPlaceDAO.addBookingPlace(bp);
                    if (!bpAdded) {
                        throw new SQLException("Failed to add booking place: " + pid);
                    }
                }
            }

            // Commit transaction
            conn.commit();
            response.sendRedirect(request.getContextPath() + "/mybookings");

        } catch (Exception e) {
            // Rollback if something goes wrong
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }

            e.printStackTrace();
            request.setAttribute("error", "Booking failed: " + e.getMessage());
            request.getRequestDispatcher(FORM_JSP).forward(request, response);

        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); } catch (SQLException ignored) {}
                try { conn.close(); } catch (SQLException ignored) {}
            }
        }
    }
}
