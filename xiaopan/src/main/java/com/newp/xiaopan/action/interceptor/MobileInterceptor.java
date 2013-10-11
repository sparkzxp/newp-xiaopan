package com.newp.xiaopan.action.interceptor;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.newp.xiaopan.common.Constants;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

/**
 * @author 张霄鹏
 */
public class MobileInterceptor extends MethodFilterInterceptor {
	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLogger(getClass());

	/**
	 * @author 张霄鹏
	 */
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		ActionContext ctx = invocation.getInvocationContext();

		HttpServletRequest request = (HttpServletRequest) ctx.get(ServletActionContext.HTTP_REQUEST);

		String userAgent = "";
		Enumeration<String> headerNames = request.getHeaderNames();
		while (headerNames.hasMoreElements()) {
			String headerName = (String) headerNames.nextElement();
			if (headerName.equals("user-agent")) {
				userAgent = request.getHeader(headerName);
				break;
			}
		}

		String browser = Constants.ANDROID_IPHONE_BAIDUTC_FILTER;
//		UC MOZILLA/5.0 (LINUX; U; ANDROID 4.0.4; ZH-CN; LT26I BUILD/6.1.A.0.452) APPLEWEBKIT/534.31 (KHTML, LIKE GECKO) UCBROWSER/9.2.3.324 U3/0.8.0 MOBILE SAFARI/534.31
//		360 MOZILLA/5.0 (LINUX; U; ANDROID 4.0.4; ZH-CN; LT26I BUILD/6.1.A.0.452) APPLEWEBKIT/534.30 (KHTML, LIKE GECKO) VERSION/4.0 MOBILE SAFARI/534.30; 360BROWSER(SECURITYPAY,SECURITYINSTALLED); 360(ANDROID,UPPAYPLUGIN); 360 APHONE BROWSER (4.8.3)
//		QQ MOZILLA/5.0 (LINUX; U; ANDROID 4.0.4; ZH-CN; LT26I BUILD/6.1.A.0.452) APPLEWEBKIT/533.1 (KHTML, LIKE GECKO)VERSION/4.0 MQQBROWSER/4.4 MOBILE SAFARI/533.1
//		BAIDU MOZILLA/5.0 (LINUX; U; ANDROID 4.0.4; ZH-CN; LT26I BUILD/6.1.A.0.452) APPLEWEBKIT/534.30 (KHTML, LIKE GECKO) VERSION/4.0 MOBILE SAFARI/534.30 BAIDUBROWSER/4.0.7.9 (BAIDU; P1 4.0.4)
//		IPHONE4 MOZILLA/5.0 (IPHONE; CPU IPHONE OS 6_1_3 LIKE MAC OS X) APPLEWEBKIT/536.26 (KHTML, LIKE GECKO) VERSION/6.0 MOBILE/10A523 SAFARI/8536.25
//		BAIDU TRANSCODER MOZILLA/5.0 (WINDOWS; U; WINDOWS NT 5.1; ZH-CN; RV:1.9.2.8;BAIDU TRANSCODER) GECKO/20100722 FIREFOX/3.6.8 ( .NET CLR 3.5.30729)
		System.out.println(userAgent.toUpperCase());
		log.info(userAgent.toUpperCase());
//		log.debug(userAgent.toUpperCase().matches(browser));

		if (userAgent.toUpperCase().matches(browser)) {
			return "mobile";
		} else {
			return invocation.invoke();
		}
	}

}
