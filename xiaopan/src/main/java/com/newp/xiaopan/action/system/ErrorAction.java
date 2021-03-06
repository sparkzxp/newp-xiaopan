package com.newp.xiaopan.action.system;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.common.MobileUtil;

/**
 * @author 张霄鹏
 * @version 创建时间：2013-9-9 下午2:53:11
 */
@Controller
public class ErrorAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLogger(getClass());

	public String toExceptionError() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String userAgent = "";
		Enumeration<String> headerNames = request.getHeaderNames();
		while (headerNames.hasMoreElements()) {
			String headerName = (String) headerNames.nextElement();
			if (headerName.equals("user-agent")) {
				userAgent = request.getHeader(headerName);
				break;
			}
		}
//		String browser = Constants.ANDROID_IPHONE_BAIDUTC_FILTER;
		System.out.println(userAgent.toUpperCase());
		log.info(userAgent.toUpperCase());

//		if (userAgent.toUpperCase().matches(browser)) {
		if(MobileUtil.CheckAgent(userAgent)) {
			return "mobile";
		} else {
			return "toExceptionError";
		}
	}
}
