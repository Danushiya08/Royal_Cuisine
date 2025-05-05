package com.royalcuisine.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/royal_cuisine";
    private static final String USER = "root"; // Change this to your MySQL username
    private static final String PASSWORD = "1234"; // Change this to your MySQL password

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL Driver
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Database Connection Successful!"); // Debugging message
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Database Connection Failed: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }
}
