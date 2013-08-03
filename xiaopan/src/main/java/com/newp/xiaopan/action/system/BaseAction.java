package com.newp.xiaopan.action.system;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.newp.xiaopan.bean.system.User;
import com.newp.xiaopan.common.Constants;
import com.opensymphony.xwork2.ActionSupport;

/**
 * action 基类,内部可添加公用方法
 */
public class BaseAction extends ActionSupport {
	private static final long serialVersionUID = -1210487690202887835L;
	private Logger logger = Logger.getLogger(this.getClass());

	/**
	 * 获取当前登录的用户
	 * 
	 * @return
	 */
	public User getLoginUser() {
		Object obj = getCurrentSession().getAttribute(Constants.SESSION_USER_KEY);
		return obj == null ? null : (User) obj;
	}

	/**
	 * 获取当前的session
	 * 
	 * @author 张霄鹏
	 */
	public HttpSession getCurrentSession() {
		return ServletActionContext.getRequest().getSession();
	}

	/**
	 * Ajax页面打印所传入的字符串
	 * 
	 * @param content
	 */
	public void ajax(String content) {
		ServletActionContext.getResponse().setCharacterEncoding("UTF-8");
		ServletActionContext.getResponse().setContentType("text/html");
		try {
			ServletActionContext.getResponse().getWriter().write(content);
			ServletActionContext.getResponse().getWriter().flush();
		} catch (IOException e) {
			this.logger.error("响应自定义结果时发生错误:" + content, e);
		}

	}

	public void ajax(boolean rslt) {
		this.ajax(rslt ? "success" : "error");
	}

	public void ajax(byte[] data, String dfileName) {
		try {
			ServletActionContext.getResponse().addHeader("Content-Disposition", "attachment; filename=" + dfileName);
			ServletActionContext.getResponse().setContentType("application/octet-stream");
			ServletActionContext.getResponse().getOutputStream().write(data);
			ServletActionContext.getResponse().getOutputStream().flush();
			ServletActionContext.getResponse().getOutputStream().close();
		} catch (IOException e) {
			this.logger.error("文件下载时出错", e);
		}
	}

	/**
	 * 将以逗号分隔的字符串转换成List<String>
	 * 
	 * @return
	 */
	public List<String> strToList(String str) {
		List<String> strList = new ArrayList<String>();
		try {
			if (!str.isEmpty()) {
				String[] strArray = str.split(",");
				strList = Arrays.asList(strArray);
			}
		} catch (Exception e) {
			this.logger.error("将以逗号分隔的字符串转换成List<String>发生错误!", e);
		}
		return strList;
	}
}
