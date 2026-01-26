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
import java.util.UUID;

@WebServlet("/admin/places")
@MultipartConfig(
        fileSizeThreshold = 2 * 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 50 * 1024 * 1024
)
public class AdminPlaceServlet extends AdminBaseServlet {

    private static final String UPLOAD_DIR = "assets/img/resources/uploads";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            handleDelete(req, resp);
            return; 
        }
        handleAddOrUpdate(req, resp);
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = parseInt(req.getParameter("id"), 0);

        if (id > 0) {
            try (Connection conn = DBConnection.getConnection()) {
                PlaceDAO dao = new PlaceDAO(conn);
                dao.deletePlace(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        resp.sendRedirect(req.getContextPath() + "/admin/dashboard#places");
    }

    private void handleAddOrUpdate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String redirectSection = req.getParameter("redirectSection");
        redirectSection = (redirectSection == null) ? "" : "#" + redirectSection;

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
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard" + redirectSection);
                    return;
                }
            }

            place.setPlaceCode(trim(req.getParameter("placeCode")));
            place.setPlaceName(trim(req.getParameter("placeName")));
            place.setDescription(trim(req.getParameter("description")));
            place.setPricePerPerson(parseDouble(req.getParameter("pricePerPerson"), 0));
            place.setStatus(trim(req.getParameter("status")));

            String imageFile = handleUpload(req);
            if (imageFile != null) {
                place.setImageUrl(imageFile);
            }

            if (placeIdStr == null || placeIdStr.isEmpty()) {
                placeDAO.addPlace(place);
            } else {
                placeDAO.updatePlace(place);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/dashboard" + redirectSection);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    // ================= FILE UPLOAD =================
    private String handleUpload(HttpServletRequest req)
            throws IOException, ServletException {

        Part filePart = req.getPart("image"); // SAFE (multipart only)

        if (filePart != null && filePart.getSize() > 0) {

            String uploadPath = getServletContext().getRealPath("/")
                    + UPLOAD_DIR.replace("/", File.separator);

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String original = new File(filePart.getSubmittedFileName()).getName();
            String fileName = UUID.randomUUID() + "_" + original;

            filePart.write(uploadPath + File.separator + fileName);
            return fileName;
        }
        return null;
    }

    private int parseInt(String s, int d) {
        try { return Integer.parseInt(s.trim()); } catch (Exception e) { return d; }
    }

    private double parseDouble(String s, double d) {
        try { return Double.parseDouble(s.trim()); } catch (Exception e) { return d; }
    }

    private String trim(String s) {
        return (s == null) ? "" : s.trim();
    }
}
