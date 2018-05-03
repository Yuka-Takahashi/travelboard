<%@ page contentType="text/html; charset=Shift_JIS"%>
<%@ page import="ph.jpn.travelboard.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<%
if(!blogUser.isAdmin()){
	throw new Exception("権限エラーです。");
}
%>
<HTML>
<HEAD>
<TITLE>ブログ</TITLE>
</HEAD>
<%
String strStatus = request.getParameter("status");
if(strStatus.equals("hide")){
	blogArticle.hide();
}else if(strStatus.equals("unhide")){
	blogArticle.unhide();
}
%>
<BODY>
更新を完了しました。<BR>
<A HREF="index.jsp?id=<%=blogArticle.getId()%>">戻る</A><BR>
</BODY>
</HTML>
