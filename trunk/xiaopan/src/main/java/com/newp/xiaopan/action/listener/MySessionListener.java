package com.newp.xiaopan.action.listener;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;

import com.newp.xiaopan.common.Constants;

/**
 * @author 张霄鹏
 * @version 创建时间：2012-12-13 上午10:59:24
 */
public class MySessionListener implements HttpSessionListener {

	private static Logger logger = Logger.getLogger(MySessionListener.class);
	public static Map<String, HttpSession> sessionMap_s = new HashMap<String, HttpSession>();
	public static Map<String, Object> configMap_s = new HashMap<String, Object>();

	/**
	 * @author 张霄鹏
	 */
	public void sessionCreated(HttpSessionEvent sessionEvent) {
		HttpSession session = sessionEvent.getSession();
		try {
			// 当session生成时，加入标识
			session.setAttribute(Constants.SESSION_USER_MARK, "INITIAL_VALUE");
			sessionMap_s.put(session.getId(), session);

			// 系统参数缓存
//			if (configMap_s.isEmpty()) {
//				configMap_s.put(Constants.SESSION_CONFIG_TOP_LOV_ID, LovReaderUtil.getTopLov());
//				configMap_s.put(Constants.SESSION_QUERY_DATER, LovReaderUtil.getQueryDate());
//			}
			logger.info("Session创建:" + session);
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
			logger.info("Session过期: " + session + "已销毁");
			sessionMap_s.remove(session.getId());
			session.setAttribute(Constants.SESSION_USER_KEY, null);
			session.setAttribute(Constants.SESSION_USER_MARK, null);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
}
