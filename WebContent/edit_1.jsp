<%@ page contentType="text/html; charset=Shift_JIS"%>
<%@ page import = "java.util.*,ph.jpn.travelboard.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<%
if(!blogUser.isAdmin()){
	%><jsp:forward page="login_1.jsp"/><%
}
String strNew = request.getParameter("new");
if(strNew!=null){
	blogArticle.clear();
}
%>
<HTML>
<HEAD>
<TITLE><%=BlogSettings.BlogTitle%></TITLE>
<SCRIPT TYPE="text/javascript">
function func_check(){
	if(document.form1.subject.value==""){
		alert("Œ–¼‚ğ“ü—Í‚µ‚Ä‚­‚¾‚³‚¢");
		return false;
	}
}
</SCRIPT>
</HEAD>
<BODY>
<%=BlogSettings.BlogTitle%><BR>
<FORM NAME="form1" ACTION="edit_2.jsp" METHOD="post" ONSUBMIT="return func_check()">
<%
Calendar cal = Calendar.getInstance();
cal.setTime(blogArticle.getDateTime());
%>
<INPUT TYPE="text" NAME="year" SIZE="4" VALUE="<%=cal.get(Calendar.YEAR)%>">”N
<INPUT TYPE="text" NAME="month" SIZE="2" VALUE="<%=cal.get(Calendar.MONTH)+1%>">Œ
<INPUT TYPE="text" NAME="date" SIZE="2" VALUE="<%=cal.get(Calendar.DATE)%>">“ú
<INPUT TYPE="text" NAME="hour" SIZE="2" VALUE="<%=cal.get(Calendar.HOUR_OF_DAY)%>">
<INPUT TYPE="text" NAME="minute" SIZE="2" VALUE="<%=cal.get(Calendar.MINUTE)%>">•ª<BR>
Œ–¼:<INPUT TYPE="text" NAME="subject" SIZE="80" 
	VALUE="<%=blogArticle.getSubject()%>"><BR>
–{•¶:<TEXTAREA COLS="60" ROWS="5" NAME="body"><%=blogArticle.getBody()%></TEXTAREA><BR>
<INPUT TYPE="submit" VALUE="‘—M">
<INPUT TYPE="button" VALUE="–ß‚é" ONCLICK="history.back()">
</FORM>
<%
ArrayList alImage = blogArticle.getImageList();
for(int i=0;i<alImage.size();i++){%>
	<IMG SRC="/travelboard/ImageConv/<%=blogArticle.getId()+"_"+alImage.get(i)%>"
	STYLE="float:left;"><BR>
	&lt;IMG SRC="<%=alImage.get(i)%>"&gt;<BR>
	&lt;IMGL SRC="<%=alImage.get(i)%>"&gt;<BR>
	&lt;IMGC SRC="<%=alImage.get(i)%>"&gt;<BR>
	&lt;IMGR SRC="<%=alImage.get(i)%>"&gt;<BR>
<HR STYLE="clear:both;">
<%}%>
</BODY>
</HTML>
