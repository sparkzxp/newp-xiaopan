package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.Feedback;

/**
 * @author 张霄鹏
 */
public interface IFeedbackDao {

	List<Feedback> query(Map<String, Object> params);

	String add(Feedback feedback);

	Integer updatePart(Feedback feedback);
}
