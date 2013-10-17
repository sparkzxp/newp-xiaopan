package com.newp.xiaopan.action.system;

import com.newp.xiaopan.bean.system.Setting;
import com.newp.xiaopan.service.system.ISettingService;

/**
 * @author 张霄鹏
 */
public class StaticMethodUtil {

	private ISettingService settingService;

	private static StaticMethodUtil staticMethodUtil;

	public void init() {
		staticMethodUtil = this;
		staticMethodUtil.settingService = this.settingService;
	}

	public static Setting querySetting(Setting setting) {
		return staticMethodUtil.settingService.query(setting);
	}

	public static void setLogUtil(StaticMethodUtil staticMethodUtil) {
		StaticMethodUtil.staticMethodUtil = staticMethodUtil;
	}

}
