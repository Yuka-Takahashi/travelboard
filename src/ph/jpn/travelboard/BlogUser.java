package ph.jpn.travelboard;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BlogUser{
	private boolean blAdmin=false;
	private String nickName="";

	public boolean isAdmin(){return blAdmin;}
	public String getNickName(){return nickName;}
	public boolean login(String strUserName,String strPassword) throws Exception{
		boolean blResult=false;

		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelboard");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "SELECT nick_name FROM user WHERE login_name = '" + strUserName + "' AND password ='" + strPassword + "'";
		ResultSet rs = stmt.executeQuery(strSql);
		if(rs.next()){
			this.nickName = rs.getString("nick_name");
			blAdmin=true;
			blResult=true;
		}
		conn.close();
		return blResult;
	}

	public boolean add(String username, String password, String nickname) throws Exception{

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
			String strSql = "INSERT INTO user (login_name, password, nick_name) VALUES ("
				+ "'" + username + "',"
				+ "'" + password + "',"
				+ "'" + nickname + "')";
			stmt.executeUpdate(strSql);
			this.nickName = nickname;
			blAdmin=true;
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			conn.close();
		}
		return blAdmin;
	}
}