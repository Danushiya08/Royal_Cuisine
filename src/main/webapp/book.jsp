<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="com.royalcuisine.servlets.GetPackagesServlet.Package" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Book a Table - Royal Cuisine</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="css/styles.css">
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
  <!-- Booking Packages Section -->
  <section class="py-5 text-center">
    <div class="container">
      <h2 class="font-serif fst-italic display-5 text-amber">Choose a Package</h2>
      <div class="row mt-4">
        <% 
        // JDBC connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/royal_cuisine";
        String jdbcUsername = "root";
        String jdbcPassword = "12345678";
        
        List<Package> packageList = new ArrayList<>();

        try {
        	 Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish connection to the database
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // Query to fetch packages
            String sql = "SELECT package_name, image_url, price, description FROM packages";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            // Fetch and store package details in packageList
            while (resultSet.next()) {
                Package pkg = new Package();
                pkg.setPackageName(resultSet.getString("package_name"));
                pkg.setImageUrl(resultSet.getString("image_url"));
                pkg.setPrice(resultSet.getDouble("price"));
                pkg.setDescription(resultSet.getString("description"));
                packageList.add(pkg);
            }

            // Close resources
            resultSet.close();
            statement.close();
            connection.close();

        } catch (Exception e) {
            // Handle exceptions and show error message
            out.println("<div class='alert alert-danger'>Error fetching packages. Please try again later.</div>");
            e.printStackTrace();
        }

        // Check if the packageList is not empty
        if (!packageList.isEmpty()) {
            // Display the packages dynamically
            for (Package pkg : packageList) {
        %>
        <!-- Display the package -->
        <div class="col-md-4">
            <div class="card bg-dark text-white p-3">
                <img src="<%= pkg.getImageUrl() %>" alt="<%= pkg.getPackageName() %>" class="card-img-top" />
                <h3 class="fs-4 mt-3"><%= pkg.getPackageName() %></h3>
                <p>$<%= pkg.getPrice() %> per person - <%= pkg.getDescription() %></p>
                <form action="menu.jsp" method="GET">
                    <input type="hidden" name="package" value="<%= pkg.getPackageName() %>">
                    <button type="submit" class="btn btn-gold">Select <%= pkg.getPackageName() %> Package</button>
                </form>
            </div>
        </div>
        <% 
            }
        } else {
        %>
        <p>No packages available at the moment.</p>
        <% 
        }
        %>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="bg-black text-white py-5">
    <div class="container">
      <div class="row">
        <!-- Open Hours -->
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
        
        <!-- Newsletter -->
        <div class="col-md-4 mb-4 mb-md-0">
          <h3 class="fs-4 mb-4">Newsletter</h3>
          <p class="mb-3 text-gray">
            Far far away, behind the word mountains, far from the countries.
          </p>
          <div class="d-flex flex-column gap-2">
            <input type="email" placeholder="Enter E-mail address" class="form-control bg-transparent text-white border-gray">
            <button class="btn btn-gold text-white">Subscribe</button>
          </div>
        </div>
        
        <!-- Instagram -->
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

  <!-- Bootstrap JS Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
