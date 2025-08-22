
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/MarkAllReadSpecServlet")
public class MarkAllReadSpecServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("user_id"));

        try {
            // Load MySQL driver (optional for newer versions)
            Class.forName("com.mysql.jdbc.Driver");

            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

            String sql = "UPDATE notifications SET status = 'read' WHERE recipient_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);

            int updated = stmt.executeUpdate();

            System.out.println(updated + " notifications marked as read.");

            stmt.close();
            conn.close();

            // Redirect back to the page showing notifications
            response.sendRedirect(request.getContextPath() + "/specialist_interface/specialist_home.jsp?notification=sucess");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
