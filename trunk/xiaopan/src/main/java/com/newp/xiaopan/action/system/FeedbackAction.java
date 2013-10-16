package com.newp.xiaopan.action.system;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Feedback;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.IFeedbackService;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class FeedbackAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private IFeedbackService feedbackService;

	private Feedback feedback;
	private List<Feedback> feedbacks;

	public String toList() {
		Map<String, Object> params = new HashMap<String, Object>();
		this.getFeedback().setIsDelete("0");
		params.put("feedback", this.getFeedback());
		params.put("pager", this.getPager());
		feedbacks = this.feedbackService.queryList(params);
		return Constants.ACTION_TO_LIST;
	}

	public void doReply() {
		feedback.setReplyTime(new Timestamp(new Date().getTime()));
		this.feedbackService.updatePart(feedback);
		this.ajax(true);
	}

	public void doDelete() {
		feedback.setIsDelete("1");
		this.feedbackService.delete(feedback);
		this.ajax(true);
	}

	/**
	 * @return the feedbacks
	 */
	public List<Feedback> getFeedbacks() {
		return feedbacks;
	}

	/**
	 * @param feedbacks
	 *            the feedbacks to set
	 */
	public void setFeedbacks(List<Feedback> feedbacks) {
		this.feedbacks = feedbacks;
	}

	/**
	 * @return the feedback
	 */
	public Feedback getFeedback() {
		if (feedback == null) {
			feedback = new Feedback();
		}
		return feedback;
	}

	/**
	 * @param feedback
	 *            the feedback to set
	 */
	public void setFeedback(Feedback feedback) {
		this.feedback = feedback;
	}
}
