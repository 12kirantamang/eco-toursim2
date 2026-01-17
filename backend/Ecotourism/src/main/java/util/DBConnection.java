package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/ecotourism_db?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";     
    private static final String PASSWORD = ""; 

    // Singleton connection
    private static Connection connection = null;

    // Private constructor to prevent instantiation
    private DBConnection() {}

    // Get connection
    public static Connection getConnection() {
        if (connection == null) {
            try {
                // Load MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Database connected successfully!");
            } catch (ClassNotFoundException e) {
                System.err.println("MySQL JDBC Driver not found!");
                e.printStackTrace();
            } catch (SQLException e) {
                System.err.println("Failed to connect to database!");
                e.printStackTrace();
            }
        }
        return connection;
    }

    // Close connection
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                connection = null;
                System.out.println("Database connection closed.");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
