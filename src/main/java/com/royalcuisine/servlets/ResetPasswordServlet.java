package com.royalcuisine.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        // Example database logic to update the password
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Database connection
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/royal_cuisine", "root", "12345678");
            String query = "UPDATE users SET password = ? WHERE email = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, newPassword); // Hash the password in production
            preparedStatement.setString(2, email);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                // Password reset successful
                sendResetPasswordSuccessEmail(email);
                response.sendRedirect("login.jsp");
            } else {
                // User not found
                response.sendRedirect("error.jsp");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to send email after password reset
    private void sendResetPasswordSuccessEmail(String email) {
        // Set up the properties for the mail session
        String host = "smtp.gmail.com";  // Replace with your SMTP server
        String from = "shiyadanu891@gmail.com"; // Replace with the sender's email
        String password = "xtlb byjw rmfv vpgf"; // Replace with the sender's email password
        String subject = "Password Reset Success";
        String body = "Dear User,\n\nYour password has been successfully reset. You can now log in with your new password.\n\nBest regards,\nRoyal Cuisine Team";

        // Set the properties for the session
        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        properties.setProperty("mail.smtp.port", "587");
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", "true");

        Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(from, password);
            }
        });

        try {
            // Create the MimeMessage
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject(subject);
            message.setText(body);

            // Send the message
            Transport.send(message);
            System.out.println("Password reset email sent successfully.");
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("Failed to send the email.");
        }
    }
}
