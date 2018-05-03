<%@page contentType="text/html;charset=utf-8"%>
<%@page import = "ph.jpn.travelboard.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<%
String strTrackbackUrl = request.getParameter("trackback_url");
String strBlogUrl = BlogSettings.BaseUrl + "/blog/m/index.jsp?id=" + blogArticle.getId();
%>
<HTML>
<HEAD><TITLE></TITLE></HEAD>
<BODY>
トラックバックpingの送信<BR>
送信先：<%=strTrackbackUrl%><BR>
<FORM ACTION="send_trackback_ping_3.jsp" METHOD="post">
<TABLE>
<TR>
	<TD>URL</TD>
	<TD><INPUT TYPE="text" NAME="url" 
	VALUE="<%=strBlogUrl%>" SIZE="60"></TD>
</TR>
<TR>
	<TD>タイトル</TD>
	<TD><INPUT TYPE="text" NAME="title" 
	VALUE="<%=blogArticle.getSubject()%>" SIZE="60"></TD>
</TR>
<TR>
	<TD>ブログ名</TD>
	<TD><INPUT TYPE="text" NAME="blog_name" 
	VALUE="<%=BlogSettings.BlogTitle%>" SIZE="60"></TD>
</TR>
<TR>
	<TD>概要</TD>
	<TD><TEXTAREA NAME="excerpt" 
	ROWS=10 COLS="60"><%=blogArticle.getBody()%></TEXTAREA></TD>
</TR>
</TABLE>
<INPUT TYPE="hidden" NAME="trackback_url" VALUE="<%=strTrackbackUrl%>">
<INPUT TYPE="button" VALUE="戻る" ONCLICK="history.back()">
<INPUT TYPE="submit" VALUE="次へ">
</FORM>
</BODY>
</HTML>
