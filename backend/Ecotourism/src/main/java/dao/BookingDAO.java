package dao;

import model.Booking;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    private Connection conn;

    public BookingDAO(Connection conn) {
        this.conn = conn;
    }

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

    // Get all bookings
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings ORDER BY createdAt DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("bookingId"));
                booking.setUserId(rs.getInt("userId"));
                booking.setBookingDate(rs.getDate("bookingDate").toLocalDate());
                booking.setTimeSlot(rs.getString("timeSlot"));
                booking.setVisitorCount(rs.getInt("visitorCount"));
                booking.setTotalAmount(rs.getDouble("totalAmount"));
                booking.setCreatedAt(rs.getTimestamp("createdAt"));
                bookings.add(booking);
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
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("bookingId"));
                booking.setUserId(rs.getInt("userId"));
                booking.setBookingDate(rs.getDate("bookingDate").toLocalDate());
                booking.setTimeSlot(rs.getString("timeSlot"));
                booking.setVisitorCount(rs.getInt("visitorCount"));
                booking.setTotalAmount(rs.getDouble("totalAmount"));
                booking.setCreatedAt(rs.getTimestamp("createdAt"));
                return booking;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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
}
