
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
@WebServlet("/RegisterDetails")
public class RegisterDetails extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Display success message
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String fname = request.getParameter("full_name");
        String gen = request.getParameter("gender");
        String db = request.getParameter("dob");
        String mail = request.getParameter("email");
        String phone = request.getParameter("phone_no");
        String password = request.getParameter("pass");
        String cPassword = request.getParameter("cpass");

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

            String query = "INSERT INTO user_registerdetails(full_name, gender, dob, email, mobile,profile_photo,password,cpassword) VALUES (?, ?, ?, ?, ?, ?, ?,?)";
            pst = con.prepareStatement(query);
            pst.setString(1, fname);
            pst.setString(2, gen);
            pst.setString(3, formattedDob);
            pst.setString(4, mail);
            pst.setString(5, phone);
            pst.setString(6, fileName);
            pst.setString(7, password);
            pst.setString(8, cPassword);

            int result = pst.executeUpdate();
            System.out.println("Insert result: " + result); // Should be 1

            if (result > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('User Registration successfully!!! Please login.');");
                out.println("location='user_interface/user_login.jsp?message=success';");
                out.println("</script>");

//                request.getRequestDispatcher("user_interface/user_login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("user_interface/user_register.jsp?message=error").forward(request, response);
            }

        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("user_interface/user_login.jsp").forward(request, response);
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

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");

        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "";
    }
}
