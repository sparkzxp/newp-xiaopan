package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.Feedback;
import com.newp.xiaopan.dao.system.IFeedbackDao;

/**
 * @author 张霄鹏
 */
@Repository
public class FeedbackDao implements IFeedbackDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Feedback> query(Map<String, Object> params) {
		return this.sqlSession.selectList("feedbackNpc.query", params);
	}

	public String add(Feedback feedback) {
		this.sqlSession.insert("feedbackNpc.add", feedback);
		return String.valueOf(feedback.getId());
	}

	public Integer updatePart(Feedback feedback) {
		return this.sqlSession.update("feedbackNpc.updatePart", feedback);
	}
}
