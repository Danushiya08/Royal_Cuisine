package com.royalcuisine.servlets;

import com.royalcuisine.utils.DBConnection;
import com.royalcuisine.utils.EmailSender;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;


public class ProcessPaymentServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
        // Set your Stripe secret key (Test key)
        Stripe.apiKey = "sk_test_51R7IsZFKBuG4KLiqTfZQ1WKUE5C7wlFOrWHg813Nv5uTr3SSTU2BqaUkMbmgh13saKHsinK0TWA5xdCwwtLcxQzs00udJJUKfa";
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String stripeToken = request.getParameter("stripeToken");
        String amountStr = request.getParameter("totalAmount");
        String reservationId = request.getParameter("reservation_id");
        HttpSession session = request.getSession(false); 
        String email = null;
        String firstName = null;
        if (session != null) {
        	email = (String) session.getAttribute("email");
        	firstName = (String) session.getAttribute("firstName");
        }


        try {
            if (stripeToken == null || stripeToken.isEmpty()) {
                throw new IllegalArgumentException("Stripe token is missing.");
            }

            if (amountStr == null || amountStr.isEmpty()) {
                throw new IllegalArgumentException("Total amount is missing.");
            }

            double amountDouble = Double.parseDouble(amountStr);
            int amount = (int) (amountDouble * 100); // Convert to cents

            Map<String, Object> chargeParams = new HashMap<>();
            chargeParams.put("amount", amount);
            chargeParams.put("currency", "usd");
            chargeParams.put("description", "Royal Cuisine Reservation");
            chargeParams.put("source", stripeToken);

            Charge charge = Charge.create(chargeParams);

         // Payment was successful
            System.out.println("Payment succeeded: " + charge.getId());
            
            String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
            String uniqueSuffix = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
            String orderId = "ORD" + timestamp + uniqueSuffix;
            
            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                conn = DBConnection.getConnection();
                if (conn == null) {
                    throw new SQLException("Failed to establish database connection.");
                }

                // === 1. Update reservations table ===
                String updateSQL = "UPDATE reservations SET payment_status = 'complete', order_id = ? WHERE id = ?";
                stmt = conn.prepareStatement(updateSQL);
                stmt.setString(1, orderId);
                stmt.setString(2, reservationId);
                int updatedRows = stmt.executeUpdate();

                if (updatedRows > 0) {
                    System.out.println("Reservation payment status updated successfully.");
                } else {
                    System.err.println("Failed to update reservation payment status.");
                }

                // === 2. Insert into payments table ===
                String insertPaymentSQL = "INSERT INTO payments (reservation_id, order_id, total_amount) VALUES (?, ?, ?)";
                try (PreparedStatement paymentStmt = conn.prepareStatement(insertPaymentSQL)) {
                    paymentStmt.setString(1, reservationId);
                    paymentStmt.setString(2, orderId);
                    paymentStmt.setDouble(3, amountDouble);
                    int insertedRows = paymentStmt.executeUpdate();
                    if (insertedRows > 0) {
                        System.out.println("Payment record inserted successfully.");
                    } else {
                        System.err.println("Failed to insert payment record.");
                    }
                }
                sendConfirmationEmail(email, firstName, orderId, amountStr);

            } catch (SQLException sqlEx) {
                System.err.println("Database error: " + sqlEx.getMessage());
            } finally {
                if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
            
            
            response.sendRedirect("paymentsuccess.jsp");

        } catch (NumberFormatException e) {
            System.err.println("Invalid amount format: " + e.getMessage());
            response.sendRedirect("error.jsp");

        } catch (StripeException e) {
            System.err.println("Stripe error: " + e.getMessage());
            response.sendRedirect("error.jsp");

        } catch (IllegalArgumentException e) {
            System.err.println("Missing input: " + e.getMessage());
            response.sendRedirect("error.jsp");

        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }
    
    private void sendConfirmationEmail(String toEmail, String firstName, String orderId, String amountStr) {
        String subject = "Payment Confirmation - Royal Cuisine";
        String body = "Hello " + firstName + "," + "\n\n" +
        			  "Thank you for your payment. We will confirm your reservation.\n\n" +
                      "Total Amount: " + amountStr + "\n" +
                      "Order ID: " + orderId + "\n" +
                      "Payment Status: " + "Complete" + "\n\n" +
                      "Thank you for join with us. \n\n" +
                      "Best regards,\n" +
                      "Royal Cuisine Team";

        // Send the email using EmailSender utility
        EmailSender.sendEmail(toEmail, subject, body);
    }
}