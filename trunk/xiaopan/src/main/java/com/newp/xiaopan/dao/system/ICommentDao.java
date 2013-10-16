package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.Comment;

/**
 * @author 张霄鹏
 */
public interface ICommentDao {

	List<Comment> query(Map<String, Object> params);

	String add(Comment comment);

	Integer updatePart(Comment comment);
}
