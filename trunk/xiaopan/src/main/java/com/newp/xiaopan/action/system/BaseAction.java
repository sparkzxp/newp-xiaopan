package com.newp.xiaopan.action.system;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.newp.xiaopan.bean.system.User;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.common.PropertiesUtil;
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
	 * 下载文件
	 * 
	 * @author 张霄鹏
	 * @param filePath
	 *            文件路径（带文件名）
	 * @param fileName
	 *            重命名的文件名
	 * @param isRename
	 *            是否重命名
	 */
	public void ajax(String filePath, String fileName, boolean isRename) {
		HttpURLConnection httpUrl = null;
		BufferedInputStream input = null;
		ServletOutputStream output = null;
		try {
			String dfileName = "";
			// 取文件名
			if (isRename) {
				dfileName = fileName + filePath.substring(filePath.lastIndexOf("."));
			} else {
				dfileName = filePath.substring(filePath.lastIndexOf("/") + 1);
			}

			String agent = ServletActionContext.getRequest().getHeader("User-Agent");
			logger.debug(agent);
			boolean isMSIE = (agent != null && agent.indexOf("MSIE") != -1);
			if (isMSIE) {
				dfileName = URLEncoder.encode(dfileName, "UTF-8");
			} else {
				dfileName = new String(dfileName.getBytes("GBK"), "ISO-8859-1");
			}
//			dfileName = new String(dfileName.getBytes("GBK"), "ISO-8859-1");

			Properties properties = PropertiesUtil.getProperties(Constants.FTP_CONFIG_FILE);
			URL url = new URL(properties.getProperty(Constants.FTP_SERVER) + filePath);
			httpUrl = (HttpURLConnection) url.openConnection();
			// 连接指定的网络资源
			httpUrl.connect();
			// **************产生输入流和输出流*************//
			input = new BufferedInputStream(httpUrl.getInputStream());
			HttpServletResponse response = ServletActionContext.getResponse();
			response.addHeader("Content-Disposition", "attachment; filename=" + dfileName);
			response.setContentType("application/octet-stream");
			output = response.getOutputStream();
			byte[] block = new byte[1024];
			int len = 0;

			// **************开始下载文件*****************//
			while ((len = input.read(block)) != -1) {
				output.write(block, 0, len);
			}
			output.flush();
		} catch (IOException e) {
			this.logger.error("文件下载时出错", e);
		} finally {
			try {
				if (output != null) {
					output.close();
				}
				if (input != null) {
					input.close();
				}
				if (httpUrl != null) {
					httpUrl.disconnect();
				}
			} catch (Exception e) {
				logger.error("连接关闭出错", e);
			}
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
