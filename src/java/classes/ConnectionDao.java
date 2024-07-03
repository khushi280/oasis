package classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

public class ConnectionDao implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent event) {
        System.out.println("Initializing database connection...");
        Connection connection = null;
        try {
            // Load Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("Oracle JDBC driver loaded successfully.");

            // Establish connection
            connection = DriverManager.getConnection(
                "jdbc:oracle:thin:@127.0.0.1:1521:XE", "system", "khushi28");
            System.out.println("Database connection established successfully.");

            // Set holdability to CLOSE_CURSORS_AT_COMMIT (optional)
            connection.setHoldability(ResultSet.CLOSE_CURSORS_AT_COMMIT);

            // Store connection in servlet context for application-wide access
            ServletContext ctx = event.getServletContext();
            ctx.setAttribute("connection", connection);
            System.out.println("Database connection stored in servlet context.");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Consider logging this exception properly
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        System.out.println("Closing database connection...");
        ServletContext ctx = event.getServletContext();
        Connection connection = (Connection) ctx.getAttribute("connection");
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed successfully.");
            } catch (SQLException e) {
                e.printStackTrace(); // Consider logging this exception properly
            }
        }
    }
}
