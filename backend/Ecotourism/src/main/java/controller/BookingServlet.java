package controller;

import dao.BookingDAO;
import dao.BookingPlaceDAO;
import dao.PlaceDAO;
import model.Booking;
import model.BookingPlace;
import model.Place;
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

    private static final String LIST_JSP = "/user/booking_list.jsp";
    private static final String FORM_JSP = "/user/booking_form.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = user.getUserId();
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        try (Connection conn = DBConnection.getConnection()) {
            
            // Show booking form with available places for new booking
            if ("new".equals(action)) {
                PlaceDAO placeDAO = new PlaceDAO(conn);
                var places = placeDAO.getActivePlaces();
                request.setAttribute("places", places);
                request.getRequestDispatcher(FORM_JSP).forward(request, response);
                return;
            }
            
            // Show booking form with existing booking data for editing
            if ("edit".equals(action) && idParam != null) {
                int bookingId = Integer.parseInt(idParam);
                BookingDAO bookingDAO = new BookingDAO(conn);
                BookingPlaceDAO bookingPlaceDAO = new BookingPlaceDAO(conn);
                PlaceDAO placeDAO = new PlaceDAO(conn);
                
                Booking booking = bookingDAO.getBookingById(bookingId);
                
                // Verify booking belongs to current user
                if (booking == null || booking.getUserId() != userId) {
                    response.sendRedirect(request.getContextPath() + "/bookings");
                    return;
                }
                
                // Get places for this booking
                var bookingPlaces = bookingPlaceDAO.getBookingPlacesByBookingId(bookingId);
                var selectedPlaceIds = new java.util.ArrayList<Integer>();
                for (BookingPlace bp : bookingPlaces) {
                    selectedPlaceIds.add(bp.getPlaceId());
                }
                
                // Get all available places
                var allPlaces = placeDAO.getActivePlaces();
                
                request.setAttribute("booking", booking);
                request.setAttribute("selectedPlaceIds", selectedPlaceIds);
                request.setAttribute("places", allPlaces);
                request.getRequestDispatcher(FORM_JSP).forward(request, response);
                return;
            }
            
            // Delete booking
            if ("delete".equals(action) && idParam != null) {
                int bookingId = Integer.parseInt(idParam);
                BookingDAO bookingDAO = new BookingDAO(conn);
                
                Booking booking = bookingDAO.getBookingById(bookingId);
                
                // Verify booking belongs to current user
                if (booking != null && booking.getUserId() == userId) {
                    bookingDAO.deleteBooking(bookingId);
                }
                
                response.sendRedirect(request.getContextPath() + "/bookings");
                return;
            }
            
            // Default: Show list of user's bookings
            BookingDAO bookingDAO = new BookingDAO(conn);
            BookingPlaceDAO bookingPlaceDAO = new BookingPlaceDAO(conn);
            PlaceDAO placeDAO = new PlaceDAO(conn);
            
            // Get bookings for this user
            var bookings = bookingDAO.getBookingsByUserId(userId);
            
            // Load places for each booking
            for (Booking booking : bookings) {
                var bookingPlaces = bookingPlaceDAO.getBookingPlacesByBookingId(booking.getBookingId());
                var places = new java.util.ArrayList<Place>();
                for (BookingPlace bp : bookingPlaces) {
                    Place place = placeDAO.getPlaceById(bp.getPlaceId());
                    if (place != null) {
                        places.add(place);
                    }
                }
                booking.setPlaces(places);
            }

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
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = user.getUserId();
        String bookingIdParam = request.getParameter("bookingId");
        boolean isEdit = (bookingIdParam != null && !bookingIdParam.isEmpty());

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
            String[] placeIds = request.getParameterValues("placeIds");

            Booking booking;
            
            if (isEdit) {
                // ---------- Update Existing Booking ----------
                int bookingId = Integer.parseInt(bookingIdParam);
                booking = bookingDAO.getBookingById(bookingId);
                
                // Verify booking belongs to current user
                if (booking == null || booking.getUserId() != userId) {
                    throw new SecurityException("Unauthorized access to booking");
                }
                
                booking.setBookingDate(bookingDate);
                booking.setTimeSlot(timeSlot);
                booking.setVisitorCount(visitorCount);
                booking.setTotalAmount(totalAmount);
                
                boolean updated = bookingDAO.updateBooking(booking);
                if (!updated) {
                    throw new SQLException("Failed to update booking");
                }
                
                // Delete existing booking places
                var existingBPs = bookingPlaceDAO.getBookingPlacesByBookingId(bookingId);
                for (BookingPlace bp : existingBPs) {
                    bookingPlaceDAO.deleteBookingPlace(bp.getBookingPlaceId());
                }
                
                // Add new booking places
                if (placeIds != null) {
                    for (String pid : placeIds) {
                        BookingPlace bp = new BookingPlace();
                        bp.setBookingId(bookingId);
                        bp.setPlaceId(Integer.parseInt(pid));
                        bookingPlaceDAO.addBookingPlace(bp);
                    }
                }
                
            } else {
                // ---------- Create New Booking ----------
                booking = new Booking();
                booking.setUserId(userId);
                booking.setBookingDate(bookingDate);
                booking.setTimeSlot(timeSlot);
                booking.setVisitorCount(visitorCount);
                booking.setTotalAmount(totalAmount);
                booking.setCreatedAt(new Timestamp(System.currentTimeMillis()));

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
            }

            // Commit transaction
            conn.commit();
            response.sendRedirect(request.getContextPath() + "/bookings");

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
