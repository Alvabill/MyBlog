package com.vae.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.db.DBUtils;
import com.vae.dao.CommentDao;
import com.vae.domain.Comment;

public class CommentDaoImol implements CommentDao{

	@Override
	public void add(Comment cm) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "insert into comment(commentdate, comment_content, art_id, uid)values(?, ?, ?, ?)";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setTimestamp(1, cm.getCommentdate());
			ps.setString(2, cm.getComment_content());
			ps.setInt(3, cm.getArt_id());
			ps.setInt(4, cm.getUid());
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("添加数据失败");
		}finally{
			DBUtils.close(null, ps, conn);
		}
	}

	@Override
	public void delete(int id) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from comment where id=?";
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
	public Comment findById(int id) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Comment cm = null;
		String sql = "select commentdate,comment_content,art_id,uid from comment where commentid=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			if(rs.next()){
				cm = new Comment();
				cm.setCommentdate(rs.getTimestamp(1));
				cm.setComment_content(rs.getString(2));
				cm.setArt_id(rs.getInt(3));
				cm.setUid(rs.getInt(4));
				cm.setCommentid(id);
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("根据ID查询数据失败");
		}finally{
			DBUtils.close(rs, ps, conn);
		}
		return cm;
	}

	@Override
	public List<Comment> findByArtId(int art_id)throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Comment cm = null;
		List<Comment> comments = new ArrayList<Comment>(); 
		String sql = "select commentdate,comment_content,uid from comment where art_id=?";
		try{
			conn = DBUtils.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, art_id);
			rs = ps.executeQuery();
			while(rs.next()){
				cm = new Comment();
				cm.setCommentdate(rs.getTimestamp(1));
				cm.setComment_content(rs.getString(2));
				cm.setUid(rs.getInt(3));
				cm.setArt_id(art_id);
				comments.add(cm);
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new SQLException("根据ID查询数据失败");
		}finally{
			DBUtils.close(rs, ps, conn);
		}
		return comments;	
	}

	@Override
	public List<Comment> findAll() throws SQLException {
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			Comment cm = null;
			List<Comment> comments = new ArrayList<Comment>(); 
			String sql = "select commentdate,comment_content,uid,art_id from comment";
			try{
				conn = DBUtils.getConnection();
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next()){
					cm = new Comment();
					cm.setCommentdate(rs.getTimestamp(1));
					cm.setComment_content(rs.getString(2));
					cm.setUid(rs.getInt(3));
					cm.setArt_id(rs.getInt(4));
					comments.add(cm);
				}
			}catch(SQLException e){
				e.printStackTrace();
				throw new SQLException("查询所有数据失败");
			}finally{
				DBUtils.close(rs, ps, conn);
			}
			return comments;
	}
}