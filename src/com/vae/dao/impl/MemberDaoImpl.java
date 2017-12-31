package com.vae.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.db.DBUtils;
import com.vae.dao.MemberDao;
import com.vae.domain.Member;

public class MemberDaoImpl implements MemberDao{

	@Override
	public void add(Member mb) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "insert into member(role_code,password,account,url,nickname)values(?,?,?,?,?)";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, mb.getRole_code());
			ps.setString(2, mb.getPassword());
			ps.setString(3, mb.getAccount());
			ps.setString(4, mb.getUrl());
			ps.setString(5, mb.getNickname());
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("添加数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}
	}

	@Override
	public void update(Member mb) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "update member set role_code=?,password=?,account=?,url=?,nickname=? where uid=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, mb.getRole_code());
			ps.setString(2, mb.getPassword());
			ps.setString(3, mb.getAccount());
			ps.setString(4, mb.getUrl());
			ps.setString(5, mb.getNickname());
			ps.setInt(8, mb.getUid());
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("更新数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}		
	}

	@Override
	public void delete(int uid) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from member where id=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1,uid);
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException(" 删除数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}	
	}
	@Override
	public void deleteUser(String userName) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from member where nickname=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1,userName);
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException(" 删除数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}	
	}
	
	@Override
	public Member findById(int uid) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Member mb = null;
		String sql = "select role_code,password,account,url,nickname from member where uid=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, uid);
			rs = ps.executeQuery();
			if(rs.next()){
				mb = new Member();
				mb.setRole_code(rs.getString(1));
				mb.setPassword(rs.getString(2));
				mb.setAccount(rs.getString(3));
				mb.setUrl(rs.getString(4));
				mb.setNickname(rs.getString(5));
				mb.setUid(uid);
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("根据ID查询数据失败");
		}finally{
			DBUtils.close(rs, ps, conn);
		}
		return mb;
	}

	@Override
	public List<Member> findAll() throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Member mb = null;
		List<Member> members = new ArrayList<Member>();
		String sql = "select role_code,password,account,url,nickname from member";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				mb = new Member();
				mb.setRole_code(rs.getString(1));
				mb.setPassword(rs.getString(2));
				mb.setAccount(rs.getString(3));
				mb.setUrl(rs.getString(4));
				mb.setNickname(rs.getString(5));
				members.add(mb);
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("查询所有数据失败");
		}finally{
			DBUtils.close(rs, ps, conn);
		}
		return members;
	}



}