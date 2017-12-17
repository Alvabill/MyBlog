<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.vae.domain.*" %>
<%@ page import="com.vae.dao.*" %>

    <%

    %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>MyBlog -- 用户注册</title>

	<link rel="stylesheet" href="asset/css/font-awesome.min.css">
    <link rel="stylesheet" href="asset/css/login.css">
</head>
<body>

  	<h1>Sign Up</h1>
  		<div class="app-block">
  		  <div class="cube">
  			  <a href="#">
  			    <img src="asset/img/upload.png" class="img-responsive" alt="">
          </a>
          </div>
  			<form action="logStatus.jsp" method="post" enctype="multipart/form-data">
          <input id="upload" type="file" name="img" value="img">
          		<input class="text" name="nickname" type="text" placeholder="Nickname">
  				    <input class="text" name="email" type="text" placeholder="Email address">
              <input name="password" type="password"  placeholder="Password">
  				<div class="submit"><input onclick="myFunction()" value="Sign up" type="submit"></div>
  				<div class="clear"></div>
  			</form>

  		</div>
  	<!--start-copyright-->
     		<div class="copy-right">
          <p>Copyright © 2017 15352344. All Rights Reserved.
            <a href="index.jsp" title="myBlog" target="_blank">MyBlog</a>
          </p>
        </div>
  	<!--//end-copyright-->


</body>
</html>
