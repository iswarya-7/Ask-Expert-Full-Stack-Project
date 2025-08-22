
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

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
@WebServlet("/SpecialistRegister_Details")
public class SpecialistRegister_Details extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Display success message
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        request.setCharacterEncoding("UTF-8");

        String fname = request.getParameter("full_name");
        String gen = request.getParameter("gender");
        String db = request.getParameter("dob");
        String mail = request.getParameter("email");
        String phone = request.getParameter("phone_no");
        String city = request.getParameter("city");
        String category = request.getParameter("category");
        String expertiseDomain = request.getParameter("sub-category");
        String experience = request.getParameter("experience");
        String workplace = request.getParameter("workplace");
        String bio = request.getParameter("bio");
        String portfolio = request.getParameter("personal_website");
        String linkedin = request.getParameter("linkedin");

//        String password = request.getParameter("pass");
//        String cPassword = request.getParameter("cpass");
        // Handle file upload
        Part filePart = request.getPart("profile_photo");
        String fileName = "";
        String uploadPath = "";

        if (filePart != null && filePart.getSize() > 0) {
            String uploadDir = getServletContext().getRealPath("/") + "profileimages";
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdir();
            }

            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // File Name
            uploadPath = uploadDir + File.separator + fileName;

            // Write file to disk
            filePart.write(uploadPath);
        }

//        to convert yyyy-mm-dd to dd-mm-yyyy format
        String formattedDob = "";

        try {
//    convert it to 'dd-mm-yyyy'
            SimpleDateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat toFormat = new SimpleDateFormat("dd-MM-yyyy");

//     change string into date obj           
            Date date = fromFormat.parse(db);
            formattedDob = toFormat.format(date);

        } catch (Exception e) {
            out.println("Error: " + e);
        }
        // Save user to database
        Connection con = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

            String query = "INSERT INTO specialist_regdetails(full_name, gender, dob,email, mobile,city,profile_photo,expertise_category,expertise_domain,years_experience,workplace,bio,portfolio,linkedin) VALUES (?, ?, ?,?, ?, ?,?,?,?,?,?,?,?,?)";
            pst = con.prepareStatement(query);
            pst.setString(1, fname);
            pst.setString(2, gen);
            pst.setString(3, formattedDob);
            pst.setString(4, mail);
            pst.setString(5, phone);
            pst.setString(6, city);
            pst.setString(7, fileName);
            pst.setString(8, category);
            pst.setString(9, expertiseDomain);
            pst.setString(10, experience);
            pst.setString(11, workplace);
            pst.setString(12, bio);
            pst.setString(13, portfolio);
            pst.setString(14, linkedin);
            int result = pst.executeUpdate();
            System.out.println("Insert result: " + result); // Should be 1

            if (result > 0) {
                // FIX: Use only one redirection method, not both
                // Use sendRedirect with a success parameter

                out.println("<script type=\"text/javascript\">");
                out.println("alert('Specialist Registration successfully!!! Please login.');");
                out.println("location='specialist_interface/specialist_login.jsp?message=success';");
                out.println("</script>");
//                out.println("<script>alert('Specialist Registration successfully!!! Please login.');</script>");

//                response.sendRedirect(request.getContextPath() + "/specialist_interface/specialist_login.jsp?message=success");
                // The following lines are removed to fix the conflict:
                // request.getRequestDispatcher("user_interface/user_login.jsp").forward(request, response);
            } else {
                // FIX: Use only one redirection method
                response.sendRedirect(request.getContextPath() + "/specialist_interface/specialist_register.jsp?success=error");
            }

        } catch (SQLException e) {
            // FIX: Use only one redirection method
            response.sendRedirect(request.getContextPath() + "/specialist_interface/specialist_register.jsp?success=error&error=" + e.getMessage());
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace(); // Shows error in logs
            out.println("JDBC Driver not found!");
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
