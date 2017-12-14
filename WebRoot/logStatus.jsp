<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%>
<%@ page import="com.vae.domain.*" %>
<%@ page import="com.vae.dao.*" %>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>

<%
	String email = null;
	String nickname = null;
	String password = null;
	String imgUrl = null;
	String fileFullName = null, fileRelaName = "default.png";

	MemberDao mbDao = DaoFactory.getMemberDaoInstance();
	Member mb = new Member();
	List<Member> mbList = mbDao.findAll();
	int uid = 1;
	if(!mbList.isEmpty()){
		for(Member member:mbList){
			uid++;
		}
	}

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


	<%	request.setCharacterEncoding("utf-8");
	//检查表单中是否包含文件
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (isMultipart) {
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = upload.parseRequest(request);
		String value = null;
		DiskFileItem dfi = null;
		for (int i=0; i<items.size(); i++) {
			FileItem fi = (FileItem) items.get(i);
			if (fi.isFormField()) {
				value = fi.getString("utf-8");
				if (fi.getFieldName().equals("email")) {// 对应form中属性的名字
					email = value;
                } else if (fi.getFieldName().equals("nickname")) {
                	nickname = value;
                } else if (fi.getFieldName().equals("password")) {
                	password = value;
                }
			}
			else {
				dfi = (DiskFileItem) fi;
				if (!dfi.getName().trim().equals("")) {
					fileRelaName = uid+"_"+FilenameUtils.getName(dfi.getName());
					fileFullName = application.getRealPath("/asset/img/")
								+System.getProperty("file.separator")
								+fileRelaName;
					//out.print(new File(fileFullName).getAbsolutePath());
					//out.print("<br>");
					dfi.write(new File(fileFullName));
				}
			}
		}

		//out.print("<a href=\'"+fileFullName+"\'>"+fileRelaName+"</a>");
	}
	%>

	<%
	imgUrl = "../asset/img/"+fileRelaName;

	String msg = "";
	boolean hasSignup = false;
	for(Member member:mbList){
		if(member.getAccount().equals(email)){
			msg = "该账号已被注册";
			hasSignup = true;
		}
	}
	if(!hasSignup){
		mb.setAccount(email);
		mb.setNickname(nickname);
		mb.setPassword(password);
		mb.setRole_code("2");
		mb.setUrl(imgUrl);
		mbDao.add(mb);
		msg ="注册成功！";

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
    <%if(hasSignup){%>
	    setTimeout("self.location=document.referrer",1500);
    <%} else {%>
    	setTimeout("window.location.href('login.jsp')",1500);
    <%}%>
    </script>
</body>
</html>
