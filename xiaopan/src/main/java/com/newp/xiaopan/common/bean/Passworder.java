package com.newp.xiaopan.common.bean;

/**
 * @author 张霄鹏
 * @version 创建时间：2012-12-12 下午5:15:00
 */
public class Passworder {

	private String originalPwd;
	private String newPwd;
	private String repeatPwd;

	public String getOriginalPwd() {
		return originalPwd;
	}

	public void setOriginalPwd(String originalPwd) {
		this.originalPwd = originalPwd;
	}

	public String getNewPwd() {
		return newPwd;
	}

	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}

	public String getRepeatPwd() {
		return repeatPwd;
	}

	public void setRepeatPwd(String repeatPwd) {
		this.repeatPwd = repeatPwd;
	}
}
