package dao;

import model.Place;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlaceDAO {
    private Connection conn;

    public PlaceDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean addPlace(Place place) {
        String sql = "INSERT INTO places (placeCode, placeName, description, pricePerPerson, status, createdAt, imageUrl) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, place.getPlaceCode());
            ps.setString(2, place.getPlaceName());
            ps.setString(3, place.getDescription());
            ps.setDouble(4, place.getPricePerPerson());
            ps.setString(5, place.getStatus());
            ps.setTimestamp(6, place.getCreatedAt());
            ps.setString(7, place.getImageUrl()); // NEW: imageUrl
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Place> getAllPlaces() {
        List<Place> places = new ArrayList<>();
        String sql = "SELECT * FROM places ORDER BY createdAt DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Place place = new Place();
                place.setPlaceId(rs.getInt("placeId"));
                place.setPlaceCode(rs.getString("placeCode"));
                place.setPlaceName(rs.getString("placeName"));
                place.setDescription(rs.getString("description"));
                place.setPricePerPerson(rs.getDouble("pricePerPerson"));
                place.setStatus(rs.getString("status"));
                place.setCreatedAt(rs.getTimestamp("createdAt"));
                place.setImageUrl(rs.getString("imageUrl")); // NEW
                places.add(place);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return places;
    }

    public Place getPlaceById(int id) {
        String sql = "SELECT * FROM places WHERE placeId=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Place place = new Place();
                place.setPlaceId(rs.getInt("placeId"));
                place.setPlaceCode(rs.getString("placeCode"));
                place.setPlaceName(rs.getString("placeName"));
                place.setDescription(rs.getString("description"));
                place.setPricePerPerson(rs.getDouble("pricePerPerson"));
                place.setStatus(rs.getString("status"));
                place.setCreatedAt(rs.getTimestamp("createdAt"));
                place.setImageUrl(rs.getString("imageUrl")); // NEW
                return place;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePlace(Place place) {
        String sql = "UPDATE places SET placeCode=?, placeName=?, description=?, pricePerPerson=?, status=?, imageUrl=? WHERE placeId=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, place.getPlaceCode());
            ps.setString(2, place.getPlaceName());
            ps.setString(3, place.getDescription());
            ps.setDouble(4, place.getPricePerPerson());
            ps.setString(5, place.getStatus());
            ps.setString(6, place.getImageUrl()); // NEW
            ps.setInt(7, place.getPlaceId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deletePlace(int id) {
        String sql = "DELETE FROM places WHERE placeId=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
