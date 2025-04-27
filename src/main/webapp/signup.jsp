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
                <div class="col-md-6 col-lg-5">
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
                                    type="email" 
                                    class="form-control custom-input" 
                                    id="emailAddress" 
                                    name="emailAddress"
                                    placeholder="Email Address"
                                    required
                                >
                                <label for="emailAddress">Email Address</label>
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
                            </div>
                            <button 
                                type="button"
                                class="btn position-absolute end-0 top-50 translate-middle-y bg-transparent border-0 text-dark me-2 toggle-password"
                                data-target="password"
                            >
                                <i class="eye-icon"></i>
                            </button>
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
                            </div>
                            <button 
                                type="button"
                                class="btn position-absolute end-0 top-50 translate-middle-y bg-transparent border-0 text-dark me-2 toggle-password"
                                data-target="confirmPassword"
                            >
                                <i class="eye-icon"></i>
                            </button>
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
    <!-- Custom JS -->
 
</body>
</html>

