<%@ page contentType="text/html; charset=Shift_JIS"%>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<HTML>
<HEAD>
<TITLE>ログイン</TITLE>
<LINK REL="stylesheet" HREF="style.css" TYPE="text/css">
</HEAD>
<%
String strUserName = request.getParameter("user_name");
String strPassword = request.getParameter("password");
boolean blResult = blogUser.login(strUserName,strPassword);
%>
<BODY>
<%if(blResult == true){%>
	ログインしました。<BR>
	<A HREF="index.jsp">戻る</A>
<%}else{%>
	パスワードが違います。<BR>
	<A HREF="javascript:history.back()">戻る</A>
<%}%>
</BODY>
</HTML>
