<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="com.royalcuisine.servlets.GetPackagesServlet.Package" %>
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
  <title>Manage Packages - Royal Cuisine</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <!-- Custom CSS -->
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

  <!-- Content Section for Package Management -->
  <div class="content">
    <h3>Manage Packages</h3>

    <!-- Add New Package -->
    <h4>Add New Package</h4>
    <form action="ManagePackagesServlet" method="POST">
      <div class="mb-3">
        <label for="packageName" class="form-label">Package Name</label>
        <input type="text" class="form-control" id="packageName" name="packageName" required>
      </div>

      <div class="mb-3">
        <label for="packageDescription" class="form-label">Package Description</label>
        <textarea class="form-control" id="packageDescription" name="packageDescription" rows="3" required></textarea>
      </div>

      <div class="mb-3">
        <label for="packageImage" class="form-label">Package Image URL</label>
        <input type="text" class="form-control" id="packageImage" name="packageImage" required>
      </div>

      <div class="mb-3">
        <label for="packagePrice" class="form-label">Package Price</label>
        <input type="number" class="form-control" id="packagePrice" name="packagePrice" required>
      </div>

      <button type="submit" class="btn btn-warning" name="action" value="addPackage">Add Package</button>
    </form>

    <!-- Display Packages from Database -->
    <h4 class="mt-5">Available Packages</h4>
    <table class="table table-dark table-striped">
      <thead>
        <tr>
          <th>Package Name</th>
          <th>Description</th>
          <th>Price</th>
          <th>Image</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <% 
        String jdbcURL = "jdbc:mysql://localhost:3308/royal_cuisine";
        String jdbcUsername = "root";
        String jdbcPassword = "12345678";

        try {
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            String sql = "SELECT * FROM packages";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
        %>
        <tr>
          <td><%= resultSet.getString("package_name") %></td>
          <td><%= resultSet.getString("description") %></td>
          <td>$<%= resultSet.getDouble("price") %></td>
          <td><img src="<%= resultSet.getString("image_url") %>" width="50" alt="<%= resultSet.getString("package_name") %>"></td>
          <td>
            <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editPackageModal<%= resultSet.getInt("id") %>">Edit</button>
            <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deletePackageModal<%= resultSet.getInt("id") %>">Delete</button>

            <!-- Edit Package Modal -->
            <div style="color:black;" class="modal fade" id="editPackageModal<%= resultSet.getInt("id") %>" tabindex="-1" aria-labelledby="editPackageModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="editPackageModalLabel">Edit Package</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <form action="ManagePackagesServlet" method="POST">
                      <input type="hidden" name="id" value="<%= resultSet.getInt("id") %>" />
                      <div class="mb-3">
                        <label for="packageName" class="form-label">Package Name</label>
                        <input type="text" class="form-control" name="packageName" value="<%= resultSet.getString("package_name") %>" required>
                      </div>
                      <div class="mb-3">
                        <label for="packageDescription" class="form-label">Description</label>
                        <textarea class="form-control" name="packageDescription" rows="3" required><%= resultSet.getString("description") %></textarea>
                      </div>
                      <div class="mb-3">
                        <label for="packageImage" class="form-label">Image URL</label>
                        <input type="text" class="form-control" name="packageImage" value="<%= resultSet.getString("image_url") %>" required>
                      </div>
                      <div class="mb-3">
                        <label for="packagePrice" class="form-label">Price</label>
                        <input type="number" class="form-control" name="packagePrice" value="<%= resultSet.getDouble("price") %>" required>
                      </div>
                      <button type="submit" class="btn btn-warning" name="action" value="editPackage">Update Package</button>
                    </form>
                  </div>
                </div>
              </div>
            </div>

            <!-- Delete Package Modal -->
            <div style="color:black;" class="modal fade" id="deletePackageModal<%= resultSet.getInt("id") %>" tabindex="-1" aria-labelledby="deletePackageModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="deletePackageModalLabel">Delete Package</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <p>Are you sure you want to delete this package?</p>
                  </div>
                  <div class="modal-footer">
                    <form action="ManagePackagesServlet" method="POST">
                      <input type="hidden" name="id" value="<%= resultSet.getInt("id") %>" />
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                      <button type="submit" class="btn btn-danger" name="action" value="deletePackage">Delete</button>
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
            out.println("<div class='alert alert-danger'>Error fetching packages: " + e.getMessage() + "</div>");
        }
        %>
      </tbody>
    </table>
  </div>

  <!-- Bootstrap JS Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
