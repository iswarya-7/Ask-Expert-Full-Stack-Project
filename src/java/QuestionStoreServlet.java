
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
@WebServlet("/QuestionStoreServlet")
public class QuestionStoreServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(); // true creates a new session if none exists

        // Display success message
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        Integer specialistId = (Integer) session.getAttribute("ansSpecialistId");

        String uProfile = (String) session.getAttribute("uprofile");
        String uname = request.getParameter("uname");
        String uid = request.getParameter("uid");
         specialistId = Integer.parseInt(request.getParameter("speId"));

        String category = request.getParameter("category");
        String specialistName = request.getParameter("specialist");
        String question = request.getParameter("question");

        if (specialistId == null) {
            out.println("Error: Specialist ID not found in session.");
            return;
        }

        //        String attchement = request.getParameter("attchement");
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
//
//        }
        // Save user to database
        Connection con = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            String query = "INSERT INTO questions(user_id, user_name,userProfile, category, specialist_id,specialist_name, question) VALUES (?, ?, ?,?, ?, ?,?)";
            pst = con.prepareStatement(query);
            pst.setString(1, uid);
            pst.setString(2, uname);
            pst.setString(3, uProfile);
            pst.setString(4, category);
            pst.setInt(5, specialistId);
            pst.setString(6, specialistName);
            pst.setString(7, question);

            // If no file is uploaded, insert NULL for the attachment path
//            if (attachmentPath != null) {
//                pst.setString(8, attachmentPath);
//            } else {
//                pst.setNull(8, java.sql.Types.VARCHAR);
//            }
//            //            pst.setString(6, fileName);
            int result = pst.executeUpdate();
            System.out.println("Insert result: " + result); // Should be 1

            if (result > 0) {
                //                request.setAttribute("message", "Question submitted successfully!.");

                // 👇 Insert into notification table
//                String notifyQuery = "INSERT INTO notifications(user_id,recipient_id, message, status) VALUES (?,?, ?, ?)";
//                PreparedStatement notifyPst = con.prepareStatement(notifyQuery);
//                String shortQn = question.length() > 80 ? question.substring(0, 100) + "..." : question;
//                String message = "You have a new question from " + uname + " in category '" + category + "':" + shortQn;
//                notifyPst.setString(1, uid);
//                notifyPst.setInt(2, specialistId);
//                notifyPst.setString(3, message);
//                notifyPst.setString(4, "unread");
//                notifyPst.executeUpdate();
//                out.println("<script>alert('Question submitted successfully!');</script>");
//                send email to user ask a question
                // Fetch specialist email from DB (you must implement this)
                String specialistEmail = null;

                try (PreparedStatement pstEmail = con.prepareStatement("SELECT email FROM specialist_regdetails WHERE id = ?")) {
                    pstEmail.setInt(1, specialistId);
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
                        String emailContent = "Hello,\n\nYou have received a new question from user '" + uname + "' in category '" + category + "'.\n\nQuestion: " + question + "\n\nPlease login to your account to answer it.\n\nThank you,\nAsk Expert Team";
                        message1.setText(emailContent);

                        Transport.send(message1);
                        System.out.println("Notification email sent successfully to " + specialistEmail);
                    } catch (MessagingException e) {
                        e.printStackTrace();
                    }
                }

                response.sendRedirect(request.getContextPath() + "/user_interface/questions.jsp?success=true");

                //                request.getRequestDispatcher("user_interface/user_login.jsp").forward(request, response);
            } else {
                //                request.setAttribute("error", "Error submitting question!");
                out.println("<script>alert('Question submitted Failed!');</script>");
                response.sendRedirect(request.getContextPath() + "/user_interface/questions.jsp?error=true");
                //                System.out.println(" error: Error submitting question! ");  // Log to server
                //                request.getRequestDispatcher("user_interface/askQuestion.jsp").forward(request, response);
            }

            //            while (specialists.next()) {
            ////                String message = "New question posted: " + questionTitle;
            //
            //                notifyStmt.setInt(1, specialistId);
            //                notifyStmt.setString(2, message);
            //                notifyStmt.addBatch();
            //            }
        } catch (SQLException e) {
            e.printStackTrace(); // this prints the full stack trace
            System.out.println("Database error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/user_interface/user_home.jsp?error=catch" + e.getMessage());
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace(); // Shows error in logs
            out.println("JDBC Driver not found!");
            response.sendRedirect(request.getContextPath() + "/user_interface/user_home.jsp?error=catch1" + ex.getMessage());

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
