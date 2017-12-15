package com.vae.dao;

import java.sql.SQLException;
import java.util.List;

import com.vae.domain.Comment;

public interface CommentDao {
	//添加方法
	public void add(Comment cm)throws SQLException;
	
	//更新方法

	//删除方法
	public void delete(int id)throws SQLException;
	
	//查找方法
	public Comment findById(int id)throws SQLException;
	
	public List<Comment> findByArtId(int art_id)throws SQLException;
	public List<Comment> findAll()throws SQLException;
	
}
