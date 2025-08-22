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

@WebServlet("/Admin_interface/DeleteQuestionServlet")
public class DeleteQuestionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        
        String questionId = request.getParameter("questionId");
        
        if (questionId != null && !questionId.isEmpty()) {
            Connection conn = null;
            try {
                int id = Integer.parseInt(questionId);
                conn = DBConnection.getConnection();
                
                // First, delete any associated answers
                try (PreparedStatement pstmtAnswers = conn.prepareStatement(
                        "DELETE FROM answers WHERE question_id = ?")) {
                    pstmtAnswers.setInt(1, id);
                    pstmtAnswers.executeUpdate();
                }
                
                // Then delete the question
                try (PreparedStatement pstmtQuestion = conn.prepareStatement(
                        "DELETE FROM questions WHERE question_id = ?")) {
                    pstmtQuestion.setInt(1, id);
                    int rowsDeleted = pstmtQuestion.executeUpdate();
                    
                    if (rowsDeleted > 0) {
                        // Success message
                        request.setAttribute("message", "Question deleted successfully");
                        response.sendRedirect(request.getContextPath() + "/Admin_interface/questions_response.jsp?status=success");
                    } else {
                        // Error message
                        request.setAttribute("error", "Failed to delete question");
                        response.sendRedirect(request.getContextPath() + "/Admin_interface/questions_response.jsp?status=fail");
                    }
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/Admin_interface/questions_response.jsp?status=invalidId");
            } catch (SQLException e) {
                e.printStackTrace();
                // Print more detailed error information
                System.out.println("SQL Error: " + e.getMessage());
                System.out.println("SQL State: " + e.getSQLState());
                System.out.println("Error Code: " + e.getErrorCode());
                
                request.setAttribute("error", "Database error: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/Admin_interface/questions_response.jsp?status=error");
            } finally {
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        } else {
            request.setAttribute("error", "Invalid question parameter");
            response.sendRedirect(request.getContextPath() + "/Admin_interface/questions_response.jsp?status=invalid");
        }
    }
}