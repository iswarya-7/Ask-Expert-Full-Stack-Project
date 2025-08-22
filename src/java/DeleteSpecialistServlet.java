import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/Admin_interface/DeleteSpecialistServlet")
public class DeleteSpecialistServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        if (email != null && !email.isEmpty()) {
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(
                     "UPDATE  specialist_regdetails SET status='rejected' WHERE email = ?")) {
                
                pstmt.setString(1, email);
                int rowsDeleted = pstmt.executeUpdate();
                
                if (rowsDeleted > 0) {
                    // Success message
                    request.setAttribute("message", "Specialist deleted successfully");
                } else {
                    // Error message
                    request.setAttribute("error", "Failed to delete specialist");
                }
                
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error: " + e.getMessage());
            }
        } else {
            request.setAttribute("error", "Invalid email parameter");
        }
        
        // Redirect back to the specialist list
        response.sendRedirect(request.getContextPath() + "/Admin_interface/specialist_details.jsp");
    }
}
