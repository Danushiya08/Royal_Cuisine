<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="com.royalcuisine.servlets.MenuManagementServlet" %>

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
  <title>Manage Menu - Royal Cuisine</title>
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

  <!-- Content Section for Menu Management -->
  <div class="content">
    <h3>Manage Menu</h3>


    <!-- Display Meal Items from Database -->
    <h4 class="mt-5">Meal Items</h4>
    <table class="table table-dark table-striped">
      <thead>
        <tr>
          <th>Meal Name</th>
          <th>Description</th>
          <th>Price</th>
          <th>Image</th>
        
        </tr>
      </thead>
      <tbody>
        <% 
        String jdbcURL = "jdbc:mysql://localhost:3306/royal_cuisine";
        String jdbcUsername = "root";
        String jdbcPassword = "12345678";
        
        try {
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            String sql = "SELECT * FROM meals";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            while (resultSet.next()) {
        %>
        <tr>
          <td><%= resultSet.getString("name") %></td>
          <td><%= resultSet.getString("description") %></td>
          <td>$<%= resultSet.getDouble("price") %></td>
          <td><img src="<%= resultSet.getString("image_url") %>" width="50" alt="<%= resultSet.getString("name") %>"></td>
          <td>
            
            
           
          </td>
        </tr>
        <% 
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='alert alert-danger'>Error fetching meals: " + e.getMessage() + "</div>");
        }
        %>
      </tbody>
    </table>

    <!-- Display Beverage Items from Database -->
    <h4 class="mt-5">Beverage Items</h4>
    <table class="table table-dark table-striped">
      <thead>
        <tr>
          <th>Beverage Name</th>
          <th>Description</th>
          <th>Price</th>
          <th>Image</th>
    
        </tr>
      </thead>
      <tbody>
        <% 
        try {
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            String sql = "SELECT * FROM beverages";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            while (resultSet.next()) {
        %>
        <tr>
          <td><%= resultSet.getString("name") %></td>
          <td><%= resultSet.getString("description") %></td>
          <td>$<%= resultSet.getDouble("price") %></td>
          <td><img src="<%= resultSet.getString("image_url") %>" width="50" alt="<%= resultSet.getString("name") %>"></td>
          <td>
            

            <!-- Edit Beverage Modal -->
            <div style="color: black;" class="modal fade" id="editBeverageModal<%= resultSet.getInt("id") %>" tabindex="-1" aria-labelledby="editBeverageModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="editBeverageModalLabel">Edit Beverage</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <form action="MenuManagementServlet" >
                      <input type="hidden" name="id" value="<%= resultSet.getInt("id") %>" />
                      <div class="mb-3">
                        <label for="beverageName" class="form-label">Beverage Name</label>
                        <input type="text" class="form-control" name="beverageName" value="<%= resultSet.getString("name") %>" required>
                      </div>
                      <div class="mb-3">
                        <label for="beverageDescription" class="form-label">Description</label>
                        <textarea class="form-control" name="beverageDescription" rows="3" required><%= resultSet.getString("description") %></textarea>
                      </div>
                      <div class="mb-3">
                        <label for="beveragePrice" class="form-label">Price</label>
                        <input type="number" class="form-control" name="beveragePrice" value="<%= resultSet.getDouble("price") %>" required>
                      </div>
                      <button type="submit" class="btn btn-warning" name="action" value="editBeverage">Update Beverage</button>
                    </form>
                  </div>
                </div>
              </div>
            </div>

            <!-- Delete Beverage Modal -->
            <div style="color: black;" class="modal fade" id="deleteBeverageModal<%= resultSet.getInt("id") %>" tabindex="-1" aria-labelledby="deleteBeverageModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="deleteBeverageModalLabel">Delete Beverage</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <p>Are you sure you want to delete this beverage?</p>
                  </div>
                  <div class="modal-footer">
                    <form action="MenuManagementServlet" method="POST">
                      <input type="hidden" name="id" value="<%= resultSet.getInt("id") %>" />
                      
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
            out.println("<div class='alert alert-danger'>Error fetching beverages: " + e.getMessage() + "</div>");
        }
        %>
      </tbody>
    </table>
  </div>

  <!-- Bootstrap JS Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
