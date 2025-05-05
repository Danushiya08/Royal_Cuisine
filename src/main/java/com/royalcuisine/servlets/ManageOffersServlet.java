package com.royalcuisine.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class ManageOffersServlet extends HttpServlet {

    // JDBC details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/royal_cuisine";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "1234";

    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Handle POST requests (CRUD operations)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addOffer".equals(action)) {
            // Handle Add Offer
            addOffer(request, response);
        } else if ("editOffer".equals(action)) {
            // Handle Edit Offer
            editOffer(request, response);
        } else if ("deleteOffer".equals(action)) {
            // Handle Delete Offer
            deleteOffer(request, response);
        }
    }

    // Add new offer to the database
    private void addOffer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("offerTitle");
        String description = request.getParameter("offerDescription");
        String imageUrl = request.getParameter("offerImage");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "INSERT INTO offers (title, description, image_url) VALUES (?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, title);
                preparedStatement.setString(2, description);
                preparedStatement.setString(3, imageUrl);

                int rowsInserted = preparedStatement.executeUpdate();
                if (rowsInserted > 0) {
                    response.sendRedirect("admin_offers.jsp?message=Offer%20added%20successfully");
                } else {
                    response.sendRedirect("admin_offers.jsp?message=Error%20adding%20offer");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_offers.jsp?message=Error: " + e.getMessage());
        }
    }

    // Edit an existing offer
    private void editOffer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("offerTitle");
        String description = request.getParameter("offerDescription");
        String imageUrl = request.getParameter("offerImage");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "UPDATE offers SET title = ?, description = ?, image_url = ? WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, title);
                preparedStatement.setString(2, description);
                preparedStatement.setString(3, imageUrl);
                preparedStatement.setInt(4, id);

                int rowsUpdated = preparedStatement.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("admin_offers.jsp?message=Offer%20updated%20successfully");
                } else {
                    response.sendRedirect("admin_offers.jsp?message=Error%20updating%20offer");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_offers.jsp?message=Error: " + e.getMessage());
        }
    }

    // Delete an offer from the database
    private void deleteOffer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "DELETE FROM offers WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setInt(1, id);

                int rowsDeleted = preparedStatement.executeUpdate();
                if (rowsDeleted > 0) {
                    response.sendRedirect("admin_offers.jsp?message=Offer%20deleted%20successfully");
                } else {
                    response.sendRedirect("admin_offers.jsp?message=Error%20deleting%20offer");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_offers.jsp?message=Error: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // You can handle GET requests for additional functionality here, such as fetching offer details
    }
}
