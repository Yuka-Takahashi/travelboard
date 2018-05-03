package ph.jpn.travelboard;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import churchillobjects.rss4j.*;
import churchillobjects.rss4j.generator.*; 
import java.text.*;

public class CastRss extends HttpServlet {
	public void doGet(HttpServletRequest request,
			HttpServletResponse response)
			throws ServletException, IOException{
		ServletContext sc=getServletContext();
		RssDocument doc = new RssDocument();			//【1】
		doc.setVersion(RssDocument.VERSION_10);			//【2】
		RssChannel channel = new RssChannel();			//【3】
		channel.setChannelTitle(ph.jpn.travelboard.BlogSettings.BlogTitle);	//【4】
		channel.setChannelLink(ph.jpn.travelboard.BlogSettings.BaseUrl);
		channel.setChannelDescription(ph.jpn.travelboard.BlogSettings.BlogDescription);
		channel.setChannelUri(ph.jpn.travelboard.BlogSettings.BaseUrl+"/blog/rdf");
		RssDublinCore dc0 = new RssDublinCore();		//【5】
		channel.setDublinCore(dc0);
		doc.addChannel(channel); 					//【6】
		DateFormat df = 
			new SimpleDateFormat("yyyy'-'MM'-'dd'T'HH':'mm':'ss'+09:00'");
		String strSql="SELECT * FROM blog WHERE hidden = 0 ORDER BY id DESC LIMIT 15";
		try{
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
			Connection conn = ds.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(strSql);
			while(rs.next()){
				RssChannelItem item = new RssChannelItem();	//【7】
				item.setItemTitle(rs.getString("subject"));	//【8】
				item.setItemLink(ph.jpn.travelboard.BlogSettings.BaseUrl
					+"/blog/N/index.jsp?id="+rs.getInt("id"));
				String strBody = rs.getString("body");
				if(strBody.length()>100){
					strBody = strBody.substring(0,99)+"...";
				}
				item.setItemDescription(strBody);
				java.util.Date date = new java.util.Date(rs.getLong("date_time"));
				RssDublinCore dc = new RssDublinCore();		//【9】
				dc.setDate(df.format(date));
				item.setDublinCore(dc);
				channel.addItem(item); 			//【10】
			}
			conn.close();
			response.setContentType("text/xml;charset=UTF-8");
			RssGenerator.generateRss(doc,response.getWriter());	//【12】
		}catch(SQLException se){
			sc.log("CastRss:" + se.getMessage() + "\n" + strSql);
		}catch(Exception e){
			sc.log("CastRss:"+e.getMessage());
		}
	}
}
