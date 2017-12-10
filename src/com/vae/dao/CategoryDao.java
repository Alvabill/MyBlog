package com.vae.dao;

import java.sql.SQLException;
import java.util.List;

import com.vae.domain.Category;

public interface CategoryDao {
	//添加方法
	public void add(Category cg)throws SQLException;
	
	//更新方法
	public void update(Category cg)throws SQLException;
	
	//删除方法
	public void delete(int id)throws SQLException;
	
	//查找方法
	public Category findById(int id)throws SQLException;
	
	//查找所有
	public List<Category> findAll()throws SQLException;
	
}
