
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BlockSpecialistServlet")
public class BlockSpecialistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SENDER_EMAIL = "askexpert05@gmail.com";
    private static final String SENDER_PASSWORD = "qfkw blbr eaqv pdav"; // App password

    // Database connection parameters - replace with your actual database details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/askexpert";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get parameters from the request
        String specialistId = request.getParameter("id");
        String action = request.getParameter("action");
        String reason = request.getParameter("reason");

        // Set response type to JSON
//        response.setContentType("application/json");
        // Validate input
        if (specialistId == null || specialistId.trim().isEmpty()
                || reason == null || reason.trim().isEmpty()) {
            out.println("{\"success\": false, \"message\": \"Specialist ID and reason are required\"}");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        String sName = "", sEmail = "";

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish connection
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Get current timestamp
            String blockedTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

            // Prepare SQL statement
            String sql = "";
            if ("block".equals(action)) {
                sql = "UPDATE specialist_regdetails SET blocked = 'yes', action_reason = ?, blocked_at = ?,blockstatus='blocked' WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, reason);
                stmt.setString(2, blockedTime);
                stmt.setString(3, specialistId);

            } else {
                sql = "UPDATE specialist_regdetails SET blocked = 'nooo',blockstatus='active' WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, specialistId);

            }

            // Execute the update
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {

                String query = "SELECT * FROM specialist_regdetails WHERE id=?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, specialistId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    sName = rs.getString("full_name");
                    sEmail = rs.getString("email");
                }

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
                    InternetAddress[] address = InternetAddress.parse(sEmail);
                    message.setRecipient(Message.RecipientType.TO, new InternetAddress(sEmail));
                    message.setSubject("Your Account Has Been Blocked");
                    String body = "Hello " + sName + ",\n\n"
                            + "Your account has been blocked for the following reason:"
                            + reason + "\n\n"
                            + "Please contact support if you believe this is a mistake.\n\n"
                            + "Best regards,\nAskExpert Team";

                    message.setText(body);
                    Transport.send(message);

                    // Success HTML response
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Specialist blocked successfully!');");
                    out.println("location='Admin_interface/specialist_details.jsp?message=success';");
                    out.println("</script>");

//            out.println("<a href='EmailForm.jsp'>Send another email</a>");
                } catch (MessagingException e) {
                    throw new RuntimeException(e);
                }

                // Success response
//                out.println("{\"success\": true, \"message\": \"Specialist "
//                        + (action.equals("block") ? "blocked" : "unblocked") + " successfully\"}");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('Specialist blocked Failed!');");
                out.println("location='Admin_interface/specialist_details.jsp?message=error';");
                out.println("</script>");
                // No rows updated
                out.println("{\"success\": false, \"message\": \"No specialist found with ID: " + specialistId + "\"}");
            }

        } catch (ClassNotFoundException e) {
            out.println("{\"success\": false, \"message\": \"Database driver not found\"}");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("{\"success\": false, \"message\": \"Database error: " + e.getMessage() + "\"}");
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
