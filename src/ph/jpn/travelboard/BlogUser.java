package ph.jpn.travelboard;

public class BlogUser{
	private boolean blAdmin=false;

	public boolean isAdmin(){return blAdmin;}
	public boolean login(String strUserName,String strPassword){
		boolean blResult=false;
		if(strUserName.equals(BlogSettings.AdminUserName)
			&& strPassword.equals(BlogSettings.AdminPassword)){
			this.blAdmin= true;
			blResult = true;
		}
		return blResult;
	}
}
