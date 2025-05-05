<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reservation Form - Royal Cuisine</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
  .reservation-summary {
    background-color: #333;
    border-radius: 8px;
    padding: 20px;
    width: 600px; /* Increased width to make it more centered */
    color: #fff;
 
  }

  .reservation-summary h4 {
    font-size: 1.5rem;
    margin-bottom: 10px;
    color: #ffcc00;
  }

  .reservation-summary ul {
    list-style: none;
    padding: 0;
  }

  .reservation-summary li {
    margin-bottom: 8px;
  }

  .reservation-summary .table-info,
  .reservation-summary .menu-info {
    display: flex;
    flex-direction: column; /* Stack items vertically */
    align-items: center; /* Center-align the content */
    justify-content: center;
  }

  .reservation-summary .menu-info div {
    margin: 10px 0; /* Add space between items */
  }

  .reservation-summary .menu-info img {
    width: 50px;
    height: 50px;
    object-fit: cover;
    border-radius: 5px;
    margin-bottom: 10px; /* Space below the image */
  }
       div:where(.swal2-container) h2:where(.swal2-title) {
  	font-size: 20px !important;
  }
  div:where(.swal2-container) div:where(.swal2-html-container) {
      font-size: 14px !important;
  }
  
  #editableMeals {
  	display: flex;
    flex-direction: column;
    align-items: flex-start;
  }
  
  #editableBeverages {
  display: flex;
    flex-direction: column;
    align-items: flex-start;
  }
</style>

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

  <!-- Reservation Section -->
  <section class="py-5 text-center">
    <div class="container">
      <h2 class="font-serif fst-italic display-5 text-warning">Complete Your Reservation</h2>
      
      <div class="d-flex justify-content-between mt-5">
	      <div class="reservation-summary ">
	        <h4>Table Details</h4>
	        <div class="table-info" style="color:white;">
	          <span><strong>Table ID:</strong> <%= request.getParameter("table_id") != null ? request.getParameter("table_id") : "Not Selected" %></span>
	        </div>
	        
	        <div class="d-flex align-items-start justify-content-center gap-5 mt-5">
		        <div>
			        <h4 class="text-start">Meals Selected</h4>
					<div id="editableMeals">
					  <% 
					    String[] Meals = request.getParameterValues("meals");
					    if (Meals != null && Meals.length > 0) {
					        for (String meal : Meals) {
					            String quantityStr = request.getParameter("meal_quantities[" + meal + "]");
					            if (quantityStr == null || quantityStr.isEmpty()) {
					                quantityStr = "1";
					            }
					  %>
					    <div class="mb-2">
					      <label>🟡<%= meal %>: </label>
					      <input 
					        type="number" 
					        class="meal-input form-control w-auto d-inline-block" 
					        name="meal_quantities_display" 
					        data-meal="<%= meal %>" 
					        value="<%= quantityStr %>" 
					        min="1" max="20" 
					        style="width: 70px;"
					      />
					    </div>
					  <% 
					        }
					    }
					  %>
					</div>
		        </div>
		        
		        <div>
			        <h4 class="text-start">Beverages Selected</h4>
			        <div id="editableBeverages">
					  <% 
					    String[] selectedBeverages = request.getParameterValues("beverage");
					    if (selectedBeverages != null && selectedBeverages.length > 0) {
					        for (String beverage : selectedBeverages) {
					            String quantityStr = request.getParameter("beverage_quantities[" + beverage + "]");
					            if (quantityStr == null || quantityStr.isEmpty()) {
					                quantityStr = "1";
					            }
					  %>
					    <div class="mb-2">
					      <label>🟡<%= beverage %>: </label>
					      <input 
					        type="number" 
					        class="beverage-input form-control w-auto d-inline-block" 
					        name="beverage_quantities_display" 
					        data-beverage="<%= beverage %>" 
					        value="<%= quantityStr %>" 
					        min="1" max="20" 
					        style="width: 70px;"
					      />
					    </div>
					  <% 
					        }
					    } else {
					  %>
					    <p>No beverages selected</p>
					  <% 
					    }
					  %>
					</div>
		        
		        </div>
	        
	        </div>
	
	        
	
	
	
	        
	
	      </div>
	      
	      <form id="reservationForm" action="BookTableServlet" method="POST" class="border p-4 " style="width: 600px;">
	          <!-- Pass the table ID, meals, and beverages to the booking page -->
	          <input type="hidden" name="table_id" value="<%= request.getParameter("table_id") %>">
	
	
	          <div class="mb-3">
	              <label for="name" class="form-label">Full Name</label>
	              <input type="text" class="form-control" id="name" name="name" required>
	          </div>
				<!--
	          <div class="mb-3">
	              <label for="email" class="form-label">Email Address</label>
	              <input type="hidden" class="form-control" id="email" name="email">
	          </div> -->
	
	          <div class="mb-3">
	              <label for="phone" class="form-label">Phone Number</label>
	              <input type="text" class="form-control" id="phone" name="phone" required>
	              <div id="phoneError" class="invalid-feedback"></div>
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
	              <div id="guestsError" class="invalid-feedback"></div>
	          </div>
	          <div id="hiddenMealInputs"></div>
	          <div id="hiddenBeverageInputs"></div>
	
	          <button type="submit" class="btn btn-warning">Complete Reservation</button>
	      </form>
	      
	      
      </div>

      <!-- Reservation Summary Section -->
      

      <!-- Reservation Form inside Border Box -->
      
    </div>
  </section>
  <script>
	document.getElementById("reservationForm").addEventListener("submit", function(e) {

	  const hiddenContainer = document.getElementById("hiddenMealInputs");
	  hiddenContainer.innerHTML = "";
	
	  const mealInputs = document.querySelectorAll(".meal-input");
	  mealInputs.forEach(input => {
	    const mealName = input.dataset.meal;
	    const qty = input.value;
	    
	    console.log(`Meal: ${mealName}, Qty: ${qty}`);
	
	    const mealInput = document.createElement("input");
	    mealInput.type = "hidden";
	    mealInput.name = "meals";
	    mealInput.value = mealName;
	    hiddenContainer.appendChild(mealInput);
	
	    const qtyInput = document.createElement("input");
	    qtyInput.type = "hidden";
	    qtyInput.name = "meal_quantity_" + mealName.replace(/\s+/g, "_");
	    qtyInput.value = qty;
	    hiddenContainer.appendChild(qtyInput);
	  });
	  
	  const hiddenContainer2 = document.getElementById("hiddenBeverageInputs");
	  hiddenContainer2.innerHTML = "";
	  
	  const beverageInputs = document.querySelectorAll(".beverage-input");
	  beverageInputs.forEach(input => {
	    const bevName = input.dataset.beverage;
	    const qty = input.value;

	    const bevInput = document.createElement("input");
	    bevInput.type = "hidden";
	    bevInput.name = "beverages";
	    bevInput.value = bevName;
	    hiddenContainer.appendChild(bevInput);

	    const qtyInput = document.createElement("input");
	    qtyInput.type = "hidden";
	    qtyInput.name = "beverage_quantity_" + bevName.replace(/\s+/g, "_");
	    qtyInput.value = qty;
	    hiddenContainer.appendChild(qtyInput);
	  });
	});
</script>
  

  <!-- Footer -->
  <footer class="bg-black text-white py-5">
    <div class="container">
      <div class="row">
        <div class="col-md-4 mb-4 mb-md-0">
          <h3 class="fs-4 mb-4">Open Hours</h3>
          <jsp:include page="/include/hours.jsp" />
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
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	<script>
	    document.getElementById("reservationForm").addEventListener("submit", function (e) {
	        const selectedDate = new Date(document.getElementById("date").value);
	        const today = new Date();
	        today.setHours(0, 0, 0, 0);
	
	        if (selectedDate < today) {
	            e.preventDefault();
	            Swal.fire({
	                icon: 'error',
	                title: 'Invalid Date',
	                text: 'Reservation date cannot be in the past.',
	            });
	        }
	    });
	</script>
	<script>
		document.getElementById('reservationForm').addEventListener('submit', function (e) {
		    let valid = true;
		
		    const phone = document.getElementById('phone');
		    const guests = document.getElementById('guests');
		
		    const phoneError = document.getElementById('phoneError');
		    const guestsError = document.getElementById('guestsError');
		
		    phone.classList.remove('is-invalid');
		    guests.classList.remove('is-invalid');
		    phoneError.textContent = '';
		    guestsError.textContent = '';
		
		    const phonePattern = /^0\d{9}$/;
		    if (!phonePattern.test(phone.value.trim())) {
		        phone.classList.add('is-invalid');
		        phoneError.textContent = "Phone number must start with 0 and be need to be 10 digits.";
		        valid = false;
		    }
		
		    if (!guests.value || parseInt(guests.value) < 1) {
		        guests.classList.add('is-invalid');
		        guestsError.textContent = "Number of guests must be at least 1.";
		        valid = false;
		    }
		
		    if (!valid) {
		        e.preventDefault();
		    }
		});
	</script>
	
	<script>
	<%
	    String errorMessage = request.getParameter("error");
	    String successMessage = request.getParameter("success");
	%>
    <% if (errorMessage != null) { %>
	    Swal.fire({
	        icon: 'error',
	        title: 'Oops...',
	        text: '<%= errorMessage %>'
	    });
	<% } else if (successMessage != null) { %>
	    Swal.fire({
	        icon: 'success',
	        title: 'Reservation Success',
	        text: '<%= successMessage %>'
	    }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "profile.jsp"; 
            }
        });
	<% } %>
	</script>
</body>
</html>
