package com.royalcuisine.servlets;

import com.royalcuisine.utils.DBConnection;
import com.royalcuisine.utils.EmailSender; // Import EmailSender utility
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BookTableServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String guests = request.getParameter("guests");
        String packageSelected = request.getParameter("package");
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection.");
            }
            
            String sql = "INSERT INTO reservations (name, email, phone, reservation_date,reservation_time, guests, package_selected) VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, date);
            stmt.setString(5, time);
            stmt.setString(6, guests);
            stmt.setString(7, packageSelected);
            
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                // Reservation successful, send confirmation email to the user
                sendConfirmationEmail(email, name, date, time, packageSelected, guests);

                out.println("<script type='text/javascript'>");
                out.println("alert('Reservation Successful! A confirmation email has been sent.');");
                out.println("window.location='home.jsp';");
                out.println("</script>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<script type='text/javascript'>");
            out.println("alert('Error while processing reservation. Please try again.');");
            out.println("window.location='profile.jsp';");
            out.println("</script>");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    // Method to send a reservation confirmation email to the user
    private void sendConfirmationEmail(String toEmail, String name, String date, String time, String packageSelected, String guests) {
        String subject = "Reservation Confirmation - Royal Cuisine";
        String body = "Dear " + name + ",\n\n" +
                      "Thank you for making a reservation with Royal Cuisine. Your reservation details are as follows:\n\n" +
                      "Package: " + packageSelected + "\n" +
                      "Reservation Date: " + date + "\n" +
                      "Reservation Time: " + time + "\n" +
                      "Number of Guests: " + guests + "\n\n" +
                      "We look forward to serving you soon!\n\n" +
                      "Best regards,\n" +
                      "Royal Cuisine Team";

        // Send the email using EmailSender utility
        EmailSender.sendEmail(toEmail, subject, body);
    }
}
