package com.royalcuisine.servlets;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.ArrayList;
import java.util.List;

public class MenuServlet extends HttpServlet {

    // Meal class to store meal data
    public static class Meal {
        private String name;
        private String description;
        private double price;
        private String imageUrl;

        // Getters and setters
        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public double getPrice() {
            return price;
        }

        public void setPrice(double price) {
            this.price = price;
        }

        public String getImageUrl() {
            return imageUrl;
        }

        public void setImageUrl(String imageUrl) {
            this.imageUrl = imageUrl;
        }
    }

    // Beverage class to store beverage data
    public static class Beverage {
        private String name;
        private String description;
        private double price;
        private String imageUrl;

        // Getters and setters
        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public double getPrice() {
            return price;
        }

        public void setPrice(double price) {
            this.price = price;
        }

        public String getImageUrl() {
            return imageUrl;
        }

        public void setImageUrl(String imageUrl) {
            this.imageUrl = imageUrl;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3308/royal_cuisine";
        String jdbcUsername = "root";
        String jdbcPassword = "12345678";

        // Lists to store meals and beverages
        List<Meal> mealList = new ArrayList<>();
        List<Beverage> beverageList = new ArrayList<>();

        try {
            // Establish connection to the database
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // Fetch meals
            String mealSql = "SELECT name, description, price, image_url FROM meals";
            PreparedStatement mealStatement = connection.prepareStatement(mealSql);
            ResultSet mealResultSet = mealStatement.executeQuery();

            while (mealResultSet.next()) {
                Meal meal = new Meal();
                meal.setName(mealResultSet.getString("name"));
                meal.setDescription(mealResultSet.getString("description"));
                meal.setPrice(mealResultSet.getDouble("price"));
                meal.setImageUrl(mealResultSet.getString("image_url"));
                mealList.add(meal);
            }

            // Fetch beverages
            String beverageSql = "SELECT name, description, price, image_url FROM beverages";
            PreparedStatement beverageStatement = connection.prepareStatement(beverageSql);
            ResultSet beverageResultSet = beverageStatement.executeQuery();

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
            request.setAttribute("errorMessage", "Error fetching meals and beverages. Please try again later.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Set the meal and beverage lists as request attributes
        request.setAttribute("meals", mealList);
        request.setAttribute("beverages", beverageList);

        // Forward the request to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("menu.jsp");
        dispatcher.forward(request, response);
    }
}
