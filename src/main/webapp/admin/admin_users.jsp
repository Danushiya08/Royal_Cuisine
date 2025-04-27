<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.io.IOException" %>
<%@ page import="com.royalcuisine.servlets.UserManagementServlet" %>

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
  <title>Manage Users - Royal Cuisine</title>
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

  <!-- Content Section for User Management -->
  <div class="content">
    <h3>Manage Users</h3>

    <h4>Add New User</h4>
    <form action="UserManagementServlet" method="POST" >
      <div class="mb-3">
        <label for="firstName" class="form-label">First Name</label>
        <input type="text" class="form-control" id="firstName" name="firstName" required>
      </div>
      <div class="mb-3">
        <label for="lastName" class="form-label">Last Name</label>
        <input type="text" class="form-control" id="lastName" name="lastName" required>
      </div>
      <div class="mb-3">
        <label for="contactNumber" class="form-label">Contact Number</label>
        <input type="tel" class="form-control" id="contactNumber" name="contactNumber" pattern="[0-9]{10}" required>
        <small class="form-text text-muted">Enter a 10-digit contact number</small>
      </div>
      <div class="mb-3">
        <label for="userEmail" class="form-label">Email</label>
        <input type="email" class="form-control" id="userEmail" name="userEmail" required>
      </div>
      <div class="mb-3">
        <label for="userPassword" class="form-label">Password</label>
        <input type="password" class="form-control" id="userPassword" name="userPassword" required>
      </div>
      <div class="mb-3">
        <label for="userRole" class="form-label">Role</label>
        <select class="form-control" id="userRole" name="userRole" required>
          <option value="admin">Admin</option>
          <option value="user">User</option>
               <option value="staff">Staff</option>
          <option value="Manager">Manager</option>
 
        </select>
      </div>
       <button type="submit" class="btn btn-warning" name="action" value="addUser">Add User</button>

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

  
    <!-- Display Users from Database -->
    <h4 class="mt-5">User List</h4>
    <table class="table table-dark table-striped">
      <thead>
        <tr>
          <th>First name</th>
          <th>Last name</th>
          <th>Contact number</th>
          <th>Email</th>
          <th>Role</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <% 
        String jdbcURL = "jdbc:mysql://localhost:3306/royal_cuisine";
        String jdbcUsername = "root";
        String jdbcPassword = "12345678";
        
        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            String sql = "SELECT * FROM users";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql);
                 ResultSet resultSet = preparedStatement.executeQuery()) {
                
                while (resultSet.next()) {
        %>
        <tr>
          <td><%= resultSet.getString("first_name") %></td>
          <td><%= resultSet.getString("last_name") %></td>
          <td><%= resultSet.getString("contact_number") %></td>
          <td><%= resultSet.getString("email") %></td>
          <td><%= resultSet.getString("role") %></td>
          <td>
            <a href="#" class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editUserModal<%= resultSet.getInt("id") %>">Edit</a>
            <a href="UserManagementServlet?userId=<%= resultSet.getInt("id") %>&action=deleteUser" class="btn btn-danger btn-sm">Delete</a>

          </td>
        </tr>

        <!-- Modal for Edit User -->
        <div style="color: black;" class="modal fade" id="editUserModal<%= resultSet.getInt("id") %>" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                <form action="UserManagementServlet" method="POST">
                  <input type="hidden" name="userId" value="<%= resultSet.getInt("id") %>" />
                  <div class="mb-3">
                    <label for="firstName" class="form-label">First Name</label>
                    <input type="text" class="form-control" name="firstName" value="<%= resultSet.getString("first_name") %>" required>
                  </div>
                  <div class="mb-3">
                    <label for="lastName" class="form-label">Last Name</label>
                    <input type="text" class="form-control" name="lastName" value="<%= resultSet.getString("last_name") %>" required>
                  </div>
                  <div class="mb-3">
                    <label for="contactNumber" class="form-label">Contact Number</label>
                    <input type="tel" class="form-control" name="contactNumber" value="<%= resultSet.getString("contact_number") %>" required>
                  </div>
                  <div class="mb-3">
                    <label for="userEmail" class="form-label">Email</label>
                    <input type="email" class="form-control" name="userEmail" value="<%= resultSet.getString("email") %>" required>
                  </div>
                  <div class="mb-3">
                    <label for="userPassword" class="form-label">Password</label>
                    <input type="password" class="form-control" name="userPassword" value="<%= resultSet.getString("password") %>" required>
                  </div>
                  <div class="mb-3">
                    <label for="userRole" class="form-label">Role</label>
                    <select class="form-control" name="userRole" required>
                      <option value="admin" <%= resultSet.getString("role").equals("admin") ? "selected" : "" %>>Admin</option>
                      <option value="user" <%= resultSet.getString("role").equals("user") ? "selected" : "" %>>User</option>
                      <option value="manager" <%= resultSet.getString("role").equals("user") ? "selected" : "" %>>Manager</option>
                      <option value="staff" <%= resultSet.getString("role").equals("user") ? "selected" : "" %>>Staff</option>
                    </select>
                  </div>
                  <button type="submit" class="btn btn-warning" name="action" value="editUser">Update User</button>
                </form>
              </div>
            </div>
          </div>
        </div>
        <% 
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Error fetching users: " + e.getMessage() + "</div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='alert alert-danger'>Database connection error: " + e.getMessage() + "</div>");
        }
        %>
      </tbody>
    </table>
  </div>

  <!-- Bootstrap JS Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
