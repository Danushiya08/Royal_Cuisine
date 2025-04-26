<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="jakarta.servlet.http.HttpSession, java.sql.*" %>

<%
    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3308/royal_cuisine";
    String dbUser = "root";
    String dbPassword = "12345678";

    // Ensure the user is logged in
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || sessionUser.getAttribute("email") == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if not logged in
        return;
    }

    // Get email from session
    String email = (String) sessionUser.getAttribute("email");

    // Fetch user details from the database
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String first_name = "";
    String last_name = "";
    String contact_number = "";

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
            last_name = rs.getString("last_name");
            contact_number = rs.getString("contact_number");
        } else {
            out.println("<p>Error: User not found in the database.</p>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Error accessing the database. Please try again later.</p>");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p>Error loading the database driver. Please contact support.</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error closing database resources.</p>");
        }
    }

    // Fetch reservation_id from URL parameter to delete reservation
    String reservation_id = request.getParameter("reservation_id");

    if (reservation_id != null) {
        try {
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // SQL to delete reservation by ID
            String sqlDelete = "DELETE FROM reservations WHERE id = ?";
            stmt = conn.prepareStatement(sqlDelete);
            stmt.setString(1, reservation_id); // Set the reservation ID to delete

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                out.println("<p>Reservation successfully canceled.</p>");
            } else {
                out.println("<p>Error: Reservation not found or couldn't be deleted.</p>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error accessing the database. Please try again later.</p>");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>Error closing database resources.</p>");
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Royal Cuisine - A Symphony of Luxury & Flavor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .containerc {
            max-width: 1000px;
            margin: 50px auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            color: #000;
        }
        .profile-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-header h2 {
            margin-bottom: 10px;
            font-size: 2rem;
            font-weight: bold;
            color: #f1c40f; 
        }
        .profile-info {
            text-align: left;
            margin-bottom: 20px;
            font-size: 1.1rem;
        }
        .profile-info p {
            margin: 10px 0;
            font-size: 1.2rem;
        }
        .profile-info strong {
            color: #f1c40f; 
        }
        .bookings-list {
            margin-top: 20px;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .booking-item {
            background: #f8f8f8;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            flex: 1 0 calc(33.333% - 20px); 
            max-width: 33.333%;
        }
        .btnp {
            display: block;
            width: 100%;
            background: #fdd835;
            color: #000;
            border: none;
            padding: 12px;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
            text-align: center;
        }
        .btnp:hover {
            background: #ffc107; 
        }
    </style>
</head>
<body class="bg-black text-white">
<!-- Header/Navigation -->
  <header class="py-3 bg-black">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-md-3 d-flex align-items-center">
          <img src="assets/image4.png" alt="Royal Cuisine Logo" width="60" height="60" class="me-2">
          <div class="text-gold fw-bold">ROYAL CUISINE</div>
        </div>
        <div class="col-md-9">
          <nav class="d-none d-md-flex justify-content-end align-items-center">
            <a href="home.jsp" class="text-white text-decoration-none me-4 nav-link">Home</a>
            <a href="about.jsp" class="text-white text-decoration-none me-4 nav-link">about</a>
            <a href="menu.jsp" class="text-white text-decoration-none me-4 nav-link">Menu</a>
            <a href="offers.jsp" class="text-white text-decoration-none me-4 nav-link">Offers</a>
            <a href="location.jsp" class="text-white text-decoration-none me-4 nav-link">Location</a>
            <a href="blog.jsp" class="text-white text-decoration-none me-4 nav-link">Blog</a>
            <a href="contact.jsp" class="text-white text-decoration-none me-4 nav-link">Contact & Feedback</a>
            <a href="book.jsp" class="btn btn-gold text-white me-4">Book a Table</a>
            <a href="profile.jsp" class="text-white text-decoration-none">
              <i class="bi bi-person"></i>
            </a>
          </nav>
        </div>
      </div>
    </div>
  </header>
    <div class="containerc">
        <div class="profile-header">
            <h2>My Profile</h2>
            <p>Welcome back, <%= first_name %>!</p>
        </div>
        <div class="profile-info">
            <p><strong>First Name:</strong> <%= first_name %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Phone:</strong> <%= contact_number %></p>
        </div>

        <h3>My Reservations</h3>
        <div class="bookings-list">
            <%
                // Fetch user bookings from the database
                Connection connBookings = null;
                PreparedStatement stmtBookings = null;
                ResultSet rsBookings = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connBookings = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    String sql = "SELECT id, reservation_date, guests, package_selected, created_at FROM reservations WHERE email = ?";
                    stmtBookings = connBookings.prepareStatement(sql);
                    stmtBookings.setString(1, email);
                    rsBookings = stmtBookings.executeQuery();

                    while (rsBookings.next()) {
                        String reservationDate = rsBookings.getString("reservation_date");
                        String guests = rsBookings.getString("guests");
                        String packageSelected = rsBookings.getString("package_selected");
                        int reservationIdFromDb = rsBookings.getInt("id");
            %>
            <div class="booking-item">
                <p><strong>Reservation Date:</strong> <%= reservationDate %></p>
                <p><strong>Package:</strong> <%= packageSelected %></p>
                <p><strong>Guests:</strong> <%= guests %></p>
                <p><strong>Created at:</strong> <%= rsBookings.getString("created_at") %></p>

                <!-- Send reservation details to payment page via URL parameters -->
                <a href="payment.jsp?reservation_id=<%= reservationIdFromDb %>&reservation_date=<%= reservationDate %>&guests=<%= guests %>&package_selected=<%= packageSelected %>" class="btnp" style="width:200px;">Pay Now</a>

                <!-- Cancel Reservation Link -->
                <a href="profile.jsp?reservation_id=<%= reservationIdFromDb %>" class="btnp" style="width:200px;">Cancel Reservation</a>
            </div>
            <%  
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Error accessing the database. Please try again later.</p>");
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                    out.println("<p>Error loading the database driver. Please contact support.</p>");
                } finally {
                    try {
                        if (rsBookings != null) rsBookings.close();
                        if (stmtBookings != null) stmtBookings.close();
                        if (connBookings != null) connBookings.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p>Error closing database resources.</p>");
                    }
                }
            %>
        </div>

        <a href="login.jsp" class="btnp">Logout</a>
    </div>

    <footer class="bg-black text-white py-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4 mb-md-0">
                    <h3 class="fs-4 mb-4">Open Hours</h3>
                    <div class="row">
                        <div class="col-6">Monday</div>
                        <div class="col-6">9:00 - 24:00</div>
                        <div class="col-6">Tuesday</div>
                        <div class="col-6">9:00 - 24:00</div>
                        <div class="col-6">Wednesday</div>
                        <div class="col-6">9:00 - 24:00</div>
                        <div class="col-6">Thursday</div>
                        <div class="col-6">9:00 - 24:00</div>
                        <div class="col-6">Friday</div>
                        <div class="col-6">9:00 - 02:00</div>
                        <div class="col-6">Saturday</div>
                        <div class="col-6">9:00 - 02:00</div>
                        <div class="col-6">Sunday</div>
                        <div class="col-6">9:00 - 02:00</div>
                    </div>
                </div>
                <div class="col-md-4 mb-4 mb-md-0">
                    <h3 class="fs-4 mb-4">Newsletter</h3>
                    <div class="d-flex flex-column gap-2">
                        <input type="email" placeholder="Enter E-mail address" class="form-control bg-transparent text-white border-gray">
                        <button class="btn btn-gold text-white">Subscribe</button>
                    </div>
                </div>
                <div class="col-md-4 px-4">
                    <h3 class="fs-4 mb-4">Instagram</h3>
                    <div class="d-flex align-items-center">
                        <i class="bi bi-instagram text-amber me-2 fs-5"></i>
                        <span class="text-gray">royal_cuisine</span>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
