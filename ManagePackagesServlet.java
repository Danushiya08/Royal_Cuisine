package com.royalcuisine.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class ManagePackagesServlet extends HttpServlet {

    // JDBC details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/royal_cuisine";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "12345678";

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

        if ("addPackage".equals(action)) {
            // Handle Add Package
            addPackage(request, response);
        } else if ("editPackage".equals(action)) {
            // Handle Edit Package
            editPackage(request, response);
        } else if ("deletePackage".equals(action)) {
            // Handle Delete Package
            deletePackage(request, response);
        }
    }

    // Handle Add Package
    private void addPackage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String packageName = request.getParameter("packageName");
        String description = request.getParameter("packageDescription");
        String imageUrl = request.getParameter("packageImage");
        double price = Double.parseDouble(request.getParameter("packagePrice"));

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "INSERT INTO packages (package_name, description, image_url, price) VALUES (?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, packageName);
                preparedStatement.setString(2, description);
                preparedStatement.setString(3, imageUrl);
                preparedStatement.setDouble(4, price);

                int rowsInserted = preparedStatement.executeUpdate();
                if (rowsInserted > 0) {
                    response.sendRedirect("admin_packages.jsp?message=Package%20added%20successfully");
                } else {
                    response.sendRedirect("admin_packages.jsp?message=Error%20adding%20package");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_packages.jsp?message=Error: " + e.getMessage());
        }
    }

    // Handle Edit Package
    private void editPackage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String packageName = request.getParameter("packageName");
        String description = request.getParameter("packageDescription");
        String imageUrl = request.getParameter("packageImage");
        double price = Double.parseDouble(request.getParameter("packagePrice"));

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "UPDATE packages SET package_name = ?, description = ?, image_url = ?, price = ? WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, packageName);
                preparedStatement.setString(2, description);
                preparedStatement.setString(3, imageUrl);
                preparedStatement.setDouble(4, price);
                preparedStatement.setInt(5, id);

                int rowsUpdated = preparedStatement.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("admin_packages.jsp?message=Package%20updated%20successfully");
                } else {
                    response.sendRedirect("admin_packages.jsp?message=Error%20updating%20package");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_packages.jsp?message=Error: " + e.getMessage());
        }
    }

    // Handle Delete Package
    private void deletePackage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "DELETE FROM packages WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setInt(1, id);

                int rowsDeleted = preparedStatement.executeUpdate();
                if (rowsDeleted > 0) {
                    response.sendRedirect("admin_packages.jsp?message=Package%20deleted%20successfully");
                } else {
                    response.sendRedirect("admin_packages.jsp?message=Error%20deleting%20package");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_packages.jsp?message=Error: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle GET requests if necessary (for viewing package details or fetching packages)
    }
}
