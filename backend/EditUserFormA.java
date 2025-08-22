
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
@WebServlet("/EditUserFormA")
public class EditUserFormA extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "profileimages"; // Folder name

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SENDER_EMAIL = "askexpert05@gmail.com";
    private static final String SENDER_PASSWORD = "qfkw blbr eaqv pdav"; // App password

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String uName = "", uEmail = "";

        try {
            // Get form data
            String sId = request.getParameter("uid");
            String fname = request.getParameter("fullName");  // Changed from full_name to fullName to match form
            String email = request.getParameter("email");
            String phone = request.getParameter("mobile1");    // Changed from phone to mobile to match form

            String dob = request.getParameter("dob1");
            String gender = request.getParameter("gender1");
            String password = request.getParameter("password");
            String cpassword = request.getParameter("cpassword");
            String bio = request.getParameter("bio1");
            String currentProfile = request.getParameter("currentProfile");

            System.out.println("Processing update for specialist ID: " + sId);

            // Check if userId is provided
            if (sId == null || sId.isEmpty()) {
                out.println("<h3>Error: User ID is missing</h3>");
                return;
            }

            // Password validation - if password is provided, confirm password must match
            if (password != null && !password.trim().isEmpty()) {
                if (cpassword == null || cpassword.trim().isEmpty()) {
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Please enter confirm password');");
                    out.println("history.back();");
                    out.println("</script>");
                    return;
                }

                if (!password.equals(cpassword)) {
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Password and Confirm Password do not match!');");
                    out.println("history.back();");
                    out.println("</script>");
                    return;
                }
            }
            // Password validation - if password is provided, confirm password must match
//            if (password != null && !password.trim().isEmpty()) {
//                if (cpassword == null || !password.equals(cpassword)) {
//                    out.println("<script type='text/javascript'>");
//                    out.println("alert('Password and Confirm Password do not match!');");
//                    out.println("history.back();");
//                    out.println("</script>");
//                    return;
//                }
//            }

            // Database connection
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

            // First, get the current specialist data to preserve values if needed
            String getCurrentDataSql = "SELECT profile_photo, password FROM user_registerdetails WHERE id=?";
            ps = con.prepareStatement(getCurrentDataSql);
            ps.setString(1, sId);
            rs = ps.executeQuery();

            String existingProfilePhoto = "";
            String existingPassword = "";

            if (rs.next()) {
                existingProfilePhoto = rs.getString("profile_photo");
                existingPassword = rs.getString("password");
            }

            // Format date if provided
            String formattedDob = "";
            if (dob != null && !dob.isEmpty()) {
                try {
                    SimpleDateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd");
                    SimpleDateFormat toFormat = new SimpleDateFormat("dd-MM-yyyy");
                    java.util.Date date = fromFormat.parse(dob);
                    formattedDob = toFormat.format(date);
                } catch (Exception e) {
                    out.println("Error formatting date: " + e);
                }
            }

            // Check if a new profile image was uploaded
            Part filePart = request.getPart("profilePhoto"); // Changed from currentProfile to profilePhoto
            String fileName = existingProfilePhoto; // Default to existing profile photo

            if (filePart != null && filePart.getSize() > 0) {
                // Get the upload folder path
                String uploadPath = getServletContext().getRealPath("/") + File.separator + UPLOAD_DIRECTORY;

                // Create the directory if it doesn't exist
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // Generate a unique filename
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // File Name
//                fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String filePath = uploadPath + File.separator + fileName;

                // Save file to disk
                filePart.write(filePath);
                System.out.println("New profile photo uploaded: " + fileName);
            } else {
                System.out.println("No new profile photo uploaded, keeping existing: " + fileName);
            }

            // Determine which password to use
            String passwordToUse = existingPassword;
            if (password != null && !password.trim().isEmpty()) {
                passwordToUse = password;
                System.out.println("Using new password");
            } else {
                System.out.println("Keeping existing password");
            }

            // Determine which password to use and if password was changed
            passwordToUse = existingPassword;
            boolean passwordChanged = false;

            if (password != null && !password.trim().isEmpty()) {
                passwordToUse = password;
                passwordChanged = true; // Flag to indicate password was changed
                System.out.println("Using new password - account will be locked");
            } else {
                System.out.println("Keeping existing password - no change to lock status");
            }

            // Update specialist profile in database
            String sql = "UPDATE user_registerdetails SET full_name=?, gender=?, dob=?, email=?, mobile=?,  "
                    + "profile_photo=?, bio=?,  password=?,locked=?,blockstatus=? WHERE id=?";

            ps = con.prepareStatement(sql);
            ps.setString(1, fname);
            ps.setString(2, gender);
            ps.setString(3, formattedDob);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, fileName);
            ps.setString(7, bio);
            ps.setString(8, passwordToUse);

            // Set the locked status based on whether password was changed
            if (passwordChanged) {
                ps.setString(9, "yes"); // Lock the account
                ps.setString(10, "blocked"); // Lock the account

            } else {
                ps.setString(9, "no"); // Keep account unlocked               
                ps.setString(10, "active"); // Lock the account

            }

            ps.setString(11, sId);

            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                // Update session attributes if needed
                if (fileName != null) {
                    session.setAttribute("profileimage", fileName);
                }

                String query = "SELECT * FROM user_registerdetails WHERE id=?";
                PreparedStatement ps1 = con.prepareStatement(query);
                ps1.setString(1, sId);
                ResultSet rs1 = ps1.executeQuery();

                if (rs1.next()) {
                    uName = rs1.getString("full_name");
                    uEmail = rs1.getString("email");
                }

                // Email credentials
                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", SMTP_HOST);
                props.put("mail.smtp.port", SMTP_PORT);
                props.put("mail.smtp.ssl.trust", SMTP_HOST);
                props.put("mail.smtp.ssl.protocols", "TLSv1.2");

                javax.mail.Session session1 = javax.mail.Session.getInstance(props, new javax.mail.Authenticator() {
                    protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                        return new javax.mail.PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
                    }
                });

                try {
                    MimeMessage message = new MimeMessage(session1);
                    message.setFrom(new InternetAddress(SENDER_EMAIL));
//            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                    InternetAddress[] address = InternetAddress.parse(uEmail);
                    message.setRecipient(Message.RecipientType.TO, new InternetAddress(uEmail));
                    String subject = "Your Account Has Been Permanently Blocked";
                    String body = "Dear " + uName + ",\n\n"
                            + "We regret to inform you that your account on AskExpert has been permanently blocked due to violations of our terms and conditions.\n\n"
                            + "You will no longer be able to access your account or services. If you think this was a mistake, please contact support.\n\n"
                            + "Regards,\n"
                            + "AskExpert Admin Team";
                    message.setText(body);
                    Transport.send(message);

                    // Success HTML response
                    out.println("<script type='text/javascript'>");
                    out.println("alert('User profile updated successfully!');");
                    out.println("location='Admin_interface/user_details.jsp?message=success';");
                    out.println("</script>");
//            out.println("<a href='EmailForm.jsp'>Send another email</a>");

                } catch (MessagingException e) {
                    throw new RuntimeException(e);
                }

            } else {
                out.println("<h3>Error: Failed to update profile in database</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script type='text/javascript'>");
            out.println("alert('Error updating profile: " + e.getMessage() + "');");
            out.println("location='Admin_interface/user_details.jsp?message=error';");
            out.println("</script>");
        } finally {
            // Close resources
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
