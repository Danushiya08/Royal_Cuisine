<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/signup.css" rel="stylesheet">
</head>
<body>
    <div class="min-vh-100 d-flex align-items-center justify-content-center background-overlay" style="background-color: rgba(0, 0, 0, 0.85);">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5">
                    <h1 class="text-white text-center mb-4 fw-bold">Welcome Back!</h1>

                    <form id="loginForm" action="LoginServlet" method="post">
                        
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
                                aria-label="Toggle password visibility"
                            >
                                <i class="bi bi-eye"></i> <!-- FontAwesome or Bootstrap Icon for eye -->
                            </button>
                        </div>
                        
                        <div class="mb-4 form-check">
                            <label class="form-check-label text-white fw-medium" for="agreeTerms">
                               Forgot Your Password?
                            </label>
                            <a href="#" class="text-danger fw-medium forgot-password-link">Reset Password</a>
                        </div>
                        
                        <button type="submit" class="btn custom-button w-100 py-3 fw-semibold">
                            Sign In
                        </button>

                        <div class="mb-5 form-check">
                            <label class="form-check-label text-white fw-medium" for="agreeTerms">
                               Don't have an account?
                            </label>
                            <a href="signup.jsp" class="text-danger fw-bold">Signup</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Forgot Password Modal -->
    <div class="modal fade" id="forgotPasswordModal" tabindex="-1" aria-labelledby="forgotPasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="forgotPasswordModalLabel">Reset Your Password</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="resetPasswordForm" method="post" action="ResetPasswordServlet">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email address" required>
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">New Password</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Enter your new password" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm your new password" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Reset Password</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom JS -->
    <script>
        // Show the reset password modal when the forgot password link is clicked
        document.querySelector('.forgot-password-link').addEventListener('click', function(e) {
            e.preventDefault();
            new bootstrap.Modal(document.getElementById('forgotPasswordModal')).show();
        });

        // Toggle password visibility
        document.querySelector('.toggle-password').addEventListener('click', function() {
            var passwordField = document.getElementById('password');
            if (passwordField.type === "password") {
                passwordField.type = "text";
            } else {
                passwordField.type = "password";
            }
        });

        // Form submission for password reset (you can adjust as per your logic)
        document.getElementById('resetPasswordForm').addEventListener('submit', function(e) {
            e.preventDefault();

            var newPassword = document.getElementById('newPassword').value;
            var confirmPassword = document.getElementById('confirmPassword').value;

            if (newPassword !== confirmPassword) {
                alert('Passwords do not match!');
                return;
            }

            // If passwords match, submit the form
            this.submit();  // This will submit the form to the ResetPasswordServlet
        });
    </script>
</body>
</html>
