package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/ecotourism_db?useSSL=false&serverTimezone=Asia/Yangon";
    private static final String USER = "root";     
    private static final String PASSWORD = ""; 

    // Private constructor to prevent instantiation
    private DBConnection() {}

    // Get a NEW connection every time
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found!", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
