
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/UserUpdatePasswordServlet")
public class UserUpdatePasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        String newpass = request.getParameter("newpass");
        String confirmpass = request.getParameter("confirmpass");
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("resetUserId");

        if (userId == null || !newpass.equals(confirmpass)) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Invalid attempt or passwords do not match.');");
            out.println("location='user_interface/UserReset_password.jsp';");
            out.println("</script>");

//            response.getWriter().println("Invalid attempt or passwords do not match.");
            return;
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

            PreparedStatement ps = con.prepareStatement("UPDATE user_registerdetails SET password=?,cpassword=?, reset_token=NULL, token_expiry=NULL WHERE id=?");
            ps.setString(1, newpass);  // You can hash this
            ps.setString(2, confirmpass);
            ps.setInt(3, userId);
            int i = ps.executeUpdate();

            if (i > 0) {
                session.removeAttribute("resetUserId");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Password updated successfully');");
                out.println("location='user_interface/user_login.jsp';");
                out.println("</script>");
//                response.getWriter().println("Password updated successfully. <a href='user_login.jsp'>Login</a>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Failed to update password. try again');");
                out.println("location='user_interface/forgotPassword.jsp';");
                out.println("</script>");
//                response.getWriter().println("Failed to update password.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
