
import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
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

@WebServlet("/UnblockUserServlet")
public class UnblockUserServlet extends HttpServlet {

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
        String uId = request.getParameter("id");
        String action = request.getParameter("action");

        // Set response type to JSON
//        response.setContentType("application/json");
        // Validate input
        if (uId == null || uId.trim().isEmpty()) {
            out.println("{\"success\": false, \"message\": \"User ID and reason are required\"}");
            return;
        }

//        password generator
        int length = 8; // Change as needed
        String UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String LOWER = "abcdefghijklmnopqrstuvwxyz";
        String DIGITS = "0123456789";
        String SPECIAL = "@#$%!&*?";
        String ALL = UPPER + LOWER + DIGITS + SPECIAL;
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();

        // Add one character from each category
        password.append(UPPER.charAt(random.nextInt(UPPER.length())));
        password.append(LOWER.charAt(random.nextInt(LOWER.length())));
        password.append(DIGITS.charAt(random.nextInt(DIGITS.length())));
        password.append(SPECIAL.charAt(random.nextInt(SPECIAL.length())));

        // Fill the rest of the length with random characters from all
        for (int i = 4; i < length; i++) {
            password.append(ALL.charAt(random.nextInt(ALL.length())));
        }

        // Shuffle characters
        char[] chars = password.toString().toCharArray();
        for (int i = chars.length - 1; i > 0; i--) {
            int j = random.nextInt(i + 1);
            char temp = chars[i];
            chars[i] = chars[j];
            chars[j] = temp;
        }

        // Final password
        String finalPassword = new String(chars);
        Connection conn = null;
        PreparedStatement stmt = null;

        String userName = "", uemail = "";
        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish connection
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Get current timestamp
            String blockedTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

            // Prepare SQL statement
            String sql = "";
            if ("unblock".equals(action)) {
                sql = "UPDATE user_registerdetails SET action_reason=? ,blocked = 'no',blockstatus='active'  WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setNull(1, java.sql.Types.VARCHAR); // <-- this explicitly sets it to SQL NULL
                stmt.setString(2, uId);

                // Execute the update
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {

                    String query = "SELECT * FROM user_registerdetails WHERE id=?";
                    PreparedStatement ps = conn.prepareStatement(query);
                    ps.setString(1, uId);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        userName = rs.getString("full_name");
                        uemail = rs.getString("email");
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
                        InternetAddress[] address = InternetAddress.parse(uemail);
                        message.setRecipient(Message.RecipientType.TO, new InternetAddress(uemail));
                        message.setSubject("Your Account Has Been Unblocked");
                        String body = "Hello " + userName + ",\n\n"
                                + "We wanted to let you know that your account has been successfully unblocked and is now active again.\n\n"
                                + "You can log in and continue using all the services available to you.\n\n"
                                + "Login your account using this password :   " + finalPassword+"\n\n"
                                + "If you have any questions or believe there was an issue, feel free to contact our support team.\n\n"
                                + "Thank you for your patience.\n\n"
                                + "Best regards,\nAskExpert Team";

                        message.setText(body);
                        Transport.send(message);

                        // Success HTML response
                        out.println("<script type='text/javascript'>");
                        out.println("alert('User Unblocked successfully!');");
                        out.println("location='Admin_interface/user_details.jsp?message=success';");
                        out.println("</script>");
//            out.println("<a href='EmailForm.jsp'>Send another email</a>");

                    } catch (MessagingException e) {
                        throw new RuntimeException(e);
                    }
                }

                // Success response
//out.println("{\"success\": true, \"message\": \"Specialist "
// + (action.equals("block") ? "blocked" : "unblocked") + " successfully\"}");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('User  Unblocked Failed!');");
                out.println("location='Admin_interface/user_details.jsp?message=error';");
                out.println("</script>");
                // No rows updated
                out.println("{\"success\": false, \"message\": \"No specialist found with ID: " + uId + "\"}");
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
