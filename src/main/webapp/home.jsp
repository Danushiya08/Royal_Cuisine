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
            <a href="about.jsp" class="text-white text-decoration-none me-4 nav-link">About</a>
            <a href="menu.jsp" class="text-white text-decoration-none me-4 nav-link">Menu</a>
            <a href="offers.jsp" class="text-white text-decoration-none me-4 nav-link">Offers</a>
            <a href="location.jsp" class="text-white text-decoration-none me-4 nav-link">Location</a>
            <a href="feedback.jsp" class="text-white text-decoration-none me-4 nav-link">Feedback</a>
            <a href="contact.jsp" class="text-white text-decoration-none me-4 nav-link">Contact</a>
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
  <section class="hero-section position-relative d-flex align-items-center justify-content-center text-center vh-100">
    <div class="hero-overlay"></div>
    <div class="container position-relative z-index-1">
      <div class="row justify-content-center">
        <div class="col-md-10 col-lg-8">
          <h2 class="font-serif fst-italic display-5 mb-2 mt-0">Welcome To Royal Cuisine</h2>
          <h1 class="font-serif display-3 mb-4" style="font-size: 60px">A Symphony of Luxury & Flavor</h1>
          <div class="d-flex justify-content-center gap-3">
            <a href="book.jsp" class="btn btn-gold px-5 py-3 text-white rounded-5">Reserve</a>
            <a href="menu.jsp" class="btn btn-light-gray px-5 py-3 rounded-5">Menu</a>
          </div>
        </div>
      </div>
    </div>
  </section>

 <!-- Master Chef Section -->
<section class="py-5 text-center bg-white" style="">
    <div class="container">
      <h2 class="mb-5">
        <span class="text-amber font-serif fst-italic display-5" style="font-size: 36px">Our Team</span>
        <br>
        <span class="text-dark fs-4 text-amber font-serif fst-italic">Focuses on the positive outcomes of collaboration.</span>
      </h2>
      
      <div class="row justify-content-center mt-5 py-4">
        <!-- Chef 1 -->
        <div class="col-md-3 mb-4 mb-md-0">
          <img src="https://businesstoday.lk/wp-content/uploads/2022/09/ezgif.com-gif-maker-25-3-863x1024.webp" alt="John Smooth" class="img-fluid mb-3" style="width: 200px; height: 200px; border-radius: 100px; object-fit: cover;">
          <h3 class="fs-4 mb-1 text-dark">Dharshan Munidasa</h3>
          <p class="text-gray small mb-2">Restaurant Owner</p>
        </div>
        
        <div class="col-md-3">
          <img src="https://traveltradejournal.com/wp-content/uploads/2024/02/Saharsh-Vadhera-Director-Sales-and-Marketing-Shangri-La-Sri-Lanka.jpg" alt="Luke Simon" class="img-fluid mb-3" style="width: 200px; height: 200px; border-radius: 100px; object-fit: cover;">
          <h3 class="fs-4 mb-1 text-dark">Saharsh Vadhera</h3>
          <p class="text-gray small mb-2">Restaurant Manager</p>
        </div>
        
        <div class="col-md-3">
          <img src="https://s3.amazonaws.com/bizenglish/wp-content/uploads/2023/03/15120002/International-award-winning-culinary-expert-Nuwan-Silva-Executive-Chef-at-Courtyard-by-Marriott-Colombo-e1678861849201.jpg" alt="Luke Simon" class="img-fluid mb-3" style="width: 200px; height: 200px; border-radius: 100px; object-fit: cover;">
          <h3 class="fs-4 mb-1 text-dark">Nuwan Silva </h3>
          <p class="text-gray small mb-2">Executive Chef</p>
        </div>
        
        <div class="col-md-3">
          <img src="https://10play.com.au/ip/s3/2022/03/30/30218224a21ae68942cb1e2ab22d4a78-1138696.jpg?image-profile=bio_full&io=portrait" alt="Luke Simon" class="img-fluid mb-3" style="width: 200px; height: 200px; border-radius: 100px; object-fit: cover;">
          <h3 class="fs-4 mb-1 text-dark">Dulan Hapuarachchi</h3>
          <p class="text-gray small mb-2">Sous Chef</p>
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
          
	<jsp:include page="/include/hours.jsp" />
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