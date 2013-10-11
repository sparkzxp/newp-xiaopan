package com.newp.xiaopan.action.filter;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

/**
 * @author 张霄鹏
 */
public class MobileFilter implements Filter {

	private Logger log = Logger.getLogger(getClass());

	public void destroy() {
		log.debug("Mobile Filter destroy");
	}

	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		log.debug("Mobile Filter doFilter");
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		String servletPath = request.getServletPath();

		String host = "";
		String userAgent = "";
		String xcalling = "";
		Enumeration headerNames = request.getHeaderNames();
		while (headerNames.hasMoreElements()) {
			String headerName = (String) headerNames.nextElement();
			if (headerName.equals("x-up-calling-line-id")) {
				xcalling = request.getHeader(headerName);
			}

			if (headerName.equals("user-agent")) {
				userAgent = request.getHeader(headerName);
			}

			if (headerName.equals("host")) {
				host = request.getHeader(headerName);
			}
		}

		String contextPath = request.getContextPath();
		String browser = ".*(FIREFOX|MSIE).*";
		log.debug(userAgent.toUpperCase());
		log.debug(userAgent.toUpperCase().matches(browser));
		chain.doFilter(req, res);
//		if (StringUtils.isNotBlank(contextPath) && !userAgent.toUpperCase().matches(browser)) {
//			response.sendRedirect(contextPath + StringUtils.defaultIfEmpty(forwardUrl, "/") + "?redirect=");
//		} else {
//			chain.doFilter(req, res);
//		}
	}

	public void init(FilterConfig cfg) throws ServletException {
		log.debug("Mobile Filter init");
	}

}
