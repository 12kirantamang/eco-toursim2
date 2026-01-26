package controller;

import com.google.gson.Gson;
import dao.UserDAO;
import dao.PlaceDAO;
import dao.BookingDAO;
import dao.BookingPlaceDAO;
import model.Booking;
import model.BookingPlace;
import model.Place;
import util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends AdminBaseServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {

            UserDAO userDAO = new UserDAO(conn);
            PlaceDAO placeDAO = new PlaceDAO(conn);
            BookingDAO bookingDAO = new BookingDAO(conn);
            BookingPlaceDAO bookingPlaceDAO = new BookingPlaceDAO(conn);

            // fetch data
            List<Booking> bookings = bookingDAO.getAllBookings();
            List<BookingPlace> allBookingPlaces = bookingPlaceDAO.getAllBookingPlaces();
            List<?> allUsers = userDAO.getAllUsers();
            List<?> allPlaces = placeDAO.getAllPlaces();

            // group booking places by bookingId
            Map<Integer, List<BookingPlace>> bookingPlacesMap = allBookingPlaces
                    .stream()
                    .collect(Collectors.groupingBy(BookingPlace::getBookingId));

            Gson gson = new Gson();
            
            

            // attach places & JSON to each booking
            for (Booking b : bookings) {
            	
            	List<BookingPlace> places = bookingPlacesMap.get(b.getBookingId());
            	if (places != null) {
            	    for (BookingPlace bp : places) {
            	        Place place = placeDAO.getPlaceById(bp.getPlaceId());
            	        if (place != null) {
            	            bp.setPlaceName(place.getPlaceName());
            	            bp.setPricePerPerson(place.getPricePerPerson());
            	        }
            	    }
            	    b.setBookingPlaces(places);
            	    b.setBookingPlacesJson(gson.toJson(places));
            	} else {
            	    b.setBookingPlaces(List.of());
            	    b.setBookingPlacesJson("[]");
            	}

            }

            // set attributes
            request.setAttribute("users", allUsers);
            request.setAttribute("places", allPlaces);
            request.setAttribute("bookings", bookings);

            request.setAttribute("totalUsers", allUsers.size());
            request.setAttribute("totalPlaces", allPlaces.size());
            request.setAttribute("totalBookings", bookings.size());

            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}
