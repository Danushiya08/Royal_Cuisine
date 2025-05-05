package com.royalcuisine.servlets;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.*;

public class GetPackagesServlet extends HttpServlet {
    
    // Package class to store package data
    public static class Package {
        private String packageName;
        private String imageUrl;
        private double price;
        private String description;

        // Getters and setters
        public String getPackageName() {
            return packageName;
        }

        public void setPackageName(String packageName) {
            this.packageName = packageName;
        }

        public String getImageUrl() {
            return imageUrl;
        }

        public void setImageUrl(String imageUrl) {
            this.imageUrl = imageUrl;
        }

        public double getPrice() {
            return price;
        }

        public void setPrice(double price) {
            this.price = price;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }
    }

    private static final Logger logger = Logger.getLogger(GetPackagesServlet.class.getName());

    static {
        // Add ConsoleHandler to the logger to log to the console
        ConsoleHandler consoleHandler = new ConsoleHandler();
        consoleHandler.setLevel(Level.ALL);
        logger.addHandler(consoleHandler);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/royal_cuisine";
        String jdbcUsername = "root";
        String jdbcPassword = "1234";

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        List<Package> packageList = new ArrayList<>();

        try {
            // Establish connection to the database
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // Query to fetch packages
            String sql = "SELECT package_name, image_url, price, description FROM packages";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            // Iterate over the result set and create Package objects
            while (resultSet.next()) {
                Package pkg = new Package();
                pkg.setPackageName(resultSet.getString("package_name"));
                pkg.setImageUrl(resultSet.getString("image_url"));
                pkg.setPrice(resultSet.getDouble("price"));
                pkg.setDescription(resultSet.getString("description"));

                packageList.add(pkg);
            }

            // Log the package list to verify it's being populated
            logger.log(Level.INFO, "Fetched " + packageList.size() + " packages from the database");

        } catch (SQLException e) {
            // Log the exception details and send an error message to the client
            logger.log(Level.SEVERE, "Database error occurred while fetching packages", e);
            request.setAttribute("errorMessage", "Sorry, we are unable to fetch packages at the moment. Please try again later.");
            // Forward to an error page or same page with an error message
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            // Catch any other exceptions that might occur
            logger.log(Level.SEVERE, "Unexpected error occurred", e);
            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again later.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } finally {
            // Close resources
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                logger.log(Level.WARNING, "Error closing database resources", e);
            }
        }

        // Set the packages as a request attribute and forward to the JSP page
        if (!packageList.isEmpty()) {
            request.setAttribute("packages", packageList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("book.jsp");
            dispatcher.forward(request, response);
        } else {
            // If no packages were found, set an error message
            request.setAttribute("errorMessage", "No packages available at the moment.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
