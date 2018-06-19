<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<HTML>
<HEAD>
<TITLE>ログイン</TITLE>
<LINK REL="stylesheet" HREF="style.css" TYPE="text/css">
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
</HEAD>
<%
request.setCharacterEncoding("UTF-8");
String strUserName = request.getParameter("user_name");
String strPassword = request.getParameter("password");
String strNickName = request.getParameter("nick_name");
String strMethod = request.getParameter("methodName");

boolean blResult = false;
if (strMethod.equals("login")) {
	blResult = blogUser.login(strUserName,strPassword);
}else{
	blResult = blogUser.add(strUserName,strPassword,strNickName);
}
%>
<BODY>
<%if(blResult == true){%>
	<%=blogUser.getNickName()%>さん。ログインしました。<BR>
	<A HREF="edit_1.jsp?new=1">スレッド作成画面へ</A>
<%}else{%>
	パスワードが違います。<BR>
	<A HREF="javascript:history.back()">戻る</A>
<%}%>
</BODY>
</HTML>
