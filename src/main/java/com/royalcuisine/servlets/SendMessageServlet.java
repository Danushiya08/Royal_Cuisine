package com.royalcuisine.servlets;
import com.royalcuisine.utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SendMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String recipientEmail = request.getParameter("email");
        String message = request.getParameter("message");

        if (recipientEmail == null || message == null || recipientEmail.isEmpty() || message.isEmpty()) {
            response.sendRedirect("admin_message.jsp?error=Email and message cannot be empty.");
            return;
        }

        // Send the email
        boolean emailSent = sendEmail(recipientEmail, "Admin Message", message);

        if (emailSent) {
            // Save the sent message to the database
            String sql = "INSERT INTO sent_messages (recipient_email, message) VALUES (?, ?)";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, recipientEmail);
                stmt.setString(2, message);
                stmt.executeUpdate();
                response.sendRedirect("admin_message.jsp?success=Message sent successfully.");
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("admin_message.jsp?error=Database error.");
            }
        } else {
            response.sendRedirect("admin_message.jsp?error=Failed to send message.");
        }
    }

    // Email sending function integrated into the servlet
    private boolean sendEmail(String toEmail, String subject, String body) {
        String fromEmail = "shiyadanu891@gmail.com"; // Your admin email
        String password = "xtlb byjw rmfv vpgf"; // Your email password

        // SMTP server settings
        String host = "smtp.gmail.com";  // Gmail SMTP server
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");

        // Set up the session and authenticate
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // Create the email message
            Message messageObj = new MimeMessage(session);
            messageObj.setFrom(new InternetAddress(fromEmail));
            messageObj.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            messageObj.setSubject(subject);
            messageObj.setText(body);

            // Send the email
            Transport.send(messageObj);
            return true; // Email sent successfully
        } catch (MessagingException e) {
            e.printStackTrace();
            return false; // Email failed to send
        }
    }
}
