package ph.jpn.travelboard;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;


public class ReceiveTrackbackPing extends HttpServlet{

	boolean blDebug=true;

	public void doGet(HttpServletRequest request,		//【1】
						HttpServletResponse response)
						throws ServletException, IOException{
		StringBuffer sbResponse = new StringBuffer();
		sbResponse.append("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>")
			.append("<response>")
			.append("<error>1</error>")
			.append("<message>This target accepts post method only.</message>")
			.append("</response>");
		PrintWriter writer = response.getWriter();
		response.setContentType("text/xml");
		writer.println(sbResponse.toString());
	}

	public void doPost(HttpServletRequest request,
						HttpServletResponse response)
						throws ServletException, IOException{
		PrintWriter writer = response.getWriter();

		String strUri=request.getRequestURI();
		int intLength = strUri.length();
		int p = strUri.lastIndexOf('/',intLength);
		String strRefId = strUri.substring(p+1);		//【2】
		request.setCharacterEncoding("utf-8");
		StringBuffer sbLog = new StringBuffer();

		if(this.blDebug){							//【3】
			sbLog.append("\r\n\r\nReceive TrackBackPing:-----\r\n");
			sbLog.append("URI:"+strUri+"\r\n");
			sbLog.append("headers:-----\r\n");
			java.util.Enumeration en_1 = request.getHeaderNames();
			while(en_1.hasMoreElements()){
				String strName = en_1.nextElement().toString();
				sbLog.append(strName+"\r\n");
				java.util.Enumeration en_2 = request.getHeaders(strName);
				while(en_2.hasMoreElements()){
					String strValue = en_2.nextElement().toString();
					sbLog.append("->" + ":" + strValue+"\r\n");
				}
			}
			sbLog.append("parameters---------------\r\n");
			en_1 = request.getParameterNames();
			while(en_1.hasMoreElements()){
				String strName = en_1.nextElement().toString();	//要確認
				sbLog.append(strName+"\r\n");
				String[] strParamValue = request.getParameterValues(strName);
				for(int k=0;k < strParamValue.length; k++){
					sbLog.append("->:" + strParamValue[k]+"\r\n");
				}
			}
		}
		String strUrl=request.getParameter("url");		//【4】
		String strTitle=request.getParameter("title");
		String strBlogName=request.getParameter("blog_name");
		String strExcerpt=request.getParameter("excerpt");

		StringBuffer sbResponse = new StringBuffer();
		String strSql="INSERT INTO comment"
			+" (article_id,subject,url,commenter,body) VALUES ("
			+ strRefId + ","
			+ "'" + strTitle + "',"
			+ "'" + strUrl + "',"
			+ "'" + strBlogName + "',"
			+ "'" + strExcerpt+"')";
		try{
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
			Connection conn = ds.getConnection();
			Statement stmt = conn.createStatement();
			stmt.executeUpdate(strSql);			//【5】
			sbResponse.append("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>")
				.append("<response>")
				.append("<error>0</error>")
				.append("</response>");
			conn.close();
		}catch(Exception e){
			sbResponse.append("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>")
				.append("<response>")
				.append("<error>1</error>")
				.append("<message>Error</message>")
				.append("</response>");
			sbLog.append(e.getMessage()+"\r\n"+strSql);
		}

		//Log.write(sbLog.toString());					//【6】
		response.setContentType("text/xml");
		writer.println(sbResponse.toString());			//【7】

	}
}
