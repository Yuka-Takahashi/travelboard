<%@ page contentType="text/html; charset=Shift_JIS"%>
<%@ page import="ph.jpn.travelboard.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<%
if(!blogUser.isAdmin()){
	throw new Exception("�����G���[�ł��B");
}
%>
<HTML>
<HEAD>
<TITLE>�u���O</TITLE>
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
�X�V���������܂����B<BR>
<A HREF="index.jsp?id=<%=blogArticle.getId()%>">�߂�</A><BR>
</BODY>
</HTML>
