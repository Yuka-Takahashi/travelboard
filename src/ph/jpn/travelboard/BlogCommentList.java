package ph.jpn.travelboard;
import java.sql.*;
import java.text.*;
import java.util.Date;
import javax.sql.*;
import javax.naming.*;

public class BlogCommentList{
	Connection connList;
	Statement stmtList;
	ResultSet rsList;
	BlogComment comment = new BlogComment();

	public BlogComment getComment(){return this.comment;};

	public void makeList(int intArticleId) throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		this.connList = ds.getConnection();
		this.stmtList = this.connList.createStatement();
		String strSql = "SELECT * FROM comment"
			+" WHERE article_id=" + intArticleId
			+" ORDER BY id";
		try{
			this.rsList = this.stmtList.executeQuery(strSql);
		}catch(SQLException se){
			throw new Exception(se.getMessage()+"\n"+strSql);
		}
	}

	public boolean next() throws Exception{
		boolean blResult=false;
		if(this.rsList.next()){
			this.comment.setId(this.rsList.getInt("id"));
			this.comment.setDateTime(new Date(this.rsList.getLong("date_time")));
			this.comment.setSubject(this.rsList.getString("subject"));
			this.comment.setUrl(this.rsList.getString("url"));
			this.comment.setCommenter(this.rsList.getString("commenter"));
			boolean blByAdmin=false;
			if(this.rsList.getInt("by_admin")==1){
				blByAdmin=true;
			}
			this.comment.setByAdmin(blByAdmin);
			this.comment.setBody(this.rsList.getString("body"));
			blResult=true;
		}else{
			this.connList.close();
		}
		return blResult;
	}
}
