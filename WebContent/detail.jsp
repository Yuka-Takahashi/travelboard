<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="ph.jpn.travelboard.*,java.util.*,java.text.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticleList" id="blogArticleList" scope="page"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
<%
int strId = Integer.parseInt(request.getParameter("id"));
%>
<html>
	<head>
		<title>Travel Board</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	</head>
	<body>

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<h1><a href="index.jsp">Travel Board</a></h1>
						<nav class="main">
							<ul>
								<li class="search">
									<a class="fa-search" href="#search">Search</a>
									<form id="search" method="get" action="#">
										<input type="text" name="query" placeholder="Search" />
									</form>
								</li>
								<li class="menu">
									<a class="fa-bars" href="#menu">Menu</a>
								</li>
							</ul>
						</nav>
					</header>

				<!-- Menu -->
					<section id="menu">

						<!-- Search -->
							<section>
								<form class="search" method="get" action="#">
									<input type="text" name="query" placeholder="Search" />
								</form>
							</section>

						<!-- Links -->
							<section>
								<ul class="links">
									<li>
										<a href="#">
											<h3>MYPAGE</h3>
											<p>登録情報の管理</p>
										</a>
									</li>
								</ul>
							</section>

						<!-- Actions -->
							<section>
								<ul class="actions vertical">
									<li><a href="login_1.jsp" class="button big fit">Log In</a></li>
								</ul>
							</section>

					</section>
				<!-- Main -->
					<div id="main">
<%
    BlogArticle article = new BlogArticle();
	article.setId(strId);
    article.load(strId);
%>
						<!-- Post -->
							<article class="post">
								<header>
									<div class="title">
										<h2><%=TextConv.beforeHtml(article.getSubject())%></h2>
									</div>
									<div class="meta">
										<time class="published" datetime="<%= article.getDateTime() %>"><%= article.getDateTime() %></time>
										<a href="#" class="author"><span class="name"><%=article.getNickName()%></span></a>
									</div>
								</header>
								<a href="#" class="image featured"><img src="<%= article.getPath() %>" alt="" /></a>
								<p><%=TextConv.beforeHtml(article.getBody())%>
								</p>
<%
	List<Map<String,String>> comment = article.getComment();
	if (comment.size() > 0) {
%>
	コメント一覧<br/>
<%

	}
	for (Map<String, String> tmpMap : comment) {
%>
	<%= tmpMap.get("body") %><br/>
	<%= tmpMap.get("commenter") %><br/>
<%
	}
%>
								<footer>
									<ul class="stats">
										<li><a href="/travelboard/Comment/createComment.jsp?article_id=<%=article.getId()%>">コメントする</a></li>
										<li><a href="#" class="icon fa-comment"><%=article.getCommentCount() %></a></li>
									</ul>
								</footer>
							</article>
					</div>



			</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="assets/js/main.js"></script>

	</body>
</html>