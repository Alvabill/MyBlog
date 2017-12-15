<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*,java.sql.Timestamp" %>
<%@ page import="com.vae.domain.*" %>
<%@ page import="com.vae.dao.*" %>

    <%
    	request.setCharacterEncoding("utf-8");
        
    	String str = request.getParameter("artID");
    	int art_rank = Integer.parseInt(str);
    	str = request.getParameter("uid");
        int uid = Integer.parseInt(str);
    	String comment_content = request.getParameter("content");
    	
    	CommentDao commentDao = DaoFactory.getCommentDaoInstance();
    	Comment comment = new Comment();
    	comment.setArt_id(art_rank);
    	comment.setComment_content(comment_content);
    	java.util.Date ud = new java.util.Date();
    	java.sql.Date commentdate = new java.sql.Date(ud.getTime());
    	Timestamp ts = new Timestamp(ud.getTime());
    	comment.setCommentdate(ts);
    	comment.setUid(uid);
    	commentDao.add(comment);
    %>