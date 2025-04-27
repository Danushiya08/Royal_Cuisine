<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="com.royalcuisine.servlets.MenuServlet.Meal" %>
<%@ page import="com.royalcuisine.servlets.MenuServlet.Beverage" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard - Royal Cuisine</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <link rel="stylesheet" href="css/styles.css">
  <style>
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

    .topbar .user-icon {
      cursor: pointer;
    }

    .admin-info {
      background: #1a1a1a;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
      margin-bottom: 30px;
    }

    .admin-info h4 {
      font-weight: bold;
      color: #f1c40f;
    }
  </style>
</head>
<body class="bg-black text-white">

   <!-- Sidebar -->
  <div class="sidebar">
    <h2 class="text-gold fw-bold">Staff Panel</h2>
    <a href="staff_dashboard.jsp">Dashboard</a>
    <a href="staff_menu.jsp">Manage Menu</a>
    <a href="staff_reservations.jsp">Manage Reservations</a>
    <a href="staff_feedbacks.jsp">Manage Feedbacks</a>
  </div>
  <!-- Topbar with User Icon -->
  <div class="topbar">
    <div class="topbar-left">
      <h4>Royal Cuisine Staff</h4>
    </div>
    <div class="topbar-right">
      <div class="dropdown">
        <button class="btn text-white user-icon" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="bi bi-person"></i>
        </button>
        <ul class="dropdown-menu" aria-labelledby="userDropdown">
          
          <li><a class="dropdown-item" href="#">Email: <%= session.getAttribute("email") %></a></li>
          <li><hr class="dropdown-divider"></li>
                 <li><a class="dropdown-item" href="../login.jsp">Logout</a></li>
        </ul>
      </div>
    </div>
  </div>

  <!-- Content Section for Dashboard -->
  <div class="content">
    <h3>Staff Dashboard</h3>

    <!-- Admin Info Section -->
    <div class="admin-info">
      <h4>Staff Details</h4>
     
      <p><strong>Email:</strong> <%= session.getAttribute("email") %></p>
      <p><strong>Role:</strong> Staff</p>
    </div>

   
    <hr class="my-4">
    
    <h4>Statistics</h4>
    <div class="row">
      <div class="col-md-4">
        <div class="card bg-dark text-white">
          <div class="card-body">
            <h5 class="card-title">Total Reservations</h5>
            <p class="card-text">
              <%
                // JDBC Connection using DriverManager
                Connection connection = null;
                try {
                  String jdbcURL = "jdbc:mysql://localhost:3306/royal_cuisine";
                  String jdbcUsername = "root";
                  String jdbcPassword = "12345678";

                  // Load the driver and establish the connection
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                  String sql = "SELECT COUNT(*) AS total FROM reservations";
                  PreparedStatement preparedStatement = connection.prepareStatement(sql);
                  ResultSet resultSet = preparedStatement.executeQuery();

                  if (resultSet.next()) {
              %>
              <%= resultSet.getInt("total") %>
              <%
                  }
                  resultSet.close();
                  preparedStatement.close();
                } catch (Exception e) {
                  e.printStackTrace();
                  out.println("<div class='alert alert-danger'>Error fetching reservations: " + e.getMessage() + "</div>");
                } finally {
                  try {
                    if (connection != null) {
                      connection.close();
                    }
                  } catch (Exception e) {
                    e.printStackTrace();
                  }
                }
              %>
            </p>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card bg-dark text-white">
          <div class="card-body">
            <h5 class="card-title">Total Users</h5>
            <p class="card-text">
              <%
                // Fetch total users count
                try {
                  String jdbcURL = "jdbc:mysql://localhost:3306/royal_cuisine";
                  String jdbcUsername = "root";
                  String jdbcPassword = "12345678";
                  connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                  String sql = "SELECT COUNT(*) AS total FROM users";
                  PreparedStatement preparedStatement = connection.prepareStatement(sql);
                  ResultSet resultSet = preparedStatement.executeQuery();

                  if (resultSet.next()) {
              %>
              <%= resultSet.getInt("total") %>
              <%
                  }
                  resultSet.close();
                  preparedStatement.close();
                } catch (Exception e) {
                  e.printStackTrace();
                  out.println("<div class='alert alert-danger'>Error fetching users: " + e.getMessage() + "</div>");
                }
              %>
            </p>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card bg-dark text-white">
          <div class="card-body">
            <h5 class="card-title">Total Feedbacks</h5>
            <p class="card-text">
              <%
                // Fetch total feedbacks count
                try {
                  String jdbcURL = "jdbc:mysql://localhost:3306/royal_cuisine";
                  String jdbcUsername = "root";
                  String jdbcPassword = "12345678";
                  connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                  String sql = "SELECT COUNT(*) AS total FROM contact";
                  PreparedStatement preparedStatement = connection.prepareStatement(sql);
                  ResultSet resultSet = preparedStatement.executeQuery();

                  if (resultSet.next()) {
              %>
              <%= resultSet.getInt("total") %>
              <%
                  }
                  resultSet.close();
                  preparedStatement.close();
                } catch (Exception e) {
                  e.printStackTrace();
                  out.println("<div class='alert alert-danger'>Error fetching feedbacks: " + e.getMessage() + "</div>");
                }
              %>
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap JS Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
