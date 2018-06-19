package ph.jpn.travelboard;
import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BlogArticle{
	private int intId=-1;
	private String strSubject;
	private String strBody;
	private String dateTime;
	private	boolean blHidden = true;
	private String strPath;
	private String strNickName;
	public int getId(){return this.intId;}
	public String getDateTime(){return this.dateTime;}
	public String getSubject(){return this.strSubject;}
	public String getBody(){return this.strBody;}
	public String getNickName(){return this.strNickName;}
	public String getBodyTop100(){
		if (strBody.length() > 100) {
			 return strBody.substring(0, 100);
		}
		return this.strBody;
		}
	public boolean isHidden(){return this.blHidden;}
	public String getPath() { return this.strPath;}
	public void setId(int intIdArg){this.intId = intIdArg;}
	public void setSubject(String strSubjectArg){this.strSubject = strSubjectArg;}
	public void setBody(String strBodyArg){this.strBody = strBodyArg;}
	public void setDateTime(String dateTimeArg){this.dateTime = dateTimeArg;}
	public void setPath(String strPathArg){this.strPath = strPathArg;}
	public void setNickName(String strNickName){this.strNickName = strNickName;}
	public void load(int intIdArg) throws Exception{

		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "SELECT * FROM blog WHERE id = " + intIdArg;
		ResultSet rs = stmt.executeQuery(strSql);
		if(rs.next()){
			this.intId = rs.getInt("id");
			this.dateTime = rs.getString("date_time");
			this.strSubject=rs.getString("subject");
			this.strBody=rs.getString("body");
			this.strPath = rs.getString("path");
			this.strNickName = rs.getString("nickname");
			if(rs.getInt("hidden")==0){
				this.blHidden=false;
			}else{
				this.blHidden=true;
			}
		}
		conn.close();
	}

	public void add() throws Exception{
		if(this.intId==-1){
			throw new Exception();
		}
		Context ctx = null;
		DataSource ds = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
			conn = ds.getConnection();
			stmt = conn.createStatement();
			String strSql = "INSERT INTO blog (date_time,subject,body,nickname) VALUES (CURRENT_TIMESTAMP,"
				+ "'" + this.strSubject + "',"
				+ "'" + this.strBody + "',"
				+ "'" + this.strNickName + "')";
			stmt.executeUpdate(strSql);
			rs = stmt.executeQuery("SELECT LAST_INSERT_ID()");
			rs.next();
			this.intId=rs.getInt(1);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			conn.close();
		}
	}

	public void update() throws Exception,Exception{
		if(this.intId==-1){
			throw new Exception();
		}
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "UPDATE blog SET date_time = CURRENT_TIMESTAMP,"
			+ "subject = '" + this.strSubject + "',"
			+ "body='" + this.strBody + "'"
			+ "WHERE id = " + this.intId;
		stmt.executeUpdate(strSql);
		conn.close();
	}

	public void delete() throws Exception,Exception{
		if(this.intId==-1){
			throw new Exception();
		}
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "DELETE FROM blog WHERE id = " + this.intId;
		stmt.executeUpdate(strSql);
		conn.close();
		ArrayList alImage = this.getImageList();
		for(int i=0;i<alImage.size();i++){
			String strImgFile=this.intId + "_" + alImage.get(i);
			File file = new File(BlogSettings.AppDir+"/images/"+strImgFile);
			file.delete();
		}
		this.clear();
	}

	public void clear(){
		this.intId=0;
		this.strSubject="";
		this.strBody="";
		this.dateTime = "";
	}

	public ArrayList getImageList() throws Exception{
		File imgDir = new File(BlogSettings.AppDir+"/images");
		String[] aryStrImg = imgDir.list();
		ArrayList<String> alImage = new ArrayList<String>();
		for(int i=0;i<aryStrImg.length;i++){
			String strImgFile=aryStrImg[i];
			if(strImgFile.startsWith(this.intId+"_")){
				alImage.add(strImgFile.substring(strImgFile.indexOf('_')+1));
			}
		}
		return alImage;
	}

	public boolean deleteImage(String strImageFile){
		boolean blResult=true;
		File file = new File(BlogSettings.AppDir+"/images/"
				+ this.intId + "_"+strImageFile);
		blResult = file.delete();
		return blResult;
	}

	public void hide() throws Exception,Exception{
		if(this.intId==-1){
			throw new Exception();
		}
		this.dateTime = "";
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql="UPDATE blog SET hidden=" + 1 +" WHERE id=" + this.intId;
		try{
			stmt.executeUpdate(strSql);
		}catch (SQLException se){
			throw new Exception(se.getMessage() + "\n" + strSql);
		}
		this.blHidden=true;
		conn.close();
	}

	public void unhide() throws Exception,Exception{
		if(this.intId==-1){
			throw new Exception();
		}
		this.dateTime = "";
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql="UPDATE blog SET hidden=" + 0 +" WHERE id=" + this.intId;
		try{
			stmt.executeUpdate(strSql);
		}catch (SQLException se){
			throw new Exception(se.getMessage() + "\n" + strSql);
		}
		this.blHidden=false;
		conn.close();
	}

}