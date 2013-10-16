package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.Comment;
import com.newp.xiaopan.dao.system.ICommentDao;

/**
 * @author 张霄鹏
 */
@Repository
public class CommentDao implements ICommentDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Comment> query(Map<String, Object> params) {
		return this.sqlSession.selectList("commentNpc.query", params);
	}

	public String add(Comment comment) {
		this.sqlSession.insert("commentNpc.add", comment);
		return String.valueOf(comment.getId());
	}

	public Integer updatePart(Comment comment) {
		return this.sqlSession.update("commentNpc.updatePart", comment);
	}
}
