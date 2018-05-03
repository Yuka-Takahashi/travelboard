<%@ page contentType="text/html; charset=Shift_JIS"%>
<%@ page import="java.util.*,java.io.*,java.sql.*,ph.jpn.travelboard.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<HTML>
<HEAD>
<TITLE><%=BlogSettings.BlogTitle%></TITLE>
</HEAD>
<%
String strImageFile=request.getParameter("image_file");
boolean blResult = blogArticle.deleteImage(strImageFile);
if(blResult){%>
	削除しました。<BR>
	<A HREF="upload_image_1.jsp?id=<%=blogArticle.getId()%>">戻る</A>
<%}else if(blogArticle.getId()==0){%>
	セッションがタイムアウトしました。<BR>
	<A HREF="index.jsp">戻る</A>
<%}else{%>
	エラーです。<BR>
	<A HREF="index.jsp">戻る</A>
<%}%>
</BODY>
</HTML>
