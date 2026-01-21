package dao;

import model.BookingPlace;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingPlaceDAO {
    private Connection conn;

    public BookingPlaceDAO(Connection conn) {
        this.conn = conn;
    }

    // Add a BookingPlace
    public boolean addBookingPlace(BookingPlace bp) {
        String sql = "INSERT INTO bookingplaces (bookingId, placeId) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, bp.getBookingId());
            ps.setInt(2, bp.getPlaceId());
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        bp.setBookingPlaceId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all booking places
    public List<BookingPlace> getAllBookingPlaces() {
        List<BookingPlace> list = new ArrayList<>();
        String sql = "SELECT * FROM bookingplaces";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToBookingPlace(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get booking places by bookingId
    public List<BookingPlace> getByBookingId(int bookingId) {
        List<BookingPlace> list = new ArrayList<>();
        String sql = "SELECT * FROM bookingplaces WHERE bookingId=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToBookingPlace(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Delete by bookingPlaceId
    public boolean deleteBookingPlace(int id) {
        String sql = "DELETE FROM bookingplaces WHERE bookingPlaceId=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete all places for a booking
    public boolean deleteBookingPlacesByBookingId(int bookingId) {
        String sql = "DELETE FROM bookingplaces WHERE bookingId=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ------------------- Helper -------------------
    private BookingPlace mapResultSetToBookingPlace(ResultSet rs) throws SQLException {
        BookingPlace bp = new BookingPlace();
        bp.setBookingPlaceId(rs.getInt("bookingPlaceId"));
        bp.setBookingId(rs.getInt("bookingId"));
        bp.setPlaceId(rs.getInt("placeId"));
        return bp;
    }
}
