package com.newp.xiaopan.bean.system;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * 用户实体
 */
public class User extends BaseBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private String username;// 姓名
	private String password;// 密码
	private Timestamp registerDate;// 注册日期
	private Timestamp loginDate;// 登录日期
	private Role role;

	public User() {
		super();
	}

	public User(String id) {
		super();
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Timestamp getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Timestamp registerDate) {
		this.registerDate = registerDate;
	}

	public Timestamp getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(Timestamp loginDate) {
		this.loginDate = loginDate;
	}

	/**
	 * @return the role
	 */
	public Role getRole() {
		return role;
	}

	/**
	 * @param role
	 *            the role to set
	 */
	public void setRole(Role role) {
		this.role = role;
	}

}
