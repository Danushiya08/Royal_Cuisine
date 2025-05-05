<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/signup.css" rel="stylesheet">
</head>
<body>
    <div class="min-vh-100 d-flex align-items-center justify-content-center background-overlay" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5 px-5 py-4" style="background-color: #000000b3; border-radius: 20px">
                    <h1 class="text-white text-center mb-4 fw-bold">Sign Up</h1>
                    
                    <form id="signupForm" action="SignupServlet" method="post">
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <div class="form-floating">
                                    <input 
                                        type="text" 
                                        class="form-control custom-input" 
                                        id="firstName" 
                                        name="firstName"
                                        placeholder="First Name"
                                        required
                                    >
                                    <label for="firstName">First Name</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input 
                                        type="text" 
                                        class="form-control custom-input" 
                                        id="lastName" 
                                        name="lastName"
                                        placeholder="Last Name"
                                        required
                                    >
                                    <label for="lastName">Last Name</label>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <div class="form-floating">
                                <input 
                                    type="text" 
                                    class="form-control custom-input" 
                                    id="emailAddress" 
                                    name="emailAddress"
                                    placeholder="Email Address"
                                    required
                                >
                                <label for="emailAddress">Email Address</label>
                                <div id="emailError" class="invalid-feedback"></div>
                            </div>
                        </div>
                        
                        <div class="mb-3 position-relative">
                            <div class="form-floating">
                                <input 
                                    type="password" 
                                    class="form-control custom-input" 
                                    id="password" 
                                    name="password"
                                    placeholder="Password"
                                    required
                                >
                                <label for="password">Password</label>
                                <div id="passwordError" class="invalid-feedback"></div>
                            </div>
                        </div>
                        
                        <div class="mb-3 position-relative">
                            <div class="form-floating">
                                <input 
                                    type="password" 
                                    class="form-control custom-input" 
                                    id="confirmPassword" 
                                    name="confirmPassword"
                                    placeholder="Confirm Password"
                                    required
                                >
                                <label for="confirmPassword">Confirm Password</label>
                                <div id="confirmPasswordError" class="invalid-feedback"></div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <div class="input-group custom-input-group">
                                <span class="input-group-text custom-input">+94</span>
                                <div class="form-floating flex-grow-1">
                                    <input 
                                        type="tel" 
                                        class="form-control custom-input border-start-0" 
                                        id="contactNumber" 
                                        name="contactNumber"
                                        placeholder="Contact Number"
                                        required
                                    >
                                    <label for="contactNumber">Contact Number</label>
                                    <div id="contactNumberError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                        
                      
                        
                        <button type="submit" class="btn custom-button w-100 py-3 fw-semibold">
                            Sign Up
                        </button>
                        <div class="mb-5 form-check">
                          
                        <label class="form-check-label text-white fw-medium" for="agreeTerms">
                          you already have an account?
                        </label>
                        <a href="login.jsp" class="text-danger fw-bold">Login</a>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <%
	    String errorMessage = request.getParameter("error");
	    String successMessage = request.getParameter("success");
	    Boolean signupSuccess  = (Boolean) request.getAttribute("signupSuccess");
	%>
	<script>
	    <% if (errorMessage != null) { %>
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '<%= errorMessage %>'
	        });
	    <% } else if (signupSuccess  != null && signupSuccess ) { %>
		    Swal.fire({
	            icon: 'success',
	            title: 'Account created successfully.',
	            text: 'Welcome to Royal Cuisine! Click Login Button to Login to Royal Cuisine Platform',
	            confirmButtonText: 'Login'
	        }).then((result) => {
	            if (result.isConfirmed) {
	                window.location.href = "login.jsp"; 
	            }
	        });
	    <% } %>
	</script>

	<script>
		document.getElementById("signupForm").addEventListener("submit", function(event) {
		    let valid = true;
		
		    const email = document.getElementById("emailAddress");
		    const password = document.getElementById("password");
		    const confirmPassword = document.getElementById("confirmPassword");
		    const contactNumber = document.getElementById("contactNumber");
		
		    email.classList.remove("is-invalid");
		    password.classList.remove("is-invalid");
		    confirmPassword.classList.remove("is-invalid");
		    contactNumberError.classList.remove("is-invalid");
		    document.getElementById("emailError").textContent = "";
		    document.getElementById("passwordError").textContent = "";
		    document.getElementById("confirmPasswordError").textContent = "";
		    document.getElementById("contactNumberError").textContent = "";
		
		    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		    if (!emailRegex.test(email.value.trim())) {
		        email.classList.add("is-invalid");
		        document.getElementById("emailError").textContent = "Please enter a valid email address.";
		        valid = false;
		    }
		
		    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/;
		    if (!passwordRegex.test(password.value)) {
		        password.classList.add("is-invalid");
		        document.getElementById("passwordError").textContent = 
		            "Password must be at least 8 characters and include upper, lower case and a number.";
		        valid = false;
		    }
		
		    if (password.value !== confirmPassword.value) {
		        confirmPassword.classList.add("is-invalid");
		        document.getElementById("confirmPasswordError").textContent = "Passwords do not match.";
		        valid = false;
		    }
		    
		    const phonePattern = /^[1-9]\d{8}$/;
		    if (!phonePattern.test(contactNumber.value.trim())) {
		        contactNumber.classList.add('is-invalid');
		        document.getElementById("contactNumberError").textContent = "Enter 9-digit phone number (without leading 0). Example: 712345678";
		        valid = false;
		    }
		
		    if (!valid) {
		        event.preventDefault();
		    }
		});
	</script>
 
</body>
</html>

