package com.newp.xiaopan.service.impl.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.Comment;
import com.newp.xiaopan.dao.system.ICommentDao;
import com.newp.xiaopan.service.system.ICommentService;

/**
 * @author 张霄鹏
 */
@Service
public class CommentService extends BaseService implements ICommentService {

	@Autowired
	private ICommentDao commentDao;

	public List<Comment> queryList(Map<String, Object> params) {
		return this.commentDao.query(params);
	}

	public Comment query(Comment comment) {
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("comment", comment);
		List<Comment> list = this.queryList(params);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(Comment comment) {
		return this.commentDao.add(comment);
	}

	public Integer updatePart(Comment comment) {
		return this.commentDao.updatePart(comment);
	}

	public Integer delete(Comment comment) {
		comment.setIsDelete("1");
		return this.commentDao.updatePart(comment);
	}
}
