package com.newp.xiaopan.bean.system;

import java.sql.Timestamp;

/**
 * @author 张霄鹏
 */
public class Comment extends BaseBean {

	private static final long serialVersionUID = 1L;

	private String comment;
	private Timestamp commentDT;
	private String reply;
	private Timestamp replyDT;
	private String ipAddress;
	private String isDelete;
	private Shop shop;

	/**
	 * @return the comment
	 */
	public String getComment() {
		return comment;
	}

	/**
	 * @param comment
	 *            the comment to set
	 */
	public void setComment(String comment) {
		this.comment = comment;
	}

	/**
	 * @return the commentDT
	 */
	public Timestamp getCommentDT() {
		return commentDT;
	}

	/**
	 * @param commentDT
	 *            the commentDT to set
	 */
	public void setCommentDT(Timestamp commentDT) {
		this.commentDT = commentDT;
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
	 * @return the replyDT
	 */
	public Timestamp getReplyDT() {
		return replyDT;
	}

	/**
	 * @param replyDT
	 *            the replyDT to set
	 */
	public void setReplyDT(Timestamp replyDT) {
		this.replyDT = replyDT;
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

	/**
	 * @return the shop
	 */
	public Shop getShop() {
		return shop;
	}

	/**
	 * @param shop
	 *            the shop to set
	 */
	public void setShop(Shop shop) {
		this.shop = shop;
	}
}
