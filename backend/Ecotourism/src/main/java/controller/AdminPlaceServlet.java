package controller;

import dao.PlaceDAO;
import model.Place;
import util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/places")
@MultipartConfig(
        fileSizeThreshold = 2 * 1024 * 1024,   // 2MB
        maxFileSize = 10 * 1024 * 1024,        // 10MB
        maxRequestSize = 50 * 1024 * 1024      // 50MB
)
public class AdminPlaceServlet extends AdminBaseServlet {

    private static final String UPLOAD_DIR = "assets/img/uploads";
    private static final String STATUS_ACTIVE = "ACTIVE";
    private static final String STATUS_INACTIVE = "INACTIVE";
    private static final String REDIRECT_URL = "/admin/places";

    // ===== GET =====
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try (Connection conn = DBConnection.getConnection()) {
            PlaceDAO placeDAO = new PlaceDAO(conn);

            switch (action) {
                case "add":
                    req.getRequestDispatcher("/admin/place_form.jsp").forward(req, resp);
                    break;

                case "edit":
                    showEditForm(req, resp, placeDAO);
                    break;

                case "delete":
                    softDelete(req, resp, placeDAO);
                    break;

                default:
                    listPlaces(req, resp, placeDAO);
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    // ===== POST =====
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {
            PlaceDAO placeDAO = new PlaceDAO(conn);

            Place place;
            String placeIdStr = req.getParameter("placeId");

            if (placeIdStr == null || placeIdStr.isEmpty()) {
                place = new Place();
                place.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            } else {
                int placeId = parseInt(placeIdStr, 0);
                place = placeDAO.getPlaceById(placeId);
                if (place == null) {
                    resp.sendRedirect(req.getContextPath() + REDIRECT_URL);
                    return;
                }
            }

            // ===== Set values =====
            place.setPlaceCode(trim(req.getParameter("placeCode")));
            place.setPlaceName(trim(req.getParameter("placeName")));
            place.setDescription(trim(req.getParameter("description")));
            place.setPricePerPerson(parseDouble(req.getParameter("pricePerPerson"), 0));
            place.setStatus(trim(req.getParameter("status")));

            // ===== Handle file upload =====
            String uploadedImage = handleUpload(req);
            if (uploadedImage != null) {
                place.setImageUrl(uploadedImage);
            }

            // ===== Save to DB =====
            if (placeIdStr == null || placeIdStr.isEmpty()) {
                placeDAO.addPlace(place);
            } else {
                placeDAO.updatePlace(place);
            }

            resp.sendRedirect(req.getContextPath() + REDIRECT_URL);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    // ===== METHODS =====
    private void listPlaces(HttpServletRequest req, HttpServletResponse resp, PlaceDAO placeDAO)
            throws ServletException, IOException {
        List<Place> places = placeDAO.getAllPlaces();
        req.setAttribute("places", places);
        req.getRequestDispatcher("/admin/place_list.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp, PlaceDAO placeDAO)
            throws ServletException, IOException {
        int id = parseInt(req.getParameter("id"), 0);
        Place place = placeDAO.getPlaceById(id);
        if (place == null) {
            resp.sendRedirect(req.getContextPath() + REDIRECT_URL);
            return;
        }
        req.setAttribute("place", place);
        req.getRequestDispatcher("/admin/place_form.jsp").forward(req, resp);
    }

    private void softDelete(HttpServletRequest req, HttpServletResponse resp, PlaceDAO placeDAO)
            throws IOException {
        int id = parseInt(req.getParameter("id"), 0);
        Place place = placeDAO.getPlaceById(id);
        if (place != null) {
            place.setStatus(STATUS_INACTIVE);
            placeDAO.updatePlace(place);
        }
        resp.sendRedirect(req.getContextPath() + REDIRECT_URL);
    }

    // ===== Helper Methods =====
    private String handleUpload(HttpServletRequest req) throws IOException, ServletException {
        Part filePart = req.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            String fileName = UUID.randomUUID() + "_" + new File(filePart.getSubmittedFileName()).getName();
            filePart.write(uploadPath + File.separator + fileName);

            return UPLOAD_DIR + "/" + fileName;
        }
        return null;
    }

    private int parseInt(String str, int defaultVal) {
        try { return Integer.parseInt(str.trim()); } catch (Exception e) { return defaultVal; }
    }

    private double parseDouble(String str, double defaultVal) {
        try { return Double.parseDouble(str.trim()); } catch (Exception e) { return defaultVal; }
    }

    private String trim(String str) {
        return (str == null) ? "" : str.trim();
    }
}
