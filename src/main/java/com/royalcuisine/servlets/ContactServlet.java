package com.royalcuisine.servlets;

import com.royalcuisine.utils.EmailSender; // Import the EmailSender utility
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class ContactServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data from request
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");

        // Setup response to be written to the browser
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Database connection variables
        Connection conn = null;
        PreparedStatement pst = null;

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection (replace with your database credentials)
            String url = "jdbc:mysql://localhost:3306/royal_cuisine";
            String dbUser = "root";
            String dbPassword = "12345678";
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // MySQL query to insert form data into the 'contact_messages' table
            String query = "INSERT INTO contact (name, email, phone, message) VALUES (?, ?, ?, ?)";

            // Prepare the SQL statement
            pst = conn.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, phone);
            pst.setString(4, message);

            // Execute the update (insert)
            int result = pst.executeUpdate();

            // Check the result and send an appropriate response
            if (result > 0) {
                // Send a confirmation email to the user
                sendConfirmationEmail(email, name);

                out.println("<h3>Thank you for your message. We will get back to you soon!</h3>");
            } else {
                out.println("<h3>Sorry, there was an issue processing your message. Please try again later.</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error occurred while processing your request. Please try again later.</h3>");
        } finally {
            try {
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to send confirmation email to the user
    private void sendConfirmationEmail(String toEmail, String firstName) {
        String subject = "Thank you for contacting Royal Cuisine!";
        String body = "Hi " + firstName + ",\n\nThank you for reaching out to Royal Cuisine. We have received your message and our team will get back to you shortly.\n\nBest regards,\nRoyal Cuisine Team";

        // Send the email using EmailSender utility
        EmailSender.sendEmail(toEmail, subject, body);
    }
}
