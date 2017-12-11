package com.vae.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.db.DBUtils;
import com.vae.dao.ArticleDao;
import com.vae.domain.Article;


public class ArticleDaoImpl implements ArticleDao{

	/**
	 * 实现添加方法
	 */
	@Override
	public void add(Article article) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "insert into article(title,`reads`,cre_time,content,uid,cate_name,articleURL)values(?,?,?,?,?,?,?)";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, article.getTitle());
			ps.setInt(2, 0);
			ps.setDate(3, article.getCre_time());
			ps.setString(4, article.getContent());
			ps.setInt(5, article.getUid());
			ps.setString(6, article.getCate_name());
			ps.setString(7, article.getArticleURL());
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("添加数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}
	}

	/**
	 * 更新方法
	 */
	@Override
	public void updateStr(Article article) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		int type = article.getType();
		String sql = "";
		switch(type) {
		    case 0:
		    	sql = "update article set title=? where artid=?";break;
		    case 1:
		    	sql = "update article set content=? where artid=?";break;
		    case 2:
		    	sql = "update article set cate_name=? where artid=?";break;
		}
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			switch(type) {
			    case 0:ps.setString(1, article.getTitle());break;
			    case 1:ps.setString(1, article.getContent());break;
			    case 2:ps.setString(1, article.getCate_name());break;
			}
			ps.setInt(2, article.getArtid());
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("更新数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}		
	}
	
	public void updateReads(Article article) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "update article set `reads`=? where artid=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, article.getReads());
			ps.setInt(2, article.getArtid());
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("更新数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}	
	}

	/**
	 * 删除方法
	 */
	@Override
	public void delete(int artid) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from article where artid=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1,artid);
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException(" 删除数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}		
	}

	/**
	 * 根据ID查询一个对象
	 */
	@Override
	public Article findById(int artid) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Article atc = null;
		String sql = "select title,`reads`,cre_time,cate_name,content,articleURL from article where artid=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, artid);
			rs = ps.executeQuery();
			if(rs.next()){
				atc = new Article();
				atc.setTitle(rs.getString(1));
				atc.setReads(rs.getInt(2));
				atc.setCre_time(rs.getDate(3));
				atc.setCate_name(rs.getString(4));
				atc.setContent(rs.getString(5));
				atc.setArticleURL(rs.getString(6));
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("根据ID查询数据失败");
		}finally{
			DBUtils.close(rs, ps, conn);
		}
		return atc;
	
	}


	public List<Article> findByCate_name(String cate_name) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Article atc = null;
		List<Article> articles = new ArrayList<Article>();
		String sql = "select title,`reads`,cre_time,content,articleURL from article where cate_name=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, cate_name);
			rs = ps.executeQuery();
			while(rs.next()){
				atc = new Article();
				atc.setTitle(rs.getString(1));
				atc.setReads(rs.getInt(2));
				atc.setCre_time(rs.getDate(3));
				atc.setContent(rs.getString(4));
				atc.setArticleURL(rs.getString(5));
				articles.add(atc);
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("查询所有数据失败");
		}finally{
			DBUtils.close(rs, ps, conn);
		}
		return articles;
		
	}
	/**
	 * 查询所有数据
	 */
	@Override
	public List<Article> findAll() throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Article atc = null;
		List<Article> articles = new ArrayList<Article>();
		String sql = "select title,`reads`,cre_time,cate_name,content,articleURL from article";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				atc = new Article();
				atc.setTitle(rs.getString(1));
				atc.setReads(rs.getInt(2));
				atc.setCre_time(rs.getDate(3));
				atc.setCate_name(rs.getString(4));
				atc.setContent(rs.getString(5));
				atc.setArticleURL(rs.getString(6));
				articles.add(atc);
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("查询所有数据失败");
		}finally{
			DBUtils.close(rs, ps, conn);
		}
		return articles;
	}
		
}