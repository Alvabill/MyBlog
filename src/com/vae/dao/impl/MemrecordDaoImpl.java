package com.vae.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.db.DBUtils;
import com.vae.dao.MemrecordDao;
import com.vae.domain.Memrecord;

public class MemrecordDaoImpl implements MemrecordDao{

	@Override
	public void add(Memrecord mr) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "insert into memrecord(ip,visit_time,uid,visit_uid)values(?,?,?,?)";
		try {
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, mr.getIp());
			ps.setTimestamp(2, mr.getVisit_time());
			ps.setInt(3, mr.getUid());
			ps.setInt(4, mr.getVisit_uid());
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("添加数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}
		
	}

	@Override
	public void update(Memrecord mr) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "update memrecord set ip=?,visit_time=?,uid=?,visit_uid=? where id=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, mr.getIp());
			ps.setTimestamp(2, mr.getVisit_time());
			ps.setInt(3, mr.getUid());
			ps.setInt(4, mr.getVisit_uid());
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
		String sql = "delete from memrecord where id=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException(" 删除数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}	
	}

	@Override
	public Memrecord findById(int id) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Memrecord mr = null;
		String sql = "select ip,visit_time,uid,visit_uid from memrecord where id=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			if(rs.next()){
				mr = new Memrecord();
				mr.setIp(rs.getString(1));
				mr.setVisit_time(rs.getTimestamp(2));
				mr.setUid(rs.getInt(3));
				mr.setVisit_uid(rs.getInt(4));
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("根据ID查询数据失败");
		}finally{
			DBUtils.close(rs, ps, conn);
		}
		return mr;
	}

	@Override
	public List<Memrecord> findByUid(int uid) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Memrecord mr = null;
		List<Memrecord> memrecords = new ArrayList<Memrecord>();
		String sql = "select ip,visit_time,visit_uid from memrecord where uid=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, uid);
			rs = ps.executeQuery();
			while(rs.next()){
				mr = new Memrecord();
				mr.setIp(rs.getString(1));
				mr.setVisit_time(rs.getTimestamp(2));
				mr.setVisit_uid(rs.getInt(3));
				memrecords.add(mr);
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("根据ID查询数据失败");
		}finally{
			DBUtils.close(rs, ps, conn);
		}
		return memrecords;
	}

	@Override
	public List<Memrecord> findByVisiteUid(int visit_uid) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Memrecord mr = null;
		List<Memrecord> memrecords = new ArrayList<Memrecord>();
		String sql = "select ip,visit_time,uid from memrecord where visit_uid=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, visit_uid);
			rs = ps.executeQuery();
			while(rs.next()){
				mr = new Memrecord();
				mr.setIp(rs.getString(1));
				mr.setVisit_time(rs.getTimestamp(2));
				mr.setUid(rs.getInt(3));
				memrecords.add(mr);
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("根据ID查询数据失败");
		}finally{
			DBUtils.close(rs, ps, conn);
		}
		return memrecords;
	}

	@Override
	public List<Memrecord> findAll() throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Memrecord mr = null;
		List<Memrecord> memrecords = new ArrayList<Memrecord>();
		String sql = "select ip,visit_time,visit_uid,uid from memrecord";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				mr = new Memrecord();
				mr.setIp(rs.getString(1));
				mr.setVisit_time(rs.getTimestamp(2));
				mr.setVisit_uid(rs.getInt(3));
				mr.setUid(rs.getInt(4));
				memrecords.add(mr);
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("查询所有数据失败");
		}finally{
			DBUtils.close(rs, ps, conn);
		}
		return memrecords;
	}

}