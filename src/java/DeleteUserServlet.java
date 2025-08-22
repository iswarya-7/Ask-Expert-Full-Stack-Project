
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/Admin_interface/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");

        if (email != null && !email.isEmpty()) {
            try (Connection conn = DBConnection.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE  user_registerdetails SET status='rejected' WHERE email = ?")) {

                pstmt.setString(1, email);
                int rowsDeleted = pstmt.executeUpdate();

                if (rowsDeleted > 0) {
                    // Success message
                    request.setAttribute("message", "User deleted successfully");
                    out.print("<script>alet('User deleted successfully')</script> ");
                } else {
                    // Error message
                    request.setAttribute("error", "Failed to delete User account");                  
                    out.print("<script>alet('Failed to delete User account')</script> ");                 
                }

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error: " + e.getMessage());
            }
        } else {
            request.setAttribute("error", "Invalid email parameter");
        }

        // Redirect back to the specialist list
        response.sendRedirect(request.getContextPath() + "/Admin_interface/user_details.jsp");
    }
}
