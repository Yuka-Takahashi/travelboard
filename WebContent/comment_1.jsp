<%@ page contentType="text/html; charset=Shift_JIS"%>
<%@ page import = "java.util.*,ph.jpn.travelboard.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<%if(blogUser.isAdmin()){%>
	<jsp:forward page="comment_2.jsp"/>
<%}%>
<HTML>
<HEAD>
<TITLE><%=BlogSettings.BlogTitle%></TITLE>
<SCRIPT TYPE="text/javascript">
function func_check(){
	if(document.form1.password.value==""){
		alert("�p�X���[�h���w�肵�Ă�������");
		return false;
	}
}
</SCRIPT>
</HEAD>
<BODY>
�p�X���[�h����͂��Ă��������B
<FORM NAME="form1" ACTION="comment_2.jsp" METHOD="post" ONSUBMIT="return func_check()">
<INPUT TYPE="password" NAME="password">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=request.getParameter("id")%>">
<INPUT TYPE="submit" VALUE="���M">
<INPUT TYPE="button" VALUE="�߂�" ONCLICK="history.back()">
</FORM>
</BODY>
</HTML>
