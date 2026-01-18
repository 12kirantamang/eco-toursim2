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
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    bp.setBookingPlaceId(rs.getInt(1));
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
                BookingPlace bp = new BookingPlace();
                bp.setBookingPlaceId(rs.getInt("bookingPlaceId"));
                bp.setBookingId(rs.getInt("bookingId"));
                bp.setPlaceId(rs.getInt("placeId"));
                list.add(bp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Delete
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
}
