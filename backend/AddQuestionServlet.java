    
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddQuestionServlet")
public class AddQuestionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");
        System.out.println("Category received: " + category);  // Log to console

        // Get the current session or create a new one if it doesn't exist
        HttpSession session = request.getSession(); // true creates a new session if none exists
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

            String query = "SELECT id, full_name FROM specialist_regdetails WHERE expertise_category=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, category);
            ResultSet rs = pst.executeQuery();

            out.println("<option value=''>-- Select Specialist --</option>");
            while (rs.next()) {
                int specialistId = rs.getInt("id");
                String specialistName = rs.getString("full_name");

                // Store the specialist ID in a session attribute with a unique name based on the specialist
                session.setAttribute("ansSpecialistId", specialistId);
                // This way we can retrieve the correct ID when the form is submitted
                System.out.println("Adding specialist: ID=" + specialistId + ", Name=" + specialistName);

                // Use the specialist's name as the value, but store the ID in a data attribute
                out.println("<option value='" + specialistName + "' data-id='" + specialistId + "'>" + specialistName + "</option>");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<option value=''>Error loading specialists</option>");
        }
    }
}
