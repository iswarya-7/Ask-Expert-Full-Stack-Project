/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AnswerQuestionServlet")
public class AnswerQuestionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        
        // Display success message
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        Integer specialistId = (Integer) session.getAttribute("specialistId");
        
        // Get parameters directly from the form, not from session
        int userId = Integer.parseInt(request.getParameter("userid"));
        int questionId = Integer.parseInt(request.getParameter("questionid"));
        int spId = Integer.parseInt(request.getParameter("spid"));
        String question = request.getParameter("question");
        String answer = request.getParameter("answer");

        System.out.println("Processing answer for question ID: " + questionId);
        System.out.println("Question text: " + question);

        // Save user to database
        Connection con = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            String query = "INSERT INTO answers(question_id, specialist_id, question, answer_text) VALUES (?, ?, ?, ?)";
            pst = con.prepareStatement(query);
            pst.setInt(1, questionId);
            pst.setInt(2, spId);
            pst.setString(3, question);
            pst.setString(4, answer);

            int result = pst.executeUpdate();
            System.out.println("Insert result: " + result); // Should be 1

            // Step 3: Fetch user ID who asked the question
            PreparedStatement getUser = con.prepareStatement(
                    "SELECT user_id,specialist_name FROM questions WHERE question_id = ?"
            );
            getUser.setInt(1, questionId);

            ResultSet rs = getUser.executeQuery();

            if (rs.next()) {
                int userId1 = rs.getInt("user_id");
                String sname = rs.getString("specialist_name");

                // Step 4: Insert notification for user
//                String notify = "Your question has been answered by " + sname + "!";
//                PreparedStatement notifyUser = con.prepareStatement(
//                        "INSERT INTO notifications (user_id, type,message, status, created_at) VALUES (?, 'expertans',?, 'unread', NOW())"
//                );
//                notifyUser.setInt(1, userId1);
//                notifyUser.setString(2, notify);
//                notifyUser.executeUpdate();
            }
            if (result > 0) {
                // 2. Update question status

//                set session
                session.setAttribute("answer", answer);
                session.setAttribute("questionId", questionId);

                String updateSQL = "UPDATE questions SET status = 'Answered' WHERE question_id = ?";
                try (PreparedStatement psUpdate = con.prepareStatement(updateSQL)) {
                    psUpdate.setInt(1, questionId);
                    psUpdate.executeUpdate();
                }

//                String uEmail = null;
//                String sname1 = null;
//                try (PreparedStatement pstEmail = con.prepareStatement(
//                        "SELECT q.user_id, q.qnaskspecialist_id, q.specialist_name, u.email AS user_email, s.email AS specialist_email "
//                        + "FROM questions q "
//                        + "LEFT JOIN user_registerdetails u ON q.user_id = u.id "
//                        + "LEFT JOIN specialist_regdetails s ON q.qnaskspecialist_id = s.id "
//                        + "WHERE q.question_id = ?"
//                )) {
//                    pstEmail.setInt(1, questionId);
//                    ResultSet rsEmail = pstEmail.executeQuery();
//                    if (rsEmail.next()) {
////                        uEmail = rsEmail.getString("email");
////                        int userId1 = rsEmail.getInt("user_id");
////                        sname1 = rsEmail.getString("specialist_name");
//                        int userId1 = rsEmail.getInt("user_id");
//                        int spAskId = rsEmail.getInt("askspecialist");
//                        sname1 = rsEmail.getString("specialist_name");
//
//                        if (userId1 > 0) {
//                            uEmail = rsEmail.getString("user_email"); // Normal user
//                        } else if (spAskId > 0) {
//                            uEmail = rsEmail.getString("specialist_email"); // Specialist user
//                        }
//                    }
//                } catch (SQLException e) {
//                    e.printStackTrace();
//                }
// Replace the problematic email retrieval section with this corrected code:
                String uEmail = null;
                String sname1 = null;
                try (PreparedStatement pstEmail = con.prepareStatement(
                        "SELECT q.user_id, q.qnaskspecialist_id, q.specialist_name, u.email AS user_email, s.email AS specialist_email "
                        + "FROM questions q "
                        + "LEFT JOIN user_registerdetails u ON q.user_id = u.id "
                        + "LEFT JOIN specialist_regdetails s ON q.qnaskspecialist_id = s.id "
                        + "WHERE q.question_id = ?"
                )) {
                    pstEmail.setInt(1, questionId);
                    ResultSet rsEmail = pstEmail.executeQuery();
                    if (rsEmail.next()) {
                        int userId1 = rsEmail.getInt("user_id");
                        int spAskId = rsEmail.getInt("qnaskspecialist_id");
                        sname1 = rsEmail.getString("specialist_name");

                        if (userId1 > 0) {
                            uEmail = rsEmail.getString("user_email"); // Normal user
                        } else if (spAskId > 0) {
                            uEmail = rsEmail.getString("specialist_email"); // Specialist user
                        }

                        System.out.println("Retrieved user_id: " + userId1 + ", qnaskspecialist_id: " + spAskId);
                        System.out.println("Retrieved email: " + uEmail);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    System.out.println("Error retrieving email: " + e.getMessage());
                }
// If specialist email found, send mail
                if (uEmail != null && !uEmail.isEmpty()) {
                    // Email credentials (use your email & password or app password)
                    final String fromEmail = "askexpert05@gmail.com";
                    final String password = "zywv zrop hglu wuer";

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
                        message1.setRecipients(Message.RecipientType.TO, InternetAddress.parse(uEmail));
                        message1.setSubject("Your Question on Ask Expert Has Been Answered!");
                        String emailContent = "Hello,\n\nYour question has been answered by " + sname1 + ".\n\nQuestion:\n" + question + "\n\nAnswer:\n" + answer + "\n\nThanks for using Ask Expert!";
                        message1.setText(emailContent);
                        System.out.println("Fetched user email for notification: " + uEmail);

                        Transport.send(message1);
                        System.out.println("Notification email sent successfully to " + uEmail);
                    } catch (MessagingException e) {
                        e.printStackTrace();
                    }
                }

                // ✅ Redirect only once
                response.sendRedirect(request.getContextPath() + "/specialist_interface/pendingQuestions.jsp?success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/specialist_interface/pendingQuestions.jsp?error=error");
            }

        } catch (SQLException e) {
            response.sendRedirect(request.getContextPath() + "/specialist_interface/pendingQuestions.jsp" + e.getMessage());

            request.setAttribute("error", "Database error: " + e.getMessage());
            System.out.println("Database error: " + e.getMessage());  // Log to server

//            request.getRequestDispatcher("specialist_interface/specialist_home.jsp").forward(request, response);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace(); // Shows error in logs
            out.println("JDBC Driver not found!");
            response.sendRedirect(request.getContextPath() + "/specialist_interface/pendingQuestions.jsp" + ex.getMessage());

//            response.sendRedirect(request.getContextPath() + "/specialist_interface/pendingQuestion.jsp?error=" + ex.getMessage());
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
