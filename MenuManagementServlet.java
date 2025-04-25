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

public class MenuManagementServlet extends HttpServlet {

    // JDBC details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/royal_cuisine";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "12345678";
    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("editMeal".equals(action)) {
            // Handle Edit Meal
            editMeal(request, response);
        } else if ("deleteMeal".equals(action)) {
            // Handle Delete Meal
            deleteMeal(request, response);
        } else if ("editBeverage".equals(action)) {
            // Handle Edit Beverage
            editBeverage(request, response);
        } else if ("deleteBeverage".equals(action)) {
            // Handle Delete Beverage
            deleteBeverage(request, response);
        } else if ("addMeal".equals(action)) {
            // Handle Add Meal
            addMeal(request, response);
        } else if ("addBeverage".equals(action)) {
            // Handle Add Beverage
            addBeverage(request, response);
        }
    }

    // Handle Add Meal
    private void addMeal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("mealName");
        String description = request.getParameter("mealDescription");
        double price = Double.parseDouble(request.getParameter("mealPrice"));
        
        // Get the image URL
        String imageUrl = request.getParameter("mealImage");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "INSERT INTO meals (name, description, price, image_url) VALUES (?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, name);
                statement.setString(2, description);
                statement.setDouble(3, price);
                statement.setString(4, imageUrl); // Save the image URL in DB

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    response.sendRedirect("admin_menu.jsp?message=Meal%20added%20successfully");
                } else {
                    response.sendRedirect("admin_menu.jsp?message=Error%20adding%20meal");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_menu.jsp?message=Error: " + e.getMessage());
        }
    }

    // Handle Add Beverage
    private void addBeverage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("beverageName");
        String description = request.getParameter("beverageDescription");
        double price = Double.parseDouble(request.getParameter("beveragePrice"));
        
        // Get the image URL
        String imageUrl = request.getParameter("beverageImage");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "INSERT INTO beverages (name, description, price, image_url) VALUES (?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, name);
                statement.setString(2, description);
                statement.setDouble(3, price);
                statement.setString(4, imageUrl); // Save the image URL in DB

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    response.sendRedirect("admin_menu.jsp?message=Beverage%20added%20successfully");
                } else {
                    response.sendRedirect("admin_menu.jsp?message=Error%20adding%20beverage");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_menu.jsp?message=Error: " + e.getMessage());
        }
    }

    // Handle Edit Meal
    private void editMeal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("mealName");
        String description = request.getParameter("mealDescription");
        double price = Double.parseDouble(request.getParameter("mealPrice"));

        // Get the image URL
        String imageUrl = request.getParameter("mealImage");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "UPDATE meals SET name = ?, description = ?, price = ?, image_url = ? WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, name);
                statement.setString(2, description);
                statement.setDouble(3, price);
                statement.setString(4, imageUrl); // Save the image URL in DB
                statement.setInt(5, id);

                int rowsUpdated = statement.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("admin_menu.jsp?message=Meal%20updated%20successfully");
                } else {
                    response.sendRedirect("admin_menu.jsp?message=Error%20updating%20meal");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_menu.jsp?message=Error: " + e.getMessage());
        }
    }

    // Handle Edit Beverage
    private void editBeverage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("beverageName");
        String description = request.getParameter("beverageDescription");
        double price = Double.parseDouble(request.getParameter("beveragePrice"));

        // Get the image URL
        String imageUrl = request.getParameter("beverageImage");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "UPDATE beverages SET name = ?, description = ?, price = ?, image_url = ? WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, name);
                statement.setString(2, description);
                statement.setDouble(3, price);
                statement.setString(4, imageUrl); // Save the image URL in DB
                statement.setInt(5, id);

                int rowsUpdated = statement.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("admin_menu.jsp?message=Beverage%20updated%20successfully");
                } else {
                    response.sendRedirect("admin_menu.jsp?message=Error%20updating%20beverage");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_menu.jsp?message=Error: " + e.getMessage());
        }
    }

    // Handle Delete Meal
    private void deleteMeal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "DELETE FROM meals WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, id);

                int rowsDeleted = statement.executeUpdate();
                if (rowsDeleted > 0) {
                    response.sendRedirect("admin_menu.jsp?message=Meal%20deleted%20successfully");
                } else {
                    response.sendRedirect("admin_menu.jsp?message=Error%20deleting%20meal");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_menu.jsp?message=Error: " + e.getMessage());
        }
    }

    // Handle Delete Beverage
    private void deleteBeverage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "DELETE FROM beverages WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, id);

                int rowsDeleted = statement.executeUpdate();
                if (rowsDeleted > 0) {
                    response.sendRedirect("admin_menu.jsp?message=Beverage%20deleted%20successfully");
                } else {
                    response.sendRedirect("admin_menu.jsp?message=Error%20deleting%20beverage");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_menu.jsp?message=Error: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // You can handle additional GET requests or data retrievals here, if necessary
    }
}
