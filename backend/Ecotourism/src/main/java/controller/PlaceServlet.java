package controller;

import dao.PlaceDAO;
import model.Place;
import util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/places")
public class PlaceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        try (Connection conn = DBConnection.getConnection()) { // new connection per request
            PlaceDAO placeDAO = new PlaceDAO(conn);

            if (idStr == null) {
                // Show all ACTIVE places
                List<Place> places = placeDAO.getActivePlaces();
                request.setAttribute("places", places);
                request.getRequestDispatcher("/place_list.jsp").forward(request, response);
            } else {
                // Show single place details
                int id = Integer.parseInt(idStr);
                Place place = placeDAO.getPlaceById(id);

                if (place == null || !"ACTIVE".equalsIgnoreCase(place.getStatus())) {
                    // Redirect if place is inactive or not found
                    response.sendRedirect(request.getContextPath() + "/places");
                    return;
                }

                request.setAttribute("place", place);
                request.getRequestDispatcher("/place_detail.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}
