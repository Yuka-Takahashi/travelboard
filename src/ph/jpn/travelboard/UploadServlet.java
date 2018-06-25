package ph.jpn.travelboard;
import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(location="/tmp", maxFileSize=1024000)
public class UploadServlet extends HttpServlet {
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        Part part = request.getPart("imagefile");
        String subject = request.getParameter("subject");
        String body = request.getParameter("body");
        String nickname = request.getParameter("nick_name");
        BlogArticle insertClass = new BlogArticle();
        insertClass.clear();
        insertClass.setSubject(subject);
        insertClass.setBody(body);
        insertClass.setNickName(nickname);

        String name = this.getFileName(part);
        part.write(getServletContext().getRealPath("/UploadImage") + "/" + name);
        insertClass.setPath("UploadImage/" + name);
        try {
        	insertClass.add();
        }catch(Exception e) {
        	e.printStackTrace();
        }
        response.sendRedirect("edit_2.jsp");
    }

    private String getFileName(Part part) {
        String name = null;
        Calendar rightNow = Calendar.getInstance();
        for (String dispotion : part.getHeader("Content-Disposition").split(";")) {
            if (dispotion.trim().startsWith("filename")) {
                name = dispotion.substring(dispotion.indexOf("=") + 1).replace("\"", "").trim();
                name = name.substring(name.lastIndexOf("\\") + 1);
                break;
            }
        }
        String[] tmpfilename = name.split(".");
        if (tmpfilename.length > 1) {
            return tmpfilename[0] + rightNow.getTime() + "." + tmpfilename[1];
        }else {
            return rightNow.getTime() + name;
        }
    }
}