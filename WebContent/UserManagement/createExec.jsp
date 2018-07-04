<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<HTML>
<HEAD>
<TITLE>ユーザー作成完了</TITLE>
<LINK REL="stylesheet" HREF="style.css" TYPE="text/css">
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="/travelboard/assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="/travelboard/assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="/travelboard/assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="/travelboard/assets/css/ie8.css" /><![endif]-->
</HEAD>
<%
request.setCharacterEncoding("UTF-8");
String strUserName = request.getParameter("user_name");
String strPassword = request.getParameter("password");
String strNickName = request.getParameter("nick_name");

boolean blResult = false;
blResult = blogUser.add(strUserName,strPassword,strNickName);
%>
<BODY>
<%if(blResult == true){%>
	<%=blogUser.getNickName()%>さん。ようこそ<BR>
	<A HREF="/travelboard/index.jsp">TOPページに戻る</A>
<%}else{%>
	ユーザー作成に失敗しました。<BR>
	<A HREF="javascript:history.back()">戻る</A>
<%}%>
</BODY>
</HTML>
