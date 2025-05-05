package com.royalcuisine.servlets;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


@WebServlet("/DownloadReportServlet")
public class DownloadReportServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession(false);
	    String email = (String) session.getAttribute("email");
	    String role = "Administrator"; // You can fetch from DB if needed

	    response.setContentType("application/pdf");
	    response.setHeader("Content-Disposition", "attachment; filename=Admin_Report.pdf");

	    String jdbcURL = "jdbc:mysql://localhost:3306/royal_cuisine";
	    String jdbcUsername = "root";
	    String jdbcPassword = "1234";

	    try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
	        Document document = new Document();
	        OutputStream out = response.getOutputStream();
	        PdfWriter.getInstance(document, out);

	        document.open();

	        Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
	        Font headerFont = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);
	        Font normalFont = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL);

	        Paragraph title = new Paragraph("Admin Daily Report", titleFont);
	        title.setAlignment(Element.ALIGN_CENTER);
	        document.add(title);
	        	        
	        document.add(new Paragraph(" "));
	        document.add(new Paragraph("Admin Email: " + email, normalFont));
	        document.add(new Paragraph("Role: " + role, normalFont));
	        document.add(new Paragraph(" "));
	        
	        LocalDateTime now = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        String formattedDateTime = now.format(formatter);
	        
	        Font timestampFont = new Font(Font.FontFamily.HELVETICA, 10, Font.ITALIC, BaseColor.DARK_GRAY);
	        Font smallHeaderFont = new Font(Font.FontFamily.HELVETICA, 13, Font.BOLD, BaseColor.DARK_GRAY);
	        Font infoFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.BLACK);



	        Paragraph timestamp = new Paragraph("Report Generated At: " + formattedDateTime, timestampFont);
	        timestamp.setAlignment(Element.ALIGN_RIGHT); 
	        document.add(timestamp);

	        document.add(new Paragraph(" ")); 
	        
	        String totalPaymentQuery = "SELECT SUM(total_amount) AS total_amount_today FROM payments WHERE DATE(payment_date) = CURDATE()";
	        try (PreparedStatement ps = conn.prepareStatement(totalPaymentQuery);
	             ResultSet rs = ps.executeQuery()) {

	            if (rs.next()) {
	                double totalAmountToday = rs.getDouble("total_amount_today");
	                document.add(new Paragraph(" "));
	                document.add(new Paragraph("Net Sales Today: Rs " + String.format("%.2f", totalAmountToday), smallHeaderFont));
	            } else {
	                document.add(new Paragraph(" "));
	                document.add(new Paragraph("Net Sales Today: Rs 0.00", smallHeaderFont));
	            }

	        }
	        
	        document.add(new Paragraph(" ")); 

	        
	        String totalReservationsQuery = "SELECT COUNT(*) FROM reservations WHERE DATE(created_at) = CURDATE()";
	        int totalReservations = 0;
	        try (PreparedStatement ps = conn.prepareStatement(totalReservationsQuery); ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                totalReservations = rs.getInt(1);
	            }
	        }

	        String totalUsersQuery = "SELECT COUNT(*) FROM users WHERE role = 'user' AND DATE(created_at) = CURDATE()";
	        int totalNewUsers = 0;
	        try (PreparedStatement ps = conn.prepareStatement(totalUsersQuery); ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                totalNewUsers = rs.getInt(1);
	            }
	        }
	        
	        document.add(new Paragraph("Top 5 Most Ordered Meals (Today)", smallHeaderFont));
	        String mealsQuery = "SELECT rm.meal_name, SUM(rm.quantity) AS total_quantity " +
	                            "FROM reservation_meals rm " +
	                            "JOIN reservations r ON rm.reservation_id = r.id " +
	                            "WHERE DATE(r.created_at) = CURDATE() " +
	                            "GROUP BY rm.meal_name " +
	                            "ORDER BY total_quantity DESC " +
	                            "LIMIT 5";
	        try (PreparedStatement ps = conn.prepareStatement(mealsQuery); ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                document.add(new Paragraph(
	                    "Meal: " + rs.getString("meal_name") +
	                    ", Quantity: " + rs.getInt("total_quantity"),
	                    normalFont
	                ));
	            }
	        }
	        document.add(new Paragraph(" ")); 
	        
	        document.add(new Paragraph("Top 5 Most Ordered Beverages (Today)", smallHeaderFont));

	        String beveragesQuery = "SELECT rb.beverage_name AS name, SUM(rb.quantity) AS quantity " +
	                                "FROM reservation_beverages rb " +
	                                "JOIN reservations r ON rb.reservation_id = r.id " +
	                                "WHERE DATE(r.created_at) = CURDATE() " +
	                                "GROUP BY rb.beverage_name " +
	                                "ORDER BY quantity DESC " +
	                                "LIMIT 5";

	        try (PreparedStatement ps = conn.prepareStatement(beveragesQuery); ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                document.add(new Paragraph(
	                    "Beverage: " + rs.getString("name") +
	                    ", Quantity: " + rs.getInt("quantity"),
	                    normalFont
	                ));
	            }
	        }
	        document.add(new Paragraph(" ")); 
	        
	     // Count pending reservations
	        String pendingSql = "SELECT COUNT(*) FROM reservations WHERE payment_status = 'pending'";
	        int totalPending = 0;
	        try (PreparedStatement ps = conn.prepareStatement(pendingSql);
	             ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                totalPending = rs.getInt(1);
	            }
	        }

	        // Count completed reservations
	        String completeSql = "SELECT COUNT(*) FROM reservations WHERE payment_status = 'complete'";
	        int totalComplete = 0;
	        try (PreparedStatement ps = conn.prepareStatement(completeSql);
	             ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                totalComplete = rs.getInt(1);
	            }
	        }
	       
	        
	        document.add(new Paragraph("Summary Totals (Today)", smallHeaderFont));
	        document.add(new Paragraph("Total Reservations Today: " + totalReservations, normalFont));
	        document.add(new Paragraph("Pending Reservations: " + totalPending, normalFont));
	        document.add(new Paragraph("Completed Reservations: " + totalComplete, normalFont));
	        document.add(new Paragraph("New Users Registered Today: " + totalNewUsers, normalFont));
	        document.add(new Paragraph(" ")); 

	        document.add(new Paragraph("Reservation Summary (Today)", smallHeaderFont));

	        String reservationQuery = "SELECT id, name, email, phone, reservation_date, guests, created_at, reservation_time, table_id, payment_status, order_id FROM reservations WHERE DATE(created_at) = CURDATE()";
	        try (PreparedStatement ps = conn.prepareStatement(reservationQuery); ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                document.add(new Paragraph(
	                    "ID: " + rs.getInt("id") +
	                    ", Email: " + rs.getString("email") +
	                    ", Table ID: " + rs.getInt("table_id") +
	                    ", Payment: " + rs.getString("payment_status") +
	                    ", Order ID: " + rs.getString("order_id"),
	                    normalFont
	                ));
	            }
	        }

	        document.add(new Paragraph(" "));

	        document.add(new Paragraph("New Users Registered Today", smallHeaderFont));

	        String usersQuery = "SELECT id, first_name, last_name, email, password, contact_number, role FROM users WHERE role = 'user' AND DATE(created_at) = CURDATE()";
	        try (PreparedStatement ps = conn.prepareStatement(usersQuery); ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                document.add(new Paragraph(
	                    "ID: " + rs.getInt("id") +
	                    ", Email: " + rs.getString("email") +
	                    ", Role: " + rs.getString("role"),
	                    normalFont
	                ));
	            }
	        }
	        
	    	    
	        document.close();

	    } catch (Exception e) {
	        throw new ServletException("Error generating PDF: " + e.getMessage(), e);
	    }
	}

}
