import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.*;

// Change the URL pattern to match your project structure
@WebServlet("/SpecialistListServlet")
public class SpecialistListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> specialistsList = new ArrayList<>();

        try (Connection conn = dbconnectionRE.getConnection()) {
            // Add debug statement to verify connection
            System.out.println("Database connection established: " + (conn != null));
            
            String query = "SELECT * FROM specialist_regdetails";
            try (PreparedStatement pstmt = conn.prepareStatement(query);
                 ResultSet rs = pstmt.executeQuery()) {

                System.out.println("Executing query: " + query);
                
                while (rs.next()) {
                    Map<String, String> specialist = new HashMap<>();
                    specialist.put("name", rs.getString("full_name"));
                    specialist.put("email", rs.getString("email"));
                    specialist.put("gender", rs.getString("gender"));
                    specialist.put("expertise_category", rs.getString("expertise_category"));
                    specialist.put("expertise_domain", rs.getString("expertise_domain"));
                    specialist.put("status", rs.getString("status"));

                    specialistsList.add(specialist);
                    // Debug: Print each specialist found
                    System.out.println("Found specialist: " + specialist.get("name"));
                }

                System.out.println("Total specialists found: " + specialistsList.size());
            }

            request.setAttribute("specialistsList", specialistsList);
            // Forward to the correct JSP path
            request.getRequestDispatcher("/Admin_interface/specialist_details.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL Error: " + e.getMessage());
            request.setAttribute("error", "Error retrieving specialists: " + e.getMessage());
            request.getRequestDispatcher("/Admin_interface/specialist_details.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("General Error: " + e.getMessage());
            request.setAttribute("error", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher("/Admin_interface/specialist_details.jsp").forward(request, response);
        }
    }
}
