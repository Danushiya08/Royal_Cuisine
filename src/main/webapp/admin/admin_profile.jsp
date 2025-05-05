<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="com.royalcuisine.servlets.MenuServlet.Meal" %>
<%@ page import="com.royalcuisine.servlets.MenuServlet.Beverage" %>

<%
    String dbURL = "jdbc:mysql://localhost:3306/royal_cuisine";
    String dbUser = "root";
    String dbPassword = "1234";

    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || sessionUser.getAttribute("email") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String email = (String) sessionUser.getAttribute("email");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String first_name = "";

    int totalReservations = 0;
    int totalUsers = 0;
    int totalFeedbacks = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        String sql = "SELECT first_name FROM users WHERE email = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        rs = stmt.executeQuery();

        if (rs.next()) {
            first_name = rs.getString("first_name");
        } else {
            out.println("<p>Error: User not found.</p>");
        }

        stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM reservations");
        rs = stmt.executeQuery();
        if (rs.next()) {
            totalReservations = rs.getInt("total");
        }

        stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM users");
        rs = stmt.executeQuery();
        if (rs.next()) {
            totalUsers = rs.getInt("total");
        }

        stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM contact");
        rs = stmt.executeQuery();
        if (rs.next()) {
            totalFeedbacks = rs.getInt("total");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error connecting to database.</p>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard - Royal Cuisine</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <link rel="stylesheet" href="css/styles.css">

  <!-- Google Charts Loader -->
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

  <style>
    body {
      background-color: black;
      color: white;
    }
    .sidebar {
      height: 100%;
      width: 250px;
      position: fixed;
      top: 0;
      left: 0;
      background-color: #000;
      color: white;
      padding-top: 20px;
      padding-left: 20px;
    }
    .sidebar a {
      color: white;
      text-decoration: none;
      display: block;
      padding: 10px 20px;
      margin-bottom: 10px;
      border-radius: 5px;
    }
    .sidebar a:hover {
      background-color: #f1c40f;
    }
    .content {
      margin-left: 250px;
      padding: 20px;
    }
    .topbar {
      background-color: #000;
      color: white;
      padding: 10px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .admin-info {
      background: #1a1a1a;
      padding: 20px;
      border-radius: 8px;
      margin-bottom: 30px;
    }
    .admin-info h4 {
      color: #f1c40f;
    }
  </style>

  
</head>

<body>

  <!-- Sidebar -->
<jsp:include page="includes/sidebar.jsp" />

  <!-- Topbar with User Icon -->
  <div class="topbar">
    <div class="topbar-left">
      <h4>Royal Cuisine Admin</h4>
    </div>
    <div class="topbar-right">
      <div class="dropdown">
        <a href="admin_message.jsp" class="btn text-white user-icon">
          <i class="bi bi-chat"></i> 
        </a>

        <a href="admin_profile.jsp" class="btn text-white user-icon">
          <i class="bi bi-person"></i> 
        </a>
        <ul class="dropdown-menu" aria-labelledby="userDropdown">
          <li><a class="dropdown-item" href="#">Email: <%= session.getAttribute("email") %></a></li>
          <li><hr class="dropdown-divider"></li>
          <li><a class="dropdown-item" href="../login.jsp">Logout</a></li>
        </ul>
      </div>
    </div>
  </div>

  <!-- Content Section -->
  <div class="content">
    <h3>Admin Dashboard</h3>

    <div class="admin-info">
      <h4>Admin Profile</h4>
      <p><strong>Email:</strong> <%= session.getAttribute("email") %></p>
      <p><strong>Role:</strong> Administrator</p>
      <button type="submit" class="btn btn-warning"><a class="dropdown-item" href="../login.jsp">Logout</a></button>
    </div>


    
      
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
