package com.royalcuisine.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class BlogServlet extends HttpServlet {

    // JDBC details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/royal_cuisine";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "1234";

    static {
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addBlog".equals(action)) {
            // Handle Add Blog
            addBlog(request, response);
        } else if ("editBlog".equals(action)) {
            // Handle Edit Blog
            editBlog(request, response);
        } else if ("deleteBlog".equals(action)) {
            // Handle Delete Blog
            deleteBlog(request, response);
        }
    }

    // Handle Add Blog
    private void addBlog(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("blogTitle");
        String description = request.getParameter("blogDescription");
        String imageUrl = request.getParameter("blogImage");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "INSERT INTO blogs (title, description, image_url) VALUES (?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, title);
                statement.setString(2, description);
                statement.setString(3, imageUrl);

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    response.sendRedirect("admin_blogs.jsp?message=Blog%20added%20successfully");
                } else {
                    response.sendRedirect("admin_blogs.jsp?message=Error%20adding%20blog");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_blogs.jsp?message=Error: " + e.getMessage());
        }
    }

    // Handle Edit Blog
    private void editBlog(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("blogTitle");
        String description = request.getParameter("blogDescription");
        String imageUrl = request.getParameter("blogImage");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "UPDATE blogs SET title = ?, description = ?, image_url = ? WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, title);
                statement.setString(2, description);
                statement.setString(3, imageUrl);
                statement.setInt(4, id);

                int rowsUpdated = statement.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("admin_blogs.jsp?message=Blog%20updated%20successfully");
                } else {
                    response.sendRedirect("admin_blogs.jsp?message=Error%20updating%20blog");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_blogs.jsp?message=Error: " + e.getMessage());
        }
    }

    // Handle Delete Blog
    private void deleteBlog(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "DELETE FROM blogs WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, id);

                int rowsDeleted = statement.executeUpdate();
                if (rowsDeleted > 0) {
                    response.sendRedirect("admin_blogs.jsp?message=Blog%20deleted%20successfully");
                } else {
                    response.sendRedirect("admin_blogs.jsp?message=Error%20deleting%20blog");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_blogs.jsp?message=Error: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Not used for now. You could implement it if you need to display blogs dynamically.
    }
}
