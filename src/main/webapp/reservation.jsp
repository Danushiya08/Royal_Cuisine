<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reservation Form - Royal Cuisine</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-white">

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

  <!-- Reservation Section -->
  <section class="py-5 text-center">
      <div class="container">
        <h2 class="font-serif fst-italic display-5 text-warning">Complete Your Reservation</h2>
        <p>Package: <%= request.getParameter("package") %></p>

        <h4>Meals Selected:</h4>
        <ul>
        <% 
          String[] selectedMeals = request.getParameterValues("meals");
          if (selectedMeals != null) {
              for (String meal : selectedMeals) {
        %>
            <ul><%= meal %></ul>
        <% 
              }
          } else {
        %>
            <ul>No meals selected</ul>
        <% 
          }
        %>
        </ul>

        <h4>Beverages Selected:</h4>
        <ul>
        <% 
          String[] selectedBeverages = request.getParameterValues("beverages");
          if (selectedBeverages != null) {
              for (String beverage : selectedBeverages) {
        %>
            <ul><%= beverage %></ul>
        <% 
              }
          } else {
        %>
            <ul>No beverages selected</ul>
        <% 
          }
        %>
        </ul>

        <!-- Reservation Form inside Border Box -->
        <form action="BookTableServlet" method="POST" class="border p-4 mx-auto"" style="max-width: 600px;">
            <input type="hidden" name="package" value="<%= request.getParameter("package") %>">

            <div class="mb-3">
                <label for="name" class="form-label">Full Name</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Phone Number</label>
                <input type="text" class="form-control" id="phone" name="phone" required>
            </div>

            <div class="mb-3">
                <label for="date" class="form-label">Reservation Date</label>
                <input type="date" class="form-control" id="date" name="date" required>
            </div>

            <div class="mb-3">
                <label for="time" class="form-label">Reservation Time</label>
                <input type="time" class="form-control" id="time" name="time" required>
            </div>

            <div class="mb-3">
                <label for="guests" class="form-label">Number of Guests</label>
                <input type="number" class="form-control" id="guests" name="guests" required>
            </div>

            <button type="submit" class="btn btn-warning">Complete Reservation</button>
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
