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
		alert("投稿者名を指定してください");
		return false;
	}
	<%}%>
	<%if(blogComment.getId()==0 && !blogUser.isAdmin()){%>
	if(document.form1.password.value==""){
		alert("パスワードを指定してください");
		return false;
	}else if(document.form1.password.value!=document.form1.password2.value){
		alert("確認用のパスワードが違います");
		return false;
	}
	<%}%>
}

function func_delete(){
	if(confirm("このコメントを削除します。よろしいですか？")){
		location.href="comment_3.jsp?delete";
	}
}

</SCRIPT>
</HEAD>
<BODY>
<%if(blResult){%>
	【コメント】
	<FORM NAME="form1" ACTION="comment_3.jsp" METHOD="post" 
		ONSUBMIT="return func_check()">
	<TABLE>
	<%if(!blogComment.isByAdmin()){%>
		<TR><TD>件名</TD><TD><INPUT TYPE="text" NAME="subject" SIZE="80" 
			VALUE="<%=blogComment.getSubject()%>"></TD></TR>
		<TR><TD>リンクするURL</TD><TD><INPUT TYPE="text" NAME="url" SIZE="80" 
			VALUE="<%=blogComment.getUrl()%>"></TD></TR>
		<TR><TD>投稿者</TD><TD><INPUT TYPE="text" NAME="commenter" SIZE="80" 
			VALUE="<%=blogComment.getCommenter()%>"></TD></TR>
	<%}%>
	<TR><TD>本文</TD><TD><TEXTAREA COLS="60" ROWS="5"
		 NAME="body"><%=blogComment.getBody()%></TEXTAREA>
		</TD></TR>
	<%if(blogComment.getId()==0 && !blogUser.isAdmin()){%>
		<TR><TD>パスワード</TD><TD><INPUT TYPE="password" NAME="password"></TD></TR>
		<TR><TD>パスワード（確認）</TD>
		<TD><INPUT TYPE="password" NAME="password2"></TD></TR>
	<%}%>
	</TABLE>
	<INPUT TYPE="submit" VALUE="送信">
	<%if(blogComment.getId()!=0){%>
		<INPUT TYPE="button" VALUE="削除" ONCLICK="func_delete()">
	<%}%>
<%}else{%>
	パスワードが違います。<BR>
<%}%>
<INPUT TYPE="button" VALUE="戻る" ONCLICK="history.back()">
</FORM>
</BODY>
</HTML>
