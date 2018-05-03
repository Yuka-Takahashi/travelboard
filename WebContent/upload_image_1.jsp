<%@page contentType="text/html;charset=Shift_JIS"%>
<%@page import = "ph.jpn.travelboard.*,java.util.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<HTML>
<HEAD>
<TITLE><%=BlogSettings.BlogTitle%></TITLE>
<LINK REL="stylesheet" HREF="style.css" TYPE="text/css">
</HEAD>
<BODY onload="window.focus()">
画像のアップロード
<HR>
<SCRIPT TYPE="text/javascript">
function check(){
	if(document.form1.file_name.value==""){
		alert("アップロードするファイルを指定してください");
		return false;
	}
}
</SCRIPT>
<FORM NAME="form1" ACTION="upload_image_2.jsp" METHOD="post" ENCTYPE="MULTIPART/FORM-DATA"
	 onSubmit="return check()">
<BR>
画像ファイル：<BR>
<INPUT TYPE="file" NAME="file_name" SIZE="60"><BR>
<INPUT TYPE="submit" VALUE="アップロード">
</FORM>
<HR>
<SCRIPT TYPE="text/javascript">
function func_delete_image(strImageFileName){
	if(confirm(strImageFileName+"を削除します。よろしいですか？")){
		location.href="delete_image.jsp?image_file="+strImageFileName;
	}
}
</SCRIPT>
<%
ArrayList alImage = blogArticle.getImageList();
for(int i=0;i<alImage.size();i++){
	String strImageFileName = (String)alImage.get(i);
	%>
	<IMG SRC="/travelboard/images/<%=blogArticle.getId()+"_"+strImageFileName%>">
	<%=strImageFileName%>
	<INPUT TYPE="button" VALUE="削除" onclick="func_delete_image('<%=strImageFileName%>')">
<%}%>
<HR>
<INPUT TYPE="button" VALUE="戻る"
	onClick="location.href='index.jsp?id=<%=blogArticle.getId()%>'">
</BODY>
</HTML>
