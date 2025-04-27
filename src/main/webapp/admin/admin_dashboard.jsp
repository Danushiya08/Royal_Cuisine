<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="com.royalcuisine.servlets.MenuServlet.Meal" %>
<%@ page import="com.royalcuisine.servlets.MenuServlet.Beverage" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/royal_cuisine";
    String dbUser = "root";
    String dbPassword = "12345678";

    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || sessionUser.getAttribute("email") == null) {
        response.sendRedirect("/admin/login.jsp");
        return;
    }

    String email = (String) sessionUser.getAttribute("email");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String first_name = "";

    int totalReservations = 0;
    int totalUsers = 0;
    int totalFeedbacks = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        String sql = "SELECT first_name FROM users WHERE email = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        rs = stmt.executeQuery();

        if (rs.next()) {
            first_name = rs.getString("first_name");
        } else {
            out.println("<p>Error: User not found.</p>");
        }

        stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM reservations");
        rs = stmt.executeQuery();
        if (rs.next()) {
            totalReservations = rs.getInt("total");
        }

        stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM users");
        rs = stmt.executeQuery();
        if (rs.next()) {
            totalUsers = rs.getInt("total");
        }

        stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM contact");
        rs = stmt.executeQuery();
        if (rs.next()) {
            totalFeedbacks = rs.getInt("total");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error connecting to database.</p>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
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

  <!-- Google Charts Loader -->
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

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

  <script type="text/javascript">
    google.charts.load('current', {packages: ['corechart', 'bar']});
    google.charts.setOnLoadCallback(drawCharts);

    function drawCharts() {
      // Pie Chart
      var pieData = google.visualization.arrayToDataTable([
        ['Category', 'Count'],
        ['Reservations', <%= totalReservations %>],
        ['Users', <%= totalUsers %>],
        ['Feedbacks', <%= totalFeedbacks %>]
      ]);

      var pieOptions = {
        title: 'Overall System Statistics',
        backgroundColor: '#1a1a1a',
        legend: {textStyle: {color: 'white'}},
        titleTextStyle: {color: 'white'},
        pieHole: 0.4
      };

      var pieChart = new google.visualization.PieChart(document.getElementById('chart_pie'));
      pieChart.draw(pieData, pieOptions);

      // Bar Chart
      var barData = google.visualization.arrayToDataTable([
        ['Category', 'Count', { role: 'style' }],
        ['Reservations', <%= totalReservations %>, 'color: #f1c40f'],
        ['Users', <%= totalUsers %>, 'color: #e67e22'],
        ['Feedbacks', <%= totalFeedbacks %>, 'color: #9b59b6']
      ]);

      var barOptions = {
        title: 'Detailed System Data',
        backgroundColor: '#1a1a1a',
        legend: 'none',
        titleTextStyle: {color: 'white'},
        hAxis: {textStyle: {color: 'white'}},
        vAxis: {textStyle: {color: 'white'}},
      };

      var barChart = new google.visualization.ColumnChart(document.getElementById('chart_bar'));
      barChart.draw(barData, barOptions);

      // Line Chart (Simulated Data)
      var lineData = google.visualization.arrayToDataTable([
        ['Month', 'Reservations'],
        ['Jan',  40],
        ['Feb',  55],
        ['Mar',  70],
        ['Apr',  65],
        ['May',  80],
        ['Jun',  <%= totalReservations %>] // June shows current reservations total
      ]);

      var lineOptions = {
        title: 'Reservations Over the Last 6 Months',
        curveType: 'function',
        backgroundColor: '#1a1a1a',
        legend: { position: 'bottom', textStyle: {color: 'white'} },
        titleTextStyle: {color: 'white'},
        hAxis: {textStyle: {color: 'white'}},
        vAxis: {textStyle: {color: 'white'}}
      };

      var lineChart = new google.visualization.LineChart(document.getElementById('chart_line'));
      lineChart.draw(lineData, lineOptions);
    }
  </script>
</head>

<body>

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

  <!-- Topbar -->
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

  <!-- Content Section -->
  <div class="content">
    <h3>Admin Dashboard</h3>

    <div class="admin-info">
      <h4>Admin Details</h4>
      <p><strong>Email:</strong> <%= session.getAttribute("email") %></p>
      <p><strong>Role:</strong> Administrator</p>
    </div>
<form action="DownloadReportServlet" method="post">
  <button type="submit" class="btn btn-warning">Download Report</button>
</form>

    <hr class="my-4">

    <h4>Statistics</h4>
    <div class="row">
      <div class="col-md-4">
        <div class="card bg-dark text-white mb-4">
          <div class="card-body">
            <h5 class="card-title">Total Reservations</h5>
            <p class="card-text"><%= totalReservations %></p>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card bg-dark text-white mb-4">
          <div class="card-body">
            <h5 class="card-title">Total Users</h5>
            <p class="card-text"><%= totalUsers %></p>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card bg-dark text-white mb-4">
          <div class="card-body">
            <h5 class="card-title">Total Feedbacks</h5>
            <p class="card-text"><%= totalFeedbacks %></p>
          </div>
        </div>
      </div>
    </div>

    <div class="card bg-dark text-white mb-4">
      <div class="card-body">
        <h5 class="card-title">Analytics Overview</h5>
        <div id="chart_pie" style="width: 100%; height: 400px;"></div>
      </div>
    </div>

    <div class="card bg-dark text-white mb-4">
      <div class="card-body">
        <h5 class="card-title">Detailed System Data</h5>
        <div id="chart_bar" style="width: 100%; height: 400px;"></div>
      </div>
    </div>

    <div class="card bg-dark text-white">
      <div class="card-body">
        <h5 class="card-title">Reservations Over Time</h5>
        <div id="chart_line" style="width: 100%; height: 400px;"></div>
      </div>
    </div>

  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
