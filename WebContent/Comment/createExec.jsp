<%@page contentType="text/html;charset=UTF-8"%>
<%@ page import="ph.jpn.travelboard.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogComment" id="blogComment" scope="session"/>
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

String str = request.getParameter("article_id");
blogComment.setArticleId(Integer.parseInt(request.getParameter("article_id")));
blogComment.setBody(request.getParameter("body"));
blogComment.setCommenter(request.getParameter("nick_name"));
blogComment.addComment();

		sbMessage.append("書き込みを完了しました。<BR>");
		sbMessage.append("<A HREF=\"index.jsp?id="+blogComment.getArticleId()+"\">戻る</A><BR>");
%>
<BODY>
書き込みを完了しました。<BR>
<A HREF="/travelboard/index.jsp">戻る</A><BR>
</BODY>
</HTML>
