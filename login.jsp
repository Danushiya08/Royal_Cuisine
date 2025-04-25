<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/signup.css" rel="stylesheet">
</head>
<body>
    <div class="min-vh-100 d-flex align-items-center justify-content-center background-overlay" style="background-color: rgba(0, 0, 0, 0.85);">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5">
                    <h1 class="text-white text-center mb-4 fw-bold">Welcome Back!</h1>
                    <div class="mb-5 form-check">
                          
                        <label class="form-check-label text-white fw-medium" for="agreeTerms">
                           Don't have an account?
                        </label>
                        <a href="signup.jsp" class="text-danger fw-bold">Signup</a>
                    </div>
                    <form id="signupForm" action="LoginServlet" method="post">
                        
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
                        
                        
                        <div class="mb-4 form-check">
                          
                            <label class="form-check-label text-white fw-medium" for="agreeTerms">
                               Forgot Your Password?
                            </label>
                            <a href="reset-password.html" class="text-danger fw-medium">Reset Password</a>
                        </div>
                        
                        <button type="submit" class="btn custom-button w-100 py-3 fw-semibold">
                            Sign In
                        </button>
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

