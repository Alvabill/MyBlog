<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*,java.net.*" %>
<%@ page import="com.vae.domain.*" %>
<%@ page import="com.vae.dao.*" %>

<%

  StringBuilder item1 = new StringBuilder("");
  StringBuilder item2 = new StringBuilder("");
  ArticleDao atcDao = DaoFactory.getArticleDaoInstance();
  List<Article> atcList = atcDao.findAll();
  if(!atcList.isEmpty()){
    Collections.reverse(atcList);
    Article article = new Article();
	  for(int i=0;i<2;i++){
		  article = atcList.get(i);
		  item1.append(
				  String.format("<div class='index-post'><header class='post-header'><a href='%s'><h2 class='post-title'>%s</h2></a><div class='post-meta'><span class='post-time'><i class='fa fa-calendar-o'></i>%s</span><span class='post-category'><i class='fa fa-folder-o'></i>%s</span> <span class='post-reads'><i class='fa fa-eye'></i>%d</span></div></header> <div class='post-body'><p class='body-content'>%s</p> </div></div>",
	              article.getArticleURL(),
	              article.getTitle(),
				  article.getCre_time().toString(),
				  article.getCate_name(),
				  article.getReads(),
				  article.getContent()
					  )
				  );
	  }
	  for(int i=2;i<4;i++){
		  article = atcList.get(i);
		  item2.append(
				  String.format("<div class='index-post'><header class='post-header'><a href='%s'><h2 class='post-title'>%s</h2></a><div class='post-meta'><span class='post-time'><i class='fa fa-calendar-o'></i>%s</span><span class='post-category'><i class='fa fa-folder-o'></i>%s</span> <span class='post-reads'><i class='fa fa-eye'></i>%d</span></div></header> <div class='post-body'><p class='body-content'>%s</p> </div></div>",
	              article.getArticleURL(),
	              article.getTitle(),
				  article.getCre_time().toString(),
				  article.getCate_name(),
				  article.getReads(),
				  article.getContent()
					  )
				  );
	  }
  }
%>
<%
    String Role_code = "2";
    int uid = 1;
    Cookie cookie = null;
    Cookie[] cookies = null;
    // 获取cookies的数据,是一个数组
    cookies = request.getCookies();
    if( cookies != null ){
       for (int i = 0; i < cookies.length; i++){
          cookie = cookies[i];
          if(cookie.getName().equals("Role_code")){
        	  Role_code = URLDecoder.decode(cookie.getValue(), "utf-8");
          }
          if(cookie.getName().equals("member")){
        	  String str = URLDecoder.decode(cookie.getValue(), "utf-8");
          	  uid = Integer.parseInt(str);
          }
       }
    }
%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>myBlog -- 主页</title>


  <link rel="stylesheet" href="asset/css/font-awesome.min.css">
  <link rel="stylesheet" href="asset/css/style.css">
  <script src="asset/js/main.js"></script>
  <style media="screen">
    .Root{
      padding: 1.4em 1.4em;
    }
  </style>
</head>
<body>
  <%-- header --%>
  <header id="header">
    <nav id="nav" class="wrapper">
      <div class="nav-logo">
        <a href="/myBlog"><span>MyBlog</span></a>
      </div>
      <div class="navbar">
        <ul>
          <li><a href="/myBlog"><i class="fa fa-home fa-fw"></i>&nbsp; 主页</a></li>
          <li><a href="blogs.jsp"><i class="fa fa-th fa-fw"></i>&nbsp; 分类</a></li>
       	 <li><a href="about.jsp"><i class="fa fa-user fa-fw"></i>&nbsp; 关于</a></li>
        	</ul>
      </div>
    </nav>
  </header>

  <%-- section --%>
  <section class="wrapper">
    <div class="new-blog-header">
      <span>Latest blogs</span>
      <i class="icon-tiny fa fa-long-arrow-right right"></i>
      <a class="right" href="blogs.jsp">View all blogs </a>
    </div>

    <div class="blog-banner left">
      <img src="asset/img/banner1.jpg" alt="">
    </div>
    <div class="blog-banner right">
      <img src="asset/img/banner2.jpg" alt="">
    </div>
    <%=item1 %>
    <%-- <div class="index-post">
      <header class="post-header">
        <h2 class="post-title"></h2>
        <div class="post-meta">
          <span class="post-time"></span>
          <span class="post-category"></span>
          <span class="post-reads"></span>
        </div>
      </header>
      <div class="post-body">
        <p class="body-content"></p>
      </div>
    </div> --%>
    <div class="clear"></div>
	 <div class="blog-banner left">
      <img src="asset/img/banner3.jpg" alt="">
    </div>
    <div class="blog-banner right">
      <img src="asset/img/banner4.jpg" alt="">
    </div>
    <%=item2 %>

    <p class="new-blog-end"><a href="blogs.jsp">View more </a></p>
    <%-- root --%>
    <div id="rootUI" class="User">
      <a href="/myBlog/page/root"><i class="fa fa-wrench fa-fw"></i></a>
    </div>
  </section>

  <div class="clear"></div>
  <%-- footer --%>
  <footer id="footer">
    <div class="wrapper">
      <p>Copyright © 2017 15352344. All Rights Reserved. <a href="index.jsp" title="myBlog" target="_blank">MyBlog</a></p>
    </div>
  </footer>

  <script type="text/javascript">
    var el = document.getElementById("rootUI");
    var classVal = el.getAttribute('class');
  	<%if (Role_code.equals("1")){ %>
      classVal = classVal.replace("User","Root");
      el.setAttribute("class",classVal );
  	<%} %>
  </script>
</body>
</html>
