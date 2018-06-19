<%@page contentType="text/html;charset=UTF-8"%>
<HTML>
<HEAD>
<TITLE>ログイン</TITLE>
<LINK REL="stylesheet" HREF="style.css" TYPE="text/css">
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
</HEAD>
<BODY>
<FORM ACTION="login_2.jsp" METHOD="post">
<INPUT TYPE="text" NAME="methodName" value="login" readonly><BR>
<TABLE>
<TR><TD>ユーザー名</TD><TD><INPUT TYPE="text" NAME="user_name"></TD></TR>
<TR><TD>パスワード</TD><TD><INPUT TYPE="password" NAME="password"></TD></TR>
<TR style="height=0"><TD style="height=0"></TD></TR>
</TABLE>
<INPUT TYPE="submit" VAULE="送信">
</FORM><br/>
<FORM ACTION="login_2.jsp" METHOD="post">
<INPUT TYPE="text" NAME="methodName" value="useradd"><BR>
<TABLE>
<TR><TD>ユーザー名</TD><TD><INPUT TYPE="text" NAME="user_name"></TD></TR>
<TR><TD>パスワード</TD><TD><INPUT TYPE="password" NAME="password"></TD></TR>
<TR><TD>ニックネーム</TD><TD><INPUT TYPE="text" NAME="nick_name"></TD></TR>
<TR style="height=0"><TD style="height=0"></TD></TR>
</TABLE>
<INPUT TYPE="submit" VAULE="新規作成">
</FORM>
</BODY>
</HTML>
