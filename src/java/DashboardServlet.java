
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Class.forName;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/Admin_interface/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        // Initialize variables to store counts
        int totalQuestions = 0;
        int answeredQuestions = 0;
        int totalUsers = 0;
        int totalSpecialists = 0;

        Connection con = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

            // Get total questions count
            String totalQuestionsQuery = "SELECT COUNT(*) FROM questions";
            try (PreparedStatement pstmt = con.prepareStatement(totalQuestionsQuery)) {
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    totalQuestions = rs.getInt(1);
                }
            }

            // Get total answers count
            String answeredQuestionsQuery = "SELECT COUNT(*) FROM questions WHERE status='Answered' ";
            try (PreparedStatement pstmt = con.prepareStatement(answeredQuestionsQuery)) {
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    answeredQuestions = rs.getInt(1);
                }
            }

            // Get total answers count
            String totalUsersQuery = "SELECT COUNT(*)  FROM  user_registerdetails";
            try (PreparedStatement pstmt = con.prepareStatement(totalUsersQuery)) {
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    totalUsers = rs.getInt(1);
                }
            }

            // Get total answers count
            String totalSpecialistQuery = "SELECT COUNT(*) FROM specialist_regdetails";
            try (PreparedStatement pstmt = con.prepareStatement(totalSpecialistQuery)) {
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    totalSpecialists = rs.getInt(1);
                }
            }

            // Set attributes to pass to JSP
            request.setAttribute("totalQuestions", totalQuestions);
            request.setAttribute("answeredQuestions", answeredQuestions);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalSpecialists", totalSpecialists);

        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            // Close resources to avoid memory leaks
            try {
                if (rs != null) {
                    rs.close();
                }
              
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Forward to the dashboard page - it pass the value to the dashboard.jsp page without using any action 
        request.getRequestDispatcher("/Admin_interface/dashboard.jsp").forward(request, response);
    }
}
