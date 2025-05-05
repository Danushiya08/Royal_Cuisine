package com.royalcuisine.servlets;

import com.royalcuisine.utils.DBConnection;
import com.royalcuisine.utils.EmailSender; // Import EmailSender utility
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class BookTableServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false); 
        String email = null;
        if (session != null) {
        	email = (String) session.getAttribute("email");
        }

        String name = request.getParameter("name");
        //String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String guests = request.getParameter("guests");
        int tableNo = Integer.parseInt(request.getParameter("table_id"));
        System.out.println(tableNo);
        String[] selectedMeals = request.getParameterValues("meals");
        if (selectedMeals != null) {
            for (String meal : selectedMeals) {
                String paramName = "meal_quantity_" + meal.replace(" ", "_");
                String quantity = request.getParameter(paramName);
                System.out.println("Meal: " + meal + ", Quantity: " + quantity);
            }
        }
        String[] selectedBeverages = request.getParameterValues("beverages");
        if (selectedBeverages != null) {
            for (String beverage : selectedBeverages) {
                String paramName = "beverage_quantity_" + beverage.replace(" ", "_");
                String quantity = request.getParameter(paramName);
                System.out.println("Beverage: " + beverage + ", Quantity: " + quantity);

            }
        }


        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection.");
            }

            String sql = "INSERT INTO reservations (name, email, phone, reservation_date, reservation_time, guests, table_id, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, date);
            stmt.setString(5, time);
            stmt.setString(6, guests);
            stmt.setInt(7, tableNo);
            stmt.setString(8, "pending");

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                int reservationId = -1;
                if (generatedKeys.next()) {
                    reservationId = generatedKeys.getInt(1);
                }

                // Insert selected meals
                if (selectedMeals != null && reservationId != -1) {
                    String mealSql = "INSERT INTO reservation_meals (reservation_id, meal_name, quantity) VALUES (?, ?, ?)";
                    PreparedStatement mealStmt = conn.prepareStatement(mealSql);

                    for (String meal : selectedMeals) {
                        String quantityStr = request.getParameter("meal_quantity_" + meal.replace(" ", "_"));
                        int quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Integer.parseInt(quantityStr) : 1;

                        mealStmt.setInt(1, reservationId);
                        mealStmt.setString(2, meal);
                        mealStmt.setInt(3, quantity);
                        mealStmt.addBatch(); 
                    }
                    mealStmt.executeBatch(); 
                }
                
             // Insert selected beverages
                if (selectedBeverages != null && reservationId != -1) {
                    String beverageSql = "INSERT INTO reservation_beverages (reservation_id, beverage_name, quantity) VALUES (?, ?, ?)";
                    PreparedStatement beverageStmt = conn.prepareStatement(beverageSql);

                    for (String beverage : selectedBeverages) {
                        String paramName = "beverage_quantity_" + beverage.replace(" ", "_");
                        String quantityStr = request.getParameter(paramName);
                        int quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Integer.parseInt(quantityStr) : 1;

                        beverageStmt.setInt(1, reservationId);
                        beverageStmt.setString(2, beverage);
                        beverageStmt.setInt(3, quantity);
                        beverageStmt.addBatch();
                    }
                    beverageStmt.executeBatch(); 
                }

                sendConfirmationEmail(email, name, date, time, tableNo, guests);
             // Update table availability
                String updateTableSql = "UPDATE tables SET is_available = false, current_reservation_id = ? WHERE table_id = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateTableSql);
                updateStmt.setInt(1, reservationId);
                updateStmt.setInt(2, tableNo);
                updateStmt.executeUpdate();




                
                response.sendRedirect("reservation.jsp?success=Your reservation has been successfully added.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<script type='text/javascript'>");
            out.println("alert('Error while processing reservation. Please try again.');");
            out.println("window.location='profile.jsp';");
            out.println("</script>");
            response.sendRedirect("reservation.jsp?error=Your reservation failed. Please try again.");
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
    private void sendConfirmationEmail(String toEmail, String name, String date, String time, int tableNo, String guests) {
        String subject = "Reservation Confirmation - Royal Cuisine";
        String body = "Dear " + name + ",\n\n" +
                      "Thank you for making a reservation with Royal Cuisine. Your reservation details are as follows:\n\n" +
                      "Table No: " + tableNo + "\n" +
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
