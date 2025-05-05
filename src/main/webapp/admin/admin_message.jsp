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
    <title>Admin - Message Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/styles.css">
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


  <div class="content">
    <h3>Send Message</h3>
    <form action="SendMessageServlet" method="POST" class="border p-4 mx-auto" style="max-width: 600px;">
        <div class="mb-3">
            <label for="email" class="form-label">Recipient Email</label>
           <input type="email" class="form-control" id="email" name="email" value="<%= request.getParameter("email") %>" required>
        </div>

        <div class="mb-3">
            <label for="message" class="form-label">Message</label>
            <textarea class="form-control" id="message" name="message" rows="4" required></textarea>
        </div>

        <button type="submit" class="btn btn-warning">Send Message</button>
    </form>

    <h4 class="mt-5">Sent Messages</h4>
    <table class="table table-dark table-striped">
        <thead>
            <tr>
                <th>Recipient Email</th>
                <th>Message</th>
                <th>Date Sent</th>
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
                String sql = "SELECT * FROM sent_messages";
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                ResultSet resultSet = preparedStatement.executeQuery();

                while (resultSet.next()) {
        %>
            <tr>
                <td><%= resultSet.getString("recipient_email") %></td>
                <td><%= resultSet.getString("message") %></td>
                <td><%= resultSet.getString("created_at") %></td>
                <td>
                    <!-- Delete Message Button -->
                    <form action="DeleteMessageServlet" method="POST" style="display:inline;">
                        <input type="hidden" name="id" value="<%= resultSet.getInt("id") %>" />
                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                    </form>
                </td>
            </tr>
        <%
                }
                resultSet.close();
                preparedStatement.close();
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Error fetching sent messages: " + e.getMessage() + "</div>");
            }
        %>
        </tbody>
    </table>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
