import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database utility class for establishing connections
 */
public class dbconnectionRE{
    // Update these with your actual database credentials
    private static final String URL = "jdbc:mysql://localhost:3306/askexpert";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    
    static {
        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Get a database connection
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
