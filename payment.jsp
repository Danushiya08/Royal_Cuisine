<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@ page import="jakarta.servlet.http.HttpSession, java.sql.*,java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>

<%
    // Get reservation details from request parameters (coming from the URL)
    String reservation_id = request.getParameter("reservation_id");
    String reservation_date = request.getParameter("reservation_date");
    String guests = request.getParameter("guests");
    String package_selected = request.getParameter("package_selected");

    // Initialize totalAmount
    double totalAmount = 0.0;

    // Calculate total amount based on package selected
    if (package_selected != null) {
        if (package_selected.equals("Basic Package")) {
            totalAmount = 50.0;
        } else if (package_selected.equals("Premium Package")) {
            totalAmount = 100.0;
        } else if (package_selected.equals("Vip Package")) {
            totalAmount = 200.0;
        }
    }

    // You can further adjust this logic if needed to add additional factors like meals or beverages
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Payment - Royal Cuisine</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <style>
    .payment-container {
      max-width: 600px;
      margin: 0 auto;
      padding: 20px;
      background-color: #333;
      border-radius: 10px;
      box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    }

    .payment-header {
      text-align: center;
      margin-bottom: 20px;
    }

    .payment-header h2 {
      margin-bottom: 10px;
      font-size: 2rem;
      font-weight: bold;
      color: #f1c40f;
    }

    .payment-header p {
      font-size: 1.2rem;
      color: #f1c40f;
    }

    .payment-info {
      text-align: left;
      margin-bottom: 20px;
      font-size: 1.1rem;
    }

    .payment-info p {
      margin: 10px 0;
      font-size: 1.2rem;
    }

    .payment-info strong {
      color: #f1c40f;
    }

    .form-control {
      background-color: #444;
      color: #fff;
      border: 1px solid #f1c40f;
    }

    .form-control:focus {
      background-color: #555;
      border-color: #f1c40f;
    }

    .btn-warning {
      background-color: #f1c40f;
      border-color: #f1c40f;
      color: #000;
    }

    .btn-warning:hover {
      background-color: #ffc107;
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

  <!-- Payment Section -->
  <section class="py-5 text-center">
    <div class="container">
      <div class="payment-container">
        <div class="payment-header">
          <h2>Payment for Your Reservation</h2>
          <p>Complete your payment below for your reservation.</p>
        </div>

        <!-- Reservation Details -->
        <div class="payment-info">
          <h4>Reservation Details:</h4>
          <p><strong>Package:</strong> <%= package_selected %></p>
          <p><strong>Reservation Date:</strong> <%= reservation_date %></p>
          <p><strong>Guests:</strong> <%= guests %></p>

          <h4>Total Amount: $<%= totalAmount %></h4>
        </div>

        <!-- Stripe Payment Form -->
        <form action="ProcessPaymentServlet" method="POST" class="border p-4" id="payment-form">
          <input type="hidden" name="reservation_id" value="<%= reservation_id %>">
          <input type="hidden" name="totalAmount" value="<%= totalAmount %>">

          <!-- Stripe Card Element -->
          <div class="form-group">
            <label for="card-element" class="form-label">Enter Payment Details</label>
            <div id="card-element" class="form-control">
              <!-- A Stripe Element will be inserted here. -->
            </div>
            <div id="card-errors" role="alert"></div>
          </div>

          <button type="submit" class="btn btn-warning" id="submit-button">Complete Payment</button>
        </form>
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
  <!-- Bootstrap JS Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Stripe JS Script -->
  <script src="https://js.stripe.com/v3/"></script>
  <script>
    var stripe = Stripe('pk_test_51R7IsZFKBuG4KLiqtsE69eFopP1SxIpOZYxmMiecU8qJ3xWu7BTzVJlx8VlOc529fH9rOMAy4kyqcsNZ0RMWgfzn00dBKdm3o8'); // Replace with your actual publishable key
    var elements = stripe.elements();
    var card = elements.create('card');
    card.mount('#card-element');

    var form = document.getElementById('payment-form');
    form.addEventListener('submit', function(event) {
      event.preventDefault();
      
      stripe.createToken(card).then(function(result) {
        if (result.error) {
          // Display error message
          var errorElement = document.getElementById('card-errors');
          errorElement.textContent = result.error.message;
        } else {
          // Attach the token to the form and submit it
          var token = result.token;
          var hiddenInput = document.createElement('input');
          hiddenInput.setAttribute('type', 'hidden');
          hiddenInput.setAttribute('name', 'stripeToken');
          hiddenInput.setAttribute('value', token.id);
          form.appendChild(hiddenInput);
          form.submit();
        }
      });
    });
  </script>
</body>
</html>
