<%@page contentType="text/html;charset=UTF-8"%>
<HTML>
<HEAD>
<TITLE>ログイン</TITLE>
<LINK REL="stylesheet" HREF="style.css" TYPE="text/css">
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="/travelboard/assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="/travelboard/assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="/travelboard/assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="/travelboard/assets/css/ie8.css" /><![endif]-->
</HEAD>
<BODY>
<FORM ACTION="/travelboard/UserManagement/login_2.jsp" METHOD="post">
<TABLE>
<TR><TD>ユーザー名</TD><TD><INPUT TYPE="text" NAME="user_name"></TD></TR>
<TR><TD>パスワード</TD><TD><INPUT TYPE="password" NAME="password"></TD></TR>
<TR style="height=0"><TD style="height=0"></TD></TR>
</TABLE>
<INPUT TYPE="submit" VAULE="ログイン">
</FORM><br/>
<a href="/travelboard/UserManagement/createUser.jsp">新規作成</a>
</FORM>
</BODY>
</HTML>
