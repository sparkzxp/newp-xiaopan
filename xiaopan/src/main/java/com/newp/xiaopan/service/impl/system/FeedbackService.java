package com.newp.xiaopan.service.impl.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.Feedback;
import com.newp.xiaopan.dao.system.IFeedbackDao;
import com.newp.xiaopan.service.system.IFeedbackService;

/**
 * @author 张霄鹏
 */
@Service
public class FeedbackService extends BaseService implements IFeedbackService {

	@Autowired
	private IFeedbackDao feedbackDao;

	public List<Feedback> queryList(Map<String, Object> params) {
		return this.feedbackDao.query(params);
	}

	public Feedback query(Feedback feedback) {
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("feedback", feedback);
		List<Feedback> list = this.queryList(params);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(Feedback feedback) {
		return this.feedbackDao.add(feedback);
	}

	public Integer updatePart(Feedback feedback) {
		return this.feedbackDao.updatePart(feedback);
	}

	public Integer delete(Feedback feedback) {
		feedback.setIsDelete("1");
		return this.feedbackDao.updatePart(feedback);
	}
}
