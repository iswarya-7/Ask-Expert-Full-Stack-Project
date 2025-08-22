
import java.io.File;
import java.util.*;
import static java.io.FileDescriptor.out;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.nio.file.Paths;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
@WebServlet("/SpecialistQuestionServlet")
public class SpecialistQuestionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Display success message
        HttpSession session = request.getSession();
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get the specialist ID from the session - this is the ID of the specialist being asked
        Integer targetSpecialistId = (Integer) session.getAttribute("ansSpecialistId");

        // Get form parameters
        String askerName = request.getParameter("sname");
        int askerId = Integer.parseInt(request.getParameter("sid"));
        String category = request.getParameter("category");
        String specialistName = request.getParameter("specialist");
        String question = request.getParameter("question");
        targetSpecialistId = Integer.parseInt(request.getParameter("speId"));

        if (targetSpecialistId == null) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Error: Specialist ID not found in session. Please select a specialist again.');");
            out.println("location='SpecialistaskQuestion.jsp';"); // Update this to the correct page
            out.println("</script>");
            return;
        }

        // Debug logs
        System.out.println("Asker ID: " + askerId);
        System.out.println("Target Specialist ID: " + targetSpecialistId);
        System.out.println("Category: " + category);
        System.out.println("Specialist Name: " + specialistName);

        // File upload handling
//        Part filePart = request.getPart("qnfile");
//        String fileName = "";
//        String attachmentPath = null;
//
//        if (filePart != null && filePart.getSize() > 0) {
//            System.out.println("File uploaded: " + filePart.getSubmittedFileName());
//
//            // Define a real upload folder in your system
//            String uploadDir = getServletContext().getRealPath("/") + "questions";
//            File uploadDirFile = new File(uploadDir);
//            if (!uploadDirFile.exists()) {
//                uploadDirFile.mkdirs(); // create folder if not exist
//            }
//
//            // Get only the file name
//            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//            String uploadPath = uploadDir + File.separator + fileName;
//
//            // Save file to disk
//            filePart.write(uploadPath);
//
//            // Save relative path for database
//            attachmentPath = fileName;
//        }

        // Save question to database
        Connection con = null;
        PreparedStatement pst = null;

        // Assuming that you have a way to check if the asker is a specialist or a user
        boolean isSpecialist = (askerId != targetSpecialistId);  // or any other condition to identify a specialist

// Create a new variable for user_id
        Integer userId = null;

// If the asker is a specialist, set user_id to null
        if (isSpecialist) {
            userId = null;
        } else {
            // If it's a user, set the userId to the value from the request (or from the session)
            userId = askerId;  // Assuming askerId is the userId in case of a user asking the question
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

            String query = "SELECT profile_photo  FROM  specialist_regdetails where id=?";
            pst = con.prepareStatement(query);
            pst.setInt(1, askerId);
            ResultSet rs = pst.executeQuery();

            String profilePhoto = null;

            if (rs.next()) {
                profilePhoto = rs.getString("profile_photo"); // Get the image file name or path
                System.out.println("Specialist profile photo: " + profilePhoto);
            }

            // Modified query to correctly map the fields
            String query1 = "INSERT INTO questions(user_name, qnaskspecialist_id,userProfile, category, specialist_id, specialist_name, question,user_id) VALUES (?, ?,?, ?, ?, ?,? ,?)";
            pst = con.prepareStatement(query1);

            // Set parameters correctly
            pst.setString(1, askerName);  // The name of the specialist asking the question
            pst.setInt(2, askerId);       // The ID of the specialist asking the question
            pst.setString(3, profilePhoto);
            pst.setString(4, category);
            pst.setInt(5, targetSpecialistId); // The ID of the specialist being asked
            pst.setString(6, specialistName);  // The name of the specialist being asked
            pst.setString(7, question);

            // If no file is uploaded, insert NULL for the attachment path
//            if (attachmentPath != null) {
//                pst.setString(8, attachmentPath);
//            } else {
//                pst.setNull(8, java.sql.Types.VARCHAR);
//            }
//              Set user_id conditionally
            if (userId != null) {
                pst.setInt(8, userId); // Set user_id for regular users
            } else {
                pst.setNull(8, java.sql.Types.INTEGER); // Set user_id to NULL for specialists
            }
            int result = pst.executeUpdate();
            System.out.println("Insert result: " + result); // Should be 1

            if (result > 0) {

//                String notifyQuery = "INSERT INTO notifications(user_id,recipient_id, message, status) VALUES (?,?, ?, ?)";
//                PreparedStatement notifyPst = con.prepareStatement(notifyQuery);
//                String shortQn = question.length() > 80 ? question.substring(0, 100) + "..." : question;
//                String message = "You have a new question from " + askerName + " in category '" + category + "':" + shortQn;
//                notifyPst.setInt(1, askerId);
//                notifyPst.setInt(2, targetSpecialistId);
//                notifyPst.setString(3, message);
//                notifyPst.setString(4, "unread");
//                notifyPst.executeUpdate();
//
//                out.println("<script>alert('Question submitted successfully!');</script>");
//                send email to user ask a question
                // Fetch specialist email from DB (you must implement this)
                String specialistEmail = null;

                try (PreparedStatement pstEmail = con.prepareStatement("SELECT email FROM specialist_regdetails WHERE id = ?")) {
                    pstEmail.setInt(1, targetSpecialistId);
                    ResultSet rsEmail = pstEmail.executeQuery();
                    if (rsEmail.next()) {
                        specialistEmail = rsEmail.getString("email");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }

// If specialist email found, send mail
                if (specialistEmail != null && !specialistEmail.isEmpty()) {
                    // Email credentials (use your email & password or app password)
                    final String fromEmail = "askexpert05@gmail.com";
                    final String password = "qfkw blbr eaqv pdav";

                    Properties props = new Properties();
                    props.put("mail.smtp.host", "smtp.gmail.com");
                    props.put("mail.smtp.port", "587");
                    props.put("mail.smtp.auth", "true");
                    props.put("mail.smtp.starttls.enable", "true");

                    Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(fromEmail, password);
                        }
                    });

                    try {
                        Message message1 = new MimeMessage(mailSession);
                        message1.setFrom(new InternetAddress(fromEmail));
                        message1.setRecipients(Message.RecipientType.TO, InternetAddress.parse(specialistEmail));
                        message1.setSubject("New Question Assigned to You");
                        String emailContent = "Hello,\n\nYou have received a new question from user '" + askerName + "' in category '" + category + "'.\n\nQuestion: " + question + "\n\nPlease login to your account to answer it.\n\nThank you,\nAsk Expert Team";
                        message1.setText(emailContent);

                        Transport.send(message1);
                        System.out.println("Notification email sent successfully to " + specialistEmail);
                    } catch (MessagingException e) {
                        e.printStackTrace();
                    }
                }

                out.println("<script type=\"text/javascript\">");
                out.println("alert('Question submitted successfully!');");
                out.println("location='specialist_interface/specialistAskedQuestions.jsp?success=true';");
                out.println("</script>");

            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error submitting question!');");
                out.println("location='specialist_interface/specialist_home.jsp';");
                out.println("</script>");
            }

        } catch (SQLException e) {
            out.println("<script type=\"text/javascript\">");
            System.out.println("Database error: " + e.getMessage());  // Log to server
            out.println("alert('Database error: " + e.getMessage().replace("'", "\\'") + "');");
            out.println("location='specialist_interface/specialist_home.jsp?success=sqlerror';");
            out.println("</script>");
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace(); // Shows error in logs

            out.println("<script type=\"text/javascript\">");
            System.out.println("JDBC Driver not found! " + ex.getMessage());  // Log to server
            out.println("alert('JDBC Driver not found!');");
            out.println("location='specialist_interface/specialist_home.jsp?error=catch';");
            out.println("</script>");
            return; // Important: Stop execution here!
        } finally {
            // Close resources
            try {
                if (pst != null) {
                    pst.close();
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
