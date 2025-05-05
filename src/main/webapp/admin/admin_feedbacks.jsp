<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
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
  <title>Manage Feedbacks - Royal Cuisine</title>
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

  <!-- Content Section for Feedback Management -->
  <div class="content">
    <h3>Manage Feedbacks</h3>

    <!-- Display Feedbacks from Database -->
    <h4 class="mt-5">Feedback Items</h4>
    <table class="table table-dark table-striped">
      <thead>
        <tr>
          <th>Customer Name</th>
          <th>Booking Number</th> <!-- Added Booking Number column -->
          <th>Email</th>
          <th>Phone</th>
          <th>Message</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <% 
        String jdbcURL = "jdbc:mysql://localhost:3306/royal_cuisine";
        String jdbcUsername = "root";
        String jdbcPassword = "1234";

        try {
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            String sql = "SELECT * FROM feedback"; // Use 'feedback' table here
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
        %>
        <tr>
          <td><%= resultSet.getString("name") %></td>
          <td><%= resultSet.getString("booking_no") %></td> <!-- Display booking number -->
          <td><%= resultSet.getString("email") %></td>
          <td><%= resultSet.getString("phone") %></td>
          <td><%= resultSet.getString("message") %></td>
          <td>
            <!-- Send Message Button with Chat Icon -->
            <!--<a href="admin_message.jsp?email=<%= resultSet.getString("email") %>" class="btn btn-success btn-sm">
              <i class="bi bi-chat"></i> Send Message
            </a>-->

            <!-- Delete Feedback Button -->
            <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteFeedbackModal<%= resultSet.getInt("id") %>">Delete</button>

            <!-- Delete Feedback Modal -->
            <div style="color:black;" class="modal fade" id="deleteFeedbackModal<%= resultSet.getInt("id") %>" tabindex="-1" aria-labelledby="deleteFeedbackModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="deleteFeedbackModalLabel">Delete Feedback</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <p>Are you sure you want to delete this feedback?</p>
                  </div>
                  <div class="modal-footer">
                    <form action="ManageFeedbacksServlet" method="POST">
                      <input type="hidden" name="id" value="<%= resultSet.getInt("id") %>" />
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                      <button type="submit" class="btn btn-danger" name="action" value="deleteFeedback">Delete</button>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </td>
        </tr>
        <% 
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='alert alert-danger'>Error fetching feedbacks: " + e.getMessage() + "</div>");
        }
        %>
      </tbody>
    </table>
  </div>

  <!-- Bootstrap JS Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
