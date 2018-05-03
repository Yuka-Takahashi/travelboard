package ph.jpn.travelboard;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BlogComment{
	private int intId=0;
	private int intArticleId=0;
	private String strSubject="";
	private String strUrl="";
	private String strCommenter="";
	private boolean blByAdmin=false;
	private String strBody="";
	private Date dateTime = new Date();

	public int getId(){return this.intId;}
	public int getArticleId(){return this.intArticleId;}
	public Date getDateTime(){return this.dateTime;}
	public String getSubject(){return this.strSubject;}
	public String getUrl(){return this.strUrl;}
	public String getCommenter(){return this.strCommenter;}
	public boolean isByAdmin(){return this.blByAdmin;}
	public String getBody(){return this.strBody;}

	public void setId(int intIdArg){
		this.intId = intIdArg;
	}
	public void setArticleId(int intArticleIdArg){
		this.intArticleId = intArticleIdArg;
	}
	public void setDateTime(Date dateTimeArg){
		this.dateTime = dateTimeArg;
	}
	public void setSubject(String strSubjectArg){
		this.strSubject = strSubjectArg;
	}
	public void setUrl(String strUrlArg){
		this.strUrl = strUrlArg;
	}
	public void setCommenter(String strCommenterArg){
		this.strCommenter = strCommenterArg;
	}
	public void setByAdmin(boolean blByAdminArg){
		this.blByAdmin = blByAdminArg;}
	public void setBody(String strBodyArg){
		this.strBody = strBodyArg;
	}

	public boolean loadWithPassword(int intIdArg,String strPassword) throws Exception{
		boolean blResult;
		String strSql = "SELECT * FROM comment WHERE id=" + intIdArg
				+ " AND password=password('" +strPassword + "')";
		blResult=loadBase(strSql);
		return blResult;
	}

	public boolean loadByAdmin(int intIdArg) throws Exception{
		boolean blResult;
		String strSql = "SELECT * FROM comment WHERE id=" + intIdArg;
		blResult=loadBase(strSql);
		return blResult;
	}

	private boolean loadBase(String strSql) throws Exception{
		boolean blResult=false;
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(strSql);
		if(rs.next()){
			this.intId = rs.getInt("id");
			this.intArticleId = rs.getInt("article_id");
			this.dateTime.setTime(rs.getLong("date_time"));
			this.strSubject=rs.getString("subject");
			this.strUrl = rs.getString("url");
			this.strCommenter = rs.getString("commenter");
			if(rs.getInt("by_admin")==0){
				this.blByAdmin = false;
			}else{
				this.blByAdmin = true;
			}
			this.strBody=rs.getString("body");
			blResult=true;
		}
		conn.close();
		return blResult;
	}

	public void addWithPassword(String strPassword)
			throws Exception,Exception{
		if(this.intArticleId==0){
			throw new Exception();
		}
		Date date = new Date();
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "INSERT INTO comment ("
			+"article_id,date_time,subject,url,commenter,by_admin,body,password"
			+") VALUES ("
			+ this.intArticleId + ","
			+ date.getTime() + ","
			+ "'" + this.strSubject + "',"
			+ "'" + this.strUrl + "',"
			+ "'" + this.strCommenter + "',0,"
			+ "'" + this.strBody + "'"
			+ ",password('" + strPassword + "')"
			+ ")";
		try{
			stmt.executeUpdate(strSql);
		}catch(SQLException se){
			throw new Exception(se.getMessage()+"\n"+strSql);
		}
		conn.close();
	}

	public void addByAdmin() throws Exception,Exception{
		if(this.intArticleId==0){
			throw new Exception();
		}
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "INSERT INTO comment ("
			+"article_id,date_time,subject,url,commenter,by_admin,body"
			+") VALUES ("
			+ this.intArticleId + ","
			+ this.dateTime.getTime() + ","
			+ "'', '', '', 1,"
			+ "'" + this.strBody + "')";
		try{
			stmt.executeUpdate(strSql);
		}catch(SQLException se){
			throw new Exception(se.getMessage()+"\n"+strSql);
		}
		conn.close();
	}

	public void update() throws Exception,Exception{
		if(this.intId==0){
			throw new Exception();
		}
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "UPDATE comment SET date_time ="
			+ this.dateTime.getTime() + ","
			+ "subject = '" + this.strSubject + "',"
			+ "url = '" + this.strUrl + "',"
			+ "commenter = '" + this.strCommenter + "',"
			+ "body='" + this.strBody + "'"
			+ "WHERE id = " + this.intId;
		stmt.executeUpdate(strSql);
		conn.close();
	}

	public void delete() throws Exception,Exception{
		if(this.intId==0){
			throw new Exception();
		}
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "DELETE FROM comment WHERE id = " + this.intId;
		stmt.executeUpdate(strSql);
		conn.close();
		this.clear();
	}

	public void clear(){
		this.intId=0;
		this.intArticleId=0;
		this.strSubject="";
		this.strUrl="";
		this.strCommenter="";
		this.strBody="";
		this.dateTime = new Date();
	}
}
