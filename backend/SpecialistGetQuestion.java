
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SpecialistGetQuestion")
public class SpecialistGetQuestion extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filter = request.getParameter("filter"); // all / pending / answered
        HttpSession session = request.getSession();

        // Get userId from parameter or session
        String userIdParam = request.getParameter("spid");
        Integer userId = null;

        if (userIdParam != null && !userIdParam.isEmpty()) {
            try {
                userId = Integer.parseInt(userIdParam);
                session.setAttribute("askspecialist", userId);
            } catch (NumberFormatException e) {
                // Invalid userId, log error
                System.out.println("Invalid userId parameter: " + userIdParam);
            }
        } else {
            // Try to get from session
            userId = (Integer) session.getAttribute("specialistId");
        }

//        // If still null, set a default for testing
//        if (userId == null) {
//            userId = 1; // Default user ID for testing
//            session.setAttribute("userId", userId);
//        }
        System.out.println("Processing questions for userId: " + userId + ", filter: " + filter);

        List<Map<String, String>> questionList = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();
            String sql;

            // Adjust SQL query based on filter
            if (filter == null || filter.equalsIgnoreCase("all")) {
                sql = "SELECT * FROM questions WHERE qnaskspecialist_id = ?";
            } else {
                sql = "SELECT * FROM questions WHERE qnaskspecialist_id = ? AND status = ?";
            }

            System.out.println("Executing SQL: " + sql);

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            if (filter != null && !filter.equals("all")) {
                ps.setString(2, filter);
            }

            ResultSet rs = ps.executeQuery();
            System.out.println("Query executed");

            while (rs.next()) {
                Map<String, String> question = new HashMap<>();

                // Get column names from database - adjust these to match your actual schema
                try {
                    question.put("id", rs.getString("question_id"));
                } catch (Exception e) {
                    try {
                        question.put("id", rs.getString("id"));
                    } catch (Exception ex) {
                    }
                }

                try {
                    question.put("category", rs.getString("category"));
                } catch (Exception e) {
                    question.put("category", "General"); // Default if column doesn't exist
                }

                try {
                    question.put("title", rs.getString("title"));
                } catch (Exception e) {
                    try {
                        question.put("title", rs.getString("question"));
                    } catch (Exception ex) {
                    }
                }

                try {
                    question.put("question", rs.getString("question"));
                } catch (Exception e) {
                    try {
                        question.put("question", rs.getString("details"));
                    } catch (Exception ex) {
                        question.put("question", ""); // Default if column doesn't exist
                    }
                }

                try {
                    question.put("status", rs.getString("status"));
                } catch (Exception e) {
                    question.put("status", "pending"); // Default if column doesn't exist
                }

                try {
                    question.put("date", rs.getDate("posted_at").toString());
                } catch (Exception e) {
                    try {
//                         SimpleDateFormat sdf = new SimpleDateFormat("MMMM dd, yyyy – hh:mm a");
//                            String formattedDate = sdf.format(ts);
                        question.put("date", rs.getDate("created_date").toString());
                    } catch (Exception ex) {
                        question.put("date", "Unknown date"); // Default if column doesn't exist
                    }
                }

                questionList.add(question);
                System.out.println("Added question: " + question.get("title"));
            }

            System.out.println("Found " + questionList.size() + " questions");

            // Store in session instead of request for redirect
            session.setAttribute("questions", questionList);
            session.setAttribute("filter", filter);

            // Use forward instead of redirect to preserve request attributes
            RequestDispatcher rd = request.getRequestDispatcher("specialist_interface/specialistAskedQuestions.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
