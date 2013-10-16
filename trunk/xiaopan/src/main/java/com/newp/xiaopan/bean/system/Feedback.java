package com.newp.xiaopan.bean.system;

import java.sql.Timestamp;

/**
 * @author 张霄鹏
 */
public class Feedback extends BaseBean {

	private static final long serialVersionUID = 1L;

	private String feedback;
	private Timestamp feedbackTime;
	private String reply;
	private Timestamp replyTime;
	private String ipAddress;
	private String isDelete;

	/**
	 * @return the feedback
	 */
	public String getFeedback() {
		return feedback;
	}

	/**
	 * @param feedback
	 *            the feedback to set
	 */
	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}

	/**
	 * @return the feedbackTime
	 */
	public Timestamp getFeedbackTime() {
		return feedbackTime;
	}

	/**
	 * @param feedbackTime
	 *            the feedbackTime to set
	 */
	public void setFeedbackTime(Timestamp feedbackTime) {
		this.feedbackTime = feedbackTime;
	}

	/**
	 * @return the reply
	 */
	public String getReply() {
		return reply;
	}

	/**
	 * @param reply
	 *            the reply to set
	 */
	public void setReply(String reply) {
		this.reply = reply;
	}

	/**
	 * @return the replyTime
	 */
	public Timestamp getReplyTime() {
		return replyTime;
	}

	/**
	 * @param replyTime
	 *            the replyTime to set
	 */
	public void setReplyTime(Timestamp replyTime) {
		this.replyTime = replyTime;
	}

	/**
	 * @return the ipAddress
	 */
	public String getIpAddress() {
		return ipAddress;
	}

	/**
	 * @param ipAddress
	 *            the ipAddress to set
	 */
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	/**
	 * @return the isDelete
	 */
	public String getIsDelete() {
		return isDelete;
	}

	/**
	 * @param isDelete
	 *            the isDelete to set
	 */
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}
}
