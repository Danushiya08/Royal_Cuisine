<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %> <!-- Add SQLException import -->
<%@ page import="java.io.IOException" %>
<%@ page import="com.royalcuisine.servlets.ReservationManagementServlet" %>
<%@ page import="com.royalcuisine.utils.DBConnection" %>

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
  <link rel="stylesheet" href="../css/styles.css">
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
    .form-control:focus {
    background-color: transparent;
    color: #212529;
    box-shadow: none;
    border-color: #8c7240;
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

  <!-- Content Section for Reservation Management -->
  <div class="content">
    <h3>Manage Reservations</h3>

    <!-- Add New Reservation -->
   

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
    <table class="table table-dark table-striped" style="font-size: 12px">
      <thead>
        <tr>
          <th>Email</th>
          <th>Phone</th>
          <th>Reservation Date</th>
          <th>Reservation Time</th>
          <th>Guests</th>
          <th>Selected Table</th>
          <th>Payment Status</th>
          <th>Order Number</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <% 
            String jdbcURL = "jdbc:mysql://localhost:3306/royal_cuisine";
            String jdbcUsername = "root";
            String jdbcPassword = "1234";

            try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
                String sql = "SELECT * FROM reservations";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql);
                     ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
        %>
        <tr>
          <td><%= resultSet.getString("email") %></td>
          <td><%= resultSet.getString("phone") %></td>
          <td><%= resultSet.getDate("reservation_date") %></td>
          <td><%= resultSet.getTime("reservation_time") %></td>
          <td><%= resultSet.getInt("guests") %></td>
          <td><%= resultSet.getInt("table_id") %></td>
          <td><%= resultSet.getString("payment_status") %></td>
          <td><%= resultSet.getString("order_id") %></td>
          <td>
            <!-- Edit and Delete Buttons -->
            <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editReservationModal<%= resultSet.getInt("id") %>">Edit</button>
            <button class="btn btn-danger btn-sm" onclick="confirmDelete(<%= resultSet.getInt("id") %>)">Delete</button>
          </td>
        </tr>
        <!-- Edit Modal -->
	<div class="modal fade" id="editReservationModal<%= resultSet.getInt("id") %>" tabindex="-1" aria-labelledby="editReservationLabel<%= resultSet.getInt("id") %>" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <form id="reservationEdit" action="TableReservationServlet" method="post">
	        <div class="modal-header">
	          <h5 class="modal-title text-dark" id="editReservationLabel<%= resultSet.getInt("id") %>">Edit Reservation</h5>
	          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	        </div>
	        <div class="modal-body">
	          <input type="hidden" name="id" value="<%= resultSet.getInt("id") %>">
	
	          <div class="mb-3">
	            <label for="reservation_date" class="form-label">Reservation Date</label>
	            <input type="date" id="date" class="form-control" name="reservation_date" value="<%= resultSet.getDate("reservation_date") %>" required>
	          </div>
	
	          <div class="mb-3">
	            <label for="reservation_time" class="form-label">Reservation Time</label>
	            <input type="time" class="form-control" name="reservation_time" value="<%= resultSet.getTime("reservation_time") %>" required>
	          </div>
	
	          <div class="mb-3">
	            <label for="phone" class="form-label">Phone</label>
	            <input type="text" class="form-control" name="phone" value="<%= resultSet.getString("phone") %>" required>
	          </div>
	
	          <div class="mb-3">
	            <label for="guests" class="form-label">Guests</label>
	            <input type="number" class="form-control" name="guests" value="<%= resultSet.getInt("guests") %>" min="1" required>
	          </div>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
	          <button type="submit" class="btn btn-gold">Save Changes</button>
	        </div>
	      </form>
	    </div>
	  </div>
	</div>
        
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
  
  <%@ page import="java.sql.*" %>
	<%
	String deleteId = request.getParameter("deleteId");
	if (deleteId != null) {
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement stmt = conn.prepareStatement("DELETE FROM reservations WHERE id = ?")) {
	
	        stmt.setInt(1, Integer.parseInt(deleteId));
	        stmt.executeUpdate();
	        out.println("<script>Swal.fire('Deleted!', 'Reservation has been deleted.', 'success')</script>");
	    } catch (Exception e) {
	        e.printStackTrace();
	        out.println("<script>Swal.fire('Error!', 'Unable to delete reservation.', 'error')</script>");
	    }
	}
	%>
  

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
	  function confirmDelete(reservationId) {
	    Swal.fire({
	      title: 'Are you sure?',
	      text: "This reservation will be deleted.",
	      icon: 'warning',
	      showCancelButton: true,
	      confirmButtonColor: '#d33',
	      cancelButtonColor: '#3085d6',
	      confirmButtonText: 'Yes, delete it!'
	    }).then((result) => {
	      if (result.isConfirmed) {
	        window.location.href = 'admin_reservations.jsp?deleteId=' + reservationId;
	      }
	    });
	  }
	</script>
	
	    <%
	    String errorMessage = request.getParameter("error");
	    String successMessage = request.getParameter("success");
	%>
	<script>
	    <% if (errorMessage != null) { %>
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '<%= errorMessage %>'
	        });
	    <% } else if (successMessage != null) { %>
		    Swal.fire({
	            icon: 'success',
	            title: 'Updated',
	            text: '<%= successMessage %>',
	            confirmButtonText: 'Login'
	        }).then((result) => {
	            if (result.isConfirmed) {
	                window.location.href = "admin_reservations.jsp"; 
	            }
	        });
	    <% } %>
	</script>


  
</body>
</html>
