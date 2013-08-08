package com.newp.xiaopan.action.system;

import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.BaseBean;

/**
 * @author 张霄鹏
 */
@Controller
public class AdminAction extends BaseBean {

	private static final long serialVersionUID = 1L;

	public String login() {
		return "login";
	}
}
