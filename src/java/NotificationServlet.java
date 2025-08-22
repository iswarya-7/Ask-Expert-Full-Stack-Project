import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
//import com.google.gson.Gson;

@WebServlet("/markNotificationsRead")
public class NotificationServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        int userId = Integer.parseInt(request.getParameter("userId"));
        boolean success = false;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            
            // Update all unread notifications to read
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE notifications SET is_read = 1 WHERE user_id = ? AND is_read = 0"
            );
            ps.setInt(1, userId);
            int rowsUpdated = ps.executeUpdate();
            
            success = rowsUpdated > 0;
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Return JSON response
        Map<String, Object> jsonResponse = new HashMap<>();
        jsonResponse.put("success", success);
        
//        Gson gson = new Gson();
//        out.print(gson.toJson(jsonResponse));
        out.flush();
    }
}
