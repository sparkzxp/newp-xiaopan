package com.newp.xiaopan.service.system;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Comment;

/**
 * @author 张霄鹏
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface ICommentService {

	Comment query(Comment comment);

	/**
	 * @param 1,comment;2,pager
	 */
	List<Comment> queryList(Map<String, Object> params);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(Comment comment);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer updatePart(Comment comment);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer delete(Comment comment);
}
