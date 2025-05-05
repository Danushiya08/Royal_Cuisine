package com.royalcuisine.servlets;

import com.royalcuisine.utils.DBConnection;
import com.royalcuisine.utils.EmailSender; // Make sure you have this utility
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class FeedbackServlet extends HttpServlet { 
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String bookingNo = request.getParameter("booking_no");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");

        if (name == null || bookingNo == null || email == null || phone == null || message == null || 
            name.isEmpty() || bookingNo.isEmpty() || email.isEmpty() || phone.isEmpty() || message.isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("feedback.jsp").forward(request, response);
            return;
        }

        // SQL query to insert feedback into the database
        String sql = "INSERT INTO feedback (name, booking_no, email, phone, message) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, bookingNo);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.setString(5, message);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                // Send Thank you email
                sendThankYouEmail(email, name);

                // Redirect to success page
                response.sendRedirect("feedback.jsp?success=Feedback submitted successfully.");
            } else {
                // Redirect back to the contact form with an error
                request.setAttribute("error", "Failed to submit feedback. Please try again.");
                request.getRequestDispatcher("feedback.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error during feedback submission.");
            request.getRequestDispatcher("feedback.jsp").forward(request, response);
        }
    }

    // Method to send the thank you email to the user
    private void sendThankYouEmail(String toEmail, String firstName) {
        String subject = "Thank You for Your Feedback!";
        String body = "Hi " + firstName + ",\n\nThank you for providing feedback to Royal Cuisine! We appreciate your input and will use it to enhance our service.\n\nBest regards,\nRoyal Cuisine Team";
        
        // Send the email using the EmailSender utility
        EmailSender.sendEmail(toEmail, subject, body);
    }
}
