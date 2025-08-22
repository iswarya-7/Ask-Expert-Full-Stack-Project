import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/StoreSpecialistIdServlet")
public class StoreSpecialistIdServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        String specialistIdStr = request.getParameter("sid");
        if (specialistIdStr != null && !specialistIdStr.isEmpty()) {
            try {
                int specialistId = Integer.parseInt(specialistIdStr);
                session.setAttribute("ansSpecialistId", specialistId);
                System.out.println("Stored specialist ID in session: " + specialistId);
                response.getWriter().write("success");
            } catch (NumberFormatException e) {
                System.out.println("Invalid specialist ID format: " + specialistIdStr);
                response.getWriter().write("error");
            }
        } else {
            System.out.println("No specialist ID received");
            response.getWriter().write("error");
        }
    }
}