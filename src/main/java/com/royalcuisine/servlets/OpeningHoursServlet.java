package com.royalcuisine.servlets;
import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.royalcuisine.utils.DBConnection;

import java.sql.*;

import org.json.JSONArray;
import org.json.JSONObject;



@WebServlet("/opening-hours-servlet")
public class OpeningHoursServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");

	    try (Connection conn = DBConnection.getConnection()) {
	        String query = "SELECT day_of_week, opening_time, closing_time, is_holiday FROM opening_hours ORDER BY FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')";
	        PreparedStatement stmt = conn.prepareStatement(query);
	        ResultSet rs = stmt.executeQuery();

	        JSONArray jsonArray = new JSONArray();
	        while (rs.next()) {
	            JSONObject obj = new JSONObject();
	            obj.put("day_of_week", rs.getString("day_of_week"));
	            obj.put("opening_time", rs.getTime("opening_time").toString());
	            obj.put("closing_time", rs.getTime("closing_time").toString());
	            obj.put("is_holiday", rs.getBoolean("is_holiday"));
	            
	            
	            jsonArray.put(obj);
	        }

	        PrintWriter out = response.getWriter();
	        out.print(jsonArray.toString());
	        out.flush();

	    } catch (SQLException e) {
	        e.printStackTrace();
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        response.getWriter().print("{\"error\": \"Failed to fetch opening hours\"}");
	    }
	}

    // Method to update opening hours
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String dayOfWeek = request.getParameter("day_of_week");
        String openingTime = request.getParameter("opening_time");
        String closingTime = request.getParameter("closing_time");
        boolean isHoliday = Boolean.parseBoolean(request.getParameter("is_holiday"));

        try (Connection conn = DBConnection.getConnection()) {
            String updateQuery = "UPDATE opening_hours SET opening_time = ?, closing_time = ?, is_holiday = ? WHERE day_of_week = ?";
            PreparedStatement stmt = conn.prepareStatement(updateQuery);
            
            stmt.setString(1, openingTime);
            stmt.setString(2, closingTime);
            stmt.setBoolean(3, isHoliday);
            stmt.setString(4, dayOfWeek);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.getWriter().println("Opening hours updated successfully");
            } else {
                response.getWriter().println("Failed to update opening hours");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().println("Error updating opening hours");
        }
    }
}
