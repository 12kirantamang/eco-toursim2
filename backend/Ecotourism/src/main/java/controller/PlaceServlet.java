package controller;

import dao.PlaceDAO;
import model.Place;
import util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/places")
public class PlaceServlet extends HttpServlet {

    private PlaceDAO placeDAO;

    @Override
    public void init() throws ServletException {
        try {
            placeDAO = new PlaceDAO(DBConnection.getConnection());
        } catch (Exception e) {
            throw new ServletException("Cannot initialize PlaceDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr == null) {
            // Show all ACTIVE places
            List<Place> places = placeDAO.getActivePlaces();
            request.setAttribute("places", places);
            request.getRequestDispatcher("/place_list.jsp").forward(request, response);
        } else {
            // Show single place details
            int id = Integer.parseInt(idStr);
            Place place = placeDAO.getPlaceById(id);

            if (place == null || !"ACTIVE".equals(place.getStatus())) {
                // Redirect if place is inactive or not found
                response.sendRedirect(request.getContextPath() + "/places");
                return;
            }

            request.setAttribute("place", place);
            request.getRequestDispatcher("/place_detail.jsp").forward(request, response);
        }
    }
}
