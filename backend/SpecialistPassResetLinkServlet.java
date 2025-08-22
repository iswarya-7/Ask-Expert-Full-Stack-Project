
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/SpecialistPassResetLinkServlet")
public class SpecialistPassResetLinkServlet extends HttpServlet {

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html"); // ✅ Set content type
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String token = UUID.randomUUID().toString();  // generate unique token
        long expiryTime = System.currentTimeMillis() + 30 * 60 * 1000; // 30 minutes

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM specialist_regdetails WHERE email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String blocked = rs.getString("blocked");
                String locked = rs.getString("locked");

                if ("yes".equalsIgnoreCase(blocked)) {
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Your account is BLOCKED. Please contact admin.');");
                    out.println("location='specialist_interface/SpecialistForgotPassword.jsp';");
                    out.println("</script>");
                    return;
                } else if ("yes".equalsIgnoreCase(locked)) {
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Your account is LOCKED. Please contact admin.');");
                    out.println("location='specialist_interface/SpecialistForgotPassword.jsp';");
                    out.println("</script>");
                    return;
                } else {
                    // Save token and expiry
                    PreparedStatement update = con.prepareStatement("UPDATE specialist_regdetails SET reset_token=?, token_expiry=? WHERE email=?");
                    update.setString(1, token);
                    update.setTimestamp(2, new Timestamp(expiryTime));
                    update.setString(3, email);
                    update.executeUpdate();

                    // Send email
                    String link = "http://localhost:8084/FinalAskexpert/specialist_interface/SpecialistReset_Password.jsp?token=" + token;
                    sendEmail(email, link);

//                response.getWriter().println("Reset link sent to your email.");
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Reset link sent to your email');");
                    out.println("</script>");

//                out.println("location='user_interface/login.jsp';");  // or any page you want to redirect to
//                out.print("<script>alert('Reset link sent to your email');</script>");
                }
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Email not registered');");
                out.println("location='specialist_interface/SpecialistForgotPassword.jsp';");
                out.println("</script>");

//                response.getWriter().println("Email not registered.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void sendEmail(String to, String link) throws Exception {
        final String from = "askexpert05@gmail.com"; // use your email
        final String password = "qfkw blbr eaqv pdav"; // use app-specific password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(from));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        msg.setSubject("Password Reset Link");
        String htmlMessage = "<html><body>"
                + "<p>Click the link to reset your password:</p>"
                + "<a href=\"" + link + "\">Reset Password</a>"
                + "<br><br>"
                + "If the link doesn’t work, copy and paste this into your browser:<br>"
                + link
                + "</body></html>";
        msg.setContent(htmlMessage, "text/html");

//        msg.setText("Click the link to reset your password:\n" + link);
        Transport.send(msg);
    }
}
