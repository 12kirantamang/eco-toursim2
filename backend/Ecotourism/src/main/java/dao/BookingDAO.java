package dao;

import model.Booking;
import model.BookingPlace;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    private Connection conn;

    public BookingDAO(Connection conn) {
        this.conn = conn;
    }

    // ------------------- Basic Methods -------------------

    // Add Booking
    public boolean addBooking(Booking booking) {
        String sql = "INSERT INTO bookings (userId, bookingDate, timeSlot, visitorCount, totalAmount, createdAt) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, booking.getUserId());
            ps.setDate(2, Date.valueOf(booking.getBookingDate()));
            ps.setString(3, booking.getTimeSlot());
            ps.setInt(4, booking.getVisitorCount());
            ps.setDouble(5, booking.getTotalAmount());
            ps.setTimestamp(6, booking.getCreatedAt());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    booking.setBookingId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Add booking and return generated ID directly
    public int addBookingAndReturnId(Booking booking) {
        String sql = "INSERT INTO bookings (userId, bookingDate, timeSlot, visitorCount, totalAmount, createdAt) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, booking.getUserId());
            ps.setDate(2, Date.valueOf(booking.getBookingDate()));
            ps.setString(3, booking.getTimeSlot());
            ps.setInt(4, booking.getVisitorCount());
            ps.setDouble(5, booking.getTotalAmount());
            ps.setTimestamp(6, booking.getCreatedAt());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // failed
    }

    // Get all bookings
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings ORDER BY createdAt DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Booking booking = mapResultSetToBooking(rs);
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Get bookings by user ID
    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE userId=? ORDER BY createdAt DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Get booking by ID
    public Booking getBookingById(int id) {
        String sql = "SELECT * FROM bookings WHERE bookingId=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBooking(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update a booking
    public boolean updateBooking(Booking booking) {
        String sql = "UPDATE bookings SET bookingDate=?, timeSlot=?, visitorCount=?, totalAmount=? WHERE bookingId=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(booking.getBookingDate()));
            ps.setString(2, booking.getTimeSlot());
            ps.setInt(3, booking.getVisitorCount());
            ps.setDouble(4, booking.getTotalAmount());
            ps.setInt(5, booking.getBookingId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete booking
    public boolean deleteBooking(int id) {
        String sql = "DELETE FROM bookings WHERE bookingId=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get bookings by date
    public List<Booking> getBookingsByDate(LocalDate date) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE bookingDate=? ORDER BY timeSlot ASC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(date));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    // Get all bookings with their places
    public List<Booking> getAllBookingsWithPlaces() throws SQLException {
        List<Booking> bookings = getAllBookings();
        BookingPlaceDAO bpDAO = new BookingPlaceDAO(conn);

        for (Booking b : bookings) {
            List<BookingPlace> places = bpDAO.getBookingPlacesByBookingId(b.getBookingId());
            b.setBookingPlaces(places);
        }
        return bookings;
    }

    // ------------------- Helper Method -------------------
    private Booking mapResultSetToBooking(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("bookingId"));
        booking.setUserId(rs.getInt("userId"));
        booking.setBookingDate(rs.getDate("bookingDate").toLocalDate());
        booking.setTimeSlot(rs.getString("timeSlot"));
        booking.setVisitorCount(rs.getInt("visitorCount"));
        booking.setTotalAmount(rs.getDouble("totalAmount"));
        booking.setCreatedAt(rs.getTimestamp("createdAt"));
        booking.setUserName(getUserNameById(booking.getUserId()));

        return booking;
    }
    
    // Inside BookingDAO
    public String getUserNameById(int userId) {
        String sql = "SELECT userName FROM users WHERE userId = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("userName");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // return null if not found
    }

    
}


