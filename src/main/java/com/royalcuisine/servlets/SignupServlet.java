// SignupServlet.java
package com.royalcuisine.servlets;

import com.royalcuisine.utils.DBConnection;
import com.royalcuisine.utils.EmailSender;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("emailAddress");
        String password = request.getParameter("password");
        String contactNumber = request.getParameter("contactNumber");
        String role = request.getParameter("role");

        if (role == null || role.isEmpty()) {
            role = "user"; // Default role if not provided
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection.");
            }

            String sql = "INSERT INTO users (first_name, last_name, email, password, contact_number, role) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, email);
            stmt.setString(4, password);
            stmt.setString(5, contactNumber);
            stmt.setString(6, role);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("User registered successfully!");
                sendWelcomeEmail(email, firstName);
                response.sendRedirect("login.jsp"); // Redirect to your login page
            } else {
                System.out.println("User registration failed! No rows affected.");
                response.sendRedirect("signup.jsp?error=Signup failed."); // Redirect back to signup with error
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL Error during signup: " + e.getMessage());
            // Check for specific SQL errors like duplicate email
            if (e.getMessage().contains("Duplicate entry") && e.getMessage().contains("email")) {
                response.sendRedirect("signup.jsp?error=Email address already registered.");
            } else {
                response.sendRedirect("signup.jsp?error=Database error during signup.");
            }
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
                System.err.println("Error closing database resources: " + ex.getMessage());
            }
        }
    }

    private void sendWelcomeEmail(String toEmail, String firstName) {
        String subject = "Welcome to Royal Cuisine!";
        String body = "Hi " + firstName + ",\n\nWelcome to Royal Cuisine! We are excited to have you as a part of our community.\n\nBest regards,\nRoyal Cuisine Team";
        EmailSender.sendEmail(toEmail, subject, body);
    }
}