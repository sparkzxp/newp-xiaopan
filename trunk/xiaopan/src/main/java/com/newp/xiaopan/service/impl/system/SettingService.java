package com.newp.xiaopan.service.impl.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.Setting;
import com.newp.xiaopan.dao.system.ISettingDao;
import com.newp.xiaopan.service.system.ISettingService;

/**
 * @author 张霄鹏
 */
@Service
public class SettingService extends BaseService implements ISettingService {

	@Autowired
	private ISettingDao settingDao;

	public List<Setting> queryList(Setting setting) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("setting", setting);
		return this.settingDao.query(params);
	}

	public Setting query(Setting setting) {
		List<Setting> list = this.queryList(setting);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public Integer update(Setting setting) {
		return this.settingDao.update(setting);
	}
}
