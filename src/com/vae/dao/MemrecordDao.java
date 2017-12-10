package com.vae.dao;

import java.sql.SQLException;
import java.util.List;

import com.vae.domain.Memrecord;

public interface MemrecordDao {
	//添加方法
	public void add(Memrecord mr)throws SQLException;
	
	//更新方法
	public void update(Memrecord mr)throws SQLException;
	
	//删除方法
	public void delete(int id)throws SQLException;
	
	//查找方法
	public Memrecord findById(int id)throws SQLException;
	public List<Memrecord> findByUid(int uid)throws SQLException;
	public List<Memrecord> findByVisiteUid(int visit_uid)throws SQLException;
	
	//查找所有
	public List<Memrecord> findAll()throws SQLException;
	
}
