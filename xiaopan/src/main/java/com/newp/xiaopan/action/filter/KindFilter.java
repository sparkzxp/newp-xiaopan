/**
 * 
 */
package com.newp.xiaopan.action.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter;

/**
 * @author 张霄鹏
 * 
 */
public class KindFilter extends StrutsPrepareAndExecuteFilter {

	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		String URI = request.getRequestURI();
		if (URI.contains("Kind")) {
			chain.doFilter(request, resp);
		} else {
			super.doFilter(req, resp, chain);
		}
	}

}
