package com.newp.xiaopan.action.web;

import java.util.List;

import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.service.system.ISiteService;

/**
 * @author 张霄鹏
 */
public class ConfigReader {

	private ISiteService siteService;

	private static ConfigReader configReader;

	public void init() {
		configReader = this;
		configReader.siteService = this.siteService;
	}

	public static List<Site> querySiteList() {
		return configReader.siteService.queryList(null);
	}

	public ISiteService getSiteService() {
		return siteService;
	}

	public void setSiteService(ISiteService siteService) {
		this.siteService = siteService;
	}

	public static void setConfigReader(ConfigReader configReader) {
		ConfigReader.configReader = configReader;
	}
}
