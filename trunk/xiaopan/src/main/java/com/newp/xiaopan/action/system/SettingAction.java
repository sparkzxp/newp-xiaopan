package com.newp.xiaopan.action.system;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Setting;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.ISettingService;
import com.opensymphony.xwork2.Action;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class SettingAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private ISettingService settingService;

	private Setting setting;
	private List<Setting> settings;

	public String toEdit() {
		if (null == setting && StringUtils.isNotEmpty(setting.getName())) {
			return Action.NONE;
		}
		setting = this.settingService.query(setting);
		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings("unchecked")
	public void doEdit() {
		JSONObject jsonObject = new JSONObject();
		this.settingService.update(setting);
		jsonObject.put("result", "success");
		jsonObject.put("id", setting.getId());
		this.ajax(jsonObject.toJSONString());
	}

	/**
	 * @return the settings
	 */
	public List<Setting> getSettings() {
		return settings;
	}

	/**
	 * @param settings
	 *            the settings to set
	 */
	public void setSettings(List<Setting> settings) {
		this.settings = settings;
	}

	/**
	 * @return the setting
	 */
	public Setting getSetting() {
		return setting;
	}

	/**
	 * @param setting
	 *            the setting to set
	 */
	public void setSetting(Setting setting) {
		this.setting = setting;
	}
}
