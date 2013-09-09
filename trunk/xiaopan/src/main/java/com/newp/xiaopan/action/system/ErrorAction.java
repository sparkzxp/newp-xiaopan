package com.newp.xiaopan.action.system;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

/**
 * @author 张霄鹏
 * @version 创建时间：2013-9-9 下午2:53:11
 */
@Controller
public class ErrorAction extends BaseAction {

	private static final long serialVersionUID = 1L;

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
		String browser = ".*(ANDROID.*MOBILE|IPHONE.*MOBILE).*";
		System.out.println(userAgent.toUpperCase());

		if (userAgent.toUpperCase().matches(browser)) {
			return "mobile";
		} else {
			return "toExceptionError";
		}
	}
}
