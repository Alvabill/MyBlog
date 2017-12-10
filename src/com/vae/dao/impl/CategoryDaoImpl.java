package com.vae.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.db.DBUtils;
import com.vae.dao.CategoryDao;
import com.vae.domain.Category;


public class CategoryDaoImpl implements CategoryDao{

	@Override
	public void add(Category cg) throws SQLException {
		Connection conn = null;
	    PreparedStatement ps = null;
	    String sql = "insert into category(name)values(?)";
	    try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, cg.getName());
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("添加数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}
	}

	@Override
	public void update(Category cg) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "update category set name=? where id=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, cg.getName());
			ps.setInt(2, cg.getId());
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("更新数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}	
	}

	@Override
	public void delete(int id) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from category where id=?";
		try {
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("删除数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}	
	}

	@Override
	public Category findById(int id) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Category cg = null;
		String sql = "select name from category where id=?";
		try {
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			if(rs.next()) {
				cg = new Category();
				cg.setName(rs.getString(1));
				cg.setId(id);
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("根据ID查询数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}
		return cg;
	}

	@Override
	public List<Category> findAll() throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Category cg = null;
		List<Category> categorys = new ArrayList<Category>();
		String sql = "select name from category";
		try {
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				cg = new Category();
				cg.setName(rs.getString(1));
				categorys.add(cg);
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("查询所有数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}
		return categorys;
	}

}