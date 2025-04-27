document.addEventListener("DOMContentLoaded", () => {
    // Password visibility toggle
    const toggleButtons = document.querySelectorAll(".toggle-password")
    toggleButtons.forEach((button) => {
      button.addEventListener("click", function () {
        const targetId = this.getAttribute("data-target")
        const passwordInput = document.getElementById(targetId)
        const eyeIcon = this.querySelector(".eye-icon")
  
        if (passwordInput.type === "password") {
          passwordInput.type = "text"
          eyeIcon.classList.add("hide")
        } else {
          passwordInput.type = "password"
          eyeIcon.classList.remove("hide")
        }
      })
    })
  
    // Form validation
    const form = document.getElementById("signupForm")
    form.addEventListener("submit", (e) => {
      e.preventDefault()
  
      // Get form values
      const firstName = document.getElementById("firstName").value
      const lastName = document.getElementById("lastName").value
      const email = document.getElementById("emailAddress").value
      const password = document.getElementById("password").value
      const confirmPassword = document.getElementById("confirmPassword").value
      const contactNumber = document.getElementById("contactNumber").value
      const agreeTerms = document.getElementById("agreeTerms").checked
  
      // Basic validation
      if (password !== confirmPassword) {
        alert("Passwords do not match!")
        return
      }
  
      if (!agreeTerms) {
        alert("Please agree to the Privacy and Policy")
        return
      }
  
      // If validation passes, you can submit the form
      console.log("Form submitted:", {
        firstName,
        lastName,
        email,
        password,
        contactNumber,
      })
  
      // Here you would typically send the data to your server
      // For demo purposes, we'll just reset the form
      form.reset()
    })
  
    // Phone number validation
    const phoneInput = document.getElementById("contactNumber")
    phoneInput.addEventListener("input", function (e) {
      // Remove any non-numeric characters
      this.value = this.value.replace(/[^\d]/g, "")
    })
  
    // Email validation
    const emailInput = document.getElementById("emailAddress")
    emailInput.addEventListener("blur", function () {
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
      if (!emailRegex.test(this.value) && this.value !== "") {
        this.classList.add("is-invalid")
      } else {
        this.classList.remove("is-invalid")
      }
    })
  
    // Password strength validation
    const passwordInput = document.getElementById("password")
    passwordInput.addEventListener("input", function () {
      const password = this.value
      const hasUpperCase = /[A-Z]/.test(password)
      const hasLowerCase = /[a-z]/.test(password)
      const hasNumbers = /\d/.test(password)
      const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password)
      const isLongEnough = password.length >= 8
  
      if (password && !(hasUpperCase && hasLowerCase && hasNumbers && hasSpecialChar && isLongEnough)) {
        this.classList.add("is-invalid")
      } else {
        this.classList.remove("is-invalid")
      }
    })
  })
  
  