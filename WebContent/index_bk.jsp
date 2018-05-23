<%@page contentType="text/html;charset=Shift_JIS"%>
<%@page import="ph.jpn.travelboard.*,java.util.*,java.text.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticleList" id="blogArticleList" scope="page"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<HTML>
<HEAD><TITLE><%=BlogSettings.BlogTitle%></TITLE>
<%if(request.getHeader("user-agent").matches(".*MSIE.*")){%>
	<LINK REL="stylesheet" HREF="style_ie.css" TYPE="text/css">
<%}else{%>
	<LINK REL="stylesheet" HREF="style_nn.css" TYPE="text/css">
<%}%>
</HEAD>
<BODY>
<H1><%=BlogSettings.BlogTitle%> TEXT by <%=BlogSettings.Author%></H1>
<%
DateFormat df = new SimpleDateFormat("yyyy'年'MM'月'dd'日' E'曜日'");
blogArticleList.setLimit(5);
int intId;
int intPage;
String strId = request.getParameter("id");
String strPage = request.getParameter("page");
if(strPage != null){
	intPage=Integer.parseInt(strPage);
	blogArticleList.setPage(intPage);
	intId = blogArticleList.getTopArticleId();
}else if(strId!=null){
	intId=Integer.parseInt(strId);
	intPage=blogArticleList.getPageFromId(intId);
	blogArticleList.setPage(intPage);
}else{
	intPage = 1;
	blogArticleList.setPage(intPage);
	intId = blogArticleList.getTopArticleId();
}
blogArticleList.makeList();
StringBuffer sbNavi = new StringBuffer();
if(intPage>1){
	sbNavi.append("<A HREF=\"index.jsp?page=")
		.append (intPage-1)
		.append("\">［次ページ］</A><BR>");
}
while(blogArticleList.next()){
	BlogArticle article = blogArticleList.getArticle();
	if(intId == article.getId()){
		sbNavi.append("●");
	}else{
		sbNavi.append("●");
	}
	sbNavi.append("<A HREF=\"index.jsp?id=")
		.append(article.getId())
		.append("\">")
		.append(TextConv.beforeHtml(article.getSubject()))
		.append("</A><BR>");
}
if(intPage < blogArticleList.getLastPage()){
	sbNavi.append("<A HREF=\"index.jsp?page=")
		.append(intPage+1)
		.append("\">［前ページ］</A>");
}
blogArticle.load(intId);
%>
<DIV CLASS="navi">
<%=sbNavi.toString()%>
</DIV>

<DIV CLASS="article">
<H2><%=TextConv.beforeHtml(blogArticle.getSubject())%></H2>
<%if(blogArticle.isHidden() && !blogUser.isAdmin()){%>
	準備中
<%}else{%>
	<%=TextConv.embedLink(TextConv.beforeHtml(blogArticle.getBody())
		.replaceAll("&lt;QUOTE&gt;","<DIV class=\"quote\">")
		.replaceAll("&lt;/QUOTE&gt;","</DIV>")
		.replaceAll("&lt;IMG SRC=&quot;(.*?)&quot;&gt;"
			,"<A HREF=\"/travelboard/images/"+blogArticle.getId()
			+"_$1\" target=\"_brank\">"
			+"<IMG SRC=\"/travelboard/ImageConv/"+blogArticle.getId()
			+"_$1\" STYLE=\"margin:5px;\" BORDER=\"0\">"
			+"</A>")
		.replaceAll("&lt;IMGL SRC=&quot;(.*?)&quot;&gt;"
			,"<A HREF=\"/travelboard/images/"+blogArticle.getId()
			+"_$1\" target=\"_brank\">"
			+"<IMG SRC=\"/travelboard/ImageConv/"+blogArticle.getId()
			+"_$1\" STYLE=\"float:left;clear:both;margin:5px;\" BORDER=\"0\">"
			+"</A>")
		.replaceAll("&lt;IMGR SRC=&quot;(.*?)&quot;&gt;"
			,"<A HREF=\"/travelboard/images/"+blogArticle.getId()
			+"_$1\" target=\"_brank\">"
			+"<IMG SRC=\"/travelboard/ImageConv/"+blogArticle.getId()
			+"_$1\" STYLE=\"float:right;clear:both;margin:5px;\" BORDER=\"0\">"
			+"</A>")
		.replaceAll("&lt;IMGC SRC=&quot;(.*?)&quot;&gt;"
			,"<DIV STYLE=\"text-align:center;clear:both;\">"
			+"<A HREF=\"/travelboard/images/"+blogArticle.getId()
			+"_$1\" target=\"_brank\">"
			+"<IMG SRC=\"/travelboard/ImageConv/"+blogArticle.getId()
			+"_$1\" BORDER=\"0\"></A>"
			+"</DIV>")
		.replaceAll("&lt;HR&gt;","<BR STYLE=\"clear:both;\"><HR>")
	)
	%>
	<BR STYLE="clear:both;">
	<%=df.format(blogArticle.getDateTime())%><BR>
	<A HREF="comment_2.jsp?article_id=<%=blogArticle.getId()%>">コメントを書く</A><BR>
	<%
	BlogCommentList blogCommentList = new BlogCommentList();
	blogCommentList.makeList(blogArticle.getId());
	while(blogCommentList.next()){
		BlogComment comment = blogCommentList.getComment();
		if(comment.isByAdmin()){%>
			<DIV class="comment_author">
			<%=TextConv.beforeHtml(comment.getBody())%><BR>
			from <%=BlogSettings.Author%>
			(<%=df.format(comment.getDateTime())%>)
			<A HREF="comment_1.jsp?id=<%=comment.getId()%>">編集</A>
			</DIV>
		<%}else{%>
			<DIV class="comment">
			<%
			String strUrl = comment.getUrl();
			if(!strUrl.equals("")){%><A HREF="<%=TextConv.beforeHtml(strUrl)%>"><%}%>
			<%=TextConv.beforeHtml(comment.getSubject())%>
			<%if(!strUrl.equals("")){%></A><%}%><BR>
			<%=TextConv.beforeHtml(comment.getBody())%><BR>
			 from <%=TextConv.beforeHtml(comment.getCommenter())%>
			(<%=df.format(comment.getDateTime())%>)
			<A HREF="comment_1.jsp?id=<%=comment.getId()%>">編集</A>
			</DIV>
		<%}%>
		<BR>
	<%}%>
	トラックバックURLはこちら→ <%=BlogSettings.BaseUrl%>/trackback/<%=intId%><BR>
<%}%>

<DIV CLASS="footer">
<%if(!blogUser.isAdmin()){%>
	<A HREF="login_1.jsp">［login］</A><BR>
<%}else{%>
	<A HREF="edit_1.jsp?new">［新規］</A>
	<A HREF="edit_1.jsp">［編集］</A>
	<A HREF="delete.jsp" onclick="return confirm('削除します。よろしいですか？')">［削除］</A>
	<A HREF="upload_image_1.jsp">［画像］</A>
	<%if(blogArticle.isHidden()){%>
		<A HREF="status_update.jsp?status=unhide" STYLE="background-color:#FFCCCC;">［準備中→公開中］</A>
	<%}else{%>
		<A HREF="status_update.jsp?status=hide">［公開中→準備中］</A>
	<%}%>
	<A HREF="send_trackback_ping_1.jsp">[TrackbackPingの送信]</A>
	<A HREF="logout.jsp">［logout］</A><BR>
<%}%>
</DIV>
</DIV>
</BODY>
</HTML>
