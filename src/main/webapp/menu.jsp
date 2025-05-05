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

  <!-- Menu Section -->
  <section class="py-5 text-center">
    <div class="container">
      <h2 class="font-serif display-5 text-amber">Our Menu</h2>
      <div class="row mt-4">

        <% 
        // JDBC connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/royal_cuisine";
        String jdbcUsername = "root";
        String jdbcPassword = "1234";
        
        List<Meal> mealList = new ArrayList<>();
        List<Beverage> beverageList = new ArrayList<>();

        try {
            // Establish connection to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // Query to fetch meals
            String mealSql = "SELECT id, name, description, price, image_url FROM meals";
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

        <!-- Form to Send Table Details and Menu Selection to Reservation Page via URL -->
        <form action="reservation.jsp" method="POST">
          
          <!-- Table Details -->
          <input type="hidden" name="table_id" value="<%= request.getParameter("table_id") %>">
          
          <!-- Meals Selection -->
          <h3 class="mt-5">Meals</h3>
          <div class="row">
		    <% 
		        if (!mealList.isEmpty()) {
		            for (Meal meal : mealList) {
		    %>
		      <div class="col-md-3 mt-4">
		        <div class="card bg-dark text-white p-3">
		            <img src="<%= meal.getImageUrl() %>" alt="<%= meal.getName() %>" class="card-img-top" style="width: 100%; height: 200px; border-radius: 10px; object-fit: cover;"/>
		            <div class="d-flex align-items-center justify-content-between mt-3">
		            	<h3 class="fs-4 text-start"><%= meal.getName() %></h3>
		            	<div class="form-check">
		            		<label class="form-check-label text-gold " style="font-size: 12px" >Select</label>
			                <input type="checkbox" class="form-check-input meal-checkbox" name="meals" value="<%= meal.getName() %>">
		            	</div>
		            </div>
		            
		            <p class="text-start" style="font-size: 14px; font-weight: 200; "><%= meal.getDescription() %></p>
		            <p class="text-start fs-5">Rs <%= String.format("%.2f", meal.getPrice()) %></p>
		
		            
		
		            <!--<input type="hidden" name="meal_images" value="<%= meal.getImageUrl() %>"> -->
		
		            <div class="w-100">
		                <label  class="text-start w-100">Quantity</label>
		                <div class="input-group quantity-selector mt-2" style="max-width: 140px;">
						    <button type="button" class="btn btn-outline-secondary btn-minus">-</button>
						    <input type="number" class="form-control text-center meal-quantity" name="meal_quantities[<%= meal.getName() %>]" min="1" max="20" value="1">
						    <button type="button" class="btn btn-outline-secondary btn-plus">+</button>
						</div>

		            </div>
		        </div>
		      </div>
		    <% 
		            }
		        }
		    %>
		</div>


		
		
          <!-- Beverages Selection -->
          <h3 class="mt-5">Beverages</h3>
          <div class="row">
            <% 
                if (!beverageList.isEmpty()) {
                    for (Beverage beverage : beverageList) {
            %>
              <div class="col-md-3 mt-4">
                <div class="card bg-dark text-white p-3">
                    <img src="<%= beverage.getImageUrl() %>" alt="<%= beverage.getName() %>" class="card-img-top" style="width: 100%; height: 200px; border-radius: 10px; object-fit: cover;"/>
                    
                    <div class="d-flex align-items-center justify-content-between mt-3">
                    	<h3 class="fs-4 text-start"><%= beverage.getName() %></h3>
                    	<div class="form-check">
			                <input type="checkbox" class="form-check-input beverage-checkbox" name="beverage" value="<%= beverage.getName() %>">
			                <label class="text-gold " style="font-size: 12px" >Select</label>
			            </div>
                    </div>
                                      
                    <p class="text-start" style="font-size: 14px; font-weight: 200; "><%= beverage.getDescription() %></p>
                    <p class="text-start fs-5">Rs <%= String.format("%.2f", beverage.getPrice()) %></p>
                    
                    <!--<input type="hidden" name="beverage_images" value="<%= beverage.getImageUrl() %>"> -->
                                                       
                    <div class="mt-2">
		                <label  class="text-start w-100">Quantity</label>
		                <div class="input-group quantity-selector mt-2" style="max-width: 140px;">
						    <button type="button" class="btn btn-outline-secondary btn-minus">-</button>
						    <input type="number" class="form-control text-center beverage-quantity" name="beverage_quantities[<%= beverage.getName() %>]" min="1" max="20" value="1">
						    <button type="button" class="btn btn-outline-secondary btn-plus">+</button>
						</div>

		            </div>
                </div>
              </div>
            <% 
                    }
                }
            %>
          </div>
          <button type="submit" class="btn btn-warning mt-4" id="submitBtn" disabled>Proceed to Reservation</button>
        </form>
    </div>
    </div>
  </section>
  <script>
		document.querySelectorAll('.quantity-selector').forEach(group => {
		    const input = group.querySelector('input');
		    const minus = group.querySelector('.btn-minus');
		    const plus = group.querySelector('.btn-plus');
		
		    minus.addEventListener('click', () => {
		        let current = parseInt(input.value) || 1;
		        if (current > parseInt(input.min)) {
		            input.value = current - 1;
		        }
		    });
		
		    plus.addEventListener('click', () => {
		        let current = parseInt(input.value) || 1;
		        if (current < parseInt(input.max)) {
		            input.value = current + 1;
		        }
		    });
		});
	</script>
  <script>
	  function hasTableIdInURL() {
	    const params = new URLSearchParams(window.location.search);
	    return params.has('table_id');
	  }
	
	  function updateSubmitButton() {
	    const submitBtn = document.getElementById('submitBtn');
	
	    if (!hasTableIdInURL()) {
	      submitBtn.style.display = 'none';
	      return;
	    }
	
	    const mealChecked = document.querySelectorAll('.meal-checkbox:checked').length > 0;
	    const beverageChecked = document.querySelectorAll('.beverage-checkbox:checked').length > 0;
	
	    submitBtn.disabled = !(mealChecked || beverageChecked);
	    submitBtn.style.display = 'inline-block'; 
	  }
	
	  const allCheckboxes = document.querySelectorAll('.meal-checkbox, .beverage-checkbox');
	  allCheckboxes.forEach(cb => cb.addEventListener('change', updateSubmitButton));
	
	  window.addEventListener('DOMContentLoaded', updateSubmitButton);
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
</body>
</html>
