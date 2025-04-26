<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="com.royalcuisine.servlets.MenuServlet.Meal" %>
<%@ page import="com.royalcuisine.servlets.MenuServlet.Beverage" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Menu - Royal Cuisine</title>
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
  <!-- Menu Section -->
  <section class="py-5 text-center">
    <div class="container">
      <h2 class="font-serif fst-italic display-5 text-amber">Our Menu</h2>
      <div class="row mt-4">

        <% 
        // JDBC connection details
        String jdbcURL = "jdbc:mysql://localhost:3308/royal_cuisine";
        String jdbcUsername = "root";
        String jdbcPassword = "12345678";
        
        List<Meal> mealList = new ArrayList<>();
        List<Beverage> beverageList = new ArrayList<>();

        try {
            // Establish connection to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // Query to fetch meals
            String mealSql = "SELECT name, description, price, image_url FROM meals";
            PreparedStatement mealStatement = connection.prepareStatement(mealSql);
            ResultSet mealResultSet = mealStatement.executeQuery();

            // Fetch and store meal details in mealList
            while (mealResultSet.next()) {
                Meal meal = new Meal();
                meal.setName(mealResultSet.getString("name"));
                meal.setDescription(mealResultSet.getString("description"));
                meal.setPrice(mealResultSet.getDouble("price"));
                meal.setImageUrl(mealResultSet.getString("image_url"));
                mealList.add(meal);
            }

            // Query to fetch beverages
            String beverageSql = "SELECT name, description, price, image_url FROM beverages";
            PreparedStatement beverageStatement = connection.prepareStatement(beverageSql);
            ResultSet beverageResultSet = beverageStatement.executeQuery();

            // Fetch and store beverage details in beverageList
            while (beverageResultSet.next()) {
                Beverage beverage = new Beverage();
                beverage.setName(beverageResultSet.getString("name"));
                beverage.setDescription(beverageResultSet.getString("description"));
                beverage.setPrice(beverageResultSet.getDouble("price"));
                beverage.setImageUrl(beverageResultSet.getString("image_url"));
                beverageList.add(beverage);
            }

            // Close resources
            mealResultSet.close();
            mealStatement.close();
            beverageResultSet.close();
            beverageStatement.close();
            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='alert alert-danger'>Error fetching meals and beverages: " + e.getMessage() + "</div>");
        }

        %>

        <!-- Display Meals -->
        <h3 class="mt-5">Meals</h3>
        <form action="reservation.jsp" method="POST">
        <div class="row">
        <% 
            if (!mealList.isEmpty()) {
                for (Meal meal : mealList) {
        %>
          <div class="col-md-4 mt-4">
            <div class="card bg-dark text-white p-3">
                <img src="<%= meal.getImageUrl() %>" alt="<%= meal.getName() %>" class="card-img-top" />
                <h3 class="fs-4 mt-3"><%= meal.getName() %></h3>
                <p><%= meal.getDescription() %></p>
                <p>$<%= meal.getPrice() %></p>
                <input type="checkbox" name="meals" value="<%= meal.getName() %>"> Select Meal
            </div>
          </div>
        <% 
                }
            }
        %>
        </div>

        <!-- Display Beverages -->
        <h3 class="mt-5">Beverages</h3>
        <div class="row">
        <% 
            if (!beverageList.isEmpty()) {
                for (Beverage beverage : beverageList) {
        %>
          <div class="col-md-4 mt-4">
            <div class="card bg-dark text-white p-3">
                <img src="<%= beverage.getImageUrl() %>" alt="<%= beverage.getName() %>" class="card-img-top" />
                <h3 class="fs-4 mt-3"><%= beverage.getName() %></h3>
                <p><%= beverage.getDescription() %></p>
                <p>$<%= beverage.getPrice() %></p>
                <input type="checkbox" name="beverages" value="<%= beverage.getName() %>"> Select Beverage
            </div>
          </div>
        <% 
                }
            }
        %>
        </div>

        <!-- Pass Package Data and Submit -->
        <input type="hidden" name="package" value="<%= request.getParameter("package") %>">
        
        <!-- Book Button -->
        <div class="mt-4">
            <button type="submit" class="btn btn-gold">Proceed to Book</button>
        </div>
        </form>
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
