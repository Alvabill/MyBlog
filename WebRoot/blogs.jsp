<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*,java.net.*" %>
<%@ page import="com.vae.domain.*" %>
<%@ page import="com.vae.dao.*" %>

<%
int category = 1;
String title1 = null;
String content1 = null;
String url1 = null;
String title2 = null;
String content2 = null;
String url2 = null;
String imgUrl1 = null;
String imgUrl2 = null;
ArticleDao atcDao = DaoFactory.getArticleDaoInstance();
List<Article> atcList = atcDao.findAll();
int atcnum = 0;
if(!atcList.isEmpty()){
	for(Article atc:atcList){
		atcnum++;
	}
}
Article article1 = new Article();
Article article2 = new Article();

request.setCharacterEncoding("utf-8");
if(request.getMethod().equalsIgnoreCase("get")){
	String category1 = request.getParameter("category");
	if(category1!=null){
		category = Integer.parseInt(category1);
	}
}

%>

<%
switch(category){
case 1:
	article1 = atcDao.findById(1);
	article2 = atcDao.findById(6);

	imgUrl1 = "asset/img/"+1+".png";
	imgUrl2 = "asset/img/"+6+".png";
	break;
case 2:
	article1 = atcDao.findById(4);
	article2 = atcDao.findById(5);
	
	imgUrl1 = "asset/img/"+4+".png";
	imgUrl2 = "asset/img/"+5+".png";
	break;
case 3:
	article1 = atcDao.findById(7);
	article2 = atcDao.findById(8);
	
	imgUrl1 = "asset/img/"+7+".png";
	imgUrl2 = "asset/img/"+8+".png";
	break;
case 4:
	article1 = atcDao.findById(2);
	article2 = atcDao.findById(3);
	
	imgUrl1 = "asset/img/"+2+".png";
	imgUrl2 = "asset/img/"+3+".png";
	break;
case 5:
	article1 = atcDao.findById(9);
	article2 = atcDao.findById(10);
	imgUrl1 = "asset/img/"+9+".png";
	imgUrl2 = "asset/img/"+9+".png";
	break;
}
title1 = article1.getTitle();
content1 = article1.getContent();
url1 = article1.getArticleURL();

title2 = article2.getTitle();
content2 = article2.getContent();
url2 = article2.getArticleURL();

%>
<!DOCTYPE HTML>
<html>
<head>
    <meta content="text/html;charset=utf-8">
    <title>myBlog -- 所有博客</title>
   <link rel="stylesheet" href="asset/css/font-awesome.min.css">
  <script src="asset/js/main.js"></script>
    <style>
        * {margin:0;padding:0;  font-size: 14px;
  font-family: "SF Pro SC", "HanHei SC", "SF Pro Text", "Myriad Set Pro", "SF Pro Icons", "PingFang SC", "Helvetica Neue", "Helvetica", "Arial", "sans-serif";
}
a:link, a:visited, a:hover, a:active {
  text-decoration: none;
}  
a {
	color: white;
}
.title{
    font-size: 1.2em;
    height: 50px;
    margin:70px 70px 40px;
    font-weight: bold;
} 
.abstract{
  height: 62px;
  overflow: hidden;
	font-size:1em;
    margin:40px 35px;
}
.button{
    margin:70px 120px;
    background-color: gray;
    width: 91px;
    padding-left: 10px;
    padding-right: 10px;
    padding-top: 10px;
    padding-bottom: 10px;
    border-radius: 10px;
    font:24px Calibri;
}
.button:hover{
    background: rgb(219, 113, 13);
         transition: background;
         transition-timing-function: ease-out;
         transition: 0.3s;
         cursor: pointer;
}


 
         @keyframes myfirst{
          from{
            transform: translate(-1px,-1px);
          }
          to{
            transform: translate(0,0);
          }
          }

        li{list-style-type:none}
        body {
        
        /* background-color: #FF8; */
        background-image:url("asset/img/blogs_bg.jpg");
        background-size: contain;
        }
        .clear {clear:both}
        .h {
            width: 600px;
            height: 200px;
        background-size: percentage;
        }
        #header {
            /* background-color: #666; */
        width: 980px;
        height: 200px;
        margin: 0 auto;
        }
        #nav_outer{background-color: rgb(32, 32, 32); }
        #nav {
        width:980px;
        height:35px; 
        margin: 0 auto;
        text-shadow: 0.5px 0.5px 1px #dfd8d8;
        }
        #main {
        width: 980px;
        margin: 0px auto;}
        .main_l {
        width: 300px;
        padding: 20px 10px 10px;
        float: left;
        box-sizing: border-box;
        position: relative;
        margin: 50px;}


        .row1 img{
        border:1px solid rgb(221, 220, 220);
        border-radius: 10px;
        width: 90px;
        height: 90px;
        margin-bottom: 20px;
        position: absolute;
        top:-20px;
        left: 140px;
        z-index: 2;
        
        
        }
        #header_outer {
            background: black url("asset/img/blogs_header.jpeg") no-repeat; 
        } 
        .navbar {
        	float: right;
        }
       
.row1 img:hover{
    animation: myfirst 5s;
}
        .row2 {
        background-color: #ebebee;
        width: 360px;
        height: 350px;
        border-radius: 5px;
        opacity: 0.9;
        z-index: -1;
        border: 1px solid rgb(221, 220, 220);
        box-shadow: 2px 2px 2px rgb(212, 209, 209),inset 2px -2px 2px rgb(212, 209, 209);
        }

.navbar ul li a{
    color:#dfd8d8;
    float: left;
    text-decoration: none;
    margin-top: 10px;
    font-size: 18px;
}

        .row1 {margin-bottom: 20px;}

        #footer {
        width: 980px;
        height: 100px;
        line-height:100px;
        margin: 0px auto;
        padding: 0;}
        #footer_outer{
        
        background-color: black;
        background-size: cover;}
        
        #nav>li {
        	width:140px;
        	float: left;
            padding: auto 0px;
        	text-align: center; 
        	line-height: 35px; 
               	
        }
        #nav>li:hover {
            background-color: black;
        }
        #nav>li a{
            text-decoration: none;
            color: white;
     	
        }
       /*footer start*/
#footer {
  width: 100%;
}
#footer p {
  color: white;
  text-align: center;
  font-size: 0.8rem;
  margin: 0;
  padding: 0 0 5px 0;
}
#footer a {
  color: white;
  font-size: 0.8rem;
}
/*footer end*/
    </style>
</head>
<body>

    <div id="header_outer">
        <div id="header" class="wrapper">
                <div class="navbar">
                        <ul>
                          <li><a href="/myBlog"><i class="fa fa-home fa-fw"></i>主页</a>
                          <li><a href="#">&nbsp;</a>
                         </ul>
                         </div>
         </div><!--header-->
    </div> <!--header_outer-->

    <div id="nav_outer">
            <ul class="wrapper" id="nav">
                <li><a href="blogs.jsp?category=1">人物</a>
                </li>
                <li><a href="blogs.jsp?category=2">生活</a>
                </li>
                <li><a href="blogs.jsp?category=3">科技</a>
                </li>
                <li><a href="blogs.jsp?category=4">学术</a>
                </li>
                <li><a href="blogs.jsp?category=5">其他</a>
                </li> 
            </ul>
        </div>

    <div id="main1_outer" class="main_outer">
        <div class="wrapper" id="main">
            <div class="main_l">
                <div class="row1">
                        <img src="<%=imgUrl1 %>" height="90" width="90" />
                 </div>
                <div class="row2" >
                   <div class="title">
<%=title1 %>
                   </div>
                   <div class="abstract">
<%=content1 %>
                   </div>
               <a class="button" href="<%=url1 %>">
Read Full
               </a>
                </div>
            </div><!--main_l-->
            <div class="main_l">
                <div class="row1">
                        <img src="<%=imgUrl2 %>" height="90" width="90" />
                 </div>
                <div class="row2" >
                   <div class="title">
<%=title2 %>
                   </div>
                   <div class="abstract">
<%=content2 %>
                   </div>
               <a class="button" href="<%=url2 %>">
Read Full
               </a>
                </div>
            </div><!--main_l-->
            <div class="clear"></div>
        </div> <!--main wrapper-->
    </div> <!--main1_outer-->

    
   
       
    <div id="footer_outer">
        <div id="footer" class="wrapper">
            <p>Copyright © 2017 15352344. All Rights Reserved. <a href="index.jsp" title="myBlog" target="_blank">MyBlog</a></p>
        </div><!--footer-->
    </div> <!--footer_outer-->
</body>
</html>
