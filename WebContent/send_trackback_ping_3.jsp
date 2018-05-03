<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="org.apache.http.*"%>
<%@ page import="org.apache.http.message.*"%>
<%@ page import="org.apache.http.impl.client.*"%>
<%@ page import="org.apache.http.client.*"%>
<%@ page import="org.apache.http.protocol.HTTP"%>
<%@ page import="org.apache.http.client.methods.*"%>
<%@ page import="org.apache.http.client.entity.*"%>
<%@ page import="org.apache.http.client.params.HttpClientParams.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.File"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="org.w3c.dom.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id = "blogArticle" scope="session"/>
<%
StringBuffer sbHtml = new StringBuffer();
String strTrackbackUrl = request.getParameter("trackback_url");
String strExcerpt = request.getParameter("excerpt");
String strUrl = request.getParameter("url");
String strBlogName = request.getParameter("blog_name");
String strTitle = request.getParameter("title");

CloseableHttpClient httpClient = HttpClients.createDefault();

ArrayList<NameValuePair> params = new ArrayList<NameValuePair>();
params.add(new BasicNameValuePair("title", "strTitle"));
params.add(new BasicNameValuePair("url", "strTitle"));
params.add(new BasicNameValuePair("blog_name", "strTitle"));
params.add(new BasicNameValuePair("excerpt", "strExcerpt"));

HttpPost post = new HttpPost(strTrackbackUrl);
post.setHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
post.setEntity(new UrlEncodedFormEntity(params, HTTP.UTF_8));

final HttpResponse clientResponse = httpClient.execute(post);
int statusCode = clientResponse.getStatusLine().getStatusCode();
if (statusCode != HttpStatus.SC_OK) {
	sbHtml.append("送信に失敗しました:"+  strTrackbackUrl);
}
/*
DocumentBuilder db
	 = DocumentBuilderFactory.newInstance().newDocumentBuilder();//【5】
Document doc = db.parse(pm.getResponseBodyAsStream());		//【6】

NodeList nlError = doc.getElementsByTagName("error");
Element elError = (Element) nlError.item(0);
String strError = elError.getFirstChild().getNodeValue();
if(strError.equals("0")){							//【7】
	sbHtml.append("トラックバックPingの送信が成功しました。<BR>");
}else{											//【8】
	sbHtml.append("トラックバックPingの送信に失敗しました。<BR>");
	NodeList nlMessage = doc.getElementsByTagName("message");
	Element elMessage = (Element) nlMessage.item(0);
	sbHtml.append(elMessage.getFirstChild().getNodeValue());
}
*/
%>
<HTML>
<HEAD><TITLE>トラックバックピング</TITLE>
<LINK REL="stylesheet" HREF="style.css" TYPE="text/css">
</HEAD>
<BODY>
<%=sbHtml.toString()%>
<BR>
<A HREF="index.jsp?id=<%=blogArticle.getId()%>">戻る</A><BR>

</BODY>
</HTML>
