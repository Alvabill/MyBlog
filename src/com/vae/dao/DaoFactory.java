package com.vae.dao;
import com.vae.dao.ArticleDao;
import com.vae.dao.CategoryDao;
import com.vae.dao.CommentDao;
import com.vae.dao.MemberDao;
import com.vae.dao.MemrecordDao;
import com.vae.dao.RoleDao;
import com.vae.dao.impl.ArticleDaoImpl;
import com.vae.dao.impl.CategoryDaoImpl;
import com.vae.dao.impl.CommentDaoImol;
import com.vae.dao.impl.MemberDaoImpl;
import com.vae.dao.impl.MemrecordDaoImpl;
import com.vae.dao.impl.RoleDaoImpl;

public class DaoFactory {
	public static ArticleDao getArticleDaoInstance() {
		return new ArticleDaoImpl();
	}
	
	public static CategoryDao getCategoryDaoInstance() {
		return new CategoryDaoImpl();
	}
	
	public static CommentDao getCommentDaoInstance() {
		return new CommentDaoImol();
	}
	public static MemberDao getMemberDaoInstance() {
		return new MemberDaoImpl();
	}
	public static MemrecordDao getMemrecordDaoInstance() {
		return new MemrecordDaoImpl();
	}
	
	public static RoleDao getRoleDaoInstance() {
		return new RoleDaoImpl();
	}

}