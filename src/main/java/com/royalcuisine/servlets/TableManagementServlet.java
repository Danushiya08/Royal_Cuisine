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

public class TableManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/royal_cuisine";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "1234";

    // Load MySQL JDBC driver explicitly (optional in newer versions)
    static {
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            // Log error or handle it as needed
        }
    }

    // Method to add a new table
    private void addTable(HttpServletRequest request) throws SQLException {
        String tableNumber = request.getParameter("table_number");
        boolean isAvailable = "1".equals(request.getParameter("is_available"));
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String imageUrl = request.getParameter("image_url");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");

        // SQL query to insert the table
        String sql = "INSERT INTO tables (table_number, is_available, capacity, image_url, price, description) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, Integer.parseInt(tableNumber));
            preparedStatement.setBoolean(2, isAvailable);
            preparedStatement.setInt(3, capacity);
            preparedStatement.setString(4, imageUrl);
            preparedStatement.setDouble(5, price);
            preparedStatement.setString(6, description);
            preparedStatement.executeUpdate();
        }
    }

    // Method to update an existing table
    private void editTable(HttpServletRequest request) throws SQLException {
        int tableId = Integer.parseInt(request.getParameter("table_id"));
        String tableNumber = request.getParameter("table_number");
        boolean isAvailable = "1".equals(request.getParameter("is_available"));
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String imageUrl = request.getParameter("image_url");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");

        // SQL query to update the table
        String sql = "UPDATE tables SET table_number = ?, is_available = ?, capacity = ?, image_url = ?, price = ?, description = ? WHERE table_id = ?";
        
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, Integer.parseInt(tableNumber));
            preparedStatement.setBoolean(2, isAvailable);
            preparedStatement.setInt(3, capacity);
            preparedStatement.setString(4, imageUrl);
            preparedStatement.setDouble(5, price);
            preparedStatement.setString(6, description);
            preparedStatement.setInt(7, tableId);
            preparedStatement.executeUpdate();
        }
    }

    // Method to delete a table
    private void deleteTable(HttpServletRequest request) throws SQLException {
        int tableId = Integer.parseInt(request.getParameter("table_id"));

        // SQL query to delete the table
        String sql = "DELETE FROM tables WHERE table_id = ?";
        
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, tableId);
            preparedStatement.executeUpdate();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the action parameter to determine what action the user wants to perform
        String action = request.getParameter("action");

        try {
            // Perform the appropriate action
            if ("addTable".equals(action)) {
                addTable(request);
                response.sendRedirect("admin_tables.jsp?message=Table added successfully");
            } else if ("editTable".equals(action)) {
                editTable(request);
                response.sendRedirect("admin_tables.jsp?message=Table updated successfully");
            } else if ("deleteTable".equals(action)) {
                deleteTable(request);
                response.sendRedirect("admin_tables.jsp?message=Table deleted successfully");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_tables.jsp?message=Error occurred: " + e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // You can implement GET if needed for certain operations like fetching data or confirmation
        doPost(request, response);
    }
}
