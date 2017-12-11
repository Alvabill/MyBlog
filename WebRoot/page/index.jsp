<%@ page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.vae.domain.*" %>
<%@ page import="com.vae.dao.*" %>

<%
  request.setCharacterEncoding("utf-8");
  String str = request.getParameter("id");
  int artID = Integer.parseInt(str);
  
  ArticleDao atcDao = DaoFactory.getArticleDaoInstance();
  Article article = atcDao.findById(artID);
  String title = article.getTitle();
  int reads = article.getReads()+1;
  String cre_time = article.getCre_time().toString();
  String cate_name = article.getCate_name();
  String content = article.getContent();
  
  article = new Article(reads,artID);
  atcDao.updateReads(article);

%>
<%
   CommentDao cmDao = DaoFactory.getCommentDaoInstance();
   List<Comment> cmList = cmDao.findByArtId(artID);
   int commentNumber = 0;
   if(!cmList.isEmpty()){
	   for(Comment comment:cmList){
		   commentNumber++;
	   }
   }
%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>blog</title>

  <link rel="stylesheet" href="../asset/css/font-awesome.min.css">
  <link rel="stylesheet" href="../asset/css/style.css">
  <%-- <script src="../asset/js/main.js"></script> --%>
  <script type="text/javascript">
    <%@ include file="../asset/js/main.js"%>
  </script>
</head>
<body>
  <%-- header --%>
    <header id="header">
      <nav id="nav" class="wrapper">
        <div class="nav-logo">
          <a href="/myBlog">
            <span>MyBlog</span>
          </a>
        </div>
        <div class="navbar">
          <ul>
            <li>
              <a href="/myBlog">
                <i class="fa fa-home fa-fw"></i>&nbsp; 主页</a>
            </li>
            <li>
              <a href="#">
                <i class="fa fa-th fa-fw"></i>&nbsp; 分类</a>
            </li>
            <li>
              <a href="#">
                <i class="fa fa-user fa-fw"></i>&nbsp; 关于</a>
            </li>
          </ul>
        </div>
      </nav>
    </header>

  <%-- section --%>
  <section class="wrapper">
    <p class="blog-title"><%=title %></p>
    <div class="blog-meta">
      <span class="post-time"><i class="fa fa-calendar-o"></i><%=cre_time %></span>
      <span class="post-category"><i class="fa fa-folder-o"></i><%=cate_name %></span>
      <span class="post-reads"><i class="fa fa-eye"></i><%=reads %></span>
    </div>
    <div class="blog-body">
    <%
      switch(artID){
      case 1:%>
    	  <jsp:include page="blog/1.jsp" />
    <% 	  break;
      case 2:%>
          <jsp:include page="blog/2.jsp" />
    <%    break;
      }
    %>
    
    
     </div>
  </section>
  <hr style="width:750px;color:gray">

  <div class="comments">
    <span class="comment-number">
      <%=commentNumber %>条评论
    </span>
    <span class="comment-login">登录</span>
    <div class="comment-textarea">
     <input id="comment-content" type="text" name="" value="我来说两句..." onkeypress="EnterPress(event)">
    </div>
  </div>
  <div class="comment-data">
      <p class="comment-data-news">最新</p>
      <%-- <div id="comment-items"></div> --%>
      <%=comment_item %>
      <%-- <div class="comment-data-item">
        <img class="comment-data-item-img"src="../../asset/img/wwb.jpg">
        <span class="comment-data-item-name">wwb</span>
        <span class="comment-data-item-time">2017-12-10 22:22:22</span>
        <p class="comment-data-item-content">hhhhhhhhhhhhhhhh</p>
      </div> --%>
  </div>

  <%-- footer --%>
  <footer id="footer">
    <div class="wrapper">
      <p>Copyright © 2017 15352344. All Rights Reserved.
        <a href="index.jsp" title="myBlog" target="_blank">MyBlog</a>
      </p>
    </div>
  </footer>
</body>
</html>
