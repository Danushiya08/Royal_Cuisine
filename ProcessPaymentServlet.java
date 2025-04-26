package com.royalcuisine.servlets;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/ProcessPaymentServlet")
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
            System.out.println("✅ Payment succeeded: " + charge.getId());
            response.sendRedirect("paymentsuccess.jsp");

        } catch (NumberFormatException e) {
            System.err.println("❌ Invalid amount format: " + e.getMessage());
            response.sendRedirect("error.jsp");

        } catch (StripeException e) {
            System.err.println("❌ Stripe error: " + e.getMessage());
            response.sendRedirect("error.jsp");

        } catch (IllegalArgumentException e) {
            System.err.println("❌ Missing input: " + e.getMessage());
            response.sendRedirect("error.jsp");

        } catch (Exception e) {
            System.err.println("❌ Unexpected error: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }
}