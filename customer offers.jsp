<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.util.ArrayList, java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Offers - Royal Cuisine</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
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
            <a href="about.jsp" class="text-white text-decoration-none me-4 nav-link">About</a>
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

  <!-- Offers Section -->
  <section class="py-5 text-center">
    <div class="container">
      <h2 class="font-serif fst-italic display-5 text-warning">Special Offers</h2>
      <p class="lead">Explore our latest offers and promotions. Enjoy special discounts and more at Royal Cuisine!</p>

      <!-- Offer Cards -->
      <div class="row mt-4">
        <% 
          // Database connection details
          String jdbcURL = "jdbc:mysql://localhost:3308/royal_cuisine";
          String jdbcUsername = "root";
          String jdbcPassword = "12345678";
          
          List<Offer> offers = new ArrayList<>();
          
          try {
              // Load MySQL JDBC Driver
              Class.forName("com.mysql.cj.jdbc.Driver");

              // Establish connection to the database
              Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
              String sql = "SELECT id, title, description, image_url FROM offers ORDER BY created_at DESC LIMIT 4";
              PreparedStatement preparedStatement = connection.prepareStatement(sql);
              ResultSet resultSet = preparedStatement.executeQuery();
              
              // Loop through the result set and add offers to the list
              while (resultSet.next()) {
                  Offer offer = new Offer();
                  offer.setId(resultSet.getInt("id"));
                  offer.setTitle(resultSet.getString("title"));
                  offer.setDescription(resultSet.getString("description"));
                  offer.setImageUrl(resultSet.getString("image_url"));
                  offers.add(offer);
              }
              connection.close();
          } catch (Exception e) {
              e.printStackTrace();
          }
          
          // Display offers dynamically
          for (Offer offer : offers) {
        %>
        <div class="col-md-4">
          <div class="card bg-dark text-white">
            <img src="<%= offer.getImageUrl() %>" class="card-img-top" alt="<%= offer.getTitle() %>">
            <div class="card-body">
              <h5 class="card-title"><%= offer.getTitle() %></h5>
              <p class="card-text"><%= offer.getDescription() %></p>
              <a href="book.jsp" class="btn btn-warning">Book Now</a>
            </div>
          </div>
        </div>
        <% } %>
      </div>

      <!-- Pagination (optional) -->
      <div class="mt-4">
        <nav aria-label="Page navigation">
          <ul class="pagination justify-content-center">
            <li class="page-item"><a class="page-link" href="#">Previous</a></li>
            <li class="page-item"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">Next</a></li>
          </ul>
        </nav>
      </div>
    </div>
  </section>

  <!-- Footer -->
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

<%!
    // Define the Offer class within the JSP to handle offer objects
    public class Offer {
        private int id;
        private String title;
        private String description;
        private String imageUrl;

        // Getters and setters
        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public String getImageUrl() {
            return imageUrl;
        }

        public void setImageUrl(String imageUrl) {
            this.imageUrl = imageUrl;
        }
    }
%>
