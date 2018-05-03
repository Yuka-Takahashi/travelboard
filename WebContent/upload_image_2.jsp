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
		throw new Exception("�Z�b�V�������^�C���A�E�g���܂����B");
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
		�A�b�v���[�h�������܂����B<BR>
		<A HREF="upload_image_1.jsp">�߂�</A>
	<%}else{%>
		�G���[�ł��B<BR>
	<%}%>
<%}catch(FileUploadBase.SizeLimitExceededException e){%>
	�摜�̃t�@�C���T�C�Y���傫�����܂�(�ő�100KB)�B<BR>
	<A HREF="javascript:history.back()">�߂�</A>
<%}catch(Exception e){%>
	<%=e.getMessage()%>
	<A HREF="index.jsp">�߂�</A>
<%}%>
</BODY>
</HTML>
