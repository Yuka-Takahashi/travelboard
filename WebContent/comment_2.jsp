<%@ page contentType="text/html; charset=Shift_JIS"%>
<%@ page import = "java.util.*,ph.jpn.travelboard.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogComment" id="blogComment" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<%
String strArticleId = request.getParameter("article_id");
String strId = request.getParameter("id");
boolean blResult=true;
if(strArticleId!=null){
	blogComment.clear();
	blogComment.setArticleId(Integer.parseInt(strArticleId));
	blogComment.setUrl("http://");
	if(blogUser.isAdmin()){
		blogComment.setByAdmin(true);
	}
}else if(strId!=null){
	int intId = Integer.parseInt(strId);
	if(blogUser.isAdmin()){
		blogComment.loadByAdmin(intId);
	}else{
		String strPassword = request.getParameter("password");
		blResult = blogComment.loadWithPassword(intId,strPassword);
	}
}
%>
<HTML>
<HEAD>
<TITLE><%=BlogSettings.BlogTitle%></TITLE>
<SCRIPT TYPE="text/javascript">
function func_check(){
	<%if(!blogComment.isByAdmin()){%>
	if(document.form1.commenter.value==""){
		alert("���e�Җ����w�肵�Ă�������");
		return false;
	}
	<%}%>
	<%if(blogComment.getId()==0 && !blogUser.isAdmin()){%>
	if(document.form1.password.value==""){
		alert("�p�X���[�h���w�肵�Ă�������");
		return false;
	}else if(document.form1.password.value!=document.form1.password2.value){
		alert("�m�F�p�̃p�X���[�h���Ⴂ�܂�");
		return false;
	}
	<%}%>
}

function func_delete(){
	if(confirm("���̃R�����g���폜���܂��B��낵���ł����H")){
		location.href="comment_3.jsp?delete";
	}
}

</SCRIPT>
</HEAD>
<BODY>
<%if(blResult){%>
	�y�R�����g�z
	<FORM NAME="form1" ACTION="comment_3.jsp" METHOD="post" 
		ONSUBMIT="return func_check()">
	<TABLE>
	<%if(!blogComment.isByAdmin()){%>
		<TR><TD>����</TD><TD><INPUT TYPE="text" NAME="subject" SIZE="80" 
			VALUE="<%=blogComment.getSubject()%>"></TD></TR>
		<TR><TD>�����N����URL</TD><TD><INPUT TYPE="text" NAME="url" SIZE="80" 
			VALUE="<%=blogComment.getUrl()%>"></TD></TR>
		<TR><TD>���e��</TD><TD><INPUT TYPE="text" NAME="commenter" SIZE="80" 
			VALUE="<%=blogComment.getCommenter()%>"></TD></TR>
	<%}%>
	<TR><TD>�{��</TD><TD><TEXTAREA COLS="60" ROWS="5"
		 NAME="body"><%=blogComment.getBody()%></TEXTAREA>
		</TD></TR>
	<%if(blogComment.getId()==0 && !blogUser.isAdmin()){%>
		<TR><TD>�p�X���[�h</TD><TD><INPUT TYPE="password" NAME="password"></TD></TR>
		<TR><TD>�p�X���[�h�i�m�F�j</TD>
		<TD><INPUT TYPE="password" NAME="password2"></TD></TR>
	<%}%>
	</TABLE>
	<INPUT TYPE="submit" VALUE="���M">
	<%if(blogComment.getId()!=0){%>
		<INPUT TYPE="button" VALUE="�폜" ONCLICK="func_delete()">
	<%}%>
<%}else{%>
	�p�X���[�h���Ⴂ�܂��B<BR>
<%}%>
<INPUT TYPE="button" VALUE="�߂�" ONCLICK="history.back()">
</FORM>
</BODY>
</HTML>
