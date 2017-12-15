<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*,java.net.*" %>
<%@ page import="com.vae.domain.*" %>
<%@ page import="com.vae.dao.*" %>

<%//cookie
int uid = 1;
Cookie cookie = null;
Cookie[] cookies = null;
// 获取cookies的数据,是一个数组
cookies = request.getCookies();
if( cookies != null ){
   for (int i = 0; i < cookies.length; i++){
      cookie = cookies[i];
      if(cookie.getName().equals("member")){
    	  String str = URLDecoder.decode(cookie.getValue(), "utf-8");
      	  uid = Integer.parseInt(str);
      }
   }
}
%>
<%//接口定义
    ArticleDao atcDao = DaoFactory.getArticleDaoInstance();
	CategoryDao cgDao = DaoFactory.getCategoryDaoInstance();
	CommentDao cmDao = DaoFactory.getCommentDaoInstance();
	MemberDao mbDao = DaoFactory.getMemberDaoInstance();
	MemrecordDao mrDao = DaoFactory.getMemrecordDaoInstance();

	List<Article> atcList = atcDao.findAll();
	List<Category> cgList = cgDao.findAll();
	List<Comment> cmList = cmDao.findAll();
	List<Member> mbList = mbDao.findAll();
	List<Memrecord> mrList = mrDao.findAll();

	Article atc = new Article();
	Category cg = new Category();
	Comment cm = new Comment();
	Member mb = new Member();
	Memrecord mr = new Memrecord();
%>
<%//定义变量
	int totalView = 0;
	int totalComment = 0;
	int totalPost = 0;
	int totalMember = 0;
	StringBuffer blogList = new StringBuffer("");
	StringBuffer commentList = new StringBuffer("");
	StringBuffer memrecordList = new StringBuffer("");
%>

<%
for(Article article:atcList){
  totalPost++;
}
	if(!atcList.isEmpty()){
		Collections.reverse(atcList);
        int count = 0;
		for(Article article:atcList){
			totalView+=article.getReads();
			count++;
			Member member = mbDao.findById(article.getUid());
			blogList.append(
					  String.format("<div class='show-blog-item' style='color:rgb(153, 153, 153)'><span>%d</span><span title='%s'>%s</span><span>%s</span><span>%s</span><span>%s</span><a href='index.jsp?deleteAtc=%s' class='myBtn'><i class='fa fa-remove'></i></a></div>",
					  count,
					  article.getTitle(),
					  article.getTitle(),
					  ""+article.getUid(),
					  article.getCre_time().toString(),
					  article.getCate_name(),
					  article.getTitle()
				  )
			  );
		}
	}
	if(!cmList.isEmpty()){
		Collections.reverse(cmList);
		for(Comment comment:cmList){
			totalComment++;
			commentList.append(
						String.format("<div class='show-blog-item' style='color:rgb(153, 153, 153)'> <span>%d</span><span>%s</span><span title='%s'>%s</span><span title='%s'>%s</span><a href='index.jsp?deleteCom=%d' class='myBtn'><i class='fa fa-remove'></i></a></div>",
								totalComment,
								mbDao.findById(comment.getUid()).getNickname(),
								comment.getCommentdate().toGMTString(),
								comment.getCommentdate().toGMTString(),
								comment.getComment_content(),
								comment.getComment_content(),
								comment.getCommentid()
								)
					);
		}
	}
	if(!mbList.isEmpty()){
		for(Member member:mbList){
			totalMember++;
		}
	}
	if(!mrList.isEmpty()){
		Collections.reverse(mrList);
		int countMr = 0;
		for(Memrecord memrecord:mrList){
			countMr++;
			memrecordList.append(
					String.format("<div class='show-visit-item' style='color:rgb(153, 153, 153)'><span>%d</span><span>%s</span><span title='%s'>%s</span></div>",
							countMr,
							mbDao.findById(memrecord.getUid()).getNickname(),
							memrecord.getVisit_time().toGMTString(),
							memrecord.getVisit_time().toGMTString()
							)
					);
		}
	}
%>
<%request.setCharacterEncoding("utf-8");
	if(request.getMethod().equalsIgnoreCase("post")){
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String category = request.getParameter("category");
		boolean isUpdate = false;
		for(Article article:atcList){
			if(article.getTitle().equals(title)){
				isUpdate = true;
				article.setCate_name(category);
				article.setContent(content);
				atcDao.updateStr(article);
			}
		}
		if(!isUpdate){
			int id = totalPost+1;
			atc.setArticleURL("page?id="+id);
			atc.setCate_name(category);
			atc.setContent(content);
			java.util.Date ud = new java.util.Date();
			java.sql.Date cre_time = new java.sql.Date(ud.getTime());
			atc.setCre_time(cre_time);
			atc.setReads(0);
			atc.setTitle(title);
			atc.setUid(uid);
			atc.setArtid(id);
			atc.setRank(id);
			atcDao.add(atc);
			
			//rank
			int count = 0;
			Collections.reverse(atcList);
			for(Article article:atcList){
				count++;
				atcDao.updateRank(article.getTitle(), count);
			}
			//rank end
		}
		
	}
	if(request.getMethod().equalsIgnoreCase("get")){
		String deleteAtc = request.getParameter("deleteAtc");
		if(deleteAtc!=null){
			atcDao.delete(deleteAtc);
			//rank
			int count = 0;
			Collections.reverse(atcList);
			for(Article article:atcList){
				count++;
				atcDao.updateRank(article.getTitle(), count);
			}
			//rank end
		}
		
		String deleteCom = request.getParameter("deleteCom");
		int id = Integer.parseInt(deleteCom);
		if(deleteCom!=null){
			cmDao.delete(id);
		}
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyBlog -- 管理员系统</title>

<link rel="stylesheet" href="../../asset/css/font-awesome.min.css">
<link rel="stylesheet" href="../../asset/css/manager_page.css">
<script>
</script>
</head>
<body>
  <header id="header">
    <nav id="nav" class="wrapper">
      <div class="nav-logo">
        <a href="/myBlog"><span>MyBlog Database</span></a>
      </div>
      <div class="navbar">
        <ul>
          <li><a href="#"><i class="fa fa-user fa-fw"></i>&nbsp; root</a></li>
          <li><a href="/myBlog"><i class="fa fa-sign-out fa-fw"></i>&nbsp; quit</a></li>
        </ul>
      </div>
    </nav>
  </header>
	<div class="show-Data">
	  <div class="show-Data-item">
	    <%-- 总访问量 --%>
      <div class="show-Data-item-icon" style="background: rgb(240, 80, 80);">
        <i class="fa fa-fire"></i>
      </div>
      <div class="show-Data-item-text">
        <h1><%=totalView %></h1>
        <p>Total View</p>
      </div>
	  </div>
    <div class="show-Data-item">
      <%-- 总评论数目 --%>
      <div class="show-Data-item-icon" style="background: rgb(114, 102, 186);">
        <i class="fa fa-send"></i>
      </div>
      <div class="show-Data-item-text">
        <h1><%=totalComment %></h1>
        <p>Total Comment</p>
      </div>
    </div>
    <div class="show-Data-item">
      <%-- 总文章数 --%>
      <div class="show-Data-item-icon" style="background: rgb(35, 183, 229);">
        <i class="fa fa-pencil"></i>
      </div>
      <div class="show-Data-item-text">
        <h1><%=totalPost %></h1>
        <p>Total Post</p>
      </div>
    </div>
    <div class="show-Data-item">
      <%-- 总注册人数 --%>
      <div class="show-Data-item-icon" style="background: rgb(39, 194, 76);">
        <i class="fa fa-group"></i>
      </div>
      <div class="show-Data-item-text">
        <h1><%=totalMember %></h1>
        <p>Total Member</p>
      </div>
    </div>
	</div>
<div class="clear"></div>


  <section>
    <div class="show-blog">
      <div class="show-blog-header">
        <span>Blog List</span>
      </div>
      <div class="show-blog-item">
        <span>#</span><span>Title</span><span>Author</span><span>Time</span><span>Category</span>
      </div>
      <%=blogList %>
      <%-- <div class="show-blog-item" style="color:rgb(153, 153, 153)">
        <span>#</span><span>Title</span><span>Author</span><span>Time</span><span>Category</span>
        <a href="#" class="myBtn"><i class="fa fa-remove"></i></a>
      </div> --%>
    </div>

    <div class="edit-blog">
      <div class="edit-blog-header">
        <span>Blog Edit</span>
      </div>
      <div class="edit-blog-form-div">
        <form class="edit-blog-form" action="index.jsp" method="post">
          <span>Title:</span> <input type="text" name="title" value=""><br>
          <span>Content:</span> <input type="text" name="content" value=""><br>
          <span>Category:</span> <input type="text" name="category" value=""><br>
          <br><br>
          <input class="myBtn" type="submit" name="" value="Submit"><br>
        </form>
      </div>
    </div>

    <div class="show-blog">
      <div class="show-blog-header">
        <span>Comment List</span>
      </div>
      <div class="show-blog-item">
        <span>#</span><span>User</span><span>Time</span><span>Content</span>
      </div>
      <%=commentList %>
      <%-- <div class="show-blog-item show-cm-item" style="color:rgb(153, 153, 153)">
        <span>#</span><span>User</span><span>Time</span><span>Content</span>
        <a href="#" class="myBtn"><i class="fa fa-remove"></i></a>
      </div> --%>
    </div>

    <div class="show-visit">
      <div class="show-blog-header">
        <span>Visit</span>
      </div>
      <div class="show-visit-item">
        <span>#</span><span>User</span><span>Time</span>
      </div>
      <%=memrecordList %>
    </div>
  </section>
  <div class="clear"></div>
  <%-- footer --%>
  <footer id="footer">
    <div class="wrapper">
      <p>Copyright © 2017 15352344. All Rights Reserved. <a href="index.jsp" title="myBlog" target="_blank">MyBlog</a></p>
    </div>
  </footer>
</body>
</html>
