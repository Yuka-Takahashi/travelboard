<%@page contentType="text/html;charset=UTF-8"%>
<%@ page import="ph.jpn.travelboard.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<HTML>
<HEAD>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
</HEAD>
<%
StringBuffer sbMessage = new StringBuffer();
request.setCharacterEncoding("UTF-8");
int intYear=0;
int intMonth=0;
int intDate=0;
int intHour=0;
int intMinute=0;

try{
	blogArticle.setSubject(request.getParameter("subject"));
	blogArticle.setBody(request.getParameter("body"));
	blogArticle.setNickName(request.getParameter("nick_name"));
	try{
		if(blogArticle.getId()==0){
			blogArticle.add();
		}else{
			blogArticle.update();
		}
		sbMessage.append("書き込みを完了しました。<BR>");
		sbMessage.append("<A HREF=\"index.jsp?id="+blogArticle.getId()+"\">戻る</A><BR>");
	}catch(Exception e){
		%><jsp:forward page="/error/session_timeout.jsp"/><%
	}
}catch(NumberFormatException e){
	sbMessage.append("日付が正しくありません。<BR>");
	sbMessage.append("<A HREF=\"javascript:history.back()\">戻る</A><BR>");
}
%>
<BODY>
<%=sbMessage.toString()%>
</BODY>
</HTML>
