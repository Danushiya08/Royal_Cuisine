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


public class ManageFeedbacksServlet extends HttpServlet {

    // JDBC details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/royal_cuisine";
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

        if ("deleteFeedback".equals(action)) {
            // Handle Delete Feedback
            deleteFeedback(request, response);
        } else if ("editFeedback".equals(action)) {
            // Handle Edit Feedback
            editFeedback(request, response);
        }
    }

    // Handle Delete Feedback
    private void deleteFeedback(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "DELETE FROM contact WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setInt(1, id);

                int rowsDeleted = preparedStatement.executeUpdate();
                if (rowsDeleted > 0) {
                    response.sendRedirect("admin_feedbacks.jsp?message=Feedback%20deleted%20successfully");
                } else {
                    response.sendRedirect("admin_feedbacks.jsp?message=Error%20deleting%20feedback");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_feedbacks.jsp?message=Error: " + e.getMessage());
        }
    }

    // Handle Edit Feedback
    private void editFeedback(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String message = request.getParameter("feedbackMessage");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "UPDATE contact SET message = ? WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, message);
                preparedStatement.setInt(2, id);

                int rowsUpdated = preparedStatement.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("admin_feedbacks.jsp?message=Feedback%20updated%20successfully");
                } else {
                    response.sendRedirect("admin_feedbacks.jsp?message=Error%20updating%20feedback");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_feedbacks.jsp?message=Error: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle GET requests if necessary (for viewing feedback details or fetching feedbacks)
    }
}
