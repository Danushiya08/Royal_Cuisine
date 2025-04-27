package com.royalcuisine.servlets;

import java.io.IOException;
import java.io.OutputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

@WebServlet("/DownloadReportServlet")
public class DownloadReportServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Dummy data from session (you can fetch from DB if needed)
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        String role = "Administrator";

        // These could be passed through hidden inputs if you want to keep dynamic
        int totalReservations = 100; // Example
        int totalUsers = 50;
        int totalFeedbacks = 25;

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Admin_Report.pdf");

        try {
            Document document = new Document();
            OutputStream out = response.getOutputStream();
            PdfWriter.getInstance(document, out);

            document.open();
            
            Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.BLACK);
            Font normalFont = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL, BaseColor.BLACK);
            
            Paragraph title = new Paragraph("Admin Report", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            document.add(new Paragraph(" ")); // Empty line
            document.add(new Paragraph("Admin Details:", normalFont));
            document.add(new Paragraph("Email: " + email, normalFont));
            document.add(new Paragraph("Role: " + role, normalFont));
            document.add(new Paragraph(" "));

            document.add(new Paragraph("Statistics:", normalFont));
            document.add(new Paragraph("Total Reservations: " + totalReservations, normalFont));
            document.add(new Paragraph("Total Users: " + totalUsers, normalFont));
            document.add(new Paragraph("Total Feedbacks: " + totalFeedbacks, normalFont));
            
            document.close();
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
