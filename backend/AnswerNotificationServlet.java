import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/createAnswerNotification")
public class AnswerNotificationServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get parameters from the request
        int questionId = Integer.parseInt(request.getParameter("questionId"));
        int specialistId = Integer.parseInt(request.getParameter("specialistId"));
        String answerText = request.getParameter("answerText");
        
        Connection conn = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            
            // First, get the user_id who asked the question
            PreparedStatement psQuestion = conn.prepareStatement(
                "SELECT user_id, question FROM questions WHERE question_id = ?"
            );
            psQuestion.setInt(1, questionId);
            ResultSet rsQuestion = psQuestion.executeQuery();
            
            if (rsQuestion.next()) {
                int userId = rsQuestion.getInt("user_id");
                String question = rsQuestion.getString("question");
                
                // Get specialist name
                PreparedStatement psSpecialist = conn.prepareStatement(
                    "SELECT specialist_name FROM specialist_regdetails WHERE id = ?"
                );
                psSpecialist.setInt(1, specialistId);
                ResultSet rsSpecialist = psSpecialist.executeQuery();
                
                String specialistName = "An expert";
                if (rsSpecialist.next()) {
                    specialistName = rsSpecialist.getString("specialist_name");
                }
                
                // Create a notification for the user
                PreparedStatement psNotification = conn.prepareStatement(
                    "INSERT INTO notifications (user_id, type, title, message, is_read, time_ago) VALUES (?, ?, ?, ?, ?, ?)"
                );
                
                // Truncate question if it's too long
                String shortQuestion = question.length() > 50 ? question.substring(0, 47) + "..." : question;
                
                psNotification.setInt(1, userId);
                psNotification.setString(2, "answer");
                psNotification.setString(3, "New Answer");
                psNotification.setString(4, "Your question about " + shortQuestion + " has been answered by " + specialistName);
                psNotification.setBoolean(5, false); // Not read yet
                psNotification.setString(6, "Just now");
                
                psNotification.executeUpdate();
                
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script type='text/javascript'>");
                out.println("alert('Answer submitted and notification sent to user');");
                out.println("window.location='specialist_dashboard.jsp';");
                out.println("</script>");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
