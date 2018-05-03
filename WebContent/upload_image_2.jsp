<%@ page contentType="text/html; charset=Shift_JIS"%>
<%@ page import="java.util.*,java.io.*,java.sql.*,ph.jpn.travelboard.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>

<HTML>
<HEAD>
<TITLE><%=BlogSettings.BlogTitle%></TITLE>
</HEAD>
<%
java.util.Date dateNow = new java.util.Date();
DiskFileUpload dfu = new DiskFileUpload();
try{
	if(blogArticle.getId()==0){
		throw new Exception("セッションがタイムアウトしました。");
	}
	dfu.setSizeMax(100000);
	dfu.setRepositoryPath(BlogSettings.AppDir+"/images");
	List lstItems = dfu.parseRequest(request);
	FileItem fi = (FileItem)lstItems.get(0);
	String strLocalFile = fi.getName();
	if(!strLocalFile.equals("")){
		String strFileName;
		int pBackSlash=strLocalFile.lastIndexOf("\\");
		if(pBackSlash!=-1){
			strFileName=strLocalFile.substring(pBackSlash+1);
		}else{
			strFileName=strLocalFile;
		}
		String strImageFilePath=BlogSettings.AppDir+"/images/"
			+ blogArticle.getId() + "_" + strFileName;
		File fileImage = new File(strImageFilePath);
		fi.write(fileImage);
		%>
		アップロード完了しました。<BR>
		<A HREF="upload_image_1.jsp">戻る</A>
	<%}else{%>
		エラーです。<BR>
	<%}%>
<%}catch(FileUploadBase.SizeLimitExceededException e){%>
	画像のファイルサイズが大きすぎます(最大100KB)。<BR>
	<A HREF="javascript:history.back()">戻る</A>
<%}catch(Exception e){%>
	<%=e.getMessage()%>
	<A HREF="index.jsp">戻る</A>
<%}%>
</BODY>
</HTML>
