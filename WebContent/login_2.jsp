<%@ page contentType="text/html; charset=Shift_JIS"%>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<HTML>
<HEAD>
<TITLE>���O�C��</TITLE>
<LINK REL="stylesheet" HREF="style.css" TYPE="text/css">
</HEAD>
<%
String strUserName = request.getParameter("user_name");
String strPassword = request.getParameter("password");
boolean blResult = blogUser.login(strUserName,strPassword);
%>
<BODY>
<%if(blResult == true){%>
	���O�C�����܂����B<BR>
	<A HREF="index.jsp">�߂�</A>
<%}else{%>
	�p�X���[�h���Ⴂ�܂��B<BR>
	<A HREF="javascript:history.back()">�߂�</A>
<%}%>
</BODY>
</HTML>
