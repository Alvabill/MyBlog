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
	<title>MyBlog -- 用户登录</title>

	<link rel="stylesheet" href="asset/css/font-awesome.min.css">
    <link rel="stylesheet" href="asset/css/login.css">
</head>
<body>

  	<h1>Sign In For Comment</h1>
  		<div class="app-block">
  		  <div class="cube">
  			    <img src="asset/img/cube.png" class="img-responsive" alt="">
          </div>
  			<form action="loginStatus.jsp" method="post">
  				<input class="text" name="email" placeholder="Email address" type="text">
  				<input name="password" placeholder="Password" type="password">
  				<div class="submit"><input onclick="myFunction()" value="Sign in" type="submit"></div>
  				<div class="clear"></div>
  				<p><a href="#">Forgot Password ?</a></p>
  			</form>
  			<p class="sign">New here ? <a href="logup.jsp"> Sign Up</a></p>

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
