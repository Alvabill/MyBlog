package com.vae.domain;

import java.sql.Date;

public class Memrecord{
	private int id;
	private String ip;
	private Date visit_time;
	private int uid;
	private int visit_uid;

	public Memrecord() {
		super();
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getId() {
		return id;
	}
	
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	public String getIp() {
		return ip;
	}
	
	public void setVisit_time(Date visit_time) {
		this.visit_time = visit_time;
	}
	
	public Date getVisit_time() {
		return visit_time;
	}
	
	public void setUid(int uid) {
		this.uid = uid;
	}
	
	public int getUid() {
		return uid;
	}
	
	public void setVisit_uid(int visit_uid) {
		this.visit_uid = visit_uid;
	}
	
	public int getVisit_uid() {
		return visit_uid;
	}
}