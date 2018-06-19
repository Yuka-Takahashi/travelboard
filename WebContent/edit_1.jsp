<%@page contentType="text/html;charset=UTF-8"%>
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
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
<SCRIPT TYPE="text/javascript">
function func_check(){
	if(document.form1.subject.value==""){
		alert("件名を入力してください");
		return false;
	}
}
</SCRIPT>
</HEAD>
<BODY>
<FORM NAME="form1" ACTION="edit_2.jsp" METHOD="post" ONSUBMIT="return func_check()">
件名:<INPUT TYPE="text" NAME="subject" SIZE="80"
	VALUE="<%=blogArticle.getSubject()%>"><BR>
本文:<TEXTAREA COLS="60" ROWS="5" NAME="body"><%=blogArticle.getBody()%></TEXTAREA><BR>
ニックネーム:<INPUT TYPE="text" NAME="nick_name" SIZE="80"
	VALUE="<%=blogUser.getNickName()%>" readonly><BR>
<INPUT TYPE="submit" VALUE="送信">
<INPUT TYPE="button" VALUE="戻る" ONCLICK="history.back()">
</FORM>
</BODY>
</HTML>