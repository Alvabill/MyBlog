package com.vae.dao;

import java.sql.SQLException;
import java.util.List;

import com.vae.domain.Article;

public interface ArticleDao {
	//添加方法
	public void add(Article article)throws SQLException;
	
	//更新方法
	public void updateStr(Article article)throws SQLException;
	public void updateRank(String title,int count) throws SQLException;
	public void updateReads(Article article)throws SQLException;
	
	//删除方法
	public void delete(String title)throws SQLException;
	
	//查找方法
	public Article findById(int artid)throws SQLException;
	public List<Article> findByCate_name(String cate_name)throws SQLException;
	
	//查找所有
	public List<Article> findAll()throws SQLException;
	
}
