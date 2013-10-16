package com.newp.xiaopan.action.system;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Comment;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.ICommentService;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class CommentAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private ICommentService commentService;

	private Comment comment;
	private List<Comment> comments;

	public String toList() {
		Map<String, Object> params = new HashMap<String, Object>();
		this.getComment().setIsDelete("0");
		params.put("comment", this.getComment());
		params.put("pager", this.getPager());
		comments = this.commentService.queryList(params);
		return Constants.ACTION_TO_LIST;
	}

	public void doReply() {
		comment.setReplyDT(new Timestamp(new Date().getTime()));
		this.commentService.updatePart(comment);
		this.ajax(true);
	}

	public void doDelete() {
		comment.setIsDelete("1");
		this.commentService.delete(comment);
		this.ajax(true);
	}

	/**
	 * @return the comments
	 */
	public List<Comment> getComments() {
		return comments;
	}

	/**
	 * @param comments
	 *            the comments to set
	 */
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	/**
	 * @return the comment
	 */
	public Comment getComment() {
		if (comment == null) {
			comment = new Comment();
		}
		return comment;
	}

	/**
	 * @param comment
	 *            the comment to set
	 */
	public void setComment(Comment comment) {
		this.comment = comment;
	}
}
