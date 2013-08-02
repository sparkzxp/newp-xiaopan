package com.newp.xiaopan.action.interceptor;

import java.util.Map;

import com.newp.xiaopan.common.Constants;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

/**
 * @author 张霄鹏
 * @version 创建时间：2012-12-13 上午10:16:57
 */
public class AuthorityInterceptor extends MethodFilterInterceptor {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * @author 张霄鹏
	 */
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		Map<String, Object> session = invocation.getInvocationContext().getSession();
		Object user = session.get(Constants.SESSION_USER_KEY);
		// lov_initTree,si_getIndustryByOrg,si_toEdit方法在注册页面用到，已屏蔽
		if (user != null) {
			return invocation.invoke();
		} else {
			return Action.LOGIN;
		}
	}

}
