package com.royalcuisine.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class ReservationManagementServlet extends HttpServlet {

    // JDBC connection details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/royal_cuisine";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "12345678";

    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Add new reservation
    private void addReservation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String reservationDate = request.getParameter("reservationDate");
        String reservationTime = request.getParameter("reservationTime");
        String guestsString = request.getParameter("guests");
        String packageSelected = request.getParameter("packageSelected");

        // Validation: check if 'guests' is valid
        int guests = 0;
        try {
            guests = Integer.parseInt(guestsString);
        } catch (NumberFormatException e) {
            response.getWriter().println("Error: Invalid number format for guests.");
            return;
        }

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "INSERT INTO reservations (name, email, phone, reservation_date,reservation_time, guests, package_selected) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, name);
                preparedStatement.setString(2, email);
                preparedStatement.setString(3, phone);
                preparedStatement.setString(4, reservationDate);
                preparedStatement.setString(5, reservationTime);
                preparedStatement.setInt(6, guests);
                preparedStatement.setString(7, packageSelected);
                int result = preparedStatement.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("admin_reservations.jsp?message=Reservation added successfully.");
                } else {
                    response.getWriter().println("Error: Reservation could not be added.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }

    // Edit an existing reservation
    private void editReservation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reservationId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String reservationDate = request.getParameter("reservationDate");
        String reservationTime = request.getParameter("reservationTime");
        String guestsString = request.getParameter("guests");
        String packageSelected = request.getParameter("packageSelected");

        // Validation: check if 'guests' is valid
        int guests = 0;
        try {
            guests = Integer.parseInt(guestsString);
        } catch (NumberFormatException e) {
            response.getWriter().println("Error: Invalid number format for guests.");
            return;
        }

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "UPDATE reservations SET name = ?, email = ?, phone = ?, reservation_date = ?,reservation_time = ?, guests = ?, package_selected = ? WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, name);
                preparedStatement.setString(2, email);
                preparedStatement.setString(3, phone);
                preparedStatement.setString(4, reservationDate);
                preparedStatement.setString(5, reservationTime);
                preparedStatement.setInt(6, guests);
                preparedStatement.setString(7, packageSelected);
                preparedStatement.setInt(8, reservationId);
                int result = preparedStatement.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("admin_reservations.jsp?message=Reservation updated successfully.");
                } else {
                    response.getWriter().println("Error: Reservation could not be updated.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }

    // Delete a reservation
    private void deleteReservation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reservationId = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "DELETE FROM reservations WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setInt(1, reservationId);
                int result = preparedStatement.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("admin_reservations.jsp?message=Reservation deleted successfully.");
                } else {
                    response.getWriter().println("Error: Reservation could not be deleted.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addReservation".equals(action)) {
            addReservation(request, response);
        } else if ("editReservation".equals(action)) {
            editReservation(request, response);
        } else if ("deleteReservation".equals(action)) {
            deleteReservation(request, response);
        } else {
            response.getWriter().println("Error: Invalid action.");
        }
    }
}
