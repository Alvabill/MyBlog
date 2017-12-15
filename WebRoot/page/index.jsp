<%@ page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*,java.net.*" %>
<%@ page import="com.vae.domain.*" %>
<%@ page import="com.vae.dao.*" %>

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
<%//文章接口
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
<% //评论接口
   CommentDao cmDao = DaoFactory.getCommentDaoInstance();
   List<Comment> cmList = cmDao.findByArtId(artID);
   int commentNumber = 0;
   if(!cmList.isEmpty()){
	   for(Comment comment:cmList){
		   commentNumber++;
	   }
   }
%>
<%//人员接口
	MemberDao mbDao = DaoFactory.getMemberDaoInstance();
	List<Member> mbList = mbDao.findAll();
	Member mb = new Member();
%>
<%//访问记录接口
	MemrecordDao mrDao = DaoFactory.getMemrecordDaoInstance();
	Memrecord mr = new Memrecord();
	if(uid > 1){
		Member mb1 = mbDao.findById(uid);
		mr.setIp(mb1.getAccount());
		mr.setUid(uid);
		java.util.Date ud = new java.util.Date();
    	java.sql.Timestamp visit_time = new java.sql.Timestamp(ud.getTime());
		mr.setVisit_time(visit_time);
		mr.setVisit_uid(artID);
		mrDao.add(mr);
	}

%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>blog -- 内容</title>

  <link rel="stylesheet" href="../asset/css/font-awesome.min.css">
  <link rel="stylesheet" href="../asset/css/style.css">
  <script src="../asset/js/main.js"></script>
  <script type="text/javascript">
    function EnterPress(e){
  var e = e || window.event;
  if(e.keyCode == 13){
    BtnAjax();
  }

}

function BtnAjax(){
  var XMLHttpReq;
  //创建XMLHttpRequest对象
  function createXMLHttpRequest() {
      if(window.XMLHttpRequest) { //Mozilla 浏览器
          XMLHttpReq = new XMLHttpRequest();
      }
      else if (window.ActiveXObject) { // IE浏览器
          try {
              XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
          } catch (e) {
              try {
                  XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
              } catch (e) {}
          }
      }
  }
  //发送请求函数
  function sendRequest() {
      createXMLHttpRequest();
      var content = document.getElementById("comment-content").value;
      var url = "ajax.jsp?artID="+'<%=artID%>'+"&uid="+'<%=uid%>'+"&content="+content;
      XMLHttpReq.open("GET", url, true);
      XMLHttpReq.onreadystatechange = processResponse;//指定响应函数
      XMLHttpReq.send(null);  // 发送请求
  }
  // 处理返回信息函数
  function processResponse() {
      if (XMLHttpReq.readyState == 4) { // 判断对象状态
          if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息
              Display();

          } else { //页面不正常
              window.alert("请先登录!");
          }
      }
  }
  function Display() {
    <%
      StringBuilder comment_item = new StringBuilder("");
      cmList = cmDao.findByArtId(artID);
      commentNumber = 0;
      if(!cmList.isEmpty()){
       Collections.reverse(cmList);
       for(Comment comment:cmList){
         commentNumber++;
             int userid = comment.getUid();
             mb = mbDao.findById(userid);
           comment_item.append(
             String.format(" <div class='comment-data-item'><img class='comment-data-item-img' src='%s'><span class='comment-data-item-name'>%s</span><span class='comment-data-item-time'>%s</span><p class='comment-data-item-content'>%s</p></div>",
              mb.getUrl(),
              mb.getNickname(),
              comment.getCommentdate().toString(),
              comment.getComment_content()
           ));
       }
      }
    %>
      // var name = XMLHttpReq.responseXML.getElementsByTagName("name")[0].firstChild.nodeValue;
      // var count = XMLHttpReq.responseXML.getElementsByTagName("count")[0].firstChild.nodeValue;
//      document.getElementById("comment-items").innerHTML(<%=comment_item %>);
  }

  sendRequest();
  document.getElementById("comment-content").value = "";
}

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
      case 3:%>
          <jsp:include page="blog/3.jsp" />
    <%    break;
      case 4:%>
      <jsp:include page="blog/4.jsp" />
<%    break;
      case 5:%>
      <jsp:include page="blog/5.jsp" />
<%    break;
      case 6:%>
      <jsp:include page="blog/6.jsp" />
<%    break;
      case 7:%>
      <jsp:include page="blog/7.jsp" />
<%    break;
      case 8:%>
      <jsp:include page="blog/8.jsp" />
<%    break;
      case 9:%>
      <jsp:include page="blog/9.jsp" />
<%    break;
      case 10:%>
      <jsp:include page="blog/10.jsp" />
<%    break;
      }
    %>
     </div>

     <div id="loginBtn" class="User">
       <a href="../login.jsp"><i class="fa fa-user-o"></i></a>
     </div>
  </section>
  <hr style="width:750px;color:gray">

  <div class="comments">
    <span class="comment-number">
      <%=commentNumber %>条评论
    </span>
    <a href="../login.jsp"><span class="comment-login">切换账号</span></a>

    <div class="comment-textarea">
     <input id="comment-content" type="text" name="" placeholder="我来说两句..." onkeypress="EnterPress(event)">
    </div>
    <input id = "comment-button" type="button" name="btn" value="提交" onclick="BtnAjax()">
  </div>
  <div class="comment-data">
      <p class="comment-data-news">最新评论</p>
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

  <script type="text/javascript">
    var el = document.getElementById("loginBtn");
    var classVal = el.getAttribute('class');
    <%if (uid <= 1){ %>
      classVal = classVal.replace("User","Root");
      el.setAttribute("class",classVal );
    <%} %>
  </script>
</body>
</html>
