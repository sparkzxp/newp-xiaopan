package com.newp.xiaopan.action.listener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;

import com.newp.xiaopan.action.web.ConfigReader;
import com.newp.xiaopan.common.Constants;

/**
 * @author 张霄鹏
 * @version 创建时间：2012-12-13 上午10:59:24
 */
public class MySessionListener implements HttpSessionListener {

	private static Logger logger = Logger.getLogger(MySessionListener.class);
//	public static Map<String, HttpSession> sessionMap_s = new HashMap<String, HttpSession>();
	public static Map<String, Object> configMap_s = new HashMap<String, Object>();

	/**
	 * @author 张霄鹏
	 */
	public void sessionCreated(HttpSessionEvent sessionEvent) {
		HttpSession session = sessionEvent.getSession();
		try {
			session.setAttribute(Constants.SESSION_USER_SITE, null);
//			sessionMap_s.put(session.getId(), session);

//			if (configMap_s.isEmpty()) {
//				initConfigMap_s();
//			}
			initConfigMap_s();
			logger.debug("Session创建:" + session);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}

	/**
	 * @author 张霄鹏
	 */
	public void sessionDestroyed(HttpSessionEvent sessionEvent) {
		HttpSession session = sessionEvent.getSession();
		try {
			logger.debug("Session过期: " + session + "已销毁");
//			sessionMap_s.remove(session.getId());
			session.setAttribute(Constants.SESSION_USER_KEY, null);
			session.setAttribute(Constants.SESSION_USER_SITE, null);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}

	private static void initConfigMap_s() {
		configMap_s.put(Constants.CONFIG_SITE_LIST, ConfigReader.querySiteList());
	}

	@SuppressWarnings("rawtypes")
	public static Map<String, Object> getConfigMap_s() {
		if (configMap_s.isEmpty() || CollectionUtils.isEmpty((List) configMap_s.get(Constants.CONFIG_SITE_LIST))) {
			initConfigMap_s();
		}
		return configMap_s;
	}

	public static void setConfigMap_s(Map<String, Object> configMap_s) {
		MySessionListener.configMap_s = configMap_s;
	}

}
