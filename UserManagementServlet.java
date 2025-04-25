package com.royalcuisine.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class UserManagementServlet extends HttpServlet {

    // JDBC connection details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/royal_cuisine";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "1234";

    static {
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            // Log or display an error if the JDBC driver is not found
        }
    }

    // Handle POST requests (add, edit, delete)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Debugging: Print action value
        System.out.println("Action received: " + action);

        // Check if action is null
        if (action == null) {
            response.getWriter().println("Error: No action specified.");
            return;
        }

        try {
            if ("addUser".equals(action)) {
                addUser(request, response);
            } else if ("editUser".equals(action)) {
                editUser(request, response);
            } else if ("deleteUser".equals(action)) {
                deleteUser(request, response);
            } else {
                throw new IllegalArgumentException("Invalid action: " + action);
            }
        } catch (Exception e) {
            // Handle and display any exceptions encountered in the POST method
            response.getWriter().println("Error in processing the request: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Add a new user
    private void addUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String contactNumber = request.getParameter("contactNumber");
        String email = request.getParameter("userEmail");
        String password = request.getParameter("userPassword");
        String role = request.getParameter("userRole");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "INSERT INTO users (first_name, last_name, contact_number, email, password, role) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, firstName);
                preparedStatement.setString(2, lastName);
                preparedStatement.setString(3, contactNumber);
                preparedStatement.setString(4, email);
                preparedStatement.setString(5, password);
                preparedStatement.setString(6, role);

                int result = preparedStatement.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("admin_users.jsp?message=User added successfully.");
                } else {
                    response.getWriter().println("Error: User could not be added.");
                }
            }
        } catch (Exception e) {
            // Log the error and send a detailed response
            e.printStackTrace();
            response.getWriter().println("Database error while adding user: " + e.getMessage());
        }
    }

    // Edit an existing user
    private void editUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String contactNumber = request.getParameter("contactNumber");
        String email = request.getParameter("userEmail");
        String password = request.getParameter("userPassword");
        String role = request.getParameter("userRole");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "UPDATE users SET first_name = ?, last_name = ?, contact_number = ?, email = ?, password = ?, role = ? WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, firstName);
                preparedStatement.setString(2, lastName);
                preparedStatement.setString(3, contactNumber);
                preparedStatement.setString(4, email);
                preparedStatement.setString(5, password);
                preparedStatement.setString(6, role);
                preparedStatement.setInt(7, userId);

                int result = preparedStatement.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("admin_users.jsp?message=User updated successfully.");
                } else {
                    response.getWriter().println("Error: User could not be updated.");
                }
            }
        } catch (Exception e) {
            // Log the error and send a detailed response
            e.printStackTrace();
            response.getWriter().println("Database error while editing user: " + e.getMessage());
        }
    }

    // Delete a user
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "DELETE FROM users WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setInt(1, userId);

                int result = preparedStatement.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("admin_users.jsp?message=User deleted successfully.");
                } else {
                    response.getWriter().println("Error: User could not be deleted.");
                }
            }
        } catch (Exception e) {
            // Log the error and send a detailed response
            e.printStackTrace();
            response.getWriter().println("Database error while deleting user: " + e.getMessage());
        }
    }

    // Handle GET requests (for editing user)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("deleteUser".equals(action)) {
                deleteUser(request, response);  // This will handle delete via GET
            } else {
                String userId = request.getParameter("userId");
                if (userId != null) {
                    getUserDetails(request, response, Integer.parseInt(userId));
                }
            }
        } catch (Exception e) {
            // Handle exceptions in GET method
            e.printStackTrace();
            response.getWriter().println("Error in GET request handling: " + e.getMessage());
        }
    }

    private void getUserDetails(HttpServletRequest request, HttpServletResponse response, int userId) throws ServletException, IOException {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             Statement statement = connection.createStatement()) {

            String sql = "SELECT * FROM users WHERE id = " + userId;
            try (ResultSet resultSet = statement.executeQuery(sql)) {

                if (resultSet.next()) {
                    request.setAttribute("user", resultSet);
                    request.getRequestDispatcher("admin_users.jsp").forward(request, response);
                } else {
                    response.getWriter().println("Error: User not found.");
                }
            }
        } catch (Exception e) {
            // Log and handle any database errors
            e.printStackTrace();
            response.getWriter().println("Database error while fetching user details: " + e.getMessage());
        }
    }
}
