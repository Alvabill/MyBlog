<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*,java.net.*"%>
<%@ page import="com.vae.domain.*" %>
<%@ page import="com.vae.dao.*" %>

<%
	String email = null;
	String password = null;

	MemberDao mbDao = DaoFactory.getMemberDaoInstance();
	List<Member> mbList = mbDao.findAll();
	Member mb = new Member();
	int uid = 1;

%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>MyBlog -- 登录状态</title>

	<link rel="stylesheet" href="asset/css/font-awesome.min.css">
    <link rel="stylesheet" href="asset/css/login.css">
</head>
<body>


	<%
	request.setCharacterEncoding("utf-8");
	email = request.getParameter("email");
	password = request.getParameter("password");

	String msg = "";
	boolean hasSignin = false, isSignin = false;
	for(Member member:mbList){
    uid++;
		if(member.getAccount().equals(email)){
			hasSignin = true;
      break;
		}
	}
	if(hasSignin){
		for(Member member:mbList){
	 		if(member.getPassword().equals(password)&&member.getAccount().equals(email)){
	 			isSignin = true;
	 			msg = "登录成功！";

	 			Cookie cookie = new Cookie("Role_code",member.getRole_code());
	 			cookie.setMaxAge(-1);//关闭浏览器消除cookie
	 			response.addCookie(cookie);
	 			cookie = new Cookie("member",""+uid);
	 			cookie.setMaxAge(-1);
	 			response.addCookie(cookie);
	 		}
		}
		if(!isSignin)
 			msg = "密码错误！";

	}else {
		msg = "该账号尚未注册，请先注册~";
	}
	%>
  	<h1 style="margin:4.5em 0;"><%=msg %></h1>

  	<!--start-copyright-->
     		<div class="copy-right">
          <p>Copyright © 2017 15352344. All Rights Reserved.
            <a href="index.jsp" title="myBlog" target="_blank">MyBlog</a>
          </p>
        </div>
  	<!--//end-copyright-->

	<script>
    <%if(hasSignin&&isSignin){%>
	    setTimeout('window.location.replace="/myBlog"',1500);
    <%} else if(hasSignin&&(!isSignin)){%>
    	setTimeout("history.go(-1)",1500);
    <%} else {%>
    	setTimeout("window.location.href='logup.jsp'",1500);
    <%}%>
    </script>
</body>
</html>
