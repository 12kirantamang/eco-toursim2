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
import java.util.stream.Collectors;

@WebServlet({"/home", "/index"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {
            PlaceDAO placeDAO = new PlaceDAO(conn);
            
            // Get all available places
            List<Place> allPlaces = placeDAO.getActivePlaces();
            
            // Get featured places (first 3)
            List<Place> featuredPlaces = allPlaces.stream()
                .limit(3)
                .collect(Collectors.toList());
            
            // Set attributes
            request.setAttribute("featuredPlaces", featuredPlaces);
            request.setAttribute("totalPlaces", allPlaces.size());
            
            // Forward to index.jsp
            request.getRequestDispatcher("/index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // If there's an error, still forward to index but without data
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
