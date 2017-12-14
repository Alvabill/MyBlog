<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*,java.net.*" %>
<%@ page import="com.vae.domain.*" %>
<%@ page import="com.vae.dao.*" %>

<%

  StringBuilder item = new StringBuilder("");
  ArticleDao atcDao = DaoFactory.getArticleDaoInstance();
  List<Article> atcList = atcDao.findAll();
  if(!atcList.isEmpty()){
    Collections.reverse(atcList);
	  for(Article article:atcList){
		  item.append(
						  String.format("<div class='index-post'><header class='post-header'><h2 class='post-title'>%s</h2><div class='post-meta'><span class='post-time'><i class='fa fa-calendar-o'></i>%s</span><span class='post-category'><i class='fa fa-folder-o'></i>%s</span> <span class='post-reads'><i class='fa fa-eye'></i>%d</span></div></header> <div class='post-body'><p class='body-content'>%s</p><div class='post-button'><a class='btn' href='%s'>阅读全文 >></a></div> </div></div>",
						  article.getTitle(),
						  article.getCre_time().toString(),
						  article.getCate_name(),
						  article.getReads(),
						  article.getContent(),
						  article.getArticleURL()
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
          <li><a href="#"><i class="fa fa-th fa-fw"></i>&nbsp; 分类</a></li>
          <li><a href="#"><i class="fa fa-user fa-fw"></i>&nbsp; 关于</a></li>
        </ul>
      </div>
    </nav>
  </header>

  <%-- section --%>
  <section class="wrapper">
    <%=item %>
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
        <p class="body-content">

        </p>
        <div class="post-button">
          <a class="btn" href="#">阅读全文 >></a>
        </div>
      </div>
    </div> --%>
    <%-- root --%>
    <div id="rootUI" class="User">
      <a href="/myBlog"><i class="fa fa-wrench fa-fw"></i></a>
    </div>
  </section>

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
