package com.vae.domain;

import java.sql.Date;

public class Comment{
	private int commentid;
	private Date commentdate;
	private String comment_content;
	private int art_id;
	private int uid;
	
	public Comment() {
		super();
	}
	
	public void setCommentid(int commentid) {
		this.commentid = commentid;
	}
	
	public int getCommentid() {
		return commentid;
	}
	
	public void setCommentdate(Date commentdate) {
		this.commentdate = commentdate;
	}
	
	public Date getCommentdate() {
		return commentdate;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	
	public String getComment_content() {
		return comment_content;
	}
	
	public void setArt_id(int art_id) {
		this.art_id = art_id;
	}
	
	public int getArt_id() {
		return art_id;
	}
	
	public void setUid(int uid) {
		this.uid = uid;
	}
	
	public int getUid() {
		return uid;
	}
}