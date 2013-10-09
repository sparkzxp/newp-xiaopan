package com.newp.xiaopan.action.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.json.simple.JSONObject;

import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.bean.system.User;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.common.bean.Pager;
import com.opensymphony.xwork2.ActionSupport;

/**
 * action 基类,内部可添加公用方法
 */
public class BaseAction extends ActionSupport {
	private static final long serialVersionUID = -1210487690202887835L;
	private Logger logger = Logger.getLogger(this.getClass());

	protected JSONObject msg = new JSONObject();
	protected Pager pager;

	/**
	 * 获取当前登录的用户
	 * 
	 * @return
	 */
	public User getLoginUser() {
		Object obj = getCurrentSession().getAttribute(Constants.SESSION_USER_KEY);
		return obj == null ? null : (User) obj;
	}

	public Site getLoginUserSite() {
		Object obj = getCurrentSession().getAttribute(Constants.SESSION_USER_SITE);
		return obj == null ? null : (Site) obj;
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

	/**
	 * 成功的时候回写KindEditor。
	 */
	public boolean makeSuccessRespForKE(HttpServletResponse resp) {
		// resp.setContentType("text/xml;charset=UTF-8");去除 否则会在谷歌火狐下上传失败
		PrintWriter out = null;
		try {
			out = resp.getWriter();
			out.write(msg.toJSONString());
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		} finally {
			if (out != null) {
				out.close();
			}
		}
		return true;
	}

	/**
	 * 返回Json
	 * 
	 * @param message
	 * @return
	 */
	// 这里封装好json数据error 1 表示错误，message 表示错误信息。
	@SuppressWarnings("unchecked")
	protected void getError(String message) {
		msg.put("error", 1);
		msg.put("message", message);
	}

	/**
	 * @return the msg
	 */
	public JSONObject getMsg() {
		return msg;
	}

	/**
	 * @param msg
	 *            the msg to set
	 */
	public void setMsg(JSONObject msg) {
		this.msg = msg;
	}

	public Pager getPager() {
		if (null == pager) {
			pager = new Pager();
		}
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}
}
