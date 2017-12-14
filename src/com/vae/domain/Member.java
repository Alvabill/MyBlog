package com.vae.domain;


public class Member{
	private int uid;
	private String role_code;
	private String password;
	private String account;
	private String url;
	private String nickname;
	
	public Member() {
		super();
	}
	
	public void setUid(int uid) {
		this.uid = uid;
	}
	
	public int getUid() {
		return uid;
	}

	public void setRole_code(String role_code) {
		this.role_code = role_code;
	}
	
	public String getRole_code() {
		return role_code;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setAccount(String account) {
		this.account = account;
	}
	
	public String getAccount() {
		return account;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getUrl() {
		return url;
	}
	
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getNickname() {
		return nickname;
	}

}