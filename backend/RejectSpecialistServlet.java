
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
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@WebServlet("/Admin_interface/RejectSpecialistServlet")
public class RejectSpecialistServlet extends HttpServlet {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SENDER_EMAIL = "askexpert05@gmail.com";
    private static final String SENDER_PASSWORD = "qfkw blbr eaqv pdav"; // App password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String sname = request.getParameter("sname");
        System.out.print(sname);

        // Email credentials
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.ssl.trust", SMTP_HOST);
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        javax.mail.Session session = javax.mail.Session.getInstance(props, new javax.mail.Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL));
//            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            InternetAddress[] address = InternetAddress.parse(email);
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Application Update");
            message.setText("Hi " + sname + ",\n\nThank you for applying to join our platform. After reviewing your application, we’re sorry to inform you that we won’t be able to move forward at this time.\n\nWe appreciate your interest and encourage you to apply again in the future. If you have any questions, feel free to ask. "  + "\n\nBest wishes,\nAskExpert Team");

            Transport.send(message);

            // Success HTML response
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Specialist Rejected successfully')</script>");
//            out.println("<a href='EmailForm.jsp'>Send another email</a>");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

        if (email != null && !email.isEmpty()) {
            try (Connection conn = DBConnection.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE specialist_regdetails SET status = 'Rejected' WHERE email = ?")) {

                pstmt.setString(1, email);
                int rowsUpdated = pstmt.executeUpdate();

                if (rowsUpdated > 0) {
                    // Success message
                    request.setAttribute("message", "Specialist rejected successfully");
                } else {
                    // Error message
                    request.setAttribute("error", "Failed to reject specialist");
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
