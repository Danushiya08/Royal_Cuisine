<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Royal Cuisine - A Symphony of Luxury & Flavor</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
  <!-- Custom CSS -->
  <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
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

  <!-- Hero Section -->
  <section class="hero-section position-relative d-flex align-items-center justify-content-center text-center">
    <div class="hero-overlay"></div>
    <div class="container position-relative z-index-1">
      <div class="row justify-content-center">
        <div class="col-md-10 col-lg-8">
          <h2 class="font-serif fst-italic display-5 mb-2">Welcome To Royal Cuisine</h2>
          <h1 class="font-serif display-3 mb-4">A Symphony of Luxury & Flavor</h1>
          <div class="d-flex justify-content-center gap-3">
            <a href="book.jsp" class="btn btn-light-gray px-4 py-2">Reserve</a>
            <a href="menu.jsp" class="btn btn-light-gray px-4 py-2">Menu</a>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Catering Services Section -->
<!-- Catering Services Section -->
<section class="py-5 bg-white">
    <div class="container text-center">
      <h2 class="mb-5">
        <span class="text-amber font-serif fst-italic display-5">Catering</span>
        <br>
        <span class="text-white fs-3">SERVICES</span>
      </h2>
      
      <div class="row ">
        <!-- Birthday Party -->
        <div class="col-md-4 mb-4 mb-md-0">
          <div class="service-icon mx-auto mb-3 bg-black text-white p-3 rounded-circle">
            <i class="bi bi-cake2 fs-1"></i>
          </div>
          <h3 class="fs-4 mb-2 text-black">Birthday Party</h3>
          <p class="text-black small">
            Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic.
          </p>
        </div>
        
        <!-- Business Meetings -->
        <div class="col-md-4 mb-4 mb-md-0">
          <div class="service-icon mx-auto mb-3 bg-black text-white p-3 rounded-circle">
            <i class="bi bi-people fs-1"></i>
          </div>
          <h3 class="fs-4 mb-2 text-black">Business Meetings</h3>
          <p class="text-black small">
            Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic.
          </p>
        </div>
        
        <!-- Wedding Party -->
        <div class="col-md-4">
          <div class="service-icon mx-auto mb-3 bg-black text-white p-3 rounded-circle">
            <i class="bi bi-cup-straw fs-1 "></i>
          </div>
          <h3 class="fs-4 mb-2 text-black">Wedding Party</h3>
          <p class="text-black small">
            Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic.
          </p>
        </div>
      </div>
    </div>
  </section>
  


 <!-- Master Chef Section -->
<section class="py-5 text-center" style="background: url('assets/Rectangle63.png') no-repeat center center/cover;">
    <div class="container">
      <h2 class="mb-5">
        <span class="text-amber font-serif fst-italic display-5">Chef</span>
        <br>
        <span class="text-white fs-3">MASTER CHEF</span>
      </h2>
      
      <div class="row justify-content-center">
        <!-- Chef 1 -->
        <div class="col-md-5 mb-4 mb-md-0">
          <img src="assets/Rectangle66.png" alt="John Smooth" class="img-fluid mb-3" style="max-width: 200px;">
          <h3 class="fs-4 mb-1 text-white">John Smooth</h3>
          <p class="text-gray small mb-2">Restaurant Owner</p>
          <p class="text-gray small">
            A small river named Duden flows by their place and supplies it with the necessary regelialia.
          </p>
        </div>
        
        <!-- Chef 2 -->
        <div class="col-md-5">
          <img src="assets/Rectangle67.png" alt="Luke Simon" class="img-fluid mb-3" style="max-width: 200px;">
          <h3 class="fs-4 mb-1 text-white">Luke Simon</h3>
          <p class="text-gray small mb-2">Head Chef</p>
          <p class="text-gray small">
            A small river named Duden flows by their place and supplies it with the necessary regelialia.
          </p>
        </div>
      </div>
    </div>
  </section>
  

  <!-- Food Gallery -->
  <section class="food-gallery position-relative">
    <!-- This would be replaced with actual images -->
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