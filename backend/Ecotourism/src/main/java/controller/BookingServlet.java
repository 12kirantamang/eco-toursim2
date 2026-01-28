package controller;

import dao.BookingDAO;
import dao.BookingPlaceDAO;
import model.Booking;
import model.BookingPlace;
import model.User;
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

    // ===================== GET (View My Bookings) =====================
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession(false);
//
//        // 🔒 Auth check
//        if (session == null || session.getAttribute("user") == null) {
//            response.sendRedirect(request.getContextPath() + "/auth");
//            return;
//        }
//
//        User user = (User) session.getAttribute("user");
//        int userId = user.getUserId();
//
//        try (Connection conn = DBConnection.getConnection()) {
//
//            BookingDAO bookingDAO = new BookingDAO(conn);
//            var bookings = bookingDAO.getBookingsByUserId(userId);
//
//            request.setAttribute("bookings", bookings);
//            request.getRequestDispatcher("/bookings.jsp").forward(request, response);
//
//        } catch (Exception e) {
//            throw new ServletException("Failed to load bookings", e);
//        }
//    }

    // ===================== POST (Create Booking) =====================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // 🔐 transaction start

            BookingDAO bookingDAO = new BookingDAO(conn);
            BookingPlaceDAO bookingPlaceDAO = new BookingPlaceDAO(conn);

            // -------- Read & validate form --------
            LocalDate bookingDate = LocalDate.parse(request.getParameter("bookingDate"));
            String timeSlot = request.getParameter("timeSlot");
            int visitorCount = Integer.parseInt(request.getParameter("visitorCount"));
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            String[] placeIds = request.getParameterValues("placeIds");

            if (placeIds == null || placeIds.length == 0) {
                throw new ServletException("No adventure selected.");
            }

            if (visitorCount < 1) {
                throw new ServletException("Invalid visitor count.");
            }

            // -------- Create booking --------
            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setBookingDate(bookingDate);
            booking.setTimeSlot(timeSlot);
            booking.setVisitorCount(visitorCount);
            booking.setTotalAmount(totalAmount);
            booking.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            if (!bookingDAO.addBooking(booking)) {
                throw new SQLException("Failed to create booking");
            }

            // -------- Booking places --------
            for (String pid : placeIds) {
                BookingPlace bp = new BookingPlace();
                bp.setBookingId(booking.getBookingId());
                bp.setPlaceId(Integer.parseInt(pid));

                if (!bookingPlaceDAO.addBookingPlace(bp)) {
                    throw new SQLException("Failed to add booking place: " + pid);
                }
            }

            conn.commit();
            response.sendRedirect(request.getContextPath() + "/bookings");

        } catch (Exception e) {

            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ignored) {}
            }

            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/adventure2.jsp").forward(request, response);

        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); } catch (SQLException ignored) {}
                try { conn.close(); } catch (SQLException ignored) {}
            }
        }
    }
}
