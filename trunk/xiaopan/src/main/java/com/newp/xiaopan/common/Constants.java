package com.newp.xiaopan.common;

/**
 * 常量
 * 
 * @author 张霄鹏
 */
public interface Constants {

	String SESSION_USER_KEY = "userInfo";
	String SESSION_USER_SITE = "userSite";
	String SESSION_HOT_KEY = "hotKey";
	String SESSION_SUPORT_SHOP = "suportShop";

	String CONFIG_SITE_LIST = "siteList";

	/**
	 * 页面跳转
	 */
	String ACTION_TO_LIST = "toList";
	String ACTION_TO_EDIT = "toEdit";
	String ACTION_TO_DETAIL = "toDetail";

	String ANDROID_IPHONE_BAIDUTC_FILTER = ".*(ANDROID.*MOBILE|IPHONE.*MOBILE|BAIDU TRANSCODER).*";
}
