package ph.jpn.travelboard;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BlogArticleList{
	private Connection connList;
	private Statement stmtList;
	private ResultSet rsList;
	private int intLimit=5;
	private int intPage=0;
	private int pageCount = 0;
	private BlogArticle article = new BlogArticle();
	private Date dateTime = new Date();

	public void setLimit(int intLimitArg){this.intLimit = intLimitArg;}
	public void setPage(int intPageArg){this.intPage=intPageArg;}
	public BlogArticle getArticle(){return this.article;}
	public int getLastPage() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "SELECT count(*) FROM blog";
		ResultSet rs = stmt.executeQuery(strSql);
		rs.next();
		int intCount = rs.getInt(1);
		conn.close();
		return (intCount-1)/this.intLimit+1;
	}

	public void makeList() throws Exception{
		pageCount = 0;
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		this.connList = ds.getConnection();
		this.stmtList = this.connList.createStatement();
		String strSql = "SELECT * FROM blog ";
		if (intPage > 0) {
			strSql += "WHERE id < " + intPage;
		}
		strSql += " ORDER BY date_time DESC";
		this.rsList = this.stmtList.executeQuery(strSql);
	}

	public boolean next() throws Exception{
		if (pageCount >= intLimit) {
			this.connList.close();
			return false;
		}
		boolean blResult=false;
		if(this.rsList.next()){
			this.article.setId(this.rsList.getInt("id"));
			this.article.setSubject(this.rsList.getString("subject"));
			this.article.setBody(this.rsList.getString("body"));
			this.article.setPath(this.rsList.getString("path"));
			this.article.setDateTime(this.rsList.getString("date_time"));
			this.article.setNickName(this.rsList.getString("nickname"));
			blResult=true;
			pageCount += 1;
		}else{
			this.connList.close();
		}
		return blResult;
	}

	public int getTopArticleId() throws Exception{
		int intTopArticle=0;
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn2 = ds.getConnection();
		Statement stmt2 = conn2.createStatement();
		String strSql = "SELECT * FROM blog ORDER BY date_time DESC LIMIT "
			+ (this.intPage-1)*this.intLimit + ",1" ;
		ResultSet rs2 = stmt2.executeQuery(strSql);
		if(rs2.next()){
			intTopArticle = rs2.getInt("id");
		}
		conn2.close();
		return intTopArticle;
	}

	public int getPageFromId(int intIdArg) throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "SELECT date_time FROM blog WHERE id =" + intIdArg;
		ResultSet rs = stmt.executeQuery(strSql);
		long lngDateTime;
		if(rs.next()){
			lngDateTime=rs.getLong("date_time");
		}else{
			throw new Exception("エラーです/getPageFromId");
		}
		strSql = "SELECT count(*) FROM blog WHERE date_time >= "+ lngDateTime;
		rs = stmt.executeQuery(strSql);
		rs.next();
		int intCount = rs.getInt(1);
		conn.close();
		return (intCount-1)/this.intLimit+1;
	}
}