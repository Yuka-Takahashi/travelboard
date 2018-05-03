<%@ page contentType="text/html; charset=Shift_JIS"%>
<%@ page import="ph.jpn.travelboard.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<HTML>
<HEAD>
<TITLE>ブログ</TITLE>
</HEAD>
<%
StringBuffer sbMessage = new StringBuffer();
request.setCharacterEncoding("Windows-31J");
int intYear=0;
int intMonth=0;
int intDate=0;
int intHour=0;
int intMinute=0;

try{
	intYear = Integer.parseInt(request.getParameter("year"));
	intMonth = Integer.parseInt(request.getParameter("month"));
	intDate = Integer.parseInt(request.getParameter("date"));
	intHour = Integer.parseInt(request.getParameter("hour"));
	intMinute = Integer.parseInt(request.getParameter("minute"));
	blogArticle.setDateTimeInt(intYear,intMonth,intDate,intHour,intMinute);
	blogArticle.setSubject(request.getParameter("subject"));
	blogArticle.setBody(request.getParameter("body"));
	try{
		if(blogArticle.getId()==0){
			blogArticle.add();
		}else{
			blogArticle.update();
		}
		sbMessage.append("書き込みを完了しました。<BR>");
		sbMessage.append("<A HREF=\"index.jsp?id="+blogArticle.getId()+"\">戻る</A><BR>");
	}catch(Exception e){
		%><jsp:forward page="/error/session_timeout.jsp"/><%
	}
}catch(NumberFormatException e){
	sbMessage.append("日付が正しくありません。<BR>");
	sbMessage.append("<A HREF=\"javascript:history.back()\">戻る</A><BR>");
}
%>
<BODY>
<%=sbMessage.toString()%>
</BODY>
</HTML>
