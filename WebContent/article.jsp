<%@page contentType="text/html;charset=Windows-31J"%>
<%@page import="ph.jpn.travelboard.*,java.text.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<%
DateFormat df = new SimpleDateFormat("yyyy'年'MM'月'dd'日' E'曜日'");
String strId = request.getParameter("id");
if(strId!=null){
	blogArticle.load(Integer.parseInt(strId));
}
%>
<HTML>
<HEAD><TITLE><%=BlogSettings.BlogTitle%></TITLE>
</HEAD>
<BODY>
<%=BlogSettings.BlogTitle%><BR>
TEXT by <%=BlogSettings.Author%>
<HR>
<%=df.format(blogArticle.getDateTime())%><BR>
【<%=TextConv.beforeHtml(blogArticle.getSubject())%>】<BR>
<%=TextConv.embedLink(TextConv.beforeHtml(blogArticle.getBody()))%><BR>
<HR>
<%if(blogUser.isAdmin()){%>
	<A HREF="edit_1.jsp">［編集］</A>
	<A HREF="delete.jsp" onclick="return confirm('削除します。よろしいですか？')">［削除］</A>
<%}%>
<A HREF="index.jsp">［一覧に戻る］</A>
</BODY>
</HTML>
