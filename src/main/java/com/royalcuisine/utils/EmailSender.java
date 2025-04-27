package com.royalcuisine.utils;

import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.AuthenticationFailedException;
import java.util.Properties;

public class EmailSender {

    public static void sendEmail(String toEmail, String subject, String body) {
        String fromEmail = "shiyadanu891@gmail.com"; // Replace with your email
        String password = "xtlb byjw rmfv vpgf"; // Replace with your email password

        // Set up the SMTP server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com"); // Using Gmail's SMTP server
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Create a session
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // Create a MimeMessage
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(body);

            // Send the email
            Transport.send(message);
            System.out.println("✅ Welcome email sent to: " + toEmail);

        } catch (AuthenticationFailedException e) {
            e.printStackTrace();
            System.out.println("❌ Authentication failed. Please check the username and password.");
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("❌ Failed to send email. Messaging exception occurred.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ An unexpected error occurred.");
        }
    }
}
