<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="com.royalcuisine.servlets.MenuServlet.Meal" %>
<%@ page import="com.royalcuisine.servlets.MenuServlet.Beverage" %>
<%
    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/royal_cuisine";
    String dbUser = "root";
    String dbPassword = "1234";

    // Ensure the user is logged in
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || sessionUser.getAttribute("email") == null) {
        response.sendRedirect("/admin/login.jsp"); // Redirect to login if not logged in
        return;
    }

    // Get email from session
    String email = (String) sessionUser.getAttribute("email");

    // Fetch user details from the database
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String first_name = "";
 

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // SQL to get user details by email
        String sql = "SELECT first_name, last_name, contact_number FROM users WHERE email = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, email); // Set the email to fetch the user details

        rs = stmt.executeQuery();

        // Check if the user exists in the database
        if (rs.next()) {
            first_name = rs.getString("first_name");
    
        } else {
            out.println("<p>Error: User not found in the database.</p>");
        }
    
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p>Error loading the database driver. Please contact support.</p>");
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
      color:white;
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
<body class="bg-black ">

  <!-- Sidebar -->
  <div class="sidebar">
    <h2 class="text-gold fw-bold">Admin Panel</h2>
    <a href="admin_dashboard.jsp">Dashboard</a>
    <a href="admin_menu.jsp">Manage Menu</a>
    <a href="admin_users.jsp">Manage Users</a>
    <a href="admin_reservations.jsp">Manage Reservations</a>
    <a href="admin_offers.jsp">Manage Offers</a>
    <a href="admin_feedbacks.jsp">Manage Feedbacks</a>
    <a href="admin_packages.jsp">Manage Packages</a>
    <a href="admin_blogs.jsp">Manage Blogs</a>
  </div>

  <!-- Topbar with User Icon -->
  <div class="topbar">
    <div class="topbar-left">
      <h4>Royal Cuisine Admin</h4>
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
  <div style="color:white;" class="content">
    <h3>Admin Dashboard</h3>

    <!-- Admin Info Section -->
    <div class="admin-info">
      <h4>Admin Details</h4>
      <p><strong>Email:</strong> <%= session.getAttribute("email") %></p>
      <p><strong>Role:</strong> Administrator</p>
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
