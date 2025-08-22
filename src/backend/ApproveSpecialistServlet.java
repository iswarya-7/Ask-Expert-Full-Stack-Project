
import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.websocket.Session;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Admin_interface/ApproveSpecialistServlet")
public class ApproveSpecialistServlet extends HttpServlet {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SENDER_EMAIL = "askexpert05@gmail.com";
    private static final String SENDER_PASSWORD = "qfkw blbr eaqv pdav"; // App password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

        String semail = request.getParameter("email");
        String sname = request.getParameter("sname");
        System.out.print(sname);

        request.getParameterMap().forEach((k, v) -> System.out.println(k + ": " + java.util.Arrays.toString(v)));

//        String email = request.getParameter("email");
        if (semail == null || semail.trim().isEmpty()) {
            throw new ServletException("Email address is missing or empty");
        }
        if (sname == null || sname.trim().isEmpty()) {
            throw new ServletException("Your name is missing or empty");
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

        // Email credentials
        Properties props = new Properties();
//        props.put("mail.smtp.auth", "true");
//        props.put("mail.smtp.starttls.enable", "true");
//        props.put("mail.smtp.host", SMTP_HOST);
//        props.put("mail.smtp.port", SMTP_PORT);
//        props.put("mail.smtp.ssl.trust", SMTP_HOST);
//        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com"); // <- Add this

        javax.mail.Session session = javax.mail.Session.getInstance(props, new javax.mail.Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            System.setProperty("java.net.preferIPv4Stack", "true");
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL));
//            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            InternetAddress[] address = InternetAddress.parse(semail);
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(semail));
            message.setSubject("Account Approved  – Login Details Provided");
            message.setText("Dear " + sname + ",\n\nGreat news! Your application has been approved, and you can now access your specialist account.\nYour login Password : " + finalPassword + "\n\nPlease log in and change your password for security. If you have any questions, feel free to reach out.\n\nBest Regards,\nAskExpert Team");

            Transport.send(message);

            // Success HTML response
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Specialist approved successfully')</script>");
//            out.println("<a href='EmailForm.jsp'>Send another email</a>");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

//        updated when admin approved
        if (semail != null && !semail.isEmpty()) {
            try (Connection conn = DBConnection.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE specialist_regdetails SET status = 'Approved',password=? WHERE email = ?")) {
                pstmt.setString(1, finalPassword);
                pstmt.setString(2, semail);
                int rowsUpdated = pstmt.executeUpdate();

                if (rowsUpdated > 0) {
                    // Success message
                    request.setAttribute("message", "Specialist approved successfully");
                    out.println("<script>alert('Specialist approved successfully');</script>");
                } else {
                    // Error message
                    request.setAttribute("error", "Failed to approve specialist");
                }

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error: " + e.getMessage());
            }
        } else {
            request.setAttribute("error", "Invalid email parameter");
        }

        // Redirect back to the specialist list
        response.sendRedirect(request.getContextPath() + "/Admin_interface/specialist_requests.jsp");
    }
}
