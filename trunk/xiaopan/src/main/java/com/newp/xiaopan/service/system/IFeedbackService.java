package com.newp.xiaopan.service.system;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Feedback;

/**
 * @author 张霄鹏
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface IFeedbackService {

	Feedback query(Feedback feedback);

	/**
	 * @param 1,feedback;2,pager
	 */
	List<Feedback> queryList(Map<String, Object> params);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(Feedback feedback);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer updatePart(Feedback feedback);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer delete(Feedback feedback);
}
