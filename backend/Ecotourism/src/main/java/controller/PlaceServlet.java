package controller;

import dao.PlaceDAO;
import model.Place;
import util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/place")
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

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                request.getRequestDispatcher("admin/place_form.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Place place = placeDAO.getPlaceById(id);
                request.setAttribute("place", place);
                request.getRequestDispatcher("admin/place_form.jsp").forward(request, response);
                break;
            case "delete":
                int delId = Integer.parseInt(request.getParameter("id"));
                placeDAO.deletePlace(delId);
                response.sendRedirect(request.getContextPath() + "/place");
                break;
            default:
                List<Place> places = placeDAO.getAllPlaces();
                request.setAttribute("places", places);
                request.getRequestDispatcher("admin/place_list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String placeIdStr = request.getParameter("placeId");
        String placeCode = request.getParameter("placeCode");
        String placeName = request.getParameter("placeName");
        String description = request.getParameter("description");
        double pricePerPerson = Double.parseDouble(request.getParameter("pricePerPerson"));
        String status = request.getParameter("status");

        Place place = new Place();
        place.setPlaceCode(placeCode);
        place.setPlaceName(placeName);
        place.setDescription(description);
        place.setPricePerPerson(pricePerPerson);
        place.setStatus(status);

        if (placeIdStr == null || placeIdStr.isEmpty()) {
            // Add new
            place.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            placeDAO.addPlace(place);
        } else {
            // Update existing
            place.setPlaceId(Integer.parseInt(placeIdStr));
            placeDAO.updatePlace(place);
        }

        response.sendRedirect(request.getContextPath() + "/place");
    }
}
