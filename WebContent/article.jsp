<%@page contentType="text/html;charset=Windows-31J"%>
<%@page import="ph.jpn.travelboard.*,java.text.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<%
DateFormat df = new SimpleDateFormat("yyyy'�N'MM'��'dd'��' E'�j��'");
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
�y<%=TextConv.beforeHtml(blogArticle.getSubject())%>�z<BR>
<%=TextConv.embedLink(TextConv.beforeHtml(blogArticle.getBody()))%><BR>
<HR>
<%if(blogUser.isAdmin()){%>
	<A HREF="edit_1.jsp">�m�ҏW�n</A>
	<A HREF="delete.jsp" onclick="return confirm('�폜���܂��B��낵���ł����H')">�m�폜�n</A>
<%}%>
<A HREF="index.jsp">�m�ꗗ�ɖ߂�n</A>
</BODY>
</HTML>
