<%@ page contentType="text/html; charset=Shift_JIS"%>
<%@ page import="ph.jpn.travelboard.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogComment" id="blogComment" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<HTML>
<HEAD>
<TITLE>�u���O</TITLE>
</HEAD>
<%
String strMessage="";
request.setCharacterEncoding("Windows-31J");
String strDelete = request.getParameter("delete");
try{
	if(strDelete!=null){
		blogComment.delete();
		strMessage="�폜���܂���";
	}else{
		blogComment.setSubject(request.getParameter("subject"));
		blogComment.setUrl(request.getParameter("url"));
		blogComment.setCommenter(request.getParameter("commenter"));
		blogComment.setBody(request.getParameter("body"));
		if(blogComment.getId()==0){
			if(blogUser.isAdmin()){
				blogComment.addByAdmin();
			}else{
				blogComment.addWithPassword(request.getParameter("password"));
			}
		}else{
			blogComment.update();
		}
		strMessage="�������݂��������܂���";
	}
}catch(Exception e){
	%><jsp:forward page="/error/session_timeout.jsp"/><%
}
%>
<BODY>
<%=strMessage%><BR>
<A HREF="index.jsp?id=<%=blogArticle.getId()%>">�߂�</A><BR>
</BODY>
</HTML>
