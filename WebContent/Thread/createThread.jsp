<%@page contentType="text/html;charset=UTF-8"%>
<%@ page import = "java.util.*,ph.jpn.travelboard.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<%
if(!blogUser.isAdmin()){
	%><jsp:forward page="UserManagement/login_1.jsp"/><%
}
String strNew = request.getParameter("new");
if(strNew!=null){
	blogArticle.clear();
}
%>
<HTML>
<HEAD>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="/travelboard/assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="/travelboard/assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="/travelboard/assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="/travelboard/assets/css/ie8.css" /><![endif]-->
<SCRIPT TYPE="text/javascript">
function func_check(){
	if(document.form1.subject.value==""){
		alert("件名を入力してください");
		return false;
	}
	form1.action = "/travelboard/UploadServlet";
}
</SCRIPT>
</HEAD>
<BODY>
<FORM NAME="form1" ACTION="/travelbord/Thread/createExec.jsp" METHOD="post" ONSUBMIT="return func_check()" ENCTYPE="multipart/form-data">
件名:<INPUT TYPE="text" NAME="subject" SIZE="80"
	VALUE="<%=blogArticle.getSubject()%>"><BR>
本文:<TEXTAREA COLS="60" ROWS="5" NAME="body"><%=blogArticle.getBody()%></TEXTAREA><BR>
画像:<INPUT TYPE="file" name="imagefile"/><BR><BR>
ニックネーム:<INPUT TYPE="text" NAME="nick_name" SIZE="80"
	VALUE="<%=blogUser.getNickName()%>" readonly><BR>
<INPUT TYPE="submit" VALUE="送信">
<INPUT TYPE="button" VALUE="戻る" ONCLICK="history.back()">
</FORM>
</BODY>
</HTML>