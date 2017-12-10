package com.vae.domain;

import java.sql.Date;

public class Article{
	private int artid;  //文章id
	private String title;  //文章标题
	private int reads;  //阅读量
	private Date cre_time;  //创建时间
	private String content;  //文章内容
	private int uid;  //用户id
	private String cate_name;  //分类名称
	
	private int type;
	
	public Article() {
		super();
	}
	
	public Article(String title, int reads, Date cre_time, String content, int uid, String cate_name) {
		super();
		this.title = title;
		this.reads = reads;
		this.cre_time = cre_time;
		this.content = content;
		this.uid = uid;
		this.cate_name = cate_name;
	}
	
	public Article(int type, String str, int artid) {
		super();
		this.type = type;
		switch(type) {
			case 0:this.title = str;break;
			case 1:this.content = str;break;
			case 2:this.cate_name = str;break;
		}
		this.artid = artid;
	}
	
	public Article(int reads, int artid) {
		super();
		this.reads = reads;
		this.artid = artid;
	}
	
	
	public void setArtid(int artid) {
		this.artid = artid;
	}
	
	public int getArtid() {
		return artid;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setReads(int reads) {
		this.reads = reads;
	}
	
	public int getReads() {
		return reads;
	}
	
	public void setCre_time(Date cre_time) {
		this.cre_time = cre_time;
	}
	
	public Date getCre_time() {
		return cre_time;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setUid(int uid) {
		this.uid = uid;
	}
	
	public int getUid() {
		return uid;
	}

	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	
	public String getCate_name() {
		return cate_name;
	}

	public int getType() {
		return type;
	}
}