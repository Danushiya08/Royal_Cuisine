package com.royalcuisine.servlets;
import java.io.IOException;
import java.util.*;

import com.google.gson.Gson;
import com.royalcuisine.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/chart-data")
public class ChartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        List<String> mealNames = new ArrayList<>();
        List<Integer> mealQuantities = new ArrayList<>();

        String sql = "SELECT rm.meal_name, SUM(rm.quantity) AS total_quantity " +
                     "FROM reservation_meals rm " +
                     "JOIN reservations r ON rm.reservation_id = r.id " +
                     "WHERE DATE(r.created_at) = CURDATE() " +
                     "GROUP BY rm.meal_name " +
                     "ORDER BY total_quantity DESC LIMIT 5";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                mealNames.add(rs.getString("meal_name"));
                mealQuantities.add(rs.getInt("total_quantity"));
            }

            String json = String.format("{\"labels\": %s, \"data\": %s}",
                    new Gson().toJson(mealNames),
                    new Gson().toJson(mealQuantities));

            response.getWriter().write(json);

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"error\": \"Failed to load data\"}");
        }
    }
}
