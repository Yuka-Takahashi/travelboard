<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="ph.jpn.travelboard.*,java.util.*,java.text.*"%>
<jsp:useBean class="ph.jpn.travelboard.BlogArticleList" id="blogArticleList" scope="page"/>
<jsp:useBean class="ph.jpn.travelboard.BlogUser" id="blogUser" scope="session"/>
<jsp:useBean class="ph.jpn.travelboard.BlogArticle" id="blogArticle" scope="session"/>
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
						<h1><a href="#">Travel Board</a></h1>
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
<%
blogArticleList.setLimit(5);
blogArticleList.makeList();
int intId;
%>

				<!-- Main -->
					<div id="main">
<%
    BlogArticle article = null;
while(blogArticleList.next()){
    article = blogArticleList.getArticle();
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
								<p><%=TextConv.beforeHtml(article.getBodyTop100())%>
								</p>

								<footer>
									<ul class="actions">
										<li><a href="/travelboard/detail.jsp?id=<%= article.getId() %>" class="button big">続きを読む</a></li>
									</ul>
									<ul class="stats">
										<li><a href="/travelboard/Comment/createComment.jsp?article_id=<%=article.getId()%>">コメントする</a></li>
										<li><a href="#" class="icon fa-comment"><%=article.getCommentCount() %></a></li>
									</ul>
								</footer>
							</article>

<%
}
%>

						<!-- Pagination -->
							<ul class="actions pagination">
								<li><a href="/travelboard/Thread/createThread.jsp?new=1">＋新しいスレッドを作る</a></li>
							</ul>
					</div>

				<!-- Sidebar -->
					<section id="sidebar">

						<!-- Intro -->
							<section id="intro">
								<a href="#" class="logo"><img src="images/logo.jpg" alt="" /></a>
								<header>
									<h2>Travel Board</h2>
									<p>旅好きのための掲示板</p>
								</header>
							</section>
<%
blogArticleList.setPage(article.getId());
blogArticleList.setLimit(4);
blogArticleList.makeList();
%>
						<!-- Mini List -->
												<%
						while(blogArticleList.next()){
							article = blogArticleList.getArticle();
						%>
							<section>
								<div class="mini-posts">

									<!-- Mini Post -->
										<article class="mini-post">
											<header>
												<h3><%=TextConv.beforeHtml(article.getSubject())%></h3>
												<time class="published" datetime="2018-01-20">January 20, 2018</time>
												<a href="#" class="author"></a>
											</header>
											<a href="#" class="image"><img src="<%= article.getPath() %>" alt="" /></a>
										</article>
								</div>
							</section>
<%
							}
blogArticleList.setPage(article.getId());
blogArticleList.setLimit(4);
blogArticleList.makeList();
%>
						<!-- Posts List -->
						<%
						while(blogArticleList.next()){
							article = blogArticleList.getArticle();
						%>
							<section>
								<ul class="posts">
									<li>
										<article>
											<header>
												<h3><%=TextConv.beforeHtml(article.getSubject())%></h3>
												<time class="published" datetime="2015-10-20">October 20, 2015</time>
											</header>
											<a href="#" class="image"><img src="<%= article.getPath() %>" alt="" /></a>
										</article>
									</li>
								</ul>
							</section>
<%
						}
%>
						<!-- About -->
							<section class="blurb">
								<h2>About</h2>
								<p>これから行きたい場所、行った場所を旅好きな仲間に相談・共有できる掲示板です。<br>あなたの次の冒険のヒントが見つかるかもしれません。</p>

						<!-- Footer -->
							<section id="footer">
								<ul class="icons">
									<li><a href="#" class="fa-twitter"><span class="label">Twitter</span></a></li>
									<li><a href="#" class="fa-facebook"><span class="label">Facebook</span></a></li>
									<li><a href="#" class="fa-instagram"><span class="label">Instagram</span></a></li>
									<li><a href="#" class="fa-rss"><span class="label">RSS</span></a></li>
									<li><a href="#" class="fa-envelope"><span class="label">Email</span></a></li>
								</ul>
							</section>

					</section>

			</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="assets/js/main.js"></script>

	</body>
</html>