<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="com.royalcuisine.servlets.TableManagementServlet" %>

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
  <title>Manage Tables - Royal Cuisine</title>
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


  <!-- Content Section for Table Management -->
  <div class="content">
    <h3>Manage Tables</h3>

    <!-- Add New Table (Admin only) -->
   
    <h4>Add New Table</h4>
    <form action="TableManagementServlet" method="POST">
      <div class="mb-3">
        <label for="table_number" class="form-label">Table Number</label>
        <input type="number" class="form-control" id="table_number" name="table_number" required>
      </div>
      <div class="mb-3">
        <label for="is_available" class="form-label">Availability</label>
        <select class="form-control" id="is_available" name="is_available" required>
          <option value="1">Available</option>
          <option value="0">Not Available</option>
        </select>
      </div>
      <div class="mb-3">
        <label for="capacity" class="form-label">Capacity</label>
        <input type="number" class="form-control" id="capacity" name="capacity" required>
      </div>
      <div class="mb-3">
        <label for="price" class="form-label">Price</label>
        <input type="number" step="0.01" class="form-control" id="price" name="price" required>
      </div>
      <div class="mb-3">
        <label for="image_url" class="form-label">Image URL</label>
        <input type="text" class="form-control" id="image_url" name="image_url">
      </div>
      <div class="mb-3">
        <label for="description" class="form-label">Description</label>
        <textarea class="form-control" id="description" name="description" rows="3"></textarea>
      </div>
      <button type="submit" class="btn btn-warning" name="action" value="addTable">Add Table</button>
    </form>
 

    <!-- Success Message Popup -->
    <%
        String message = request.getParameter("message");
        if (message != null) {
    %>
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
      var myModal = new bootstrap.Modal(document.getElementById('successModal'));
      myModal.show();
    </script>
    <% 
        }
    %>

    <!-- Display Tables from Database -->
    <h4 class="mt-5">Tables List</h4>
    <table class="table table-dark table-striped">
      <thead>
        <tr>
          <th>Table Number</th>
          <th>Price</th>
          <th>Availability</th>
          <th>Capacity</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <% 
            String jdbcURL = "jdbc:mysql://localhost:3306/royal_cuisine";
            String jdbcUsername = "root";
            String jdbcPassword = "1234";

            try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
                String sql = "SELECT * FROM tables";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql);
                     ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
        %>
        <tr>
          <td><%= resultSet.getInt("table_number") %></td>
          <td>Rs.<%= resultSet.getDouble("price") %></td>
          <td>
            <%= resultSet.getBoolean("is_available") ? "Available" : "Not Available" %>
          </td>
          <td><%= resultSet.getInt("capacity") %></td>
          <td>
            <!-- Edit Table Button -->
            <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editTableModal<%= resultSet.getInt("table_id") %>">Edit</button>
            <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteTableModal<%= resultSet.getInt("table_id") %>">Delete</button>

            <!-- Edit Table Modal -->
            <div class="modal fade" id="editTableModal<%= resultSet.getInt("table_id") %>" tabindex="-1" aria-labelledby="editTableModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="editTableModalLabel">Edit Table</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <form action="TableManagementServlet" method="POST">
                      <input type="hidden" name="table_id" value="<%= resultSet.getInt("table_id") %>" />
                      <div class="mb-3">
                        <label for="table_number" class="form-label">Table Number</label>
                        <input type="number" class="form-control" name="table_number" value="<%= resultSet.getInt("table_number") %>" required>
                      </div>
                      <div class="mb-3">
                        <label for="is_available" class="form-label">Availability</label>
                        <select class="form-control" name="is_available" required>
                          <option value="1" <%= resultSet.getBoolean("is_available") ? "selected" : "" %>>Available</option>
                          <option value="0" <%= !resultSet.getBoolean("is_available") ? "selected" : "" %>>Not Available</option>
                        </select>
                      </div>
                      <div class="mb-3">
                        <label for="capacity" class="form-label">Capacity</label>
                        <input type="number" class="form-control" name="capacity" value="<%= resultSet.getInt("capacity") %>" required>
                      </div>
                      <div class="mb-3">
                        <label for="price" class="form-label">Price</label>
                        <input type="number" step="0.01" class="form-control" name="price" value="<%= resultSet.getDouble("price") %>" required>
                      </div>
                      <button type="submit" class="btn btn-warning" name="action" value="editTable">Update Table</button>
                    </form>
                  </div>
                </div>
              </div>
            </div>
            <!-- Delete Table Modal -->
            <div class="modal fade" id="deleteTableModal<%= resultSet.getInt("table_id") %>" tabindex="-1" aria-labelledby="deleteTableModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="deleteTableModalLabel">Delete Table</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <p>Are you sure you want to delete this table?</p>
                  </div>
                  <div class="modal-footer">
                    <form action="TableManagementServlet" method="POST">
                      <input type="hidden" name="table_id" value="<%= resultSet.getInt("table_id") %>" />
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                      <button type="submit" class="btn btn-danger" name="action" value="deleteTable">Delete</button>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </td>
        </tr>
        <%  
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Error fetching tables: " + e.getMessage() + "</div>");
            }
        %>
      </tbody>
    </table>
  </div>

  <!-- Bootstrap JS and Modal -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
