<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>About Us - Royal Cuisine</title>
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
  <!-- About Us Section -->
  <section class="py-5 text-center" style="background: url('https://cdn2.forkly.com/eyJidWNrZXQiOiJvbS1wdWItc3RvcmFnZSIsImtleSI6ImZvcmtseS93cC1jb250ZW50L3VwbG9hZHMvMjAxNi8xMC9CbGFja291dC1DaG9jb2xhdGUtQ3VwY2FrZS1SZWNpcGUtU29jaWFsLTEwMjR4NTM2LmpwZyIsImVkaXRzIjp7IndlYnAiOnsicXVhbGl0eSI6ODB9LCJyZXNpemUiOnsiZml0IjoiY292ZXIiLCJiYWNrZ3JvdW5kIjp7InIiOjAsImciOjAsImIiOjAsImFscGhhIjoxfSwid2lkdGgiOjEyMDAsImhlaWdodCI6NjMwLCJwb3NpdGlvbiI6InRvcCJ9fX0=') no-repeat center center/cover;">
    <div class="container py-5">
      <h2 class="font-serif fst-italic display-5 text-amber">Our Story</h2>
      <p class="text-white fs-4">A Journey of Taste & Excellence</p>
      <p class="text-white px-4">
        Royal Cuisine was founded with the passion of bringing together flavors from around the world, 
        crafting an unforgettable dining experience that exudes luxury and indulgence. 
        Our team of expert chefs combines traditional techniques with modern innovation, ensuring that each dish 
        is an artistic masterpiece.
      </p>
    </div>
  </section>

  <!-- Our Mission Section -->
  <section class="py-5 bg-white text-center">
    <div class="container">
      <h2 class="font-serif fst-italic display-5 text-amber">Our Mission</h2>
      <p class="text-black fs-4">Delivering an Exquisite Culinary Experience</p>
      <p class="text-black px-4">
        At Royal Cuisine, our mission is to offer a fine dining experience that captivates the senses. 
        We source the finest ingredients, ensuring quality and authenticity in every bite. 
        Our commitment to excellence is reflected in our meticulous attention to detail, impeccable service, 
        and an ambiance that sets the stage for memorable moments.
      </p>
    </div>
  </section>

  <!-- Meet Our Team Section -->
  <section class="py-5 text-center bg-black text-white">
    <div class="container">
      <h2 class="font-serif fst-italic display-5 text-amber">Meet Our Team</h2>
      <p class="fs-4">Experts in the Art of Fine Dining</p>
      <div class="row justify-content-center">
        <div class="col-md-5 mb-4">
          <img src="assets/Rectangle66.png" alt="John Smooth" class="img-fluid mb-3" style="max-width: 200px;">
          <h3 class="fs-4 mb-1">John Smooth</h3>
          <p class="text-gray small">Restaurant Owner</p>
        </div>
        <div class="col-md-5">
          <img src="assets/Rectangle67.png" alt="Luke Simon" class="img-fluid mb-3" style="max-width: 200px;">
          <h3 class="fs-4 mb-1">Luke Simon</h3>
          <p class="text-gray small">Head Chef</p>
        </div>
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
