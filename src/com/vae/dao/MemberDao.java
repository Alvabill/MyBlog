package com.vae.dao;

import java.sql.SQLException;
import java.util.List;

import com.vae.domain.Member;

public interface MemberDao {
	//添加方法
	public void add(Member mb)throws SQLException;
	
	//更新方法
	public void update(Member mb)throws SQLException;
	
	//删除方法
	public void delete(int uid)throws SQLException;
	
	//查找方法
	public Member findById(int uid)throws SQLException;
	
	//查找所有
	public List<Member> findAll()throws SQLException;
	
}
