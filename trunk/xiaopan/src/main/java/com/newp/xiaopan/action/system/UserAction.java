package com.newp.xiaopan.action.system;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.User;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.common.MD5;
import com.newp.xiaopan.common.bean.Pager;
import com.newp.xiaopan.common.bean.Passworder;
import com.newp.xiaopan.service.system.IUserService;
import com.opensymphony.xwork2.Action;

/**
 * 用户管理
 */
@Controller
@Scope(value = "prototype")
public class UserAction extends BaseAction {
	private static final long serialVersionUID = 7054055956492130575L;

	@Autowired
	private IUserService userService;// user业务对象

	private List<User> users;// 用户集合
	private User user;// 用户对象
	private Pager pager;// 分页对象
	private Passworder passworder;// 密码对象
	private String failureReason;// login页面登录失败原因

	public String login() {
		if (user == null || StringUtils.isEmpty(user.getUsername()) || StringUtils.isEmpty(user.getPassword())) {
			return Action.LOGIN;
		}
		User tmp = this.userService.query(user);
		if (tmp != null) {
			if (tmp.getPassword().equals(MD5.MD5_32(user.getPassword()))) {
				// record user info into session
				this.getCurrentSession().setAttribute(Constants.SESSION_USER_KEY, tmp);
				user = tmp;
				return "toLogin";
			} else {
				this.failureReason = "密码输入错误！";
			}
		} else {
			this.failureReason = "用户已失效或不存在！";
		}
		return Action.LOGIN;
	}

	/**
	 * user logout(didn't distinguish company and government)
	 * 
	 * @author 张霄鹏
	 * @return
	 */
	public void logout() {
		this.ajax(Action.SUCCESS);
		ServletActionContext.getRequest().getSession().invalidate();
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public Passworder getPassworder() {
		return passworder;
	}

	public void setPassworder(Passworder passworder) {
		this.passworder = passworder;
	}

	public String getFailureReason() {
		return failureReason;
	}

	public void setFailureReason(String failureReason) {
		this.failureReason = failureReason;
	}

}
