
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.*;
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
@WebServlet("/SpecialistUpdateProfile")
public class SpecialistUpdateProfile extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "profileimages"; // Folder name

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Get form data
            String sId = request.getParameter("spid");
            String fname = request.getParameter("full_name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String category = request.getParameter("category");
            String expert_domain = request.getParameter("domain");
            String experience = request.getParameter("experience");
            String workplace = request.getParameter("workplace");
            String portfolio = request.getParameter("portfolio");
            String bio = request.getParameter("bio");
            System.out.println(fname);

            // Check if userId is provided
            if (sId == null || sId.isEmpty()) {
                out.println("<h3>Error: Specialist ID is missing</h3>");
                return;
            }

            // Database connection
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

            // Check if a new profile image was uploaded
            String fileName = null;
            Part filePart = request.getPart("profilefile");

            if (filePart != null && filePart.getSize() > 0) {
                // New image uploaded
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

                String uploadPath = getServletContext().getRealPath("/") + File.separator + UPLOAD_DIRECTORY;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
            } else {
                // No new image uploaded → get old image from DB
                PreparedStatement getOldImage = con.prepareStatement("SELECT profile_photo FROM specialist_regdetails WHERE id=?");
                getOldImage.setString(1, sId);
                ResultSet rs = getOldImage.executeQuery();
                if (rs.next()) {
                    fileName = rs.getString("profile_photo");
                }
                rs.close();
                getOldImage.close();
            }

//            sqlBuilder.append(" WHERE id=?");
            String sql = "UPDATE specialist_regdetails SET full_name=?,mobile=?,  profile_photo=?,expertise_category=?,expertise_domain=?,years_experience=?,workplace=?,bio=?,portfolio=? WHERE id=?";
            ps = con.prepareStatement(sql);

//            ps = con.prepareStatement(sqlBuilder.toString());
            ps.setString(1, fname);
//            ps.setString(2, email);
            ps.setString(2, phone);
            ps.setString(3, fileName);
            ps.setString(4, category);
            ps.setString(5, expert_domain);
            ps.setString(6, experience);
            ps.setString(7, workplace);
            ps.setString(8, bio);
            ps.setString(9, portfolio);

            ps.setString(10, sId);

//            if (fileName != null) {
//                ps.setString(5, fileName);
//                ps.setString(6, userId);
//            } else {
//                ps.setString(5, userId);
//            }
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                // Update session attributes
                if (fileName != null) {
                    session.setAttribute("profileimage", fileName);
                }

                // Redirect with success message
                session.setAttribute("fullname", fname);
                session.setAttribute("phone", phone);
                session.setAttribute("bio", bio);
                session.setAttribute("category", category);
                session.setAttribute("expertDomain", expert_domain);

                session.setAttribute("years_experience", experience);
                session.setAttribute("workplace", workplace);
                session.setAttribute("bio", bio);

                out.println("<script>alert('Specialist profile upfate succesfully !!');</script>");
                response.sendRedirect(request.getContextPath() + "/specialist_interface/specialist_editProfile.jsp?success=true");

            } else {
                out.println("<h3>Error: Failed to update profile in database</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error updating profile: " + e.getMessage() + "</h3>");
            out.println("<a href='" + request.getContextPath() + "/specialist_interface/specialist_editProfile.jsp'>Go back to profile</a>");
        } finally {
            // Close resources
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                }
            }
        }
    }
}
