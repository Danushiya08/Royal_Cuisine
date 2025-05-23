<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="com.royalcuisine.servlets.ReservationManagementServlet" %>

<%
    try {
        // Load MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<div class='alert alert-danger'>Error: Unable to load MySQL JDBC driver. " + e.getMessage() + "</div>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Reservations - Royal Cuisine</title>
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

  <!-- Content Section for Reservation Management -->
  <div class="content">
    <h3>Manage Reservations</h3>

    <!-- Add New Reservation -->
    <h4>Add New Reservation</h4>
    <form action="ReservationManagementServlet" method="POST">
      <div class="mb-3">
        <label for="name" class="form-label">Customer Name</label>
        <input type="text" class="form-control" id="name" name="name" required>
      </div>
      <div class="mb-3">
        <label for="email" class="form-label">Email</label>
        <input type="email" class="form-control" id="email" name="email" required>
      </div>
      <div class="mb-3">
        <label for="phone" class="form-label">Phone</label>
        <input type="tel" class="form-control" id="phone" name="phone" required>
      </div>
      <div class="mb-3">
        <label for="reservationDate" class="form-label">Reservation Date</label>
        <input type="date" class="form-control" id="reservationDate" name="reservationDate" required>
      </div>
      <div class="mb-3">
        <label for="reservationTime" class="form-label">Reservation Time</label>
        <input type="time" class="form-control" id="reservationTime" name="reservationTime" required>
      </div>
      <div class="mb-3">
        <label for="guests" class="form-label">Guests</label>
        <input type="number" class="form-control" id="guests" name="guests" required>
      </div>
      <div class="mb-3">
        <label for="table_id" class="form-label">Select Table</label>
        <select class="form-control" id="table_id" name="table_id" required>
          <option value="">--Select Table--</option>
          <% 
            // Fetch tables and their prices from the database
            Connection connTables = null;
            PreparedStatement stmtTables = null;
            ResultSet rsTables = null;

            try {
                connTables = DriverManager.getConnection("jdbc:mysql://localhost:3306/royal_cuisine", "root", "12345678");
                String sql = "SELECT table_id, price FROM tables";
                stmtTables = connTables.prepareStatement(sql);
                rsTables = stmtTables.executeQuery();

                while (rsTables.next()) {
          %>
              <option value="<%= rsTables.getString("table_id") %>">
                Table <%= rsTables.getString("table_id") %> - $<%= rsTables.getDouble("price") %>
              </option>
          <% 
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rsTables != null) rsTables.close();
                    if (stmtTables != null) stmtTables.close();
                    if (connTables != null) connTables.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
          %>
        </select>
      </div>
      <button type="submit" class="btn btn-warning" name="action" value="addReservation">Add Reservation</button>
    </form>

    <!-- Success Message Popup -->
    <%
        String message = request.getParameter("message");
        if (message != null) {
    %>
    <!-- Bootstrap Modal for success message -->
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="successModalLabel">Success</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <p><%= message %></p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
    <script>
      // Show the success modal if message is passed
      var myModal = new bootstrap.Modal(document.getElementById('successModal'));
      myModal.show();
    </script>
    <% 
        }
    %>

    <!-- Display Reservations from Database -->
    <h4 class="mt-5">Reservations List</h4>
    <table class="table table-dark table-striped">
      <thead>
        <tr>
          <th>Customer Name</th>
          <th>Email</th>
          <th>Phone</th>
          <th>Reservation Date</th>
          <th>Guests</th>
          <th>Table ID</th>
         
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <% 
            String jdbcURL = "jdbc:mysql://localhost:3306/royal_cuisine";
            String jdbcUsername = "root";
            String jdbcPassword = "12345678";

            try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
                String sql = "SELECT * FROM reservations";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql);
                     ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
        %>
        <tr>
          <td><%= resultSet.getString("name") %></td>
          <td><%= resultSet.getString("email") %></td>
          <td><%= resultSet.getString("phone") %></td>
          <td><%= resultSet.getDate("reservation_date") %></td>
          <td><%= resultSet.getInt("guests") %></td>
          <td><%= resultSet.getString("table_id") %></td>
        
          <td>
            <!-- Edit and Delete Buttons -->
            <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editReservationModal<%= resultSet.getInt("id") %>">Edit</button>
            <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteReservationModal<%= resultSet.getInt("id") %>">Delete</button>
          </td>
        </tr>
        <%  
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Error fetching reservations: " + e.getMessage() + "</div>");
            }
        %>
      </tbody>
    </table>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
