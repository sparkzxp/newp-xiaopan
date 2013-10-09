package com.newp.xiaopan.action.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Resource;
import com.newp.xiaopan.bean.system.Role;
import com.newp.xiaopan.bean.system.User;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.common.MD5;
import com.newp.xiaopan.service.system.IResourceService;
import com.newp.xiaopan.service.system.IRoleService;
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
	@Autowired
	private IRoleService roleService;
	@Autowired
	private IResourceService resourceService;

	private List<User> users;// 用户集合
	private User user;// 用户对象
	private String failureReason;// login页面登录失败原因
	private List<Role> roles;
	private String adminId;

	public String login() {
		if (user == null || StringUtils.isEmpty(user.getUsername()) || StringUtils.isEmpty(user.getPassword())) {
			return Action.LOGIN;
		}

		HttpServletRequest request = ServletActionContext.getRequest();
		String kaptchaExpected = (String) request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		String kaptchaReceived = request.getParameter("kaptcha");
		if (kaptchaReceived == null || !kaptchaReceived.equalsIgnoreCase(kaptchaExpected)) {
			this.failureReason = "验证码错误！";
			return Action.LOGIN;
		}

		User tmp = this.userService.query(user);
		if (tmp != null) {
			if (tmp.getPassword().equals(MD5.MD5_32(user.getPassword()))) {
				// record user info into session
				this.getCurrentSession().setAttribute(Constants.SESSION_USER_KEY, tmp);
				this.getCurrentSession().setAttribute(Constants.SESSION_USER_SITE, tmp.getRole().getSite());
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
	 * user logout
	 * 
	 * @author 张霄鹏
	 */
	public String logout() {
		ServletActionContext.getRequest().getSession().invalidate();
		return Action.LOGIN;
	}

	public String toManagePwd() {
		return "toManagePwd";
	}

	public void doManagePwd() {
		user.setPassword(MD5.MD5_32(user.getPassword()));
		if (StringUtils.isEmpty(user.getId())) {
			user.setId(this.getLoginUser().getId());
		}
		this.userService.updatePart(user);
		this.ajax(true);
	}

	public String toList() {
		adminId = Constants.SYS_ADMIN_ID;
		users = this.userService.queryList(null);
		return Constants.ACTION_TO_LIST;
	}

	public String toEdit() {
		if (null != user && StringUtils.isNotEmpty(user.getId())) {
			user = this.userService.query(user);
		}
		roles = this.roleService.queryList(null);
		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings("unchecked")
	public void doEdit() {
		JSONObject jsonObject = new JSONObject();
		if (StringUtils.isEmpty(user.getId())) {
			user.setPassword(MD5.MD5_32(user.getPassword()));
			String id = this.userService.add(user);
			jsonObject.put("result", "success");
			jsonObject.put("id", id);
		} else {
			this.userService.update(user);
			jsonObject.put("result", "success");
			jsonObject.put("id", user.getId());
		}
		this.ajax(jsonObject.toJSONString());
	}

	public void doDelete() {
		this.userService.delete(user);
		this.ajax(true);
	}

	@SuppressWarnings("unchecked")
	public void getResource() {
		List<Resource> resources = this.resourceService.queryList(null, this.getLoginUser().getRole());
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject;
		if (CollectionUtils.isNotEmpty(resources)) {
			for (Resource t : resources) {
				jsonObject = new JSONObject();
				jsonObject.put("resourceName", t.getName());
				jsonArray.add(jsonObject);
			}
		}
		this.ajax(jsonArray.toJSONString());
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

	public String getFailureReason() {
		return failureReason;
	}

	public void setFailureReason(String failureReason) {
		this.failureReason = failureReason;
	}

	/**
	 * @return the roles
	 */
	public List<Role> getRoles() {
		return roles;
	}

	/**
	 * @param roles
	 *            the roles to set
	 */
	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	/**
	 * @return the adminId
	 */
	public String getAdminId() {
		return adminId;
	}

	/**
	 * @param adminId
	 *            the adminId to set
	 */
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

}
