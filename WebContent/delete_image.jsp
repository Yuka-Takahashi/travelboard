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
	�폜���܂����B<BR>
	<A HREF="upload_image_1.jsp?id=<%=blogArticle.getId()%>">�߂�</A>
<%}else if(blogArticle.getId()==0){%>
	�Z�b�V�������^�C���A�E�g���܂����B<BR>
	<A HREF="index.jsp">�߂�</A>
<%}else{%>
	�G���[�ł��B<BR>
	<A HREF="index.jsp">�߂�</A>
<%}%>
</BODY>
</HTML>
