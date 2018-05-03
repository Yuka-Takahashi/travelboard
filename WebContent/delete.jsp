<%@ page contentType="text/html; charset=Shift_JIS"%>
<%@ page import="ph.jpn.travelboard.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<%
if(!blogUser.isAdmin()){
	throw new Exception("エラーです。");
}
%>
<HTML>
<HEAD>
<TITLE><%=BlogSettings.BlogTitle%></TITLE>
</HEAD>
<%
blogArticle.delete();
%>
<BODY>
削除しました。<BR>
<A HREF="index.jsp">戻る</A><BR>
</BODY>
</HTML>
