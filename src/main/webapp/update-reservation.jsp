<%@ page import="java.sql.*, java.net.URLEncoder" %>
<%
    String reservationId = request.getParameter("reservation_id");
    String reservationDate = request.getParameter("reservation_date");
    String guests = request.getParameter("guests");
    String tableId = request.getParameter("table_id");

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/royal_cuisine", "root", "root");

        // Update meals
        String mealQuery = "UPDATE reservation_meals SET quantity = ? WHERE reservation_id = ? AND meal_name = ?";
        ps = conn.prepareStatement(mealQuery);
        for (String param : request.getParameterMap().keySet()) {
            if (param.startsWith("meal_")) {
                String mealName = param.substring(5);
                int qty = Integer.parseInt(request.getParameter(param));
                ps.setInt(1, qty);
                ps.setString(2, reservationId);
                ps.setString(3, mealName);
                ps.executeUpdate();
            }
        }

        // Update beverages
        String bevQuery = "UPDATE reservation_beverages SET quantity = ? WHERE reservation_id = ? AND beverage_name = ?";
        ps = conn.prepareStatement(bevQuery);
        for (String param : request.getParameterMap().keySet()) {
            if (param.startsWith("beverage_")) {
                String bevName = param.substring(9);
                int qty = Integer.parseInt(request.getParameter(param));
                ps.setInt(1, qty);
                ps.setString(2, reservationId);
                ps.setString(3, bevName);
                ps.executeUpdate();
            }
        }

        // Redirect with all required parameters
        response.sendRedirect("payment.jsp?reservation_id=" + reservationId +
                              "&reservation_date=" + URLEncoder.encode(reservationDate, "UTF-8") +
                              "&guests=" + URLEncoder.encode(guests, "UTF-8") +
                              "&table_id=" + URLEncoder.encode(tableId, "UTF-8"));

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>