<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.vae.domain.*" %>
<%@ page import="com.vae.dao.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>myBlog--主页</title>

  <link rel="stylesheet" href="asset/css/style.css">

  <script src="asset/js/main.js"></script>
</head>
<body>
<%
	ArticleDao atcDao = DaoFactory.getArticleDaoInstance();
	Article a = new Article();
	a.setCate_name("aaa");
	a.setContent("resdf");
	java.util.Date ud = new java.util.Date();
	java.sql.Date d = new java.sql.Date(ud.getTime());
	a.setCre_time(d);
	a.setReads(0);
	a.setTitle("hhh");
	a.setUid(2);
	atcDao.add(a);
%>



</body>
</html>
